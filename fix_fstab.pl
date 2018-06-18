
open(FH,"/etc/fstab");
@arr = <FH>;
close(FH);

open(NFH,'>', "fstab.new");

foreach $line (@arr) {
  if ($line =~ /swap/ and $line !~ /^#/) {
    print NFH "# $line";
  } else {
    print NFH $line;
  }
}

close(NFH);

system("cp fstab.new /etc/fstab");
system("swapoff -a");
system("rm -f fstab.new");
