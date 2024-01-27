#!/usr/bin/perl -w
use utf8 ;

# Simple script to convert csv to xml
# For input/outpus examples, see below.


print STDOUT "<r>\n";

while (<>) 
{
	chomp ;
#	my ($lemma, $POS, $trans, $trans2, $trans3) = split /\t/ ;
	my ($item, $Fi, $Smn, $Se, $Sms, $Sma, $Smj, $Nb, $En, $Ru) = split /\t/ ;
	print STDOUT "   <e src=\"$item\">\n";
	print STDOUT "      <lg>\n";
	print STDOUT "         <l pos=\"N\" type=\"Prop\" sem_type=\"Plc\">$Fi</l>\n";
	print STDOUT "      </lg>\n";
	print STDOUT "      <mg>\n";
	print STDOUT "         <tg xml:lang=\"smn\">\n";
	print STDOUT "            <t pos=\"N\" type=\"Prop\">$Smn</t>\n";
#	print STDOUT "            <t pos=\"$POS\">$trans2</t>\n";
#	print STDOUT "            <t pos=\"$POS\">$trans3</t>\n";
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

