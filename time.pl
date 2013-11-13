#! /usr/bin/perl

package DDG::Goodies::Timer;
# ABSTRACT: Countdown from user input to 0.

use Modern::Perl;
#use DDG::Goudie;
#triggers start => 'timer';
#handle remainder => sub {
#&timer($_);
#}

sub timer {
    my $countdown = shift;
    my @pair = ($countdown =~ m/(\d+\s\w+)/g);
    
    my $cd = 0;
    my $i = 0;
    my $tmp;
    foreach my $lol (@pair) {
	print "$lol\n";
	my @temp = split ' ', $pair[$i];

	$tmp = $temp[0];	
	if ($temp[1] eq "hour") {
	    $tmp = $tmp * 60 * 60;
	} elsif ($temp[1] eq "min") {
	    $tmp = $tmp * 60;
	} elsif ($temp[1] eq "sec") {
	    $tmp = $tmp;
	}
	
	print "tmp = $tmp\n";
	$cd = $cd + $tmp;
	$tmp = 0;
	$i++;
    }
    print "$cd\n";

    $| = 1;
    my $begtime = time;
    my $endtime = $begtime + $cd;
    
    for (;;) {
	my $time = time;
	last if ($time >= $endtime);
	
	printf("\r%02d:%02d:%02d",
	       ($endtime - $time) / (60 * 60),
	       ($endtime - $time) / (60) % 60,
	       ($endtime - $time) % 60,
	    );
	sleep(1);
    }
}

&timer("1 hour 30 min 45 sec");
