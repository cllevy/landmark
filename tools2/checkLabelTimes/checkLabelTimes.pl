#!/usr/bin/perl

print "This program checks to make sure that the times for each label are sequential\n";
print "10/4/01 NMV\n"; 

print "What is the name of the file you want to check? (e.g. k11_mjx.label)\n";
$infile = <STDIN>;

open (CHECK, "<".$infile) or die("$!, stopped");
@lines =<CHECK>;
close(CHECK);
print "\n\n"; 

@times1 = ();
@phones1 = ();
foreach $line (@lines){
	if( $line =~ /Symbol:/){
		push (@phones1, $line); 
	}
	elsif( $line =~ /Time:/){
		push (@times1,$line); 
	}
}  

$endPhones = @phones1;
$endTimes = @times1;

if($endPhones != $endPhones){
	print "different numbers of times and labels\n";
	# probabably want to bail out here, but didn't write this feature
}  

@times = ();
@phones = ();

for($i=0;$i < $endPhones; $i++){
	$time = shift(@times1);
	$phone = shift(@phones1);
	if($time =~ /[0-9]+/){
		chomp($time); 
		@temp = split(/: /,$time);
#		print $temp[1]. "\n";  
		push (@times, $temp[1]);
		chomp($phone); 
		push (@phones, $phone); 
	} 

}

$endPhones = @phones;
$endTimes = @times;

$okay = "okay"; 
for($i=0;$i < $endPhones-1; $i++){
#	print "\n\n next phone:\n" . $times[$i-1] . "   " . $phones[$i-1] . "\n"; 
#	print $times[$i] . "   " . $phones[$i] . "\n"; 
#	print $times[$i+1] . "   " . $phones[$i+1] . "\n"; 
#	$wait = <STDIN>;

	if($times[$i] > $times[$i+1]){
		print "trouble at $phones[$i] (incorrect time: $times[$i])\n";
		if($i>0){
			print "\tbetween $times[$i-1] ($phones[$i-1]) and $times[$i+1] ($phones[$i+1])\n";
		}else{
			print "\tbefore $times[$i+1] ($phones[$i+1])\n";  
		}
		$okay = "wrong"; 
	}
}

if( $okay eq "okay"){
	print "No problems with the times in $infile\n";
}
else {
	print "This program found problems with the times in $infile\n";
}


	
