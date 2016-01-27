<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml"
            encoding="utf-8"/>

<xsl:template match='sol'>
	<xsl:copy>
		<xsl:apply-templates />
	</xsl:copy>
</xsl:template>

<xsl:template match='node'>
	<xsl:copy>
		<xsl:attribute name='id'>
			<xsl:value-of select='generate-id()' />
		</xsl:attribute>
		<xsl:apply-templates select='@*' />
		<xsl:apply-templates />
	</xsl:copy>
</xsl:template>

<xsl:template match='@*'>
	<xsl:copy-of select='.' />
</xsl:template>

<xsl:template match='label | value'>
	<xsl:copy>
		<xsl:attribute name='id'>
			<xsl:value-of select='generate-id()' />
		</xsl:attribute>
		<xsl:value-of select='.' />
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
