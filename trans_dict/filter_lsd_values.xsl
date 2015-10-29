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

  <xsl:output method="text" name="txt"
              encoding="UTF-8"/>

  <xsl:output method="html" name="html"
              encoding="UTF-8"
              version="4.0"
              indent="yes"/>

  <xsl:param name="inFile" select="'all_sme2smn_lsd_pseudo-sme_v4.xml'"/>
  <xsl:param name="version" select="'v4'"/>
  <xsl:param name="utFileName" select="'all_sme2smn_lsd_pseudo-sme_'"/>
  <xsl:param name="outDir" select="'some_odir'"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="false()"/>
  <xsl:variable name="nl" select="'&#xa;'"/>
  <xsl:variable name="sr" select="'\*'"/>
  <xsl:variable name="rarrow" select="'▸'"/>
  <xsl:variable name="tb" select="'&#x9;'"/>
  <xsl:variable name="apo">'</xsl:variable>
  <xsl:variable name="vCaps" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  
  <xsl:template match="/" name="main">
    <xsl:result-document href="{$outDir}/{$utFileName}GT3.{$of}" format="{$of}">
      <r>
	<xsl:for-each select="doc($inFile)/r/e[every $t in ./t
			      satisfies  (number($t/@mld)&gt;3)]"> 
	  <xsl:copy-of select="."/>
	</xsl:for-each>
      </r>
    </xsl:result-document>

    <xsl:result-document href="{$outDir}/{$utFileName}LT4.{$of}" format="{$of}">
      <r>
	<xsl:for-each select="doc($inFile)/r/e[some $t in ./t
			      satisfies  (number($t/@mld)&lt;4)]">
	  <e>
	    <xsl:copy-of select="./@*"/>
	    <xsl:variable name="best_mld">
              <xsl:for-each-group select="./t" group-by="number(./@mld)">
		<xsl:sort select="current-grouping-key()" data-type="number" order="ascending" />
		<xsl:if test="position() = 1">
		  <x>
		    <xsl:value-of select="current-grouping-key()"/>
		  </x>
		</xsl:if>
	      </xsl:for-each-group>
	    </xsl:variable>
	    <xsl:copy-of select="./t[number(./@mld)=number($best_mld)]"/>
	  </e>
	</xsl:for-each>
      </r>
    </xsl:result-document>

  </xsl:template>
  
</xsl:stylesheet>
