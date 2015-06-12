#!/bin/bash

for file in 0_input/*.csv
do
 #awk '{for (i=1; i<=NF; i++) printf("<p>%s</p>",$i);printf ("\n")}' $file
 awk -F '\t' 'BEGIN{print "<r>"}
      {printf ("  <e id=\""NR"\">\n" );
      for (i=1; i<=NF; i++) printf "    <p id=\""i"\">"$i"</p>\n";
      printf ("  </e>");
      printf ("\n")}
      END{print "</r>"}' $file > $file.xml
done
