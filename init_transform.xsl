<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml"
            encoding="utf-8"/>

<xsl:template match='/'>
	<xsl:element name='sol'>
		<xsl:apply-templates />
	</xsl:element>
</xsl:template>

<xsl:template match='processing-instruction()'>
	<xsl:element name='node'>
		<xsl:attribute name='kind'>
			<xsl:text>processing-instruction</xsl:text>
		</xsl:attribute>
		<xsl:call-template name='label' />
		<xsl:call-template name='value' />
	</xsl:element>
</xsl:template>

<xsl:template match='*'>
	<xsl:element name='node'>
		<xsl:attribute name='kind'>
			<xsl:text>element</xsl:text>
		</xsl:attribute>
		<xsl:call-template name='label' />
		<xsl:apply-templates select='@*' />
		<xsl:apply-templates select='node()' />
	</xsl:element>
</xsl:template>

<xsl:template match='@*'>
	<xsl:element name='node'>
		<xsl:attribute name='kind'>
			<xsl:text>attribute</xsl:text>
		</xsl:attribute>
		<xsl:call-template name='label' />
		<xsl:call-template name='value' />
	</xsl:element>
</xsl:template>

<xsl:template match='text()[normalize-space(.)!=""]'>
	<xsl:element name='node'>
		<xsl:attribute name='kind'>
			<xsl:text>text</xsl:text>
		</xsl:attribute>
		<xsl:call-template name='value' />
	</xsl:element>
</xsl:template>

<xsl:template match='comment()'>
	<xsl:element name='node'>
		<xsl:attribute name='kind'>
			<xsl:text>comment</xsl:text>
		</xsl:attribute>
		<xsl:call-template name='value' />
	</xsl:element>
</xsl:template>

<xsl:template name='label'>
	<xsl:element name='label'>
		<xsl:value-of select='name()' />
	</xsl:element>
</xsl:template>

<xsl:template name='value'>
	<xsl:element name='value'>
		<xsl:value-of select='.' />
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
