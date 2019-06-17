#include "obfusgem/cache_obgem.hh"

inline uint64_t obgem_error_inject_lsq(uint64_t addr, uint64_t is_dcache)
  {
    uint64_t reg = addr;

    if(is_dcache == 1)
      {
        if(dcache_lock == 1)
          {
            if(cache_obfuscation_mode)
              {
                if(dcache_err_rate > (rand() % cache_err_rate_denom))
                  reg = reg ^ dcache_err_severity;
              }
            else
              {
                if((addr & dcache_locked_mask) == (dcache_locked_addr & dcache_locked_mask))
                  reg = dcache_locked_out;
              }
          }
      }
    else
      {
        if(icache_lock == 1)
          {
            if(cache_obfuscation_mode)
              {
                if(icache_err_rate > (rand() % cache_err_rate_denom))
                  reg = reg ^ icache_err_severity;
              }
            else
              {
                if((addr & icache_locked_mask) == (icache_locked_addr & icache_locked_mask))
                  reg = icache_locked_out;
              }
          }
      }

    return reg;
  }
