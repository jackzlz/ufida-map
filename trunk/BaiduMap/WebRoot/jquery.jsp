<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>JqueryEasyUI</title>
<script src="./easyui/jquery-1.8.0.min.js" type="text/javascript"></script>
<script src="./easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link href="./easyui/themes/gray/easyui.css" rel="stylesheet" type="text/css" />
<link href="./easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script>
  function show1() {
      $.messager.show({
          title: '提示信息1',
          msg: '信息1',
          showType: 'show'
      });
  }
  function show2() {
      $.messager.show({
          title: '提示信息2',
          msg: '信息5分钟后消失.',
          timeout: 5000,
          showType: 'slide'
      });
  }
  function show3() {
      $.messager.show({
          title: '渐进显示信息3',
          msg: '渐进显示信息3',
          timeout: 0,
          showType: 'fade'
      });
  }
</script>

</head>
<body class="easyui-layout">
		<div region="north" border="false"
			style="overflow:hidden;height:60px;">
			<h2>Border布局</h2>
		</div>
		<div region="south" split="true" style="height:50px;"></div>
		<div region="west" split="true" title="菜单" style="width:150%;">

			<div id="aa" class="easyui-accordion" fit="true"
				style="width:300px;height:200px;">
				<div title="Title1" style="overflow:auto;padding:10px;">
					<a href="#">Accordion1</a>
				</div>
				<div title="Title2" style="padding:10px;">
					<h3>Accordion2</h3>
				</div>
				<div title="Title3">
					<h3>Accordion3</h3>
				</div>
			</div>
		</div>
		<div region="center" class="easyui-tabs" title="管理区">
			<div title="Tab1">
		        <a href="javascript:void(0)" onclick="show1()">显示</a> |
		        <a href="#" onclick="show2()">滑动</a> |
		        <a href="#" onclick="show3()">渐进显示</a> |
    		</div>
    		<div title="Tab2">
    			<table id="tt"></table>
    			<script type="text/javascript">
    				$('#tt').treegrid({  
					    url:'treegrid_data.json',  
					    treeField:'name',  
					    columns:[[  
					        {title:'Task Name',field:'name',width:180},  
					        {field:'persons',title:'Persons',width:60,align:'right'},  
					        {field:'begin',title:'Begin Date',width:80},  
					        {field:'end',title:'End Date',width:80}  
					    ]]  
					});
    			</script>
    		</div>
		</div>
		
	
</body>
</html>
