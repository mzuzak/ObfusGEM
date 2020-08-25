#!/bin/bash

#
# Shell script to automatically generate bit-masks for ObfusGEM.
#      Set number of operands and number of unmasked bits.
#      Script returns bit-masks with specified number of non-zero bits in random locations. (cur_mask_op1, cur_mask_op2)
#      Used for Monte Carlo simulations that randomize locked minterms of fixed length.
#

# Number of masked bits
cur_mask_bits=0

# Initialize valid ALU locking operands
mask_operand=(1 2)

# Initialize bit masks
cur_mask_op1=0
cur_mask_op2=0

# Initialize bits which are valid for masking
mask_bits_op1=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63)
mask_bits_op2=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63)

# Randomly determine bitmask bits
while [ $cur_mask_bits -lt $cur_mask ]
do

    # Shuffle to randomly select operand and bit to be masked
    operand_select=( $(shuf -e "${mask_operand[@]}") )
    
    if [ $operand_select -eq 1 ]
    then
        # We know were masking operand 1.
        
        # Select bit in operand 1 to mask
        bit_select=( $(shuf -e "${mask_bits_op1[@]}") )
        
        # Debug
        #echo ${mask_bits_op1[@]}
        #echo $bit_select
        #echo $operand_select

        # Remove masked bit from possible selected operand bits to ensure that no duplication occurs
        # Note that we must rebuild the array to do so, hence the second code block
        for target in "${bit_select[@]}"; do
            for i in "${!mask_bits_op1[@]}"; do
                if [[ ${mask_bits_op1[i]} = "${bit_select[0]}" ]]; then
                    unset 'mask_bits_op1[i]'
                fi
            done
        done

        for i in "${!mask_bits_op1[@]}"; do
            new_array+=( "${mask_bits_op1[i]}" )
        done
        mask_bits_op1=("${new_array[@]}")
        unset new_array
        
        # Debug
        #echo ${mask_bits_op1[@]}
        #echo $bit_select
        #echo $operand_select
        
        # Update bit mask
        cur_mask_op1=$((2**$bit_select + $cur_mask_op1))

	# Debug
        #echo $cur_mask_op1
        
    else
        # We know were masking operand 2.
        
        # Select bit in operand 2 to mask
        bit_select=( $(shuf -e "${mask_bits_op2[@]}") )
        
        # Debug
        #echo ${mask_bits_op2[@]}
        #echo $bit_select
        #echo $operand_select
        
        # Remove masked bit from possible selected operand bits to ensure that no duplication occurs
        # Note that we must rebuild the array to do so, hence the second code block
        for target in "${bit_select[@]}"; do
            for i in "${!mask_bits_op2[@]}"; do
                if [[ ${mask_bits_op2[i]} = "${bit_select[0]}" ]]; then
                    unset 'mask_bits_op2[i]'
                fi
            done
        done
        
        for i in "${!mask_bits_op2[@]}"; do
            new_array+=( "${mask_bits_op2[i]}" )
        done
        mask_bits_op2=("${new_array[@]}")
        unset new_array
        
        # Debug
        #echo ${mask_bits_op2[@]}
        #echo $bit_select
        #echo $operand_select
        
        # Update bit mask
        cur_mask_op2=$((2**$bit_select + $cur_mask_op2))

	# Debug
        #echo $cur_mask_op2
        
    fi

    # Iterate number of masked bits iterator
    (( cur_mask_bits++ ))
    
    # Debug
    #echo $bit_select
    #echo $operand_select
    #echo ${mask_bits_op1[@]}
    #echo ${mask_bits_op2[@]}
    #echo $cur_mask_op1
    #echo $cur_mask_op2

done

# Debug
#echo $bit_select
#echo $operand_select
#echo ${mask_bits_op1[@]}
#echo ${mask_bits_op2[@]}
#echo $cur_mask_op1
#echo $cur_mask_op2
