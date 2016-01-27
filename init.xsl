<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="test.css" type="text/css"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml"
            indent="yes"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
            omit-xml-declaration="yes"
            encoding="utf-8"/>  

<xsl:variable name="name" select="expression"></xsl:variable>

<xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="rus">
        <head>
            <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
            <meta http-equiv="X-UA-Compatible" content="IE=100" />
            <link rel="stylesheet" type="text/css" href="xsledit.css" />
        </head>
        <body>
            <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<!--Test comment-->

<xsl:template name='test_template'>
    <xsl:text>Test text</xsl:text>
</xsl:template>



<xsl:template match="*">
    <div class="{local-name()}">
        <div class="label">
            <xsl:value-of select="name()"/>
        </div>
        <xsl:if test="@*">
            <div class="attributes">
                <xsl:apply-templates select="@*"/>
            </div>
        </xsl:if>
        <div class="elements">
            <xsl:apply-templates select="node()"/>
            <xsl:apply-templates select="self::*[not(node()) or text()='']" mode="html-empty"/>
        </div>
    </div>
</xsl:template>

<xsl:template match="text()[normalize-space(.)!='']">
    <div class="text-node">
        <xsl:value-of select="."/>
    </div>
</xsl:template>

<xsl:template match="comment()">
    <div class="comment-node">
        <xsl:value-of select="."/>
    </div>
</xsl:template>

<xsl:template match="@*">
    <div class="{local-name()}">
        <span class="label">
            <xsl:value-of select="name()"/>
        </span>
        <span class="delimiter">:</span>
        <span class="value">
            <xsl:value-of select="."/>
        </span>
    </div>
</xsl:template>

<xsl:template match="*" mode="html-empty"/>

<xsl:template match="xsl:template" mode="html-empty">
    <div class="empty"></div>
</xsl:template>

</xsl:stylesheet>