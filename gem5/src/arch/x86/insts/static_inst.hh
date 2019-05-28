/*
 * Copyright (c) 2007 The Hewlett-Packard Development Company
 * All rights reserved.
 *
 * The license below extends only to copyright in the software and shall
 * not be construed as granting a license to any other intellectual
 * property including but not limited to intellectual property relating
 * to a hardware implementation of the functionality of the software
 * licensed hereunder.  You may use the software subject to the license
 * terms below provided that you ensure that this notice is replicated
 * unmodified and in its entirety in all distributions of the software,
 * modified or unmodified, in source code or in binary form.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met: redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer;
 * redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution;
 * neither the name of the copyright holders nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Authors: Gabe Black
 */

#ifndef __ARCH_X86_INSTS_STATICINST_HH__
#define __ARCH_X86_INSTS_STATICINST_HH__

#include "base/trace.hh"
#include "cpu/static_inst.hh"
#include "debug/X86.hh"

#include "obfusgem/alu_obgem.hh"
#include "obfusgem/fpu_obgem.hh"

namespace X86ISA
{
    /**
     * Class for register indices passed to instruction constructors. Using a
     * wrapper struct for these lets take advantage of the compiler's type
     * checking.
     */
    struct InstRegIndex : public RegId
    {
        explicit InstRegIndex(RegIndex _idx) :
           RegId(computeRegClass(_idx), _idx) {}

      private:
        // TODO: As X86 register index definition is highly built on the
        //       unified space concept, it is easier for the moment to rely on
        //       an helper function to compute the RegClass. It would be nice
        //       to fix those definition and get rid of this.
        RegClass computeRegClass(RegIndex _idx) {
            if (_idx < FP_Reg_Base) {
                return IntRegClass;
            } else if (_idx < CC_Reg_Base) {
                return FloatRegClass;
            } else if (_idx < Misc_Reg_Base) {
                return CCRegClass;
            } else {
                return MiscRegClass;
            }
        }
    };

    /**
     * Base class for all X86 static instructions.
     */

    class X86StaticInst : public StaticInst
    {
      protected:
        // Constructor.
        X86StaticInst(const char *mnem,
             ExtMachInst _machInst, OpClass __opClass)
                : StaticInst(mnem, _machInst, __opClass)
            {
            }

        std::string generateDisassembly(Addr pc,
            const SymbolTable *symtab) const;

        void printMnemonic(std::ostream &os, const char * mnemonic) const;
        void printMnemonic(std::ostream &os, const char * instMnemonic,
                const char * mnemonic) const;

        void printSegment(std::ostream &os, int segment) const;

        void printReg(std::ostream &os, RegId reg, int size) const;
        void printSrcReg(std::ostream &os, int reg, int size) const;
        void printDestReg(std::ostream &os, int reg, int size) const;
        void printMem(std::ostream &os, uint8_t segment,
                uint8_t scale, RegIndex index, RegIndex base,
                uint64_t disp, uint8_t addressSize, bool rip) const;

        inline uint64_t merge(uint64_t into, uint64_t val, int size) const
        {
            X86IntReg reg = into;
            if (_destRegIdx[0].index() & IntFoldBit)
            {
                reg.H = val;
                return reg;
            }
            switch(size)
            {
              case 1:
                reg.L = val;
                break;
              case 2:
                reg.X = val;
                break;
              case 4:
                //XXX Check if this should be zeroed or sign extended
                reg = 0;
                reg.E = val;
                break;
              case 8:
                reg.R = val;
                break;
              default:
                panic("Tried to merge with unrecognized size %d.\n", size);
            }
            return reg;
        }

        inline uint64_t pick(uint64_t from, int idx, int size) const
        {
            X86IntReg reg = from;
            DPRINTF(X86, "Picking with size %d\n", size);
            if (_srcRegIdx[idx].index() & IntFoldBit)
                return reg.H;
            switch(size)
            {
              case 1:
                return reg.L;
              case 2:
                return reg.X;
              case 4:
                return reg.E;
              case 8:
                return reg.R;
              default:
                panic("Tried to pick with unrecognized size %d.\n", size);
            }
        }

