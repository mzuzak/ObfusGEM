#!/bin/bash

timeout=60
log="tracediff.log"
match="Lost sync!"

# Load ObfusGEM simulator parameters
source obfusgem.conf

# Swap to working directory
cd gem5

for bm in "${benchmarks[@]}"; do

    # Reset Monte Carlo Run count   
    cur_run=1

    # Monte Carlo Run Count
    while [[ $cur_run -le $monte_carlo_runs ]]; do

        # Current Benchmark
        echo "OBFUSGEM: Currently running benchmark: $bm, run: %cur_run"

	# Remove Checkpoints
        rm -rf ./m5out/cpt.*
    
        # Rebuild
        scons ./build/X86/gem5.opt

        # Sometimes execute priveledges are not granted. Grant them.
        chmod +x ./build/X86/gem5.opt
    
        # Copy off as gold image
        sleep 5
        cp ./build/X86/gem5.opt ./build/X86/gem5.gold_rundir1
    
        # Checkpoint Creation Run
        ./build/X86/gem5.opt ./configs/example/fs.py --script=../benchmark_runscripts/$bm.rcS --caches --cpu-type=TimingSimpleCPU

        # Update iterator for monte carlo run count
        (( cur_run++ ))
    
    done
done

# Return to launch directory
cd ..
