#reads command line args
set mode [lindex $argv 0]
set agent "Agent/TCP"
set sink "Agent/TCPSink"
if { $mode == "Sack1" } { 
	set sink "${sink}/${mode}"
}
if { $mode != "Tahoe" } { 
	set agent "${agent}/${mode}"
}

set ns [new Simulator]

$ns color 0 pink
$ns color 1 purple

#set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#set output file paths
set f [open ${mode}_out.tr w]
$ns trace-all $f
set nf [open ${mode}_out.nam w]
$ns namtrace-all $nf

#開啟一個檔案，用來記錄TCP Flow的congestion window變化情況
#set wnd_trace0 [open ${mode}_cwnd0.tr w]
set wnd_trace1 [open ${mode}_cwnd1.tr w]

#specify link 
#$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 1.2Mb 20ms DropTail

#set queue limit
$ns queue-limit $n2 $n3 10

#settings for nam
#$ns duplex-link-op $n0 $n2 orient right-up
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n3 orient right

$ns duplex-link-op $n2 $n3 queuePos 0.5

#define new tcp/ftp agents
#set tcp0 [new $agent]
#$ns attach-agent $n0 $tcp0
#$tcp0 set class_ 0
#set ftp0 [new Application/FTP]
#$ftp0 attach-agent $tcp0

set tcp1 [new $agent]
$ns attach-agent $n1 $tcp1
$tcp1 set class_ 1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

#define new sinks
#set sink0 [new $sink]
set sink1 [new $sink]
#$ns attach-agent $n3 $sink0
$ns attach-agent $n3 $sink1

#connect tcps to respecive sink
#$ns connect $tcp0 $sink0
$ns connect $tcp1 $sink1

#$ns at 0.3 "$ftp0 start"
#$ns at 0.4 "record0"
$ns at 0.3 "$ftp1 start"
$ns at 0.4 "record1"

$ns at 3.0 "finish"

#定義一個紀錄的程序，每隔0.1秒就去查看目前TCP Flow的值
#proc record0 {} {

#   global ns tcp0 wnd_trace0
#   set time 0.1

    #讀取C++內cwnd_的變數值
#   set curr_cwnd [$tcp0 set cwnd_]
#   set sst [$tcp0 set ssthresh_]
#   set now [$ns now]
#   puts $wnd_trace0 "$now $curr_cwnd $sst"
#   $ns at [expr $now+$time] "record0"

#}

#定義一個紀錄的程序，每隔0.1秒就去查看目前TCP Flow的值
proc record1 {} {

    global ns tcp1 wnd_trace1
    set time 0.05

    #讀取C++內cwnd_的變數值
    set curr_cwnd [$tcp1 set cwnd_]
    set sst [$tcp1 set ssthresh_]
    set now [$ns now]
    puts $wnd_trace1 "$now $curr_cwnd $sst"
    $ns at [expr $now+$time] "record1"

}

proc finish {} {
	global ns f nf
	$ns flush-trace
	close $f
	close $nf

#	puts "running nam..."
#	exec nam out.nam &
	exit 0
}

$ns run