        inline int64_t signedPick(uint64_t from, int idx, int size) const
        {
            X86IntReg reg = from;
            DPRINTF(X86, "Picking with size %d\n", size);
            if (_srcRegIdx[idx].index() & IntFoldBit)
                return reg.SH;
            switch(size)
            {
              case 1:
                return reg.SL;
              case 2:
                return reg.SX;
              case 4:
                return reg.SE;
              case 8:
                return reg.SR;
              default:
                panic("Tried to pick with unrecognized size %d.\n", size);
            }
        }

        void
        advancePC(PCState &pcState) const
        {
            pcState.advance();
        }


      inline uint64_t obgem_error_inject(uint64_t result, uint64_t op1, uint64_t op2, uint64_t flags, uint64_t is_add_mul_div) const
        {
            X86IntReg reg = result;

            if(is_add_mul_div == 2)
              {
                if(div_lock == 1)
                  {
                    if(alu_obfuscation_mode)
                      {
                        if(div_err_rate > (rand() % alu_err_rate_denom))
                          reg = reg ^ div_err_severity;
                      }
                    else
                      {
                        if(((op1 & div_locked_op1_mask) == (div_locked_op1 & div_locked_op1_mask)) && ((op2 & div_locked_op2_mask) == (div_locked_op2 & div_locked_op2_mask)) && ((flags & div_locked_flags_mask) == (div_locked_flags & div_locked_flags_mask)))
                          reg = div_locked_out;
                      }
                  }
              }
            else
              {
                if(is_add_mul_div == 1)
                  {
                    if(mult_lock == 1)
                      {
                        if(alu_obfuscation_mode)
                          {
                            if(mult_err_rate > (rand() % alu_err_rate_denom))
                              reg = reg ^ mult_err_severity;
                          }
                        else
                          {
                            if(((op1 & mult_locked_op1_mask) == (mult_locked_op1 & mult_locked_op1_mask)) && ((op2 & mult_locked_op2_mask) == (mult_locked_op2 & mult_locked_op2_mask)) && ((flags & mult_locked_flags_mask) == (mult_locked_flags & mult_locked_flags_mask)))
                              reg = mult_locked_out;
                          }
                      }
                  }
                else
                  {
                    if(adder_lock == 1)
                      {
                        if(alu_obfuscation_mode)
                          {
                            if(adder_err_rate > (rand() % alu_err_rate_denom))
                              reg = reg ^ adder_err_severity;
                          }
                        else
                          {
                            if(((op1 & adder_locked_op1_mask) == (adder_locked_op1 & adder_locked_op1_mask)) && ((op2 & adder_locked_op2_mask) == (adder_locked_op2 & adder_locked_op2_mask)) && ((flags & adder_locked_flags_mask) == (adder_locked_flags & adder_locked_flags_mask)))
                              reg = adder_locked_out;
                          }
                      }
                  }
              }

            return reg;
        }

        inline uint64_t obgem_error_inject_media(uint64_t result, uint64_t op1, uint64_t op2, uint64_t flags, uint64_t is_add_mul_div) const
        {
            uint64_t reg = result;

            if(is_add_mul_div == 2)
              {
                if(fpu_div_lock == 1)
                  {
                    if(fpu_obfuscation_mode)
                      {
                        if(fpu_div_err_rate > (rand() % fpu_err_rate_denom))
                          reg = reg ^ fpu_div_err_severity;
                      }
                    else
                      {
                        if(((op1 & fpu_div_locked_op1_mask) == (fpu_div_locked_op1 & fpu_div_locked_op1_mask)) && ((op2 & fpu_div_locked_op2_mask) == (fpu_div_locked_op2 & fpu_div_locked_op2_mask)) && ((flags & fpu_div_locked_flags_mask) == (fpu_div_locked_flags & fpu_div_locked_flags_mask)))
                          reg = fpu_div_locked_out;
                      }
                  }
              }
            else
              {
                if(is_add_mul_div == 1)
                  {
                    if(fpu_mult_lock == 1)
                      {
                        if(fpu_obfuscation_mode)
                          {
                            if(fpu_mult_err_rate > (rand() % fpu_err_rate_denom))
                              reg = reg ^ fpu_mult_err_severity;
                          }
                        else
                          {
                            if(((op1 & fpu_mult_locked_op1_mask) == (fpu_mult_locked_op1 & fpu_mult_locked_op1_mask)) && ((op2 & fpu_mult_locked_op2_mask) == (fpu_mult_locked_op2 & fpu_mult_locked_op2_mask)) && ((flags & fpu_mult_locked_flags_mask) == (fpu_mult_locked_flags & fpu_mult_locked_flags_mask)))
                              reg = fpu_mult_locked_out;
                          }
                      }
                  }
                else
                  {
                    if(fpu_adder_lock == 1)
                      {
                        if(fpu_obfuscation_mode)
                          {
                            if(fpu_adder_err_rate > (rand() % fpu_err_rate_denom))
                              reg = reg ^ fpu_adder_err_severity;
                          }
                        else
                          {
                            if(((op1 & fpu_adder_locked_op1_mask) == (fpu_adder_locked_op1 & fpu_adder_locked_op1_mask)) && ((op2 & fpu_adder_locked_op2_mask) == (fpu_adder_locked_op2 & fpu_adder_locked_op2_mask)) && ((flags & fpu_adder_locked_flags_mask) == (fpu_adder_locked_flags & fpu_adder_locked_flags_mask)))
                              reg = fpu_adder_locked_out;
                          }
                      }
                  }
              }

            return reg;
        }

