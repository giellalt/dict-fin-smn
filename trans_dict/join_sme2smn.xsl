<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inDir=DIR
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:functx="http://www.functx.com"
		exclude-result-prefixes="xs xhtml functx">

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

<xsl:function name="functx:is-node-in-sequence-deep-equal" as="xs:boolean"
              xmlns:functx="http://www.functx.com">
  <xsl:param name="node" as="node()?"/>
  <xsl:param name="seq" as="node()*"/>

  <xsl:sequence select="
   some $nodeInSeq in $seq satisfies deep-equal($nodeInSeq,$node)
 "/>

</xsl:function>

<xsl:function name="functx:distinct-deep" as="node()*"
              xmlns:functx="http://www.functx.com">
  <xsl:param name="nodes" as="node()*"/>

  <xsl:sequence select="
    for $seq in (1 to count($nodes))
    return $nodes[$seq][not(functx:is-node-in-sequence-deep-equal(
                          .,$nodes[position() &lt; $seq]))]
 "/>

</xsl:function>


  
  <xsl:param name="inDir" select="'sme2fin'"/>
  <xsl:param name="plFile" select="'fin2smn/all_fin2smn.xml'"/>
  
  <xsl:param name="outDir" select="'out_sme2smn'"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="false()"/>
  <xsl:variable name="nl" select="'&#xa;'"/>
  <xsl:variable name="sr" select="'\*'"/>
  <xsl:variable name="rarrow" select="'▸'"/>
  <xsl:variable name="tb" select="' 	 '"/>

  
  <xsl:template match="/" name="main">

    <xsl:for-each select="for $f in collection(concat($inDir,'?recurse=no;select=*.xml;on-error=warning')) return $f">
      
      <xsl:variable name="current_file" select="(tokenize(document-uri(.), '/'))[last()]"/>
      <xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
      <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
      <xsl:variable name="file_name" select="substring-before($current_file, '.xml')"/>

      <xsl:if test="true()">
	<xsl:message terminate="no">
	  <xsl:value-of select="concat('-----------------------------------------', $nl)"/>
	  <xsl:value-of select="concat('processing file ', $current_file, $nl)"/>
	  <xsl:value-of select="'-----------------------------------------'"/>
	</xsl:message>
      </xsl:if>
      <!--[]-->
      
      <xsl:result-document href="{$outDir}/{$file_name}.{$of}" format="{$of}">
	<r>
	  <xsl:for-each select="./r/e[some $t in .//t satisfies
				normalize-space($t)=doc($plFile)/r/e/lg/l]">
	    
	    <xsl:message terminate="no">
              <xsl:value-of select="concat('Processing: ', ./lg/l, ' _
				    ', ./mg[1]/tg/t[1])"/>
	    </xsl:message>
	    <e>
		<xsl:copy-of select="./@*"/>
		<xsl:copy-of copy-namespaces="no" select="./lg"/>

		<xsl:for-each select="./mg">
		  
		  <xsl:variable name="c_mg">
		    <mg>
		      <tg xml:lang="smn">
			<xsl:for-each
			    select="./tg/t[normalize-space(.)=doc($plFile)/r/e/lg/l],
				     ./tg/t[normalize-space(.)=doc($plFile)/r/e/mg/tg/t/@l_par]">
			  <xsl:variable name="c_t" select="normalize-space(.)"/>
			  <xsl:variable name="c_t_pos" select="concat(normalize-space(.),'_',./@pos)"/>

			    <xsl:for-each select="doc($plFile)/r/e[./lg/l=$c_t]//t">
			      <t link="{$c_t_pos}">
				<xsl:copy-of select="./@*"/>
				<xsl:value-of select="."/>
			      </t>
			    </xsl:for-each>

			</xsl:for-each>
		      </tg>
		    </mg>
		  </xsl:variable>
		  
		  <xsl:if test="$c_mg/mg/tg/t">
		    <xsl:copy-of select="$c_mg"/>
		  </xsl:if>
		  
		</xsl:for-each>
		
	    </e>
	  </xsl:for-each>
	  

	  <!--xsl:for-each select="./r/e">
	    <xsl:variable name="c_id" select="./@id"/>
	    <xsl:if test=".[not(document($filterFile)/r/e[./@id=$c_id])]">
	      <xsl:copy-of copy-namespaces="no" select="."/>
	    </xsl:if>
	    
	    <xsl:if test=".[document($filterFile)/r/e[./@id=$c_id]]">
	      <e>
		<xsl:copy-of select="./@*"/>
		<xsl:copy-of copy-namespaces="no" select="./p[./@id='1']"/>
		<xsl:copy-of copy-namespaces="no" select="document($filterFile)/r/e[./@id=$c_id]/p[./@id='2']"/>
		<xsl:copy-of copy-namespaces="no" select="./p[./@id&gt;number('2')]"/>
	      </e>
	    </xsl:if>
	    
	  </xsl:for-each-->

	</r>
      </xsl:result-document>
    </xsl:for-each>
    
  </xsl:template>
  
</xsl:stylesheet>
