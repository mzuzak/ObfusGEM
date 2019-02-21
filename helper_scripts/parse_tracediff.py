import re
import os
import sys

# I/O Files
txt_file = r"tracediff.log"

if not os.path.isfile('./../../../global_sim_data.csv'):
    f = open('./../../../global_sim_data.csv', 'w')
    # Print the header
    f.write('Benchmark, Lock Type, Incorrect Lock Bits, Result, Ops Until Trace Diverges\n')
else :
    f = open('./../../../global_sim_data.csv', 'a')

# Print the useful input arg simulation info
f.write(sys.argv[1] + ',')
f.write(sys.argv[2] + ',')
f.write(sys.argv[3] + ',')

# Now pull the data we care about
with open("tracediff.log") as in_file:
    if "Lost sync!" not in in_file.read():
        f.write("Pass,N/A\n")
    else:
        for line in reversed(open("tracediff.log").readlines()):
            if "Lost sync!" in line:
                f.write("Fail," + str(int((line.split(' ')[-1])[:-2])-32) + '\n')
                break

f.close()
