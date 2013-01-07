<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script src="./easyui/utils.js" type="text/javascript"></script>
<link href="./css/map.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function doSave(){
		var pointIndex = $('pointIndex').value;
		if(pointIndex.trim()==""){
			alert("站点编号不能为空");
			return ;
		}
		
		var pointName = $('pointName').value;
		if(pointName.trim()==""){
			alert("站点名称不能为空");
			return ;
		}
		
		
		if(!isNum(pointIndex)){
			alert("站点编号"+pointIndex+'不是数字');
			return ;
		}
		document.pointInfoForm.submit();
	}
</script>
</head>
<body>
<div id="tableForm">
<form id="pointInfoForm" name="pointInfoForm" action="./mapServlet?action=${action }" method="POST">
	<input type="hidden" id="lineId" name="lineId" value="${pointInfo.lineId }" />
	<input type="hidden" id="pointId" name="pointId" value="${pointInfo.id }" />
	
	<table border="0" cellspacing=0 cellpadding=5 >
		<tr>
			<td>
				站点编号：<input type="text" id="pointIndex" name="pointIndex" value="${pointInfo.pointIndex }">
			</td>
		</tr>
		<tr>
			<td>
				站点名称：<input type="text" id="pointName" name="pointName" value="${pointInfo.pointName }"/>
			</td>
		</tr>
		<tr>
			<td>经&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度：<input type="text" id="pointX" name="pointX" value="${pointInfo.pointX }"/></td>
		</tr>
		<tr>
			<td>纬&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度：<input type="text" id="pointY" name="pointY" value="${pointInfo.pointY }"/></td>
		</tr>
	</table>
</form>
<button onclick="doSave()">保存</button>
</div>
	<div id="preview">
		<div id="float_search_bar">			  
			<label>区域：</label> <input type="text" id="keyword" />
			<button id="search_button">查找</button>
			<span>点击地图或标注获取坐标</span>
		</div>		
		<div id="map_container"></div>
	</div>
	
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2"></script>
	<script type="text/javascript">
		function getUrlParas() {
			var hash = location.hash, para = {}, tParas = hash.substr(1).split(
					"&");
			for ( var p in tParas) {
				if (tParas.hasOwnProperty(p)) {
					var obj = tParas[p].split("=");
					para[obj[0]] = obj[1];
				}
			}
			return para;
		}
		
		var defaultPointName = '用友软件园';			
		var JSONString = ${requestScope.pointInfoJSON};
		var pointInfo = eval(JSONString);
		var pointName = pointInfo.pointName;
		if(pointName != null){
			defaultPointName = pointName;
		}
		
		var para = getUrlParas(), center = para.address ? decodeURIComponent(para.address)
				: defaultPointName, city = para.city ? decodeURIComponent(para.city): "北京市";

		document.getElementById("keyword").value = center;

		var marker_trick = false;
		var map = new BMap.Map("map_container");
		map.enableScrollWheelZoom();

		var marker = new BMap.Marker(new BMap.Point(116.404, 39.915), {
			enableMassClear : false,
			raiseOnDrag : true
		});
		marker.enableDragging();
		map.addOverlay(marker);

		map.addEventListener("click", function(e) {
			if (!(e.overlay)) {
				map.clearOverlays();
				marker.show();
				marker.setPosition(e.point);
				setResult(e.point.lng, e.point.lat);
			}
		});
		marker.addEventListener("dragend", function(e) {
			setResult(e.point.lng, e.point.lat);
		});

		var local = new BMap.LocalSearch(map, {
			renderOptions : {
				map : map
			},
			pageCapacity : 1
		});
		local.setSearchCompleteCallback(function(results) {
			if (local.getStatus() !== BMAP_STATUS_SUCCESS) {
				alert("无结果");
			} else {
				marker.hide();
			}
		});
		local.setMarkersSetCallback(function(pois) {
			for ( var i = pois.length; i--;) {
				var marker = pois[i].marker;
				marker.addEventListener("click", function(e) {
					marker_trick = true;
					var pos = this.getPosition();
					setResult(pos.lng, pos.lat);
				});
			}
		});

		window.onload = function() {
			local.search(center);
			document.getElementById("search_button").onclick = function() {
				local.search(document.getElementById("keyword").value);
			};
			document.getElementById("keyword").onkeyup = function(e) {
				var me = this;
				e = e || window.event;
				var keycode = e.keyCode;
				if (keycode === 13) {
					local.search(document.getElementById("keyword").value);
				}
			};
		};
		function a() {
			document.getElementById("float_search_bar").style.display = "none";
		}

		/*
		 * setResult : 定义得到标注经纬度后的操作
		 * 请修改此函数以满足您的需求
		 * lng: 标注的经度
		 * lat: 标注的纬度
		 */
		function setResult(lng, lat) {
			document.getElementById("pointX").value = lng;
			document.getElementById("pointY").value = lat;
		}
	</script>
			
</body>
</html>