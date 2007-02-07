#!/usr/bin/perl

$g_filename = $ARGV[0];

open (IN_FILE, "<$g_filename") or die "Failed to open: \"$g_filename\"";
open (OUT_FILE, ">$g_filename.out") or die "Failed to open: \"$g_filename\"";

while ($line = <IN_FILE>)
{
   if ($line =~ /^\t@(.*)/)
   {
      #$line =~ s/ /\\\ /g;
      print OUT_FILE "\t@\"$1\"";
   }
   else
   {
      print OUT_FILE $line;
   }
}

close(OUT_FILE);
close(IN_FILE);

system ("mv $g_filename.out $g_filename");

