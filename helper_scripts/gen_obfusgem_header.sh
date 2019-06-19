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

echo "// ObfusGEM Injection Mode" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t alu_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/alu_obgem.hh
echo "" >> ./src/obfusgem/alu_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t alu_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/alu_obgem.hh
echo "" >> ./src/obfusgem/alu_obgem.hh

echo "// Adder Locking Configuration" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_lock = $adder_lock;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_err_rate = $adder_err_rate;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_err_severity = $adder_err_severity;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_locked_op1 = $adder_locked_op1;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_locked_op2 = $adder_locked_op2;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_locked_flags = $adder_locked_flags;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_locked_op1_mask = $adder_locked_op1_mask;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_locked_op2_mask = $adder_locked_op2_mask;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_locked_flags_mask = $adder_locked_flags_mask;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_locked_out = $adder_locked_out;" >> ./src/obfusgem/alu_obgem.hh
echo "" >> ./src/obfusgem/alu_obgem.hh

echo "// Multiplier Locking Configuration" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_lock = $mult_lock;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_err_rate = $mult_err_rate;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_err_severity = $mult_err_severity;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_locked_op1 = $mult_locked_op1;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_locked_op2 = $mult_locked_op2;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_locked_flags = $mult_locked_flags;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_locked_op1_mask = $mult_locked_op1_mask;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_locked_op2_mask = $mult_locked_op2_mask;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_locked_flags_mask = $mult_locked_flags_mask;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_locked_out = $mult_locked_out;" >> ./src/obfusgem/alu_obgem.hh
echo "" >> ./src/obfusgem/alu_obgem.hh

echo "// Divider Locking Configuration" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_lock = $div_lock;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_err_rate = $div_err_rate;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_err_severity = $div_err_severity;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_locked_op1 = $div_locked_op1;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_locked_op2 = $div_locked_op2;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_locked_flags = $div_locked_flags;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_locked_op1_mask = $div_locked_op1_mask;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_locked_op2_mask = $div_locked_op2_mask;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_locked_flags_mask = $div_locked_flags_mask;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_locked_qou_out = $div_locked_qou_out;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t div_locked_rem_out = $div_locked_rem_out;" >> ./src/obfusgem/alu_obgem.hh
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

echo "// ObfusGEM Injection Mode" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/dec_obgem.hh
echo "" >> ./src/obfusgem/dec_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/dec_obgem.hh
echo "" >> ./src/obfusgem/dec_obgem.hh

echo "// Decoder Locking Configuration" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_lock = $dec_lock;" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_err_rate = $dec_err_rate;" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_err_severity = $dec_err_severity;" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_locked_op = $dec_locked_op;" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_locked_mask = $dec_locked_mask;" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_locked_out = $dec_locked_out;" >> ./src/obfusgem/dec_obgem.hh
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

echo "// ObfusGEM Injection Mode" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t ras_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t btb_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/bp_obgem.hh
echo "" >> ./src/obfusgem/bp_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t ras_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t btb_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/bp_obgem.hh
echo "" >> ./src/obfusgem/bp_obgem.hh

echo "// Branch Predictor Locking Configuration" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_lock = $bp_lock;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_err_rate = $bp_err_rate;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_locked_addr = $bp_locked_addr;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_locked_mask = $bp_locked_mask;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_locked_out = $bp_locked_out;" >> ./src/obfusgem/bp_obgem.hh
echo "" >> ./src/obfusgem/bp_obgem.hh

echo "// BTB Locking Configuration" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t btb_lock = $btb_lock;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t btb_err_rate = $btb_err_rate;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t btb_locked_addr = $btb_locked_addr;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t btb_locked_mask = $btb_locked_mask;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t btb_locked_out = $btb_locked_out;" >> ./src/obfusgem/bp_obgem.hh
echo "" >> ./src/obfusgem/bp_obgem.hh

echo "// RAS Locking Configuration" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t ras_lock = $ras_lock;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t ras_err_rate = $ras_err_rate;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t ras_locked_addr = $ras_locked_addr;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t ras_locked_mask = $ras_locked_mask;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t ras_locked_out = $ras_locked_out;" >> ./src/obfusgem/bp_obgem.hh
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

