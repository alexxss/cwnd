BEGIN{
   highestPkt = 0; 
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

    if(action=="r" && to=="2" && recv[seq_no]==0){
#        printf("%.4f %d\n",time,seq_no%60);
        recv[seq_no]=time;
    }

#   if(action=="r" && type=="ack" && to=="1"){
#       back[seq_no]=time;
#   }

    if(seq_no> highestPkt) highestPkt = seq_no;

}

END{

     for(i=0; i < highestPkt; i++) {
        printf("%d %.4f\n",i%60,recv[i]);
    }
#    for(i = 1; i < highestPkt; i++){
#       printf("%d,%.4f\n",i,arrvTime[seq_no]);
#  } 
}
