<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml"
            indent="yes"
            omit-xml-declaration="no"
            encoding="utf-8"/>

<xsl:template match='/'>
	<xsl:apply-templates select='//div[@class="root"]' />
</xsl:template>

<xsl:template match='div[@class="root"]'>
	<xsl:apply-templates select='*' />
</xsl:template>

<xsl:template match='div[contains(@class,"processing-instruction")]'>
	<xsl:processing-instruction name='{./div[@class="label"]/input/@value}'>
		<xsl:value-of select='./div[@class="value"]/input/@value' />	
	</xsl:processing-instruction>
</xsl:template>

<xsl:template match='div[contains(@class,"element")]'>
	<xsl:element name='{./div[@class="label"]/input/@value}'>
		<xsl:apply-templates select='div[contains(@class,"container")]' />
	</xsl:element>
</xsl:template>

<xsl:template match='div[contains(@class,"attribute")]'>
	<xsl:attribute name='{./div[@class="label"]/input/@value}'>
		<xsl:value-of select='./div[@class="value"]/input/@value' />
	</xsl:attribute>
</xsl:template>

<xsl:template match='div[contains(@class,"text")]'>
	<xsl:value-of select='./div[@class="value"]/input/@value' />
</xsl:template>

<xsl:template match='div[contains(@class,"comment")]'>
	<xsl:comment>
		<xsl:value-of select='./div[@class="value"]/input/@value' />
	</xsl:comment>
</xsl:template>

<xsl:template match='div[@class="buttons"]' />
<xsl:template match='div[@class="controls"]' />

</xsl:stylesheet>
