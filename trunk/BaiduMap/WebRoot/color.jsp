<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'color.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
	function getColor(e){

    obj = document.all ? event.srcElement : e.target;
    obj.style.position = "relative";
    var inputTop = getTop(obj);
    var inputLeft = getLeft(obj);
    
    var htmlStr = "visibility:visible;position:absolute;";
    //
    var colorPacker = document.getElementById("colorPacker");
    var colorPackerShadow = document.getElementById("colorPackerShadow");

    if (!colorPacker) {
        colorPacker = document.createElement("div");
        colorPackerShadow = document.createElement("div");

        colorPacker.id = "colorPacker";
        colorPackerShadow.id = "colorPackerShadow";
		
        colorPacker.style.cssText = htmlStr;
		colorPackerShadow.style.cssText = htmlStr+"opacity:0.3;filter:alpha(opacity=20);";
		
        colorPacker.style.zIndex = 34535;
		colorPackerShadow.style.zIndex = 34534;
        
		colorPacker.style.backgroundColor = "#6997EF" ;
		colorPackerShadow.style.backgroundColor = "#000000" ;
		
		colorPacker.style.height = "115px";
		colorPackerShadow.style.height = "115px";
		
		colorPacker.style.width = "165px";
		colorPackerShadow.style.width = "165px";
		
		var titleStyle = "width:95%;background:#6997EF;color:#ffffff;font-size:12px;margin-left:5px;";
		var contetnStyle = "width:95%;text-align:center;margin:auto;background:#6997EF;" ;
		
		var colorPackerTitle = "<div style='"+titleStyle+"'>取色器</div>" ;
		var colorPackerContent = "<div style='"+contetnStyle+"'>"+bulid()+"<div>" ;
		
        document.body.appendChild(colorPacker);
        document.body.appendChild(colorPackerShadow);
		
        colorPacker.innerHTML = colorPackerTitle+ colorPackerContent;
        
    }
    else {
        document.getElementById("colorPacker").style.visibility = "visible";
		document.getElementById("colorPackerShadow").style.visibility = "visible";
		
    }
	
    colorPacker.style.left = (inputLeft) + "px";
    colorPacker.style.top = (inputTop + obj.clientHeight) + "px";

    colorPackerShadow.style.left = (inputLeft+2) + "px";
    colorPackerShadow.style.top = (inputTop + obj.clientHeight+2) + "px";
    
	if(!colorPacker.onclick){
	    colorPacker.onclick = function(oEvent){
	        e = oEvent || window.event;
			var ev = document.all ? event.srcElement : e.target ;
			
			obj.style.backgroundColor = ev.bgColor;
			
			this.style.visibility = "hidden";
			document.getElementById("colorPackerShadow").style.visibility = "hidden";
	        if (document.all) {
	            e.cancelBubble = true;
	        }
	        else {
	            e.stopPropagation();
	        }
	    };
	}
	if(!document.all){
		colorPacker.setAttribute('flag','flag');
		colorPackerShadow.setAttribute('flag','flag');
		obj.setAttribute('flag','flag');

	}else{
		colorPacker.flag = "flag";
		colorPackerShadow.flag = "flag";
		obj.flag = "flag";
		
	}

	if(!document.onclick){
		document.onclick = function(e){
			var ev = document.all ? event.srcElement : e.target ;
			
			if (ev.getAttribute("flag")==null){
				document.getElementById("colorPacker").style.visibility = "hidden";
				document.getElementById("colorPackerShadow").style.visibility = "hidden";
			}
		};
	}
    
}

var hexch = new Array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
var cnum = new Array(1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0);

function ToHex(n){
    var h, l;
    
    n = Math.round(n);
    l = n % 16;
    h = Math.floor((n / 16)) % 16;
    return (hexch[h] + hexch[l]);
}

function DoColor(c, l){
    var r, g, b;
    
    r = '0x' + c.substring(1, 3);
    g = '0x' + c.substring(3, 5);
    b = '0x' + c.substring(5, 7);
    
    if (l > 120) {
        l = l - 120;
        
        r = (r * (120 - l) + 255 * l) / 120;
        g = (g * (120 - l) + 255 * l) / 120;
        b = (b * (120 - l) + 255 * l) / 120;
    }
    else {
        r = (r * l) / 120;
        g = (g * l) / 120;
        b = (b * l) / 120;
    }
    
    return '#' + ToHex(r) + ToHex(g) + ToHex(b);
}

function wc(r, g, b, n){
    r = ((r * 16 + r) * 3 * (15 - n) + 0x80 * n) / 15;
    g = ((g * 16 + g) * 3 * (15 - n) + 0x80 * n) / 15;
    b = ((b * 16 + b) * 3 * (15 - n) + 0x80 * n) / 15;
    
    return '<TD  BGCOLOR=#' + ToHex(r) + ToHex(g) + ToHex(b) + ' height=6 width=6></TD>';
}

function bulid(){
    var trStr = "<table CELLPADDING=0 CELLSPACING=0>";
    for (i = 0; i < 16; i++) {
        trStr += '<TR>';
        for (j = 0; j < 30; j++) {
            n1 = j % 5;
            n2 = Math.floor(j / 5) * 3;
            n3 = n2 + 3;
            
            trStr += wc((cnum[n3] * n1 + cnum[n2] * (5 - n1)), (cnum[n3 + 1] * n1 + cnum[n2 + 1] * (5 - n1)), (cnum[n3 + 2] * n1 + cnum[n2 + 2] * (5 - n1)), i);
        }
        
        trStr += '</TR>';
    }
    trStr += "</table>";
    return trStr;
    
}

function getTop(e){
    var offset = e.offsetTop;
    if (e.offsetParent != null) 
        offset += getTop(e.offsetParent);
    return offset;
}

function getLeft(e){
    var offset = e.offsetLeft;
    if (e.offsetParent != null) 
        offset += getLeft(e.offsetParent);
    return offset;
}


	
	</script>
</head>

<body>
	<button  onclick="getColor(event)">ddd</button>
</body>
</html>
