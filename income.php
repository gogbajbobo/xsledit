<?php

session_name('xsledit');
session_start();

if (!empty($_POST)) {
	$changesdoc = new DOMDocument('1.0','UTF-8');
	if (empty($_SESSION['changes'])) {
		$changes_sol = $changesdoc->createElement('sol');
		$changes_change = $changesdoc->createElement('change');
		$changes_delete = $changesdoc->createElement('delete');
		$changes_sol->appendChild($changes_change);
		$changes_sol->appendChild($changes_delete);
		$changesdoc->appendChild($changes_sol);
		$_SESSION['changes'] = $changesdoc->saveXML();
	}
	$changesdoc->loadXML($_SESSION['changes']);
	$changes_branch = $changesdoc->getElementsByTagName($_POST['type'])->item(0);
	$key = $changesdoc->getElementsByTagName($_POST['key'])->item(0);
	if (empty($key)) $key = $changesdoc->createElement($_POST['key']);
	$key->setAttribute('value',$_POST['value']);
	$changes_branch->appendChild($key);
	$_SESSION['changes'] = $changesdoc->saveXML();
}

?>