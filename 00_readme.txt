
@trond: Important question: where do these data sets (fin_* and smn_* files) stem from?


Work plan for improving the finsmn*) dictionary.


PROGRAMMER WORK:

Move all entries with SPACE in lemma to MWE_finsmn.xml
======================================================
There are 67 of them, almost all of them are fixed expressions.
These may just be moved to MWE_finsme at once.

Add part of speech lemma and translation :
=========================================
We have POS for 93% of fin and 85% of smn (with some overlap, especially for A=N)
The main POS are listed in files fin_A, etc and smn_A, etc.

For each l node, fill in POS according to key in files fin_*

For each one-word t node, fill in POS according to key in files smn_*
For each multiword t node, inherit the POS from the l node


In case of more than one POS, one may
a. take the pos from the opposite member of the pair
b. take both, and leave the decision for manual inspection

src>cat fin_*|s|uc|snr|g ' 3 '|c
       8
src>cat fin_*|s|uc|snr|g ' 2 '|c
     815

src>cat smn_*|s|uc|snr|g ' 2 '|c
     328
src>cat smn_*|s|uc|snr|g ' 3 '|c
       8


Split the all_finsmn.xml according to fin POS.
==============================================
... after fin POS have been added





LINGUIST WORK:

Dictionary translations missing in fst:
=================================
Some of the smn words are wrong, and have a correct version in the fst.
(They are typos or outside the norm). These should be corrected in the dictionary

Some of the smn words are just missing in the fst. 
They should be added.


Dictionary lemmas missing in fst:
=================================
Assume Finnish words are written correctly 
Add missing Finnish words to langs/fin/src/morphology/stems (not high priority)



----

*)
The original source file is described in 
finsmn/inc/2015/00_readme.txt

Later additions have come via Giellatekno / Giellagáldu work with FST and dictionary.
