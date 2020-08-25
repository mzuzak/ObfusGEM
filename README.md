# ObfusGEM

This is the ObfusGEM simulator. It implements an error injection framework inspired by the architectural error resilience community to "close the loop" between module-level logic locking or hardware security techniques and their architecture-level impact. We provide a library of existing hardware security techniques and configurations along with a simulation framework in hopes of providing a tool enabling the design and evaluation of hardware security configurations for specific architectures or devices.

## Getting Started

These instructions are intended to get a copy of ObfusGEM up and running on your machine. We provide a basic example of an ObfusGEM simulation run to demonstrate the capabilities of the tool as well.

### Prerequisites

ObfusGEM can be cloned with the following command:

```
git clone git@github.com:mzuzak/ObfusGEM.git
```

ObfusGEM uses a modified version of the GEM5 simulator. This requires several dependencies. A list is contained at:

```
http://www.m5sim.org/Dependencies
```

### Installing

Given that dependencies have been successfully installed, the ObfusGEM simulator can be built as follows:

```
cd <PATH_TO_OBFUSGEM_REPO>/gem5
bash ./../helper_scripts/gen_clean_headers.sh

scons build/X86/gem5.opt # Builds Obfusgem for the X86 architecture
<OR ALTERNATIVELY>
scons build/ARM/gem5.opt # Builds Obfusgem for the ARM architecture
```

If interested, the given build can be tested using standard GEM5 simulation commands as all modifications for ObfusGEM are innocuous in the case of a clean repository. Some test commands can be found at:

```
http://www.gem5.org/Introduction
```

ObfusGEM requires disk images in order to run error injection simulations. We have provided 2 sample images, one X86 and one ARM, which can be pulled from the following location. Both of these images contain the PARSEC and SPLASH2 benchmark suites pre-installed and are compatible with the runscripts provided in the "obfusgem_runscripts" directory. We note that these images are very large (~5GB).

```
https://drive.google.com/drive/folders/1NKmThiV7jXGiKg3BQtdqyNEVHOO7lbw4?usp=sharing
```

Additionally, similar images can be created for any benchmarks of your choice using the following tutorials. To mimic our provided images, PARSEC and SPLASH-2 must be installed on an ARM and X86 disk image.

```
http://www.gem5.org/Disk_images
```

At this point, if the ObfusGEM has been built successfully and the sample images have been downloaded and located in the home directory of the ObfusGEM repo, a sample ObfusGEM simulation can be run with:

```
./obfusgem_runscript.sh
```

If successful, a "PASS" result will be recorded in "obgem_out/global_sim_data.csv". By modifying the security configuration in the "obfusgem.conf" file, logic locking errors can be induced, leading to "FAIL" and a fail location recorded in "obgem_out/global_sim_data.csv". As an example, the following parameters can be modified in obfusgem.conf:

```
...

# System Architecture
arch=ARM
gem5_config=configs/example/arm/starter_fs.py
gem5_args=(--cpu=hpi --num-cores=1 --disk-image=$M5_PATH/disks/expanded-linaro-minimal-aarch64.img)

# Select Benchmarks to be run
#
#     Stored as an array variable in shell. Space delimit list of
#     benchmark names corresponding to runscripts in the
#     obfusgem_runscripts directory
#
benchmarks=(arm_runscripts/blackscholes_arm arm_runscripts/ferret_arm)

...

adder_lock=1

...

# Select Locked Minterms (deterministic obfuscation mode)
adder_locked_op1=$(($(od -A n -N 4 -t u /dev/urandom)))
adder_locked_op1_mask=4095
adder_locked_op2=0
adder_locked_op2_mask=0
adder_locked_flags=0
adder_locked_flags_mask=0
adder_locked_out=$(($(od -A n -N 4 -t u /dev/urandom)))

...

```

## Repository Layout

The basic release includes these files and subdirectories:
benchmark_runscripts - sample GEM5 runscripts for running PARSEC and SPLASH-2 on sample disk images
helper_scripts - set of scripts to automatically generate obfusgem header files
gem5 - modified GEM5 simulator for ObfusGEM simulation capabilities. Although heavily modified, prior GEM5 documentation at gem5.org will generally apply as ObfusGEM modifications only become visible when enabled in the "obfusgem.conf" file.
obfusgem_runscript.sh - sample ObfusGEM runscript to launch obfusgem simulation
obfusgem.conf - configuration file for ObfusGEM simulation runs

## Brief Usage Notes

We suggest the following steps when running ObfusGEM:

1. Edit the architectural configuration of the simulated core. We have shown examples using "starter_fs.py" and "fs.py" configuration files. Alternatives or sample files to create your own architecture are located throughout <REPO_HOME>/gem5/configs/.

2. Modify the hardware security configuration and simulation parameters of ObfusGEM in "obfusgem.conf". Note that there are architectural and run command specific parameters in this file which must be updated as well. We suggest parameter sweeps or parameter randomization for design space exploration problems.

3. Run ObfusGEM with

```
bash ./obfusgem_runscript.sh
```

4. On termination, the resulting simulation files will be recorded in the "obgem_out" directory. Timestamped run files and simulation "diffs" are included in each directory organized by the runscript used to create the file. Overall "PASS/FAIL" type results are aggregated in the automatically generated file "global_sim_data.csv" in the same directory.

## License

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met: redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer;
redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution;
neither the name of the copyright holders nor the names of its
contributors may be used to endorse or promote products derived from
this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
