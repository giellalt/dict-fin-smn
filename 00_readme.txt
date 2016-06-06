
@trond: Important question: where do these data sets (fin_* and smn_* files) stem from?
==> fin_smn from fin_smn dict (incoming), smn_fin from smn_fin dict (incoming), as 
==> described in letters from Taarna Valtonen.
==> cf. finsmn/inc/2015/00_readme.txt
==> cf. smnfin/inc/2015/00_readme.txt

Work plan for improving the finsmn*) dictionary.


PROGRAMMER WORK:

Move all entries with SPACE in lemma to MWE_finsmn.xml
======================================================
There are 67 of them, almost all of them are fixed expressions.
These may just be moved to MWE_finsme at once.
 ==> DONE

Add part of speech lemma and translation :
=========================================
 ==> DONE

Split the all_finsmn.xml according to fin POS.
==============================================
... after fin POS have been added
 ==> DONE

Unifiy the lema_pos entries to improve the presentation of matches in NDS
=========================================================================
 ==> TODO

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
