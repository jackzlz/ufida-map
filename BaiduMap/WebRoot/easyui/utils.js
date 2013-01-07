function isNum(val){
	if(isNaN(val)){
		return false;
	}else{   
		return true;
	}
}

function $(id) {
	obj = document.getElementById(id);
	if (obj == null) obj = document.all.id;
	return obj;
}