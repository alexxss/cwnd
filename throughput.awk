
BEGIN {
    recvdSize = 0
    transSize = 0
    startTime = 400
    stopTime = 0
}

{

	action=$1;
	time=$2;
	from=$3;
	to=$4;
	type=$5;
	pktsize=$6;
	flow_id=$8;
	src=$9;
	dst=$10;
	seq_no=$11;
	packet_id=$12;

    # Store start time
    if (from == "0") {
        if (time < startTime) {
            startTime = time
        }

    }

    # Update total received packets' size and store packets arrival time
    if (action == "r" && to==dst) {
        if (time > stopTime) {
            stopTime = time
        }
        # Store received packet's size
        
            recvdSize += pktsize
        
    }
}

END {
    printf("Throughput: %.3fMbps\n",(recvdSize*8/1000000)/(stopTime-startTime));
}