echo "// ObfusGEM Injection Mode" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t rf_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/rf_obgem.hh
echo "" >> ./src/obfusgem/rf_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t rf_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/rf_obgem.hh
echo "" >> ./src/obfusgem/rf_obgem.hh

echo "// Integer Register File Locking Configuration" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t int_rf_lock = $int_rf_lock;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t int_rf_err_rate = $int_rf_err_rate;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t int_rf_err_severity = $int_rf_err_severity;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t int_rf_locked_reg = $int_rf_locked_reg;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t int_rf_locked_mask = $int_rf_locked_mask;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t int_rf_locked_out = $int_rf_locked_out;" >> ./src/obfusgem/rf_obgem.hh
echo "" >> ./src/obfusgem/rf_obgem.hh

echo "// Floating Point Register File Locking Configuration" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t flt_rf_lock = $flt_rf_lock;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t flt_rf_err_rate = $flt_rf_err_rate;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t flt_rf_err_severity = $flt_rf_err_severity;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t flt_rf_locked_reg = $flt_rf_locked_reg;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t flt_rf_locked_mask = $flt_rf_locked_mask;" >> ./src/obfusgem/rf_obgem.hh
echo "static uint64_t flt_rf_locked_out = $flt_rf_locked_out;" >> ./src/obfusgem/rf_obgem.hh
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

echo "// ObfusGEM Injection Mode" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t cache_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/cache_obgem.hh
echo "" >> ./src/obfusgem/cache_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t cache_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/cache_obgem.hh
echo "" >> ./src/obfusgem/cache_obgem.hh

echo "// Data Cache Locking Configuration" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t dcache_lock = $dcache_lock;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t dcache_err_rate = $dcache_err_rate;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t dcache_err_severity = $dcache_err_severity;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t dcache_locked_addr = $dcache_locked_addr;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t dcache_locked_mask = $dcache_locked_mask;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t dcache_locked_out = $dcache_locked_out;" >> ./src/obfusgem/cache_obgem.hh
echo "" >> ./src/obfusgem/cache_obgem.hh

echo "// Instruction Cache Locking Configuration" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t icache_lock = $icache_lock;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t icache_err_rate = $icache_err_rate;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t icache_err_severity = $icache_err_severity;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t icache_locked_addr = $icache_locked_addr;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t icache_locked_mask = $icache_locked_mask;" >> ./src/obfusgem/cache_obgem.hh
echo "static uint64_t icache_locked_out = $icache_locked_out;" >> ./src/obfusgem/cache_obgem.hh
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

echo "// ObfusGEM Injection Mode" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "" >> ./src/obfusgem/cache_tag_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "" >> ./src/obfusgem/cache_tag_obgem.hh

echo "// Data Cache Locking Configuration" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_lock = $cache_tag_lock;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_err_rate = $cache_tag_err_rate;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_err_severity = $cache_tag_err_severity;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_locked_tag = $cache_tag_locked_tag;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_locked_mask = $cache_tag_locked_mask;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "static uint64_t cache_tag_locked_out = $cache_tag_locked_out;" >> ./src/obfusgem/cache_tag_obgem.hh
echo "" >> ./src/obfusgem/cache_tag_obgem.hh


#
# FPU ObfusGEM Configuration
#

# Print Warning Header
echo "// This file is automatically generated for ObfusGEM. Do not Edit!" > ./src/obfusgem/fpu_obgem.hh
echo -e "\n" >> ./src/obfusgem/fpu_obgem.hh

# Print obfuscation configuration
echo "// ObfusGEM Seed" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_obfusgem_seed = $obfusgem_seed;" >> ./src/obfusgem/fpu_obgem.hh
echo "" >> ./src/obfusgem/fpu_obgem.hh

echo "// ObfusGEM Injection Mode" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/fpu_obgem.hh
echo "" >> ./src/obfusgem/fpu_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/fpu_obgem.hh
echo "" >> ./src/obfusgem/fpu_obgem.hh

