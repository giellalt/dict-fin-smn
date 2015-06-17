#!/usr/bin/perl -w
use utf8 ;

# Simple script to convert csv to xml
# For input/outpus examples, see below.


print STDOUT "<r>\n";

while (<>) 
{

s/,</,/g; # ad hoc fix

s/H/h/g;
s/M/m/g;
s/N/n/g;
s/Ŋ/ŋ/g;
s/L/l/g;
s/V/v/g;
s/S/s/g;
s/Š/š/g;
s/R/r/g;
s/Đ/đ/g;
s/J/j/g;

s/'//g;

print ;
}

