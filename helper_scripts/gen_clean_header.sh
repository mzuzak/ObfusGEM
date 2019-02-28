#!/bin/bash

# Load ObfusGEM simulator parameters
source ../obfusgem.conf

# Make obfusgem directory if necessary
mkdir -p ./src/obfusgem/


#
# ALU ObfusGEM Configuration
#

# Print Warning Header
echo "// This file is automatically generated for ObfusGEM. Do not Edit!" > ./src/obfusgem/alu_obgem.hh
echo -e "\n" >> ./src/obfusgem/alu_obgem.hh

# Print obfuscation configuration
echo "// ObfusGEM Seed" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t alu_obfusgem_seed = $obfusgem_seed;" >> ./src/obfusgem/alu_obgem.hh
echo "" >> ./src/obfusgem/alu_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t alu_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/alu_obgem.hh
echo "" >> ./src/obfusgem/alu_obgem.hh

echo "// Adder Locking Configuration" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_lock = 0;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_err_rate = 0;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_err_severity = 0;" >> ./src/obfusgem/alu_obgem.hh
echo "" >> ./src/obfusgem/alu_obgem.hh

echo "// Multiplier Locking Configuration" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_lock = 0;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_err_rate = 0;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_err_severity = 0;" >> ./src/obfusgem/alu_obgem.hh
echo "" >> ./src/obfusgem/alu_obgem.hh


#
# Decoder ObfusGEM Configuration
#

# Print Warning Header
echo "// This file is automatically generated for ObfusGEM. Do not Edit!" > ./src/obfusgem/dec_obgem.hh
echo -e "\n" >> ./src/obfusgem/dec_obgem.hh

# Print obfuscation configuration
echo "// ObfusGEM Seed" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_obfusgem_seed = $obfusgem_seed;" >> ./src/obfusgem/dec_obgem.hh
echo "" >> ./src/obfusgem/dec_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/dec_obgem.hh
echo "" >> ./src/obfusgem/dec_obgem.hh

echo "// Decoder Locking Configuration" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_lock = 0;" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_err_rate = 0;" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_err_severity = 0;" >> ./src/obfusgem/dec_obgem.hh
echo "" >> ./src/obfusgem/dec_obgem.hh


#
# Branch Predictor ObfusGEM Configuration
#

# Print Warning Header
echo "// This file is automatically generated for ObfusGEM. Do not Edit!" > ./src/obfusgem/bp_obgem.hh
echo -e "\n" >> ./src/obfusgem/bp_obgem.hh

# Print obfuscation configuration
echo "// ObfusGEM Seed" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_obfusgem_seed = $obfusgem_seed;" >> ./src/obfusgem/bp_obgem.hh
echo "" >> ./src/obfusgem/bp_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/bp_obgem.hh
echo "" >> ./src/obfusgem/bp_obgem.hh

echo "// Branch Predictor Locking Configuration" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_lock = 0;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_err_rate = 0;" >> ./src/obfusgem/bp_obgem.hh
echo "" >> ./src/obfusgem/bp_obgem.hh


#
# Register File ObfusGEM Configuration
#

# Print Warning Header
echo "// This file is automatically generated for ObfusGEM. Do not Edit!" > ./src/obfusgem/rf_obgem.hh
echo -e "\n" >> ./src/obfusgem/rf_obgem.hh

# Print obfuscation configuration
echo "// ObfusGEM Seed" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t rf_obfusgem_seed = $obfusgem_seed;" >> ./src/obfusgem/rf_obgem.hh
echo "" >> ./src/obfusgem/rf_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t rf_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/rf_obgem.hh
echo "" >> ./src/obfusgem/rf_obgem.hh

echo "// Integer Register File Locking Configuration" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t int_rf_lock = 0;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t int_rf_err_rate = 0;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t int_rf_err_severity = 0;" >> ./src/obfusgem/rf_obgem.hh
echo "" >> ./src/obfusgem/rf_obgem.hh

echo "// Floating Point Register File Locking Configuration" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t flt_rf_lock = 0;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t flt_rf_err_rate = 0;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t flt_rf_err_severity = 0;" >> ./src/obfusgem/rf_obgem.hh
echo "" >> ./src/obfusgem/rf_obgem.hh


#
# Cache ObfusGEM Configuration
#

# Print Warning Header
echo "// This file is automatically generated for ObfusGEM. Do not Edit!" > ./src/obfusgem/cache_obgem.hh
echo -e "\n" >> ./src/obfusgem/cache_obgem.hh

# Print obfuscation configuration
echo "// ObfusGEM Seed" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t cache_obfusgem_seed = $obfusgem_seed;" >> ./src/obfusgem/cache_obgem.hh
echo "" >> ./src/obfusgem/cache_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t cache_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/cache_obgem.hh
echo "" >> ./src/obfusgem/cache_obgem.hh

echo "// Data Cache Locking Configuration" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t dcache_lock = 0;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t dcache_err_rate = 0;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint8_t dcache_err_severity = 0;" >> ./src/obfusgem/cache_obgem.hh
echo "" >> ./src/obfusgem/cache_obgem.hh

echo "// Instruction Cache Locking Configuration" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t icache_lock = 0;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t icache_err_rate = 0;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint8_t icache_err_severity = 0;" >> ./src/obfusgem/cache_obgem.hh
echo "" >> ./src/obfusgem/cache_obgem.hh


#
# Cache Tag ObfusGEM Configuration
#

# Print Warning Header
echo "// This file is automatically generated for ObfusGEM. Do not Edit!" > ./src/obfusgem/cache_tag_obgem.hh
echo -e "\n" >> ./src/obfusgem/cache_tag_obgem.hh

# Print obfuscation configuration
echo "// ObfusGEM Seed" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_obfusgem_seed = $obfusgem_seed;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "" >> ./src/obfusgem/cache_tag_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "" >> ./src/obfusgem/cache_tag_obgem.hh

echo "// Data Cache Locking Configuration" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t dcache_tag_lock = 0;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t dcache_tag_err_rate = 0;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t dcache_tag_err_severity = 0;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "" >> ./src/obfusgem/cache_tag_obgem.hh

echo "// Instruction Cache Locking Configuration" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t icache_tag_lock = 0;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t icache_tag_err_rate = 0;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t icache_tag_err_severity = 0;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "" >> ./src/obfusgem/cache_tag_obgem.hh
 
