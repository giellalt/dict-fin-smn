1. compile fst file after Tronds last changes
xfst -f ~/main/langs/smn/src/scripts/smn-sme-lemma.xfscript

2. extract and unique the t-strings
g '<t ' all_sme2smn_levenshtein_check.xml |z|s|u> smn_t4pseudo-sme_t.txt

3. map real smn strings into pseudo-sme strings 
cat smn_t4pseudo-sme_t.txt |lookup smnsme.fst > smn2pseudo-sme_map.txt

4. get rid of the empty lines from the fst output
g -v '^\s*$' smn2pseudo-sme_map.txt > smn2pseudo-sme_map.txt___

5. replace the files with empty lines by the one without
mv smn2pseudo-sme_map.txt___ smn2pseudo-sme_map.txt

6. calculate the Levenshtein distance between the sme lemma and the modified smn strings
_six add_pseudo-sme2ls_xml.xsl

7. add the latest version to the svn
svn add all_sme2smn_lsd_pseudo-sme_v2.xml

