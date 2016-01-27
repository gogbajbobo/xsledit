window.addEventListener('DOMContentLoaded', function() {
    var inputs = document.getElementsByClassName('textinput');
    for (var i=0; i<inputs.length; i++) { 
        var input = inputs[i];
		resize.call(input);
		input.onkeyup = inputChange;
    }
	var containers = document.getElementsByClassName('container');
	for (var i=0; i<containers.length; i++) {
		var container = containers[i];
		container.onmouseover = showhideControls;
		container.onmouseout = showhideControls;
	}
	var controlsDivs = document.getElementsByClassName('delete');
	for (var i=0; i<controlsDivs.length; i++) {
		var controlsDiv = controlsDivs[i];
		controlsDiv.onclick = deleteContainer;
	}
	var testbutton = document.getElementById('testbutton');
	testbutton.onclick = testsubmit;
}, false);

function testsubmit() {
	xmlhttp = new XMLHttpRequest();
	var postparam = '<sol>'+document.body.innerHTML+'</sol>';
	xmlhttp.open('POST', 'test.php', true);
	xmlhttp.setRequestHeader("Content-Type", "text/xml");
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4) {
			if(xmlhttp.status == 200) {
				alert(xmlhttp.responseText);
				document.innerHTML = xmlhttp.responseText;
			}
		}
	};
	//alert(postparam);
	xmlhttp.send(postparam);
	//if(xmlhttp.status == 200) {
	//  alert(xmlhttp.responseText);
	//}
}

function sendChanges(key,value,type) {
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.open('POST', 'income.php', true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	var data2send = 'key=' + key + '&value=' + value + '&type=' + type;
	xmlhttp.send(data2send);
}

function resize() {
	var value_length = this.value.length;
	if (value_length==0) value_length = 1;
	this.setAttribute('size', value_length);
}

function inputChange() {
	resize.call(this);
	var submitform = document.getElementById('submitform');
	for (var i=0; i<submitform.childNodes.length; i++) {
		var sfChild = submitform.childNodes[i];
		if (sfChild.name=='c'+this.name) {
			var inputExist=true;
			var targetinput = sfChild;
		}
	}
	if (!inputExist) {
		var targetinput = document.createElement('input');
		targetinput.setAttribute('type', 'hidden');
		targetinput.setAttribute('name', 'c'+this.name);
		submitform.appendChild(targetinput);
	}
	this.setAttribute('value',this.value);
	targetinput.setAttribute('value', this.value);
	sendChanges(this.name,this.value,'change');
}

function showhideControls() {
	var childs = this.childNodes;
	for (var i=0; i<childs.length; i++) {
		if (childs[i].className == 'controls') {
			if (childs[i].style.visibility == 'visible') {
				childs[i].style.visibility = 'hidden';
				this.style.borderBottomColor = 'hsla(0,0%,100%,0)';
				this.style.borderTopColor = 'hsla(0,0%,100%,0)';
			} else {
				childs[i].style.visibility = 'visible';
				this.style.borderBottomColor = '#ccf';
				this.style.borderTopColor = '#ccf';
			}
		}
	}
	if (!e) var e = window.event;
	if (e.stopPropagation) e.stopPropagation();
}

function deleteContainer() {
	var parentContainer = this.parentNode.parentNode;
	if (!parentContainer.deleted) {
		deleteControlsTrue.call(parentContainer);
	} else {
		deleteControlsFalse.call(parentContainer);
		deleteControlsFalseParent.call(parentContainer.parentNode);
	}
}

function deleteControlsTrue() {
	this.style.backgroundColor = 'lightgray';
	this.style.borderColor = 'lightgray';
	var containerDeleteControl = document.getElementById('delete-'+this.id);
	containerDeleteControl.style.color = 'black';
	containerDeleteControl.style.backgroundColor = 'rosybrown';
	this.deleted = true;
	inputDelete.call(this);
	var containerChilds = this.getElementsByClassName('container');
	for (var i=0; i<containerChilds.length; i++) {
		var containerChild = containerChilds[i];
		deleteControlsTrue.call(containerChild);
	}
}

function deleteControlsFalse() {
	this.style.backgroundColor = 'hsla(0,0%,100%,0)';
	this.style.borderColor = 'hsla(0,0%,100%,0)';
	this.style.borderLeftColor = '#ccf';
	var containerDeleteControl = document.getElementById('delete-'+this.id);
	containerDeleteControl.style.color = 'white';
	containerDeleteControl.style.backgroundColor = 'red';
	this.deleted = false;
	inputDeleteCancel.call(this);
	var containerChilds = this.getElementsByClassName('container');
	for (var i=0; i<containerChilds.length; i++) {
		var containerChild = containerChilds[i];
		containerChild.style.backgroundColor = 'hsla(0,0%,100%,0)';
		containerChild.style.borderColor = 'hsla(0,0%,100%,0)';
		containerChild.style.borderLeftColor = '#ccf';
		var containerDeleteControl = document.getElementById('delete-'+containerChild.id);
		containerDeleteControl.style.color = 'white';
		containerDeleteControl.style.backgroundColor = 'red';
		containerChild.deleted = false;
		inputDeleteCancel.call(containerChild);
		//deleteControlsFalse.call(containerChild);
	}
}

function deleteControlsFalseParent() {
	if (this.deleted) {
		this.style.backgroundColor = 'hsla(0,0%,100%,0)';
		this.style.borderColor = 'hsla(0,0%,100%,0)';
		this.style.borderLeftColor = '#ccf';
		var containerDeleteControl = document.getElementById('delete-'+this.id);
		containerDeleteControl.style.color = 'white';
		containerDeleteControl.style.backgroundColor = 'red';
		this.deleted = false;
		inputDeleteCancel.call(this);
		deleteControlsFalseParent.call(this.parentNode);
	}
}

function inputDelete() {
	var submitform = document.getElementById('submitform');
	if (!document.getElementById('d'+this.id)) {
		var targetinput = document.createElement('input');
		targetinput.setAttribute('type', 'hidden');
		targetinput.setAttribute('name', 'd'+this.id);
		targetinput.setAttribute('id', 'd'+this.id);
		submitform.appendChild(targetinput);
	}
	sendChanges(this.id,'ok','delete');
}

function inputDeleteCancel() {
	var submitform = document.getElementById('submitform');
	submitform.removeChild(document.getElementById('d'+this.id));
	sendChanges(this.id,'cancel','delete');
}