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
		xmlns:local="nightbar"
		exclude-result-prefixes="xs xhtml local functx">

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


<xsl:function name="functx:index-of-string-first" as="xs:integer?"
              xmlns:functx="http://www.functx.com">
  <xsl:param name="arg" as="xs:string?"/>
  <xsl:param name="substring" as="xs:string"/>

  <xsl:sequence select="
  if (contains($arg, $substring))
  then string-length(substring-before($arg, $substring))+1
  else ()
 "/>

</xsl:function>

<xsl:function name="functx:index-of-string-last" as="xs:integer?"
              xmlns:functx="http://www.functx.com">
  <xsl:param name="arg" as="xs:string?"/>
  <xsl:param name="substring" as="xs:string"/>

  <xsl:sequence select="
  functx:index-of-string($arg, $substring)[last()]
 "/>

</xsl:function>

<xsl:function name="functx:index-of-string" as="xs:integer*"
              xmlns:functx="http://www.functx.com">
  <xsl:param name="arg" as="xs:string?"/>
  <xsl:param name="substring" as="xs:string"/>

  <xsl:sequence select="
  if (contains($arg, $substring))
  then (string-length(substring-before($arg, $substring))+1,
        for $other in
           functx:index-of-string(substring-after($arg, $substring),
                               $substring)
        return
          $other +
          string-length(substring-before($arg, $substring)) +
          string-length($substring))
  else ()
 "/>

