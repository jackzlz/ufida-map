<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
	<!--
　　　.tnt {Writing-mode:tb-rl;Text-align:left;font-size:9pt}
　	-->
</style>
<script type="text/javascript">
		function deleteLine(selectedLineId){
			if(confirm("是否要将"+selectedLineId+"号线路信息删除?")){
				//document.location ="./../mapServlet?action=deleteLine&id="+selectedLineId;
				//window.open("mapServlet?action=deleteLine&lineId="+selectedLineId);
				document.location.href="mapServlet?action=deleteLine&lineId="+selectedLineId;
			}else{
				return ;
			}
		}
		
		function deletePoint(id){
			if(confirm("是否要将"+id+"号站点信息删除?")){
				//document.location ="./../mapServlet?action=deleteLine&id="+selectedLineId;
				//window.open("mapServlet?action=deleteLine&lineId="+selectedLineId);
				document.location.href="mapServlet?action=deletePoint&pointId="+id;
			}else{
				return ;
			}
		}
	</script>

</head>

<body>
	<!-- 
	<select id="lineSelect" name="lineSelect"
		onchange="javascript:setLinePoints();">
		<option disabled="disabled" selected="selected">---------选择路线---------</option>
	</select>


	<select id="pointSelect" name="pointSelect" onchange="selectPoint()">
		<option disabled="disabled" selected="selected">---------路线站点---------</option>
	</select>
	 -->
	 
	 
	<!-- 
    <button onclick="addLine()" target="southMain">新增路线</button>
     -->
	
	<table border="1" cellspacing=0 cellpadding=5  bgcolor="WHITE">
		<tr>
			<td align="center" colspan="7"><h1>编辑页面</h1></td>
		</tr>
		<tr>
			<td align="center" colspan="2"><a href="mapServlet?action=showEditLinePage" target="_self">新增路线</a></td>
			<td align="center" colspan="5"><font color="red"><c:out value="${requestScope.msg }"></c:out></font></td>
		</tr>
		<tr bgcolor="#80ff80">
			<td align="center" >路线编号</td>
			<td align="center" >路线方向</td>
			<td align="center" >标注颜色</td>
			<td colspan="4"  align="center">操作</td>
		</tr>

		<c:forEach items="${requestScope.allLineInfoList}" var="lineInfo">
			<tr bgcolor="#8080ff">
				<td align="center" >${lineInfo.lineId }号线</td>
				<td align="center">${lineInfo.lineName }</td>
				<td align="center">${lineInfo.lineColor }</td>
				<td align="center">
					<a href="mapServlet?action=showAddPointPage&lineId=${lineInfo.lineId}">添加站点</a>
				</td>
				<td align="center">
					<a href="mapServlet?action=updateLinePage&lineId=${lineInfo.lineId}">修改</a>
				</td>
				<td align="center" colspan="2">
					<a href="#" onclick="deleteLine(${lineInfo.lineId })">删除</a>
				</td>
			</tr>
			<c:if test="${!empty lineInfo.pointList}">
				<tr>
					<td align="center" rowspan="${fn:length(lineInfo.pointList)+1 }" bgcolor="#8080ff">站点信息</td>
					<td align="center" bgcolor="gray">站点序号</td>
					<td align="center" bgcolor="gray">站点名</td>
					<td align="center" bgcolor="gray">经度</td>
					<td align="center" bgcolor="gray">纬度</td>
					<td align="center" colspan="2" bgcolor="gray">操作</td>
    			</tr>
   				<c:forEach items="${lineInfo.pointList }" var="pointInfo">
					<tr>
   						<td align="center">${pointInfo.pointIndex }</td>
   						<td align="center">${pointInfo.pointName }</td>
   						<td align="center">${pointInfo.pointX }</td>
   						<td align="center">${pointInfo.pointY }</td>
   						<td align="center">
	   						<c:if test="${pointInfo.pointIndex != 0 }">
	   							<a href="mapServlet?action=showUpdatePoint&pointId=${pointInfo.id}">修改</a>
	   						</c:if>
   						</td>
   						<td align="center">
	   						<c:if test="${pointInfo.pointIndex != 0 }">
	   							<a href="#" onclick="deletePoint(${pointInfo.id})">删除</a>
	   						</c:if>
   						</td>
   					</tr>
   				</c:forEach>
					</c:if>
   		</c:forEach>
    </table>
  </body>
</html>
<!-- 
<script type="text/javascript">
		var lineSelect = $("lineSelect");
		var pointSelect = $("pointSelect");
		var JSONString = ${requestScope.allLineInfoJson};
		var routeLines = eval(JSONString);
		
	
		function $(id){
			//alert(id);
			return document.getElementById(id);
		}
		
		function selectPoint(){
			//alert(pointSelect.value);
		}
	
		function setLinePoints(){
			//alert("setLinePoints");
			var selectedLineId = lineSelect.value;
			//alert(selectedLineId);
			for (index = 0; index < routeLines.length; index++) {
				var routeLine = routeLines[index];
				var lineId = routeLine.lineId;
				//alert("selectedLineId="+selectedLineId+",lineId="+lineId+",lineId == selectedLineId"+(lineId == selectedLineId));
				if(routeLine.lineId == selectedLineId){
					var pointList = routeLine.pointList;
					//alert("选项有："+pointList.length);
					pointSelect.options.length=1;//移除所有选项，默认项不移除
					for(i=0; i<pointList.length; i++){
						var point = pointList[i];
						//alert(point.pointName+"="+point.id);
						var msg;
						if(i!=0){
							msg = "第"+point.pointIndex+"站-["+point.pointName+"]";
						}else{
							msg = "首发-"+point.pointName;
						}
						
						var option = new Option(msg,point.id);
						pointSelect.add(option);
					}
				}
			}
		}
			
		for (index = 0; index < routeLines.length; index++) {
			var routeLine = routeLines[index];
			var show = routeLine.lineId+"号线开往"+routeLine.lineName;
			lineSelect.add(new Option(show,routeLine.lineId));
		}
</script>

 -->