echo "// FPU Adder Locking Configuration" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_lock = $fpu_adder_lock;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_err_rate = $fpu_adder_err_rate;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_err_severity = $fpu_adder_err_severity;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_locked_op1 = $fpu_adder_locked_op1;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_locked_op2 = $fpu_adder_locked_op2;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_locked_flags = $fpu_adder_locked_flags;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_locked_op1_mask = $fpu_adder_locked_op1_mask;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_locked_op2_mask = $fpu_adder_locked_op2_mask;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_locked_flags_mask = $fpu_adder_locked_flags_mask;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_adder_locked_out = $fpu_adder_locked_out;" >> ./src/obfusgem/fpu_obgem.hh
echo "" >> ./src/obfusgem/fpu_obgem.hh

echo "// FPU Multiplier Locking Configuration" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_lock = $fpu_mult_lock;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_err_rate = $fpu_mult_err_rate;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_err_severity = $fpu_mult_err_severity;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_locked_op1 = $fpu_mult_locked_op1;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_locked_op2 = $fpu_mult_locked_op2;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_locked_flags = $fpu_mult_locked_flags;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_locked_op1_mask = $fpu_mult_locked_op1_mask;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_locked_op2_mask = $fpu_mult_locked_op2_mask;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_locked_flags_mask = $fpu_mult_locked_flags_mask;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_mult_locked_out = $fpu_mult_locked_out;" >> ./src/obfusgem/fpu_obgem.hh
echo "" >> ./src/obfusgem/fpu_obgem.hh

echo "// FPU Divider Locking Configuration" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_lock = $fpu_div_lock;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_err_rate = $fpu_div_err_rate;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_err_severity = $fpu_div_err_severity;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_locked_op1 = $fpu_div_locked_op1;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_locked_op2 = $fpu_div_locked_op2;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_locked_flags = $fpu_div_locked_flags;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_locked_op1_mask = $fpu_div_locked_op1_mask;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_locked_op2_mask = $fpu_div_locked_op2_mask;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_locked_flags_mask = $fpu_div_locked_flags_mask;" >> ./src/obfusgem/fpu_obgem.hh
echo "static uint64_t fpu_div_locked_out = $fpu_div_locked_out;" >> ./src/obfusgem/fpu_obgem.hh
echo "" >> ./src/obfusgem/fpu_obgem.hh


#
# TLB ObfusGEM Configuration
#

# Print Warning Header
echo "// This file is automatically generated for ObfusGEM. Do not Edit!" > ./src/obfusgem/tlb_obgem.hh
echo -e "\n" >> ./src/obfusgem/tlb_obgem.hh

# Print obfuscation configuration
echo "// ObfusGEM Seed" >> ./src/obfusgem/tlb_obgem.hh
echo "static uint64_t tlb_obfusgem_seed = $obfusgem_seed;" >> ./src/obfusgem/tlb_obgem.hh
echo "" >> ./src/obfusgem/tlb_obgem.hh

echo "// ObfusGEM Injection Mode" >> ./src/obfusgem/tlb_obgem.hh
echo "static uint64_t tlb_obfuscation_mode = $random_obfuscation_mode;" >> ./src/obfusgem/tlb_obgem.hh
echo "" >> ./src/obfusgem/tlb_obgem.hh

echo "// Error Rate Denominator" >> ./src/obfusgem/tlb_obgem.hh
echo "static uint64_t tlb_err_rate_denom = $err_rate_denom;" >> ./src/obfusgem/tlb_obgem.hh
echo "" >> ./src/obfusgem/tlb_obgem.hh

echo "// Data Cache Locking Configuration" >> ./src/obfusgem/tlb_obgem.hh
echo "static uint64_t tlb_lock = $tlb_lock;" >> ./src/obfusgem/tlb_obgem.hh
echo "static uint64_t tlb_err_rate = $tlb_err_rate;" >> ./src/obfusgem/tlb_obgem.hh
echo "static uint64_t tlb_err_severity = $tlb_err_severity;" >> ./src/obfusgem/tlb_obgem.hh
echo "static uint64_t tlb_locked_vaddr = $tlb_locked_vaddr;" >> ./src/obfusgem/tlb_obgem.hh
echo "static uint64_t tlb_locked_mask = $tlb_locked_mask;" >> ./src/obfusgem/tlb_obgem.hh
echo "static uint64_t tlb_locked_out = $tlb_locked_out;" >> ./src/obfusgem/tlb_obgem.hh
echo "" >> ./src/obfusgem/tlb_obgem.hh
