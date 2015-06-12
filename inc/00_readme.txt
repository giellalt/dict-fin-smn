
This catalogue contains the file suoma-saami-sanikirjeversio-12012015, in two versions:
suoma-saami-sanikirjeversio-12012015.xlsx (the original)
suoma-saami-sanikirjeversio-12012015.csv  (saved via libreoffice, TAB delimiter)

The fields are:

A     1	SUOMEN_HAKSUOMEN_YHD SUOMEN_HA2 SUOMEN_J_L
B     2	SUOMEN_POS fin_pos
C     3	SAAMEN_HAKSAAMEN_YHD  SAAMEN_TAI  SAAMEN_RIN  ESIMERKIT JA MUITA HAKUSANAAN LIITTYVIÄ SANOJA  
D     4	SAAMEN_HAK
E     5	SUOMEN_HAK
F     6	SAAMEN_RIN
G     7	ESIMERKIT JA MUITA HAKUSANAAN LIITTYVIÄ SANOJA
H     8	SAAMEN_YHD
I     9	SUOMEN_YHD
J    10	SAAMEN_TAI
K    11	SUOMEN_HA2
L    12	SUOMEN_J_L

The fields are (now also translated):

A     1	Finnish_LemmaFinnish_Compound Finnish_2nd_Lemma Finnish_J_L (J_L
B     2	Finnish_POS 
C     3	Saami_LemmaSaami_Compound  Saami_TAI  Saami_Parallel  Examples and other words associated with the Lemma  
D     4	Saami_Lemma (First part of compound words made by concatenating DH)
E     5	Finnish_Lemma  (First part of compound words made by concatenating EI)
F     6	Saami_Parallel (this is additional information related to the Saami_Lemma)
G     7	Examples and other words associated with the Lemma
H     8	Saami_Compound  (Second part of compound words made by concatenating DH)
I     9	Finnish_Compound  (Second part of compound words made by concatenating EI)
J    10	Saami_TAI This is a field containing Saami stem information (irrelevant in an NDS with fst)
K    11	Finnish_2nd_Lemma
L    12	Finnish_J_L This is a <re> field containing Latin terms and field specifications

Note that two of the fields in the Excel file are functions of other fields.

A: =CONCATENATE(E1,I1," ",K1," ",L1,)
C: =CONCATENATE(D1,H1,"  ",J1,"  ",F1,"  ",G1," "," ")

So:
The Finnish lemma is E (or EI)
The Saami lemma is D (or DH)

Capital consonants shall be scripted to 
- the corresponding small letters for Apertium bidix
- In the so-called dictionary orthography they are
   ṃ  ṇ  ŋ̣  ṿ  ṣ  ṛ  đ̣  ḷ  j̣  ḥ  ṣ̌  
   (i.e. small letters followed by U+0323) 
   and they are marked as such in the lower side of the fst.
   FST-wise, we remove this info on the lemma (upper) side

After added SUOMEN_POS to the smn words, the distribution of POS is:

11418 N
3620 V
1252 A
 863 X
 299 Adv
  71 Pcle
  46 Num
  43 Pron
  17 Po
  17 Interj
  13 CC
  10 CS
   1 SUOMEN_POS


Capital letter marks DOT BELOW (half-length), and should be marked as R = r7, V = v7, etc. in the lower side of lexc

This is the letter that followed the file:

12.01.15.

Tiervâ!

Taast lii lahtosin suomâ - säämi -sänikirje Excel-vuárkkán. Lam keččâlâm tärhistiđ tom nuuvt pyereest ko puávtám, mut tiäđust-uv tobbeen láá feeilah jet huolâttesvuođâfeeilah.

Taast mottoom merkkimvuovij pirrâ:

Stuorrâ puustuveh láá kevttum tuš pelikuhes konsonaantij merkkân. Ton tet materiaalist iä lah noomah já mottoom soojin lasičielgimijn lii ovdâmerkkân Raamattu čallum raamattu. Toh mottoom noomah moh lijjii originaal materiaalist láá kuođđum meddâl.

Vuosmuš kyehti sárgáttuv lává čuákánkiäsuh eres sárgáttuvvâin (Hánno tyeji). 

Fiskes ivnijn láá merkkum tagareh säänih, moh láá lasettum originaal = Márjá-Liisá materiaalin. Toi tehelumos käldee lii Maati já Ilmar Uđđâ säänih -listo, mut tobbeen láá säänih meiddei Erkki-čeesi sänikirjeest ja om. Anârâš-loostâst. Hánnoin lii lamaš saahâ, et sun koijâd Maatis, jis tast ličij mielâ tärhistiđ taid.

Ruonáá ivnijn láá merkkum tagareh säänih, main lam kavnâm tiäđu, et Kielârävvimjuávkku lii tuhhiittâm/tärhistâm taid.

Tävgiruáđui siste lii tärhilub čielgim čuávuváá säänist. Jis lii tuš ohtâ vaastâ, te tot lii suomâkielâ uuccâmsääni maŋŋeel, jis vastuuh láá maaŋgah čielgim lii ain jyehi sääni ovdiibeln. Siämmáá náál tävgiruáđuigijn láá sierrijum suomâkielâ ovdâmerkkâcelkkuuh já eres materiaal sämikielâ jurgâlusâst ovdâmeerhah-sárgáttuvvâst.

Pilkku saanij kooskâst meerhâš, et saanijn kyevtpeln piilku lii aldaaš ohtiikullevâšvuotâ merhâšume tááhust.

Peličuogâstâh saanij kooskâst meerhâš, et saanijn kyevtpeln peličuogâstuv ij lah koskâvuotâ merhâšume tááhust teik ohtâvuotâ ij lah aldaaš.

~ meerhâš variaatio. Jis páro kyevtpeln láá kooskah, te variaatio lii stuáráb ko jis tagareh iä lah. Koskâittáá lii vookaalvariaatio, mut jis variaatio kuáská om. sujâttemtiijpân (uánnum vs. normaaltijppâ) teikkâ konsontkuávdáážan, te lam kiävttám kooskâid.

Jis láá eres merkkimeh, maid jiem lah hoksaam čielgiđ, čälliđ munjin maasâd.

Pyeri pargo-okko Roomsân!
Tierv. Taarna
