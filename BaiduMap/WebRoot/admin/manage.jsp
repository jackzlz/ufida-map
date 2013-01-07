<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理</title>
<link href="images/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="javascript/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	//setMenuHeight
	$('.menu').height($(window).height()-51-27-26-5);
	$('.sidebar').height($(window).height()-51-27-26-5);
	$('.page').height($(window).height()-51-27-26-5);
	$('.page iframe').width($(window).width()-15-168);
	
	//menu on and off
	$('.btn').click(function(){
		$('.menu').toggle();
		
		if($(".menu").is(":hidden")){
			$('.page iframe').width($(window).width()-15+5);
			}else{
			$('.page iframe').width($(window).width()-15-168);
				}
		});
		
	//
	$('.subMenu a[href="#"]').click(function(){
		$(this).next('ul').toggle();
		return false;
		});
})
</script>


</head>

<body style="overflow-y:hidden">
<div id="wrap">
	<div id="header">
    <div class="logo fleft"></div>
    <div class="nav fleft">
    	<ul>
        	<div class="nav-left fleft"></div>
            <li class="first"><a href="#">我的面板</a></li>
        	<li><a href="#">设置</a></li>
            <li><a href="#">模块</a></li>
            <li><a href="#">内容</a></li>
            <li><a href="#">用户</a></li>
            <li><a href="#">扩展</a></li>
            <li><a href="#">应用</a></li>
            <div class="nav-right fleft"></div>
        </ul>
    </div>
    <a class="logout fright" href="login.jsp"> </a>
    <div class="clear"></div>
    <div class="subnav">
    	<div class="subnavLeft fleft"></div>
        <div class="fleft"></div>
        <div class="subnavRight fright"></div>
    </div>
    </div>
    <!--#header -->
    <div id="content">
    <div class="space"></div>
    <div class="menu fleft">
    	<ul>
        	<li class="subMenuTitle">菜单列表</li>
            <li class="subMenu"><a href="#">常用菜单</a>
            	<ul>
                	<li><a href="./../mapServlet?action=showAllLine" target="right">路线地图</a></li>
               
                	<li><a href="./../mapServlet?action=showManageInfo" target="right">管理路线</a></li>
                </ul>
            </li>
            <li class="subMenu"><a href="#">常用工具</a>
             	<ul>
                	<li><a href="./../getPoint.jsp" target="right">取经纬度</a></li>
                </ul>
            </li>
            <li class="subMenu"><a href="#">系统选项</a>
             	<ul>
                	<li><a href="#" target="right">参数设置</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <div class="sidebar fleft"><div class="btn"></div></div>
    <div class="page">
    <iframe width="100%" height="100%"  src="./../mapServlet" id="rightMain" name="right"></iframe>
    </div>
    </div>
    <!--#content -->
    <div class="clear"></div>
    <div id="footer">CopyRight &copy; 2012-2014 zhangrm </div><!--#footer -->
   
    
</div><!--#wrap -->
</body>
</html>
