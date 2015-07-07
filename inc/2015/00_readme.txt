This folder contains the finsmn dictionary sent by
Taarna Valtonen in early june 2015. See below for the
accompanying letter. With it there also came a smnfin file
(see smnfin/inc/2015).

The columns are the following

     1	    SUOMI
     2	    SÄMIKIELÂ UUCÂMSÄÄNI
     3	    SAAMEN_HAK
     4	    SUOMEN_HAK
     5	    SAAMEN_RIN
     6	    ESIMERKKEJÄ JA LIITTYVIÄ ILMAUKSIA
     7	    SAAMEN_YHD
     8	    SUOMEN_YHD
     9	    SAAMEN_TAI
    10	    SUOMEN_HA2
    11	    SUOMEN_J_L

Delivered with this letter:

Pyeri iiđeed/iijâ!

Tast lahtosin suomâ-säämi ja säämi-suomâ sänikirjemateriaaleh Excelist
ton tiileest ko toh tääl láá. Maati tivodmijn aldasij puoh láá
fáárust, mut jiem lah puáhtám tärhistiđ taid uđđâsist. Nuuvt et
illátusah láá vejuliih. Tuáivuu mield puoh mana kuittâg pyereest.

Tast te tibi alga uđđâlágan servodâtlâš sänikirjeproojeekt, ko
kevtteeh uážuh kommentistiđ tyeji já iävtuttiđ uđđâ saanijd jna.

Tääl aaigum uáđđiđ muáddi tijme ko piäiváš-uv lii jo pajânâm.

Tierv. Taarna

==========================
Fra: Taarna Valtonen
Emne: Errata sátnegirjái
Dato: July 3, 2015 at 12:30:46 GMT+2
Til: Trond Trosterud

Dearvva!

Dás čuovusin errata-dieđut anárašgiela sátnegirjái. Leat Morottaja Matti divodeamit ja eará fuomašumit. Eanas oassi leat uhca feaillažat '-mearkkat jed. Lean merken dakkár gurgadasaid, main lea feaila / leat feaillat ruoná foantaivnniin, nu ahte leat álkit gávdnamis Excela ohcangaskomiin. Dat leat gal dan mađe olu, ahte gánneha jurddašit viššágo manuálalaččat divvut. Ledje báhcán olu divokeahtes sánit dalle go ovddit háve sáddejin, danin go ii lean doarvái olu áigi Matti divodemiidda. Dál lean bargan guokte luopmovahku daiguin. Sávvamis dál lea stuorimus oassi materiálas sullii ortnegis.

Dál vuolggán lupmui inge leat fierpmádaga olis boahtte iđida rájes guovtti vahkui.

Oaidnáleapmái Oulus borgemánus!
Dearvv. Taarna

==========================


Legend:
     1	A SUOMI	=> FIN lemma
     2	B SÄMIKIELÂ UUCÂMSÄÄNI	=> SMN lemma
     3	C SAAMEN_HAK	=> Saami_Lemma (First part of compound words made by concatenating DH)
     4	D SUOMEN_HAK	=> Finnish_Lemma  (First part of compound words made by concatenating EI)
     5	E SAAMEN_RIN	=> Saami_Parallel (this is additional information related to the Saami_Lemma)
     6	F ESIMERKKEJÄ JA LIITTYVIÄ ILMAUKSIA	Examples???
     7	G SAAMEN_YHD	=> Saami_Compound  (Second part of compound words made by concatenating DH)
     8	H SUOMEN_YHD	=> Finnish_Compound  (Second part of compound words made by concatenating EI)
     9	I SAAMEN_TAI	=> Saami_TAI This is a field containing Saami stem information (irrelevant in an NDS with fst)
    10	J SUOMEN_HA2	=> Finnish_2nd_Lemma
    11	K SUOMEN_J_L	=> Finnish_J_L This is a <re> field containing Latin terms and field specifications

A: =CONCATENATE(DH," ",J," ",K)
B: =CONCATENATE(CG," ",I," ",E," ",F," "," ") = 3 7, 5, 9

<e>
  <l>DH</l>
  <mg>
    <tg>
      <re>K</re>
      <t>CG</t>
      <t>E</t>
    </tg>
  </mg>
</e>

Issues with the target language:
1. Which are (quasi-)synonyms and should land in the same mg and which not?
2. Separators: , ;
3. Other characters: . ~ - ( ) # =
4. COMMA abmiguity:
Ex.
   (ehyt, jtak pitävä) čavos čappoos # čapo; (esim. sauma) lävvid~läävviđ # läVidis; (tiivis aine) tooškâs toškâs # toškâ, čaavdes;





