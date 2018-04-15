

BEGIN{
#  highestPkt = 0; 
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

    if(action=="+" && type=="tcp" && src=from){
#       back[seq_no]=time;
	printf("%d %.4f\n",seq_no%60,time);
    }

#   if(seq_no> highestPkt) highestPkt = seq_no;

}

END{

#    for(i=0; i < highestPkt; i++) {
#       printf("%d %.4f %.4f\n",i%60,recv[i],back[i]);
#   }
}
