<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
body,html,#allmap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0;
}

#l-map {
	height: 100%;
	width: 78%;
	float: left;
	border-right: 2px solid #bcbcbc;
}

#r-result {
	height: 100%;
	width: 20%;
	float: left;
}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
<link rel="shortcut icon" href="favicon.ico" />
<title>添加自定义覆盖物</title>
</head>
<body>
	<div id="allmap"></div>

</body>
</html>

<script type="text/javascript">
	var mp = new BMap.Map("allmap");
	mp.addControl(new BMap.NavigationControl());
	mp.addControl(new BMap.ScaleControl());
	mp.addControl(new BMap.OverviewMapControl());
	mp.addControl(new BMap.MapTypeControl());
	mp.centerAndZoom("北京", 11);

	mp.enableScrollWheelZoom();
	// 复杂的自定义覆盖物
	function ComplexCustomOverlay(point, text, mouseoverText) {
		this._point = point;
		this._text = text;
		this._overText = mouseoverText;
	}
	ComplexCustomOverlay.prototype = new BMap.Overlay();
	ComplexCustomOverlay.prototype.initialize = function(map) {
		this._map = map;
		var div = this._div = document.createElement("div");
		div.style.position = "absolute";
		div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
		div.style.backgroundColor = "#EE5D5B";
		div.style.border = "1px solid #BC3B3A";
		div.style.color = "white";
		div.style.height = "18px";
		div.style.padding = "2px";
		div.style.lineHeight = "18px";
		div.style.whiteSpace = "nowrap";
		div.style.MozUserSelect = "none";
		div.style.fontSize = "12px";
		var span = this._span = document.createElement("span");
		div.appendChild(span);
		span.appendChild(document.createTextNode(this._text));
		var that = this;

		var arrow = this._arrow = document.createElement("div");
		arrow.style.background = "url(images/label.png) no-repeat";
		arrow.style.position = "absolute";
		arrow.style.width = "11px";
		arrow.style.height = "10px";
		arrow.style.top = "22px";
		arrow.style.left = "10px";
		arrow.style.overflow = "hidden";
		div.appendChild(arrow);

		div.onmouseover = function() {
			this.style.backgroundColor = "#6BADCA";
			this.style.borderColor = "#0000ff";
			this.getElementsByTagName("span")[0].innerHTML = that._overText;
			arrow.style.backgroundPosition = "0px -20px";
		};

		div.onmouseout = function() {
			this.style.backgroundColor = "#EE5D5B";
			this.style.borderColor = "#BC3B3A";
			this.getElementsByTagName("span")[0].innerHTML = that._text;
			arrow.style.backgroundPosition = "0px 0px";
		};

		mp.getPanes().labelPane.appendChild(div);

		return div;
	};
	ComplexCustomOverlay.prototype.draw = function() {
		var map = this._map;
		var pixel = map.pointToOverlayPixel(this._point);
		this._div.style.left = pixel.x - parseInt(this._arrow.style.left)
				+ "px";
		this._div.style.top = pixel.y - 30 + "px";
	};

	var JSONString = ${requestScope.allLineInfoJson};
	var routeLines = eval(JSONString);
	for (index = 0; index < routeLines.length; index++) {
		var routeLine = routeLines[index];
		var lineId = routeLine.lineId;
		var pointList = routeLine.pointList;
		var lineName = routeLine.lineName;
		var pointArray = new Array();//创建一个数组
		for (i = 0; i < pointList.length; i++) {
			var linePoint = pointList[i];//站点对象
			var pointName = linePoint.pointName;
			var pointIndex = linePoint.pointIndex;
			var pointX = linePoint.pointX;
			var pointY = linePoint.pointY;			
			var mouseoverTxt = pointName +",<b>"+ lineId+"</b>号班车第<b>"+(pointIndex)+"</b>站,往["+lineName+"]方向";
			if(i == 0){
				var mouseoverTxt = pointName ;
			}
			var point = new BMap.Point(pointX,pointY);
			var myCompOverlay = new ComplexCustomOverlay(point, pointName,mouseoverTxt);
			mp.addOverlay(myCompOverlay);
			pointArray.push(point);
		}
		

		var polyline = new BMap.Polyline(pointArray, {
			strokeColor:routeLine.lineColor,//画线颜色
			strokeWeight:2,//画线宽度
			strokeOpacity:0.5
		});
		mp.addOverlay(polyline);
	}
</script>

