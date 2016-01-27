<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml"
            encoding="utf-8"/>  

<xsl:template match='@* | node()'>
	<xsl:copy>
		<xsl:apply-templates select='@* | node()' />
	</xsl:copy>
</xsl:template>

<xsl:template match='*[@id=/*/postlist/change/@id]'>
    <xsl:copy>
        <xsl:apply-templates select='@*' />
        <xsl:value-of select='/*/postlist/change[@id=current()/@id]' />
    </xsl:copy>
</xsl:template>

<xsl:template match='*[@id=/*/postlist/delete/@id]' />

<xsl:template match='postlist' />

</xsl:stylesheet>
