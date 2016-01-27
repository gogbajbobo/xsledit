<?php

session_name('xsledit');
session_start();
header('Content-type: text/xml');
$url = $_SERVER['SERVER_PORT']==80 ? 'http://' : 'https://';
$url .= $_SERVER['SERVER_NAME'];
$url .= $_SERVER['SCRIPT_NAME'];
if ($_POST['reload']=='yes' || $_POST['undo']=='yes') {
	unset($_SESSION['changes']);
	header('Location: ' . $url);
}

$filename = 'init.xsl';
$xmldoc = new DOMDocument('1.0','UTF-8');
$xmldoc->load($filename);
$xslt = new XSLTProcessor();
$xsldoc = new DOMDocument('1.0','UTF-8');

function XSLTR($xslfile,$xsldoc,$xslt,$xmldoc) {
	$xsldoc->load($xslfile);
	$xslt -> importStylesheet($xsldoc);
	return $xslt->transformToXML($xmldoc);
}

if ($_SESSION['status']!='init_complete') {
	$xmldoc->loadXML(XSLTR('init_transform.xsl',$xsldoc,$xslt,$xmldoc));
	$xmldoc->loadXML(XSLTR('identification.xsl',$xsldoc,$xslt,$xmldoc));
	$_SESSION['htmldoc'] = XSLTR('xml2html.xsl',$xsldoc,$xslt,$xmldoc);
	$_SESSION['xmldoc']=$xmldoc->saveXML();
	$_SESSION['status']='init_complete';
}
//elseif (!empty($_POST) && $_POST['reload']!='yes') {
//	$xmldoc->loadXML($_SESSION['xmldoc']);
//	$sol = $xmldoc->getElementsByTagName('sol')->item(0);
//	$post_list = $xmldoc->createElement('postlist');
//	foreach($_POST as $key=>$value) {
//		if (chr(ord($key))=='c') $post_elm = $xmldoc->createElement('change', $value);
//		if (chr(ord($key))=='d') $post_elm = $xmldoc->createElement('delete', $value);
//		$post_elm->setAttribute('id', substr($key,1));
//		$post_list->appendChild($post_elm);
//	}
//	$sol->appendChild($post_list);
//	$xmldoc->loadXML(XSLTR('replace_values.xsl',$xsldoc,$xslt,$xmldoc));
//	$_SESSION['htmldoc'] = XSLTR('xml2html.xsl',$xsldoc,$xslt,$xmldoc);
//	$_SESSION['xmldoc']=$xmldoc->saveXML();
//}
elseif ($_POST['reload']=='yes') {
	$_SESSION['status']='reload';
}
if ($_GET['show']=='xml') {
	echo $_SESSION['xmldoc'];
} else {
	echo $_SESSION['htmldoc'];
}


?>