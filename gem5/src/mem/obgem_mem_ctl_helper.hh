#include "obfusgem/mem_ctl_obgem.hh"

inline uint64_t obgem_error_inject_mem_ctl(uint64_t addr)
  {
    uint64_t reg = addr;

    if(mem_ctl_lock == 1)
      {
        if(mem_ctl_obfuscation_mode)
          {
            if(mem_ctl_err_rate > (rand() % mem_ctl_err_rate_denom))
              reg = reg ^ mem_ctl_err_severity;
          }
        else
          {
            if((addr & mem_ctl_locked_mask) == (mem_ctl_locked_addr & mem_ctl_locked_mask))
              reg = mem_ctl_locked_out;
          }
      }

    return reg;
  }
