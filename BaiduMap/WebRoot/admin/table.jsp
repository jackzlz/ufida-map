<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="images/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="javascript/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('tbody tr:odd').addClass("trLight");
		
		$(".select-all").click(function(){
			if($(this).attr("checked")){
				$(".checkBox input[type=checkbox]").each(function(){
					$(this).attr("checked", true);  
					});
				}else{
					$(".checkBox input[type=checkbox]").each(function(){
					$(this).attr("checked", false);  
					});
				}
			});
		
		})
</script>
<style type="text/css">
body {
	background:#FFF
}
</style>
</head>

<body>
<div id="contentWrap">
	<!--表格控件 -->
  <div id="widget table-widget">
    <div class="pageTitle">表格控件-简单</div>
    <div class="pageColumn">
      <div class="pageButton"></div>
      <table>
        <thead>
        <th width="25"><input class="select-all" name="" type="checkbox" value="" /></th>
          <th width="">id</th>
          <th width="">用户名</th>
          <th width="">密码</th>
          <th width="">4</th>
          <th width="">55</th>
          <th width="10%">操作</th>
            </thead>
        <tbody>
          <tr>
            <td class="checkBox"><input name="ids[]" type="checkbox" value="" /></td>
            <td>11</td>
            <td>11</td>
            <td>11</td>
            <td>11</td>
            <td>5555555555555555555</td>
            <td><img src="images/icon/edit2.png" width="16" height="16" />　
            <img src="images/icon/del.png" width="16" height="16" /></td>
          </tr>
          <tr class=" ">
            <td class="checkBox"><input name="ids[]" type="checkbox"  value="" /></td>
            <td>11</td>
            <td>11</td>
            <td>11</td>
            <td>11</td>
            <td>5555555555555555555</td>
            <td><img src="images/icon/edit2.png" width="16" height="16" />　
            <img src="images/icon/del.png" width="16" height="16" /></td>
          </tr>
          <tr class=" ">
            <td class="checkBox"><input name="ids[]" type="checkbox"  value="" /></td>
            <td>11</td>
            <td>11</td>
            <td>11</td>
            <td>11</td>
            <td>5555555555555555555</td>
            <td><img src="images/icon/edit2.png" width="16" height="16" />　
            <img src="images/icon/del.png" width="16" height="16" /></td>
          </tr>
          <tr class=" ">
            <td class="checkBox"><input name="ids[]" type="checkbox"  value="" /></td>
            <td>11</td>
            <td>11</td>
            <td>11</td>
            <td>11</td>
            <td>5555555555555555555</td>
            <td><img src="images/icon/edit2.png" width="16" height="16" />　
            <img src="images/icon/del.png" width="16" height="16" /></td>
          </tr>
          
          <tr class=" ">
            <td colspan="7" class="checkBox">共找到 1000 条记录，每页50条记录 &lt;上页　1　　2 　3　　4　　5　　6　　7　　8　　9　　10　下页&gt;　</td>
          </tr>
          
        </tbody>
      </table>
    </div>
  </div><!-- #widget -->
</div>


</body>
</html>
