if [ $# -eq 0 ]; then
    mode="Tahoe"
else
    mode=$1
fi
ns simple.tcl $mode
awk -f throughput.awk ${mode}_out.tr
awk -f loss-rate.awk ${mode}_out.tr
awk -f fack.awk ${mode}_out.tr > ${mode}_ack.txt
awk -f pktnum.awk ${mode}_out.tr > ${mode}_pktnum.txt
gnuplot -p -e "set xrange [0.2:3.2]; set xtics 0,0.2,3;set xlabel 'Time(s)';set ylabel 'Congestion Window'; set title '$mode';plot '${mode}_cwnd1.tr' using 1:2 with lines title 'n0 cwnd' , '${mode}_cwnd1.tr' using 1:3  with lines title 'n0 sst' "
#gnuplot -p -e "set xrange [0.2:3.2]; set xtics 0,0.2,3;set xlabel 'Time(s)';set ylabel 'Congestion Window'; set title '$mode';plot '${mode}_cwnd0.tr' using 1:2 with linespoint title 'n0 cwnd' , '${mode}_cwnd0.tr' using 1:3 with linespoint title 'n0 sst' ,'${mode}_cwnd1.tr' using 1:2 with linespoint title 'n1 cwnd' , '${mode}_cwnd1.tr' using 1:3  with linespoint title 'n1 sst' "
gnuplot -p -e "set xrange [0.2:3.2]; set xtics 0,0.2,3;set xlabel 'Time(s)';set ylabel 'Packet # (mod 60)'; set title '$mode'; set datafile missing '0.0000';plot '${mode}_pktnum.txt' using 2:1 linestyle 8, '${mode}_ack.txt' using 2:1 linestyle 2"
