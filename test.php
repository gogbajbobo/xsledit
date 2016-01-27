<?php

session_name('xsledit');
session_start();
header('Content-type: text/xml');

function XSLTR($xslfile,$xsldoc,$xslt,$xmldoc) {
	$xsldoc->load($xslfile);
	$xslt -> importStylesheet($xsldoc);
	return $xslt->transformToXML($xmldoc);
}

if (!empty($HTTP_RAW_POST_DATA)) {
	$xmldoc = new DOMDocument('1.0','UTF-8');
	//$xmldoc->load('temp.xml');
	$xmldoc->loadXML($HTTP_RAW_POST_DATA);
	$xslt = new XSLTProcessor();
	$xsldoc = new DOMDocument('1.0','UTF-8');
	$xmldoc->loadXML(XSLTR('html2xml.xsl',$xsldoc,$xslt,$xmldoc));
	$xmldoc->loadXML(XSLTR('init_transform.xsl',$xsldoc,$xslt,$xmldoc));
	$xmldoc->loadXML(XSLTR('identification.xsl',$xsldoc,$xslt,$xmldoc));
	$_SESSION['htmldoc'] = XSLTR('xml2html.xsl',$xsldoc,$xslt,$xmldoc);
	$_SESSION['xmldoc']=$xmldoc->saveXML();
	
	echo 'test';
	//echo $_SESSION['htmldoc'];
}
else {
	echo 'NO POST_DATA';
}


?>