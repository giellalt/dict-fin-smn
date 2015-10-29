<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inDir=DIR
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:my="my"
		exclude-result-prefixes="xs xhtml my">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

  <xsl:output method="xml" name="dix"
	      encoding="UTF-8"
	      omit-xml-declaration="yes"
	      indent="no"/>

  <xsl:output method="text" name="txt"
              encoding="UTF-8"/>

  <xsl:output method="html" name="html"
              encoding="UTF-8"
              version="4.0"
              indent="yes"/>

  <!-- adjust to your needs -->
  <xsl:param name="inFile" select="'all_sme2smn_levenshtein_check_tEQ1.xml'"/>
  <xsl:param name="utFileName" select="'apertium-sme-smn.sme-smn'"/>
  <!-- adjust to your needs -->
  <xsl:param name="outDir" select="'bdx_out'"/>
  <xsl:variable name="of" select="'dix'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="false()"/>
  <xsl:variable name="nl" select="'&#xa;'"/>
  <xsl:variable name="sr" select="'\*'"/>
  <xsl:variable name="rarrow" select="'▸'"/>
  <xsl:variable name="tb" select="'&#x9;'"/>
  <xsl:variable name="apo">'</xsl:variable>
  <xsl:variable name="vCaps" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

  <!-- extend or change this mapping as needed -->
  <xsl:variable name="pos_map">
    <map gt="A" ap="adj"/>
    <map gt="Adv" ap="adv"/>
    <map gt="CC" ap="cnjcoo"/>
    <map gt="CS" ap="cnjsub"/>
    <map gt="Interj" ap="interj"/>
    <map gt="N" ap="n"/>
    <map gt="Num" ap="num"/>
    <map gt="Po" ap="po"/>
    <map gt="Pr" ap="pr"/>
    <map gt="Pron" ap="prn"/>
    <map gt="V" ap="vblex"/>
    <map gt="mwe" ap="mwe"/>
  </xsl:variable>
 
  <xsl:template match="/" name="main">
    <xsl:result-document href="{$outDir}/{$utFileName}.{$of}" format="{$of}">
      <dictionary>
	<xsl:for-each-group select="doc($inFile)/r/e"  group-by="./@p">
	  <xsl:sort select="$pos_map/map[./@gt=current-grouping-key()]/@ap" />
	  <!-- SECTION: Adverbs -->
	  <xsl:value-of select="$nl"/>
	  <xsl:value-of select="'    '"/>
	  <xsl:comment>
	    <xsl:value-of select="concat('    SECTION: ',$pos_map/map[./@gt=current-grouping-key()]/@ap)"/>
	  </xsl:comment>
	  <xsl:value-of select="$nl"/>
	  <xsl:value-of select="$nl"/>
	  <xsl:for-each select="current-group()">
	    <xsl:sort select="./@s" />

	    <xsl:if test="true()">
	      <xsl:message terminate="no">
		<xsl:value-of select="concat('lemma ', ./@s, $nl)"/>
	      </xsl:message>
	    </xsl:if>

	    <xsl:variable name="current_lemma" select="./@s"/>
	    <xsl:variable name="current_pos" select="./@p"/>
	    <xsl:for-each select="./t">
	      
	      <xsl:value-of select="'    '"/>
	      <e><p><l><xsl:value-of select="$current_lemma"/><s n="{$pos_map/map[./@gt=$current_pos]/@ap}"/></l><r><xsl:value-of select="."/><s n="{$pos_map/map[./@gt=$current_pos]/@ap}"/></r></p></e>
	      <xsl:value-of select="$nl"/>
	    </xsl:for-each>
	  </xsl:for-each>
	</xsl:for-each-group>
      </dictionary>
    </xsl:result-document>

  </xsl:template>
  
</xsl:stylesheet>
