#!/usr/bin/perl -w
use utf8 ;

# Simple script to convert csv to xml
# For input/outpus examples, see below.


print STDOUT "<r>\n";


while (<>) 


{
	chomp ;
	my ($lemma, $POS, $trans) = split /\t/ ;
#	my ($lemma, $POS, $trans, $trans2) = split /\t/ ;
#	my ($lemma, $POS, $trans, $trans2, $trans3) = split /\t/ ;
#	my ($lemma, $POS, $trans, $trans2, $trans3, $trans4, $trans5, $ex, $exj) = split /\t/ ;
	print STDOUT "   <e>\n";
	print STDOUT "      <lg>\n";
	print STDOUT "         <l pos=\"$POS\">$lemma</l>\n";
	print STDOUT "      </lg>\n";
	print STDOUT "      <mg>\n";
	print STDOUT "         <tg xml:lang=\"smn\">\n";
	print STDOUT "            <t pos=\"$POS\">$trans</t>\n";
#	print STDOUT "            <t pos=\"$POS\">$trans2</t>\n";
#	print STDOUT "            <t pos=\"$POS\">$trans3</t>\n";
#	print STDOUT "            <t pos=\"$POS\">$trans4</t>\n";
#	print STDOUT "            <t pos=\"$POS\">$trans5</t>\n";
#	print STDOUT "            <xg>\n";
#	print STDOUT "              <x>$ex</x>\n";
#	print STDOUT "              <xt>$exj</xt>\n";
#	print STDOUT "            </xg>\n";
	print STDOUT "         </tg>\n";
	print STDOUT "      </mg>\n";
#	print STDOUT "      <mg>\n";
#	print STDOUT "         <tg xml:lang=\"smn\">\n";
#	print STDOUT "            <t pos=\"$POS\">$trans2</t>\n";
#	print STDOUT "            <xg>\n";
#	print STDOUT "              <x></x>\n";
#	print STDOUT "              <xt></xt>\n";
#	print STDOUT "            </xg>\n";
#	print STDOUT "         </tg>\n";
#	print STDOUT "      </mg>\n";
#	print STDOUT "      <mg>\n";
#	print STDOUT "         <tg xml:lang=\"smn\">\n";
#	print STDOUT "            <t pos=\"$POS\">$trans3</t>\n";
#	print STDOUT "            <xg>\n";
#	print STDOUT "              <x></x>\n";
#	print STDOUT "              <xt></xt>\n";
#	print STDOUT "            </xg>\n";
#	print STDOUT "         </tg>\n";
#	print STDOUT "      </mg>\n";
	print STDOUT "   </e>\n";
}


#{
#	chomp ;
##	my ($POS, $A, $B, $C, $D, $E, $F, $G, $H, $I, $J, $K) = split /\t/ ;
#	print STDOUT "   <e src=\"MO\">\n";
#	print STDOUT "      <lg>\n";
#	print STDOUT "         <l pos=\"$POS\">$D$H</l>\n";
#	print STDOUT "      </lg>\n";
#	print STDOUT "      <mg>\n";
#	print STDOUT "         <tg>\n";
#	print STDOUT "            <t pos=\"$POS\">$C$G</t>\n";
#	print STDOUT "            <t pos=\"$POS\">$E</t>\n";
#	print STDOUT "            <xg>\n";
#	print STDOUT "              <x>$F</x>\n";
#	print STDOUT "              <xt></xt>\n";
#	print STDOUT "            </xg>\n";
#	print STDOUT "         </tg>\n";
#	print STDOUT "      </mg>\n";
#	print STDOUT "   </e>\n";
#}




print STDOUT "</r>\n";

# A     1	    SUOMI
# B     2	    SÄMIKIELÂ UUCCÂMSÄÄNI
# C     3	    SAAMEN_HAK
# D     4	    SUOMEN_HAK
# E     5	    SAAMEN_RIN
# F     6	    ESIMERKKEJÄ JA LIITTYVIÄ ILMAUKSIA
# G     7	    SAAMEN_YHD
# H     8	    SUOMEN_YHD
# I     9	    SAAMEN_TAI
# J    10	    SUOMEN_HA2
# K    11	    SUOMEN_J_L

# A = CONCATENATE(C14,G14,"  ",I14,"  ",E14,"  ",F14," "," ")

