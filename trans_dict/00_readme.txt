Task: constraining the (near-/pseudo-)synonyms of t-elements in the sme2smn dict
1. 1:1 (mapping between l:t) ==> DONE
 OUTPUT: all_sme2smn_levenshtein_check_tEQ1.xml 

trans_dict>g '<e' all_sme2smn_levenshtein_check_tEQ1.xml|c
    2653
trans_dict>g '<t' all_sme2smn_levenshtein_check_tEQ1.xml|c
    2653

2. 1:many

2.1  mld less than 4 ==> DONE
 OUTPUT: all_sme2smn_lsd_pseudo-sme_LT4.xml

trans_dict>g '<e' all_sme2smn_lsd_pseudo-sme_LT4.xml|c
    2333
trans_dict>g '<t' all_sme2smn_lsd_pseudo-sme_LT4.xml|c
    2511

2.2 mld greater than 3 ==> DONE

2.2.1 with at least one t-element that have a corresponding
      entry in the smn2fin (noisy!!!) data ==> DONE
 OUTPUT: all_sme2smn_lsd_pseudo-sme_GT3_fin-link-filtered.xml

trans_dict>g '<e' all_sme2smn_lsd_pseudo-sme_GT3_fin-link-filtered.xml|c
    1462
trans_dict>g '<t' all_sme2smn_lsd_pseudo-sme_GT3_fin-link-filtered.xml|c
    4542

2.2.2 with no t-element that have a corresponding
      entry in the smn2fin (noisy!!!) data ==> DONE
 OUTPUT: all_sme2smn_lsd_pseudo-sme_GT3_fin-link-filtered-n.xml

trans_dict>g '<e' all_sme2smn_lsd_pseudo-sme_GT3_fin-link-filtered-n.xml|c
      12
trans_dict>g '<t' all_sme2smn_lsd_pseudo-sme_GT3_fin-link-filtered-n.xml|c
      32



=== 
docu about the calculation of mld, i.e., levenshtein distance of
the modified smn string as pseudo-sme
===
1. compile fst file after Tronds last changes
xfst -f ~/main/langs/smn/src/scripts/smn-sme-lemma.xfscript

2. extract and unique the t-strings
grep '<t ' all_sme2smn_levenshtein_check_tGT1.xml |tr '<' '>'|cut -d">" -f3|sort|uniq > smn_t4pseudo-sme_t.txt

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

