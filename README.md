Developed on Centos7, ns-2.35

clear.sh
- clears all output files: \*.txt, \*.tr, \*.nam

run.sh
*runs simple.tcl,throughput.awk,loss-rate.awk,fack.awk,pktnum.awk,plots cwnd,plots pktnum
-takes 0 or 1 parameters
-parameter 1: mode, which can be "Tahoe","Reno","Newreno","Sack1"
-parameter 1: case-sensitive
-if there is no parameter, the default is "Tahoe"

all.sh
-does not take parameters
-executes everything in every mode

example:
```
$ ./all.sh
Clearing output files...
Running Tahoe...
Throughput: 0.824Mbps
Packets sent:270, Received:258
Loss rate:4.44%
Running Reno...
Throughput: 0.765Mbps
Packets sent:249, Received:240
Loss rate:3.61%
Running Newreno...
Throughput: 0.874Mbps
Packets sent:289, Received:274
oss rate:5.19%
Running Sack1...
Throughput: 0.920Mbps
Packets sent:303, Received:288
Loss rate:4.95%
```

see './pic/' for more example
~~im too lazy to rename the pics~~