        inline double obgem_error_inject_fp(double result, unsigned char *op1, unsigned char *op2, uint64_t flags, uint64_t is_add_mul_div) const
        {
            double reg = result;
            int cur_match_flag = 1;
            int iter;

            if(is_add_mul_div == 2)
              {
                if(fpu_div_lock == 1)
                  {
                    if(fpu_obfuscation_mode)
                      {
                        if(fpu_div_err_rate > (rand() % fpu_err_rate_denom))
                          reg = rand();
                      }
                    else
                      {
                        for(iter = 0; iter < 8; iter++)
                          if(!((op1[iter] & (unsigned char)(fpu_div_locked_op1_mask << (iter*8))) == (unsigned char)((fpu_div_locked_op1 & fpu_div_locked_op1_mask) << (iter*8))))
                            cur_match_flag = 0;

                        for(iter = 0; iter < 8; iter++)
                          if(!((op2[iter] & (unsigned char)(fpu_div_locked_op2_mask << (iter*8))) == (unsigned char)((fpu_div_locked_op2 & fpu_div_locked_op2_mask) << (iter*8))))
                            cur_match_flag = 0;

                        if(cur_match_flag)
                          reg = fpu_div_locked_out;
                      }
                  }
              }
            else
              {
                if(is_add_mul_div == 1)
                  {
                    if(fpu_mult_lock == 1)
                      {
                        if(fpu_obfuscation_mode)
                          {
                            if(fpu_mult_err_rate > (rand() % fpu_err_rate_denom))
                              reg = rand();
                          }
                        else
                          {
                            for(iter = 0; iter < 8; iter++)
                              if(!((op1[iter] & (unsigned char)(fpu_mult_locked_op1_mask << (iter*8))) == (unsigned char)((fpu_mult_locked_op1 & fpu_mult_locked_op1_mask) << (iter*8))))
                                cur_match_flag = 0;

                            for(iter = 0; iter < 8; iter++)
                              if(!((op2[iter] & (unsigned char)(fpu_mult_locked_op2_mask << (iter*8))) == (unsigned char)((fpu_mult_locked_op2 & fpu_mult_locked_op2_mask) << (iter*8))))
                                cur_match_flag = 0;

                            if(cur_match_flag)
                              reg = fpu_mult_locked_out;
                          }
                      }
                  }
                else
                  {
                    if(fpu_adder_lock == 1)
                      {
                        if(fpu_obfuscation_mode)
                          {
                            if(fpu_adder_err_rate > (rand() % fpu_err_rate_denom))
                              reg = rand();
                          }
                        else
                          {
                            for(iter = 0; iter < 8; iter++)
                              if(!((op1[iter] & (unsigned char)(fpu_adder_locked_op1_mask << (iter*8))) == (unsigned char)((fpu_adder_locked_op1 & fpu_adder_locked_op1_mask) << (iter*8))))
                                cur_match_flag = 0;

                            for(iter = 0; iter < 8; iter++)
                              if(!((op2[iter] & (unsigned char)(fpu_adder_locked_op2_mask << (iter*8))) == (unsigned char)((fpu_adder_locked_op2 & fpu_adder_locked_op2_mask) << (iter*8))))
                                cur_match_flag = 0;

                            if(cur_match_flag)
                              reg = fpu_adder_locked_out;
                          }
                      }
                  }
              }

            return reg;
        }

    };
}

#endif //__ARCH_X86_INSTS_STATICINST_HH__
