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

  <xsl:param name="inFile" select="'all_sme2smn_levenshtein_check.xml'"/>
  <xsl:param name="version" select="'v4'"/>
  <xsl:param name="utFileName" select="concat('all_sme2smn_lsd_pseudo-sme_',$version)"/>
  <xsl:param name="filterFile" select="'smn2pseudo-sme_map.txt'"/>
  <xsl:variable name="ffParsed" select="unparsed-text($filterFile)"/>
  <xsl:variable name="ffLines" select="tokenize($ffParsed, '&#xa;')" as="xs:string+"/>
  <xsl:param name="outDir" select="'.'"/>
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
    <xsl:result-document href="{$outDir}/{$utFileName}.{$of}" format="{$of}">
      <r>
	<xsl:for-each select="doc($inFile)/r/e">
	  <e>
	    <xsl:copy-of select="./@*"/>
	    <xsl:variable name="cs" select="./@s"/>
	    <xsl:variable name="ct">

	      <xsl:for-each select="./t">
		<xsl:variable name="current_t" select="."/>
		<xsl:variable name="pseudo_sme"
			      select="(tokenize($ffLines[starts-with(.,concat($current_t,$tb))],$tb))[2]"/>
		<t mld="{my:LevenshteinDistanceC($cs,$pseudo_sme)}"
		   old="{my:LevenshteinDistanceC($cs,.)}"
		   p_sme="{$pseudo_sme}">
		  <xsl:value-of select="."/>
		</t>
	      </xsl:for-each>
	    </xsl:variable>
	    <xsl:for-each select="$ct/t">
	      <xsl:sort select="@mld" data-type="number" order="ascending"/>
	      <xsl:copy-of select="."/>
	    </xsl:for-each>
	  </e>
	</xsl:for-each>
      </r>
    </xsl:result-document>
    
  </xsl:template>

  <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text"
			  select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:function name="my:LevenshteinDistanceC" as="xs:integer">
    <xsl:param name="string1" as="xs:string" />
    <xsl:param name="string2" as="xs:string" />
    <xsl:choose>
      <xsl:when test="$string1 = ''">
	<xsl:sequence select="string-length($string2)" />
      </xsl:when>
      <xsl:when test="$string2 = ''">
	<xsl:sequence select="string-length($string1)" />
      </xsl:when>
      <xsl:otherwise>
	<xsl:sequence select="my:LevenshteinDistanceC(
                              string-to-codepoints($string1),
                              string-to-codepoints($string2),
                              string-length($string1),
                              string-length($string2),
                              (1, 0, 1),
                              2)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="my:LevenshteinDistanceC" as="xs:integer">
    <xsl:param name="chars1" as="xs:integer*" />
    <xsl:param name="chars2" as="xs:integer*" />
    <xsl:param name="length1" as="xs:integer" />
    <xsl:param name="length2" as="xs:integer" />
    <xsl:param name="lastDiag" as="xs:integer*" />
    <xsl:param name="total" as="xs:integer" />
    <xsl:variable name="shift" as="xs:integer" 
		  select="if ($total > $length2) then ($total - ($length2 + 1)) else 0" />
    <xsl:variable name="diag" as="xs:integer*">
      <xsl:for-each select="max((0, $total - $length2)) to 
                            min(($total, $length1))">
	<xsl:variable name="i" as="xs:integer" select="." />
	<xsl:variable name="j" as="xs:integer" select="$total - $i" />
	<xsl:variable name="d" as="xs:integer" select="($i - $shift) * 2" />
	<xsl:if test="$j &lt; $length2">
          <xsl:sequence select="$lastDiag[$d - 1]" />
	</xsl:if>
	<xsl:choose>
          <xsl:when test="$i = 0">
            <xsl:sequence select="$j" />
          </xsl:when>
          <xsl:when test="$j = 0">
            <xsl:sequence select="$i" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence 
		select="min(($lastDiag[$d - 1] + 1,
                        $lastDiag[$d + 1] + 1,
                        $lastDiag[$d] +
                        (if ($chars1[$i] eq $chars2[$j]) then 0 else 1)))" />
          </xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$total = $length1 + $length2">
	<xsl:sequence select="exactly-one($diag)" />
      </xsl:when>
      <xsl:otherwise>
	<xsl:sequence select="my:LevenshteinDistanceC(
                              $chars1, $chars2, 
                              $length1, $length2, 
                              $diag, $total + 1)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
</xsl:stylesheet>
