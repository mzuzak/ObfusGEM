#!/bin/bash

# Load ObfusGEM simulator parameters
source ../obfusgem.conf

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
echo "static uint64_t adder_lock = $adder_lock;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_err_rate = $adder_err_rate;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t adder_err_severity = $adder_err_severity;" >> ./src/obfusgem/alu_obgem.hh
echo "" >> ./src/obfusgem/alu_obgem.hh

echo "// Multiplier Locking Configuration" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_lock = $mult_lock;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_err_rate = $mult_err_rate;" >> ./src/obfusgem/alu_obgem.hh
echo "static uint64_t mult_err_severity = $mult_err_severity;" >> ./src/obfusgem/alu_obgem.hh
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
echo "static uint64_t dec_lock = $dec_lock;" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_err_rate = $dec_err_rate;" >> ./src/obfusgem/dec_obgem.hh
echo "static uint64_t dec_err_severity = $dec_err_severity;" >> ./src/obfusgem/dec_obgem.hh
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
echo "static uint64_t bp_lock = $bp_lock;" >> ./src/obfusgem/bp_obgem.hh
echo "static uint64_t bp_err_rate = $bp_err_rate;" >> ./src/obfusgem/bp_obgem.hh
echo "" >> ./src/obfusgem/bp_obgem.hh