</xsl:function>


  <xsl:param name="flag" select="'a'"/>
  <xsl:param name="inDir" select="concat($flag,'_1_xml_input')"/>
  <xsl:param name="outDir" select="concat('out_',$flag,'_2_gtxml')"/>
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
	  <xsl:for-each select="./r/e">
	    <xsl:variable name="current_e" select="."/>
	    <e id="{./@id}">
	      <lg>
		<l pos="">
		  <xsl:copy-of select="$current_e/p[./@id='1']/@*[not(local-name()='id')]"/>
		  <xsl:value-of select="normalize-space(./p[./@id='1'])"/>
		</l>
	      </lg>
	      <xsl:variable name="c_mgf" select="normalize-space(./p[./@id='2'])"/>
	      <xsl:for-each select="tokenize($c_mgf, ';')">
		<mg id="{position()}">

		  <xsl:variable name="corrected_t">
		    <xsl:if test="not(contains(., '('))">
		      <xsl:value-of select="."/>
		    </xsl:if>
		    <xsl:if test="contains(., '(')">
		      <xsl:if test="not(contains(., ','))">
			<xsl:value-of select="."/>
		      </xsl:if>
		      <xsl:if test="contains(., ',')">
			
			<xsl:if test="not((functx:index-of-string-first(.,'(')
				  &lt;
				  functx:index-of-string-first(.,','))
				  and
				  (functx:index-of-string-first(.,',')
				  &lt;
				  functx:index-of-string-first(.,')')))">
			<xsl:value-of select="."/>
			</xsl:if>
			
			<xsl:if
			    test="(functx:index-of-string-first(.,'(')
				  &lt;
				  functx:index-of-string-first(.,','))
				  and
				  (functx:index-of-string-first(.,',')
				  &lt;
				  functx:index-of-string-first(.,')'))
				   ">
			  
			  <xsl:variable name="l_part">
			    <xsl:value-of select="substring(., 1, functx:index-of-string-first(.,'(')-1)"/>
			  </xsl:variable>
			  
			  <xsl:variable name="i_part">
			    <xsl:value-of select="concat('',substring(.,
						  functx:index-of-string-first(.,'(')+1,
						  functx:index-of-string-first(.,')')-functx:index-of-string-first(.,'(')-1
						  ), '')"/>
			  </xsl:variable>
			  
			  
			  <xsl:variable name="corrected_i_part">
			    <xsl:call-template name="string-replace-all">
			      <xsl:with-param name="text" select="$i_part" />
			      <xsl:with-param name="replace" select="','" />
			      <xsl:with-param name="by" select="' _COMMA_'" />
			    </xsl:call-template>
			  </xsl:variable>
			  
			  <xsl:variable name="r_part">
			    <xsl:value-of select="substring(.,
						  functx:index-of-string-first(.,')') +1,
						  string-length(.))"/>
			  </xsl:variable>
			  
			  <xsl:value-of select="concat($l_part, '(',
						$corrected_i_part
						, ')', $r_part)"/>
			</xsl:if>
		      </xsl:if>
		    </xsl:if>
		  </xsl:variable>
		  
		  <tg xml:lang="smn">
		    <xsl:for-each select="tokenize($corrected_t, ',')">
		      <xsl:variable name="c_t" select="normalize-space(.)"/>
		      <xsl:if test="not($c_t='')">
			
			<xsl:if test="false()">
			  <xsl:message terminate="no">
			    <xsl:value-of select="concat('t XXX ', $corrected_t, $nl)"/>
			  </xsl:message>
			</xsl:if>
			
			<xsl:variable name="l_par"
				      select="
					      if (starts-with($c_t, '('))
					      then substring($c_t,2,functx:index-of-string-first($c_t,')')-2)
					      else ()
					      "/>
			
			<xsl:variable name="r1"
				      select="
					      if (starts-with($c_t, '('))
					      then normalize-space(substring($c_t,functx:index-of-string-first($c_t,')')+2,string-length($c_t)))
					      else ($c_t)
					      "/>
			
			<xsl:variable name="r_par"
				      select="
					      if (ends-with($r1, ')'))
					      then substring($r1,functx:index-of-string-last($r1,'(')+1,functx:index-of-string-last($r1,')')-1)
					      else ()
					      "/>
			
			<xsl:variable name="r2"
				      select="
					      if (ends-with($r1, ')'))
					      then substring($r1,1,functx:index-of-string-last($r1,'(')-1)
					      else ($r1)
					      "/>


			<xsl:variable name="syn_tilde"
				      select="
					      if ((contains($r2,
					      '~') and
					      not(contains($r2,'-')))
					      or
					      (contains($r2,
					      '~') and
					      contains($r2,'-')
					      and
					      contains($r2,'#')))
					      then
					      normalize-space(substring($r2,functx:index-of-string-first($r2,'~')))
					      else ()
					      "/>
			
			<xsl:variable name="r3"
				      select="
					      if ((contains($r2,
					      '~') and
					      not(contains($r2,'-')))
					      or
					      (contains($r2,
					      '~') and
					      contains($r2,'-')
					      and
					      contains($r2,'#')))
					      then
					      substring($r2,1,functx:index-of-string-first($r2,'~')-1)
					      else ($r2)
					      "/>
			
			<xsl:variable name="attr"
				      select="
					      if (contains($r3,
					      '#') and
					      not(contains($r3,'~')))
					      then
					      normalize-space(concat('#',substring-after($r3,'#')))
					      else ()
					      "/>
			
			<xsl:variable name="r4"
				      select="
					      if (contains($r3,
					      '#') and
					      not(contains($r3,'~')))
					      then
					      substring-before($r3,'#')
					      else ($r3)
					      "/>
			
			<xsl:variable name="syn_dash"
				      select="
					      if (contains($r4,
					      ' -') and
					      not(contains($r4,'~') or contains($r4,'#')))
					      then
					      normalize-space(concat('-',substring-after($r4,' -')))
					      else ()
					      "/>
			
			<xsl:variable name="r5"
				      select="
					      if (contains($r4,
					      ' -') and
					      not(contains($r4,'~') or contains($r4,'#')))
					      then
					      substring-before($r4,' -')
					      else ($r4)
					      "/>

			<!-- tilde-dash issue still not resolved:
			     that's why the not-conditions -->
			<xsl:variable name="word_form"
				      select="
					      if (contains($r5,
					      ' ') and
					      not(contains($r5,'~') or contains($r5,'-'))
					      and
					      not($current_e/p[./@id='2'][./@mwe])
					      and
					      not(contains($r5,'_MWEy_')))
					      then
					      normalize-space(substring(
					      $r5,
					      functx:index-of-string-first($r5,' ')+1,string-length($r5)))
					      else ()
					      "/>
			
			<xsl:variable name="r6"
				      select="
					      if (contains($r5,
					      ' ') and
					      not(contains($r5,'~') or contains($r5,'-'))
					      and
					      not($current_e/p[./@id='2'][./@mwe])
					      and
					      not(contains($r5,'_MWEy_')))
					      then
					      normalize-space(substring(
					      $r5, 1,
					      functx:index-of-string-first($r5,' ')))
					      else ($r5)
					      "/>

			<xsl:variable name="mwe_word_form">
			  <xsl:if test="$current_e/p[./@id='2'][./@mwe]
					and not($current_e/p[./@id='2'][./@mwe='y'])">
			    <xsl:variable name="counter"
					  select="number($current_e/p[./@id='2']/@mwe)"/>
			    <xsl:for-each select="tokenize($r6, ' ')">
			      <xsl:variable name="c_p" select="position()"/>
			      <xsl:if test="number($c_p) &gt; number($counter)">
				<xsl:value-of select="concat(., ' ')"/>
			      </xsl:if>
			      
			    </xsl:for-each>
			  </xsl:if>

			  <xsl:if test="not($current_e/p[./@id='2'][./@mwe]
					and not($current_e/p[./@id='2'][./@mwe='y']))">
			    <xsl:value-of select="''"/>
			  </xsl:if>
			</xsl:variable>

			<xsl:variable name="r7">
			  <xsl:if test="$current_e/p[./@id='2'][./@mwe]
					and not($current_e/p[./@id='2'][./@mwe='y'])">
			    <xsl:variable name="counter"
					  select="number($current_e/p[./@id='2']/@mwe)"/>
			    <xsl:for-each select="tokenize($r6, ' ')">
			      <xsl:variable name="c_p" select="position()"/>
			      <xsl:if test="$c_p &lt;= $counter">
				<xsl:value-of select="concat(., ' ')"/>
			      </xsl:if>
			    </xsl:for-each>
			    
			  </xsl:if>

			  <xsl:if test="not($current_e/p[./@id='2'][./@mwe]
					and not($current_e/p[./@id='2'][./@mwe='y']))">
			    <xsl:value-of select="$r6"/>
			  </xsl:if>

			</xsl:variable>

			<xsl:if test="not($mwe_word_form='')">
			  <xsl:message terminate="no">
			    <xsl:value-of
				select="concat($mwe_word_form,' __ ', $r7, ' _ ', ., $nl)"/>
			  </xsl:message>
			</xsl:if>
			
			
			<t pos="">
			  <xsl:if test="not(normalize-space($l_par)='')">
			    <xsl:attribute name="l_par">
			      <xsl:value-of select="$l_par"/>
			    </xsl:attribute>
			  </xsl:if>
			  <xsl:if test="not(normalize-space($r_par)='')">
			    <xsl:attribute name="r_par">
			      <xsl:value-of select="translate($r_par,')','')"/>
			    </xsl:attribute>
			  </xsl:if>
			  <xsl:if test="not(normalize-space($syn_dash)='')">
			    <xsl:attribute name="syn_dash">
			      <xsl:value-of select="$syn_dash"/>
			    </xsl:attribute>
			  </xsl:if>
			  <xsl:if test="not(normalize-space($attr)='')">
			    <xsl:attribute name="attr">
			      <xsl:value-of select="$attr"/>
			    </xsl:attribute>
			  </xsl:if>
			  <xsl:if test="not(normalize-space($syn_tilde)='')">
			    <xsl:attribute name="t_tld">
			      <xsl:value-of select="normalize-space($syn_tilde)"/>
			    </xsl:attribute>
			  </xsl:if>
			  <xsl:if
			      test="not(normalize-space($word_form)='')
				    or
				    not(normalize-space($mwe_word_form)='')">
			    <xsl:attribute name="wf">
			      <xsl:value-of
				  select="concat(normalize-space($word_form),
					  normalize-space($mwe_word_form))"/>
			    </xsl:attribute>
			  </xsl:if>
			  <!-- after all cleanup mwe-attributes can be
			       then fitered out -->
			  <!--xsl:copy-of select="$current_e/p[./@id='2']/@*[not(local-name()='id')][not(local-name()='mwe')]"/-->
			  <xsl:if test="contains($r7, '_MWEy_')">
			    <xsl:attribute name="mwe">
			      <xsl:value-of select="'y'"/>
			    </xsl:attribute>
			  </xsl:if>
			  <xsl:copy-of select="$current_e/p[./@id='2']/@*[not(local-name()='id')]"/>
			  <xsl:value-of select="normalize-space(replace($r7, '_MWEy_', ''))"/>
			</t>
			
		      </xsl:if>
		    </xsl:for-each>
		  </tg>
		</mg>
	      </xsl:for-each>
	      
	    </e>
	  </xsl:for-each>
	</r>
      </xsl:result-document>
    </xsl:for-each>
    
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

  
</xsl:stylesheet>
