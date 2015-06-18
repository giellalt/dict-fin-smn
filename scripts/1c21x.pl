#!/usr/bin/perl -w
use utf8 ;

# Simple script to convert csv to xml
# For input/outpus examples, see below.


print STDOUT "<r>\n";

while (<>) 
{
	chomp ;
	my ($lemma, $trans, $POS) = split /\t/ ;
	print STDOUT "   <e>\n";
	print STDOUT "      <lg>\n";
	print STDOUT "         <l pos=\"$POS\">$trans</l>\n";
	print STDOUT "      </lg>\n";
	print STDOUT "      <mg>\n";
	print STDOUT "         <tg lang=\"sme\">\n";
	print STDOUT "            <t pos=\"$POS\">$lemma</t>\n";
	print STDOUT "         </tg>\n";
	print STDOUT "      </mg>\n";
	print STDOUT "   </e>\n";
}

print STDOUT "</r>\n";



# Example input:
#
# aampumakenttä	N	skytefelt


#Target output:
#
#   <e src="yr">
#      <lg>
#         <l pos="N">aampumakenttä</l>
#      </lg>
#      <mg>
#         <tg>
#            <t pos="N" gen="x">skytefelt</t>
#         </tg>
#      </mg>
#   </e>
#

