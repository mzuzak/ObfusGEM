#!/bin/bash

timeout=60
log="tracediff.log"
terminal="system.terminal"
match="Lost sync!"

# Load ObfusGEM simulator parameters
source obfusgem.conf

# Swap to working directory
cd gem5

for bm in "${benchmarks[@]}"; do

    #Remove Checkpoints
    rm -rf ./m5out/cpt.* 2> /dev/null

    # Generate clean ObfusGEM header
    ./../helper_scripts/gen_clean_header.sh
    
    # Rebuild
    rm ./build/$arch/gem5.opt 2> /dev/null
    rm ./build/$arch/gem5.gold 2> /dev/null
    scons ./build/$arch/gem5.opt

    # Sometimes execute priveledges are not granted. Grant them.
    chmod +x ./build/$arch/gem5.opt
    
    # Copy off as gold image
    sleep 5
    cp ./build/$arch/gem5.opt ./build/$arch/gem5.gold

    # Checkpoint Creation Run
    ./build/$arch/gem5.opt $gem5_config --script=./../benchmark_runscripts/$bm.rcS ${gem5_args[@]}

    # Remove stale checkpoints
    rm -rf ./tracediff-1/cpt.* 2> /dev/null
    rm -rf ./tracediff-2/cpt.* 2> /dev/null
    
    # Make tracediff directories if not already created
    mkdir tracediff-1
    mkdir tracediff-2

    # Copy off checkpoints
    cp -r ./m5out/cpt.* ./tracediff-1/ 2> /dev/null
    cp -r ./m5out/cpt.* ./tracediff-2/ 2> /dev/null

    # Reset Monte Carlo Run count   
    cur_run=1

    # Current Benchmark
    echo "OBFUSGEM: Currently running benchmark: $bm, run: $cur_run"
    
    # Monte Carlo Run Count
    while [[ $cur_run -le $monte_carlo_runs ]]; do

        # Update ObfusGEM Configuration File
        ./../helper_scripts/gen_obfusgem_header.sh
    
        # Rebuild Obfuscated Copy
        rm ./build/$arch/gem5.opt 2> /dev/null
        rm ./build/$arch/gem5.obfus 2> /dev/null
        scons ./build/$arch/gem5.opt

        # Copy off obfuscated image
        sleep 5
        cp ./build/$arch/gem5.opt ./build/$arch/gem5.obfus

        # Start stochastic fault injection run. Monitor both simulations and terminate on persistent difference.
        cd m5out
        cpt_pattern="cpt.*"
        cpt_files=( $cpt_pattern )
        echo "${cpt_files[0]}"
        cd -

        ./util/tracediff './build/X86/gem5.gold|./build/X86/gem5.obfus' --debug-flags=Exec,-ExecTicks $gem5_config $gem5_cpt_restore --script=../benchmark_runscripts/$bm.rcS ${gem5_args[@]} > "$log" 2>&1 &
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
        mv ./$terminal ./../obgem_out/$bm/$runstring/
        mv ./tracediff-*.out ./../obgem_out/$bm/$runstring/
	mv ./tracediff-2/stats.txt ./../obgem_out/$bm/$runstring/
        mv ./tracediff-2/config.ini ./../obgem_out/$bm/$runstring/
        mv ./tracediff-2/system.* ./../obgem_out/$bm/$runstring/

        # Remove files not archived
        rm ./tracediff-1/*
        rm ./tracediff-2/*

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
