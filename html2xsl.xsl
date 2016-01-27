<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml"
            indent="yes"
            omit-xml-declaration="no"
            encoding="utf-8"/>  




<xsl:template match='/'>
	<xsl:apply-templates select='//*[@class="stylesheet"] | //*[@class="transform"]' />
</xsl:template>


<xsl:template match='*[@class="element"]'>
	<xsl:element name='{./div[@class="label"]//@value}'>
		<xsl:apply-templates select='*[@class="attributes"]' />
		<xsl:apply-templates select='*[@class="text-node"]' />
		<xsl:apply-templates select='*[@class="comment-node"]' />
		<xsl:apply-templates select='*[@class="childs"]' />
	</xsl:element>
</xsl:template>

<xsl:template match='*[@class="attributes"]'>
	<xsl:for-each select='./*'>
		<xsl:attribute name='{./div[@class="label"]//@value}'>
			<xsl:value-of select='./div[@class="value"]//@value' />
		</xsl:attribute>
	</xsl:for-each>
</xsl:template>

<xsl:template match='*[@class="text-node"]'>
	<xsl:value-of select='.//@value'/>
</xsl:template>

<xsl:template match='*[@class="comment-node"]'>
	<xsl:comment>
		<xsl:value-of select='.//@value'/>		
	</xsl:comment>
</xsl:template>

</xsl:stylesheet>
