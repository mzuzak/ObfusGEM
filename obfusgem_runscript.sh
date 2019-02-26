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

    # Current Benchmark
    echo "OBFUSGEM: Currently running benchmark: $bm, run: $cur_run"

    #Remove Checkpoints
    rm -rf ./m5out/cpt.*

    # Generate clean ObfusGEM header
    ./../helper_scripts/gen_clean_header.sh > ./src/obfusgem/obfusgem.hh
    
    # Rebuild
    rm ./build/X86/gem5.opt
    rm ./build/X86/gem5.gold
    scons ./build/X86/gem5.opt

    # Sometimes execute priveledges are not granted. Grant them.
    chmod +x ./build/X86/gem5.opt
    
    # Copy off as gold image
    sleep 5
    cp ./build/X86/gem5.opt ./build/X86/gem5.gold

    # Checkpoint Creation Run
    ./build/X86/gem5.opt ./configs/example/fs.py --script=../benchmark_runscripts/$bm.rcS --caches --cpu-type=TimingSimpleCPU

    # Update ObfusGEM Configuration File
    ./../helper_scripts/gen_obfusgem_header.sh > ./src/obfusgem/obfusgem.hh
    
    # Rebuild Obfuscated Copy
    rm ./build/X86/gem5.opt
    rm ./build/X86/gem5.obfus
    scons ./build/X86/gem5.opt

    # Copy off obfuscated image
    sleep 5
    cp ./build/X86/gem5.opt ./build/X86/gem5.obfus

    # Copy off checkpoints
    cp -r ./m5out/cpt.* ./tracediff-1/
    cp -r ./m5out/cpt.* ./tracediff-2/
    
    # Monte Carlo Run Count
    while [[ $cur_run -le $monte_carlo_runs ]]; do

        # Start stochastic fault injection run. Monitor both simulations and terminate on persistent difference.
        ./util/tracediff './build/X86/gem5.gold|./build/X86/gem5.obfus' --debug-flags=Exec,-ExecTicks ./configs/example/fs.py -r 1 --script=../benchmark_runscripts/$bm.rcS --caches --cpu-type=TimingSimpleCPU > "$log" 2>&1 &
        pid=$!

        # Checker loop -- Kill simulation process when traces diverge or benchmark completes
        # TODO: Do this without PID tracking
        while sleep 10; do
            if ps -p $pid > /dev/null; then
                if fgrep --quiet "$match" "$log"; then
                    pkill -f "gem5.obfus"
                    pkill -f "gem5.gold"
                fi
            else
                break
            fi
        done

        # Archive Simulation Results
        runstring="sim.$(date +%F_%R)"
        mkdir -p ./../obgem_out/$bm/$runstring
        mv ./$log ./../obgem_out/$bm/$runstring/
        mv ./tracediff-*.out ./../obgem_out/$bm/$runstring/
	mv ./tracediff-2/stats.txt ./../obgem_out/$bm/$runstring/
        mv ./tracediff-2/config.ini ./../obgem_out/$bm/$runstring/
        mv ./tracediff-2/system.* ./../obgem_out/$bm/$runstring/

        # Remove files not archived
        rm -rf ./tracediff-1/*
        rm -rf ./tracediff-2/*

	# Copy in monte-carlo parser to update global data
        cp ./../helper_scripts/parse_tracediff.py ./../obgem_out/$bm/$runstring/

        # Parse simulation data
        cd ./../obgem_out/$bm/$runstring/
        python parse_tracediff.py $bm NA 0
        rm parse_tracediff.py
        cd -

        # Update iterator for monte carlo run count
        (( cur_run++ ))
    
    done
done

# Return to launch directory
cd ..
