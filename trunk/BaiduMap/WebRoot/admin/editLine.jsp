<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="./easyui/colorpicker.js" type="text/javascript"></script>
<script src="./easyui/utils.js" type="text/javascript"></script>
<link href="./easyui/themes/colorpicker.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function doSave(){
		var lineId = $('lineNO').value;
		if(!isNum(lineId)){
			alert(lineId+'不是数字');
			return ;
		}
		
		document.lineInfoForm.submit();
		
	}
</script>
</head>
<body>
<form id="lineInfoForm" name="lineInfoForm" action="./mapServlet?action=${action }" method="POST">
	<table border="0">
		<tr>
			<td width=20>
				<span class="gray f12">路线编号：<input type="text" id="lineNO" name="lineNO" value="${routeLine.lineId }"></span>
			</td>
		</tr>
		<tr>
			<td width=20 valign="top">
				<span class="gray f12">路线名称：<input type="text" id="lineName" name="lineName" value="${routeLine.lineName }"/></span>
			</td>
		</tr>
		
		<tr align="left" valign="top">
			<td width=20 valign="top" colspan="2">
				<span class="gray f12">
				路线颜色：
				<div class="box" style="width:50px">
					<table ID=ShowColor width="50" height="18">
					</table>
				</div>
				<INPUT TYPE="text" ID=SelColor name="lineColor" value="${routeLine.lineColor }"/>
				</span>
			</td>
		</tr>
		<tr>
			<td width=515>
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><span class="gray f12">颜色：</span>
							<div class="box"
								style="padding:0;width:422px !important;width:424px">
								<TABLE ID=ColorTable BORDER=0 CELLSPACING=2 CELLPADDING=0
									style='cursor:pointer'>
									<script type="text/javascript">
											function wc(r, g, b, n)
												{
													r = ((r * 16 + r) * 3 * (15 - n) + 0x80 * n) / 15;
													g = ((g * 16 + g) * 3 * (15 - n) + 0x80 * n) / 15;
													b = ((b * 16 + b) * 3 * (15 - n) + 0x80 * n) / 15;
												
													document.write('<TD BGCOLOR=#' + ToHex(r) + ToHex(g) + ToHex(b) + ' height=8 width=12 onmouseover="ctOver(this)" onmouseout="ctOut(this)" onmousedown="ctClick(this)"></TD>');
												}
												
												var cnum = new Array(1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0);
												
												  for(i = 0; i < 16; i ++)
												  {
												     document.write('<TR>');
												     for(j = 0; j < 30; j ++)
												     {
												     	n1 = j % 5;
												     	n2 = Math.floor(j / 5) * 3;
												     	n3 = n2 + 3;
												
												     	wc((cnum[n3] * n1 + cnum[n2] * (5 - n1)),
												     		(cnum[n3 + 1] * n1 + cnum[n2 + 1] * (5 - n1)),
												     		(cnum[n3 + 2] * n1 + cnum[n2 + 2] * (5 - n1)), i);
												     }
												
												     document.writeln('</TR>');
												  }
											</script>
								</TABLE>
							</div></td>
						<td valign="top" style="padding-left:30px "><span
							class="gray f12">亮度：</span>
							<div class="box" style="width:20px !important;width:26px;">
								<TABLE ID=GrayTable BORDER=0 CELLSPACING=0 CELLPADDING=0
									style='cursor:pointer'>
									<SCRIPT LANGUAGE=JavaScript>
											 	for(i = 255; i >= 0; i -= 8.5) {
													document.write('<TR BGCOLOR=#' + ToHex(i) + ToHex(i) + ToHex(i) + '><TD TITLE=' + Math.floor(i * 16 / 17) + ' height=5 width=20  onmousedown="gtClick(this)"></TD></TR>');
												}
									</SCRIPT>
								</TABLE>
							</div>
						</td>
					</tr>
				</table></td>
		</tr>
	</table>
</form>
<button onclick="doSave()">保存</button>
</body>
</html>