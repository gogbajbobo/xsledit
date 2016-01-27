<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml"
            indent="yes"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
            omit-xml-declaration="yes"
            encoding="utf-8"/>  


<xsl:template match="/">
    <html>
        <head>
			<title></title>
            <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
            <meta http-equiv="X-UA-Compatible" content="IE=100" />
            <link rel="stylesheet" type="text/css" href="xsledit.css" />
            <script type='text/javascript' src='xsledit.js'></script>
        </head>
        <body>
			<div class='root'>
				<xsl:apply-templates />
			</div>
			<div class='buttons'>
				<form action='?' method='post' id='submitform'>
					<input class='button submit' type="submit" value="Submit" />
				</form>
				<form action='?' method='post'>
					<input name='undo' value='yes' type='hidden' />
					<input class='button undo' type="submit" value="Undo" />
				</form>
				<form action='?' method='post'>
					<input name='reload' value='yes' type='hidden' />
					<input class='button reload' type="submit" value="Reload" />
				</form>
				<form action='?' method='get'>
					<input name='save' value='yes' type='hidden' />
					<input class='button save' type="submit" value="Save" />
				</form>
				<div>
					<input class='button test' type="submit" id="testbutton" value="TEST" />
				</div>
			</div>
        </body>
    </html>
</xsl:template>

<xsl:template match='node'>
	<div class='container {@kind}' id='{@id}'>
		<xsl:apply-templates select='label' />
		<xsl:apply-templates select='value' />
		<xsl:apply-templates select='node' />
		<div class='controls'><span class='delete' id='delete-{@id}'>DEL</span></div>
	</div>
</xsl:template>

<xsl:template match='label | value'>
	<div class='{name()}'>
		<input class='textinput' type='text' name='{@id}' value='{.}' />
	</div>
</xsl:template>

</xsl:stylesheet>