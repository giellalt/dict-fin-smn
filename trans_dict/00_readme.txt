Task: constraining the (near-/pseudo-)synonyms of t-elements in the sme2smn dict
1. 1:1 (mapping between l:t) ==> DONE
all_sme2smn_levenshtein_check_tEQ1.xml 

2. 1:many

2.1  mld less than 4 ==> DONE
all_sme2smn_lsd_pseudo-sme_LT4.xml

2.2 mld greater than 3 ==> ongoing work

   <e s="anonyma" p="A">
      <t mld="6" old="7" p_sme="oarbaš" link="nimetön_A">uárbâš</t>
      <t mld="6" old="8" p_sme="oarbišmaš" link="nimetön_A">uárbišmâš</t>
      <t mld="7" old="7" p_sme="nomatten" link="nimetön_A">nomâttem</t>
      <t mld="7" old="7" p_sme="oarbmušn" link="nimetön_A">uármušm</t>
      <t mld="8" old="9" p_sme="oarbášnjaš" link="nimetön_A">uárbášnjâš</t>
   </e>

"nimetön" issue ==> use CONTAINS aka fuzzy matching
   <e id="26635">
      <lg>
         <l pos="N" rest="">uárbâš</l>
      </lg>
      <mg>
         <tg xml:lang="fin">
            <t>nimetön (sormi)</t>
         </tg>
      </mg>
   </e>
   <e id="26636">
      <lg>
         <l pos="A" rest="">uárbášnjâš</l>
      </lg>
      <mg>
         <tg xml:lang="fin">
            <t>nimetön (sormi)</t>
         </tg>
      </mg>
   </e>


2.2.1 with at least one t-element that have a corresponding
      entry in the smn2fin (noisy!!!) data ==> DONE
all_sme2smn_lsd_pseudo-sme_GT3_fin-link-filtered.xml

2.2.2 with no t-element that have a corresponding
      entry in the smn2fin (noisy!!!) data ==> TODO

=== 
docu on the caluculation of mld, i.e., levenshtein distance of
the modified smn string as pseudo-sme
===
1. compile fst file after Tronds last changes
xfst -f ~/main/langs/smn/src/scripts/smn-sme-lemma.xfscript

2. extract and unique the t-strings
TODO: update, no file "all_sme2smn_levenshtein_check.xml"
grep '<t ' all_sme2smn_levenshtein_check.xml |tr '<' '>'|cut -d">" -f3|sort|uniq > smn_t4pseudo-sme_t.txt

3. map real smn strings into pseudo-sme strings 
cat smn_t4pseudo-sme_t.txt |lookup smnsme.fst > smn2pseudo-sme_map.txt

4. get rid of the empty lines from the fst output
grep -v '^\s*$' smn2pseudo-sme_map.txt > smn2pseudo-sme_map.txt___

5. replace the files with empty lines by the one without
mv smn2pseudo-sme_map.txt___ smn2pseudo-sme_map.txt

6. calculate the Levenshtein distance between the sme lemma and the modified smn strings
_six add_pseudo-sme2ls_xml.xsl

trans_dict>alias _six
alias _six='java -Xmx16800m -Dfile.encoding=UTF8 net.sf.saxon.Transform -it:main'

7. add the latest version to the svn
svn add all_sme2smn_lsd_pseudo-sme_v2.xml

