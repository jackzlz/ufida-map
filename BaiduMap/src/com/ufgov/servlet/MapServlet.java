package com.ufgov.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ufgov.bean.LinePoint;
import com.ufgov.bean.RouteLine;
import com.ufgov.inter.IDataSource;
import com.ufgov.source.SQLiteDataSource;
import com.ufgov.tools.StringTools;

public class MapServlet extends HttpServlet {

	private static final long serialVersionUID = -8812746074896459572L;
	private IDataSource dataSource = SQLiteDataSource.getInstance();
	private static final String ACTION = "action";
	private static final String SHOW_ALL_LINE_INFO = "./mapServlet?action=showManageInfo";
	private static final String EDIT_POINT_JSP = "admin/editPoint.jsp";
	private static final String MSG = "msg";
	private static final String POINT_ID = "pointId";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		String action = request.getParameter(ACTION);

		if (action == null) {
			action = "showAllLine";
		}

		if ("showAllLine".equals(action)) {
			showAllLine(request, response);
		} else if ("showManageInfo".equals(action)) {
			edit(request, response);
		} else if("addLine".equals(action)){
			addline(request, response);
		} else if("deleteLine".equals(action)){
			deleteLine(request, response);
		} else if("showEditLinePage".equals(action)){
			String url = "admin/editLine.jsp";
			request.setAttribute(ACTION, "addLine");
			dispatcher(request, response, url);
		} else if("updateLinePage".equals(action)){
			showUpdateLinePage(request, response);
		} else if("updateLine".equals(action)){
			updateLine(request, response);
		} else if("showAddPointPage".equals(action)){
			showAddPointPage(request, response);
		} else if("savePoint".equals(action)){
			savePoint(request, response);
		}else if("showUpdatePoint".equals(action)){
			showUpdatePoint(request, response);
		}else if("updatePoint".equals(action)){
			updatePoint(request, response);
		}else if("deletePoint".equals(action)){
			deletePoint(request, response);
		}
	}
	
	private void showUpdatePoint(HttpServletRequest request,
			HttpServletResponse response) {
		String pointId = request.getParameter(POINT_ID);
		try {
			LinePoint pointInfo = dataSource.getLinePointById(pointId);
			request.setAttribute("pointInfoJSON", JSONObject.toJSONString(pointInfo));
			request.setAttribute("pointInfo", pointInfo);
			request.setAttribute(ACTION, "updatePoint");
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		dispatcher(request, response, EDIT_POINT_JSP);
	}

	private void deletePoint(HttpServletRequest request,
			HttpServletResponse response) {
		String pointId = request.getParameter(POINT_ID);
		String msg = "站点删除成功";
		try {
			dataSource.deleteLinePoint(pointId);
		} catch (SQLException e) {
			msg = "站点删除失败";
			e.printStackTrace();
		}
		
		request.setAttribute(MSG, msg);
		dispatcher(request, response, SHOW_ALL_LINE_INFO);
	}

	private void updatePoint(HttpServletRequest request,HttpServletResponse response) {
		int lineId = Integer.parseInt(request.getParameter("lineId"));
		int pointIndex = Integer.parseInt(request.getParameter("pointIndex"));
		float pointX = Float.parseFloat(request.getParameter("pointX"));
		float pointY = Float.parseFloat(request.getParameter("pointY"));
		String pointName = request.getParameter("pointName");
		String pointId = request.getParameter(POINT_ID);
		String msg = "站点更新成功";
		try {
			pointName= StringTools.ISO2UTF(pointName);
			dataSource.updateLinePoint(new LinePoint(pointId,pointIndex, pointX, pointY, pointName, lineId));
		} catch (SQLException e) {
			msg = "站点更新失败";
			e.printStackTrace();
		}
		
		request.setAttribute(MSG, msg);
		dispatcher(request, response, SHOW_ALL_LINE_INFO);
	}

	private void savePoint(HttpServletRequest request,
			HttpServletResponse response) {
		int lineId = Integer.parseInt(request.getParameter("lineId"));
		int pointIndex = Integer.parseInt(request.getParameter("pointIndex"));
		float pointX = Float.parseFloat(request.getParameter("pointX"));
		float pointY = Float.parseFloat(request.getParameter("pointY"));
		String pointName = request.getParameter("pointName");
		String msg = "站点添加成功";
		try {
			pointName= StringTools.ISO2UTF(pointName);
			dataSource.saveLinePoint(new LinePoint(pointIndex, pointX, pointY, pointName, lineId));
		} catch (SQLException e) {
			msg = "站点添加失败";
			e.printStackTrace();
		}
		
		request.setAttribute(MSG, msg);
		dispatcher(request, response, SHOW_ALL_LINE_INFO);
	}

	private void showAddPointPage(HttpServletRequest request,
			HttpServletResponse response) {
		int lineId = Integer.parseInt(request.getParameter("lineId"));
		int maxPointIndex = 0;
		try {
			maxPointIndex = dataSource.getMaxPointIndexByLineId(lineId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		int curPointIndex = maxPointIndex+1;
		
		request.setAttribute(ACTION, "savePoint");
		LinePoint pointInfo = new LinePoint(curPointIndex, 116.241743f, 40.074053f, "用友软件园", lineId);
		request.setAttribute("pointInfo", pointInfo);
		request.setAttribute("pointInfoJSON", JSONObject.toJSONString(pointInfo));
		dispatcher(request, response, EDIT_POINT_JSP);
	}

	private void updateLine(HttpServletRequest request,
			HttpServletResponse response) {
		int lineNO = -1;
		String msg = "路线更新成功";
		try {
			
			lineNO = Integer.parseInt(request.getParameter("lineNO"));
		} catch (NumberFormatException e1) {
			msg = "路线编号须为数字";
			e1.printStackTrace();
		}
		String lineName = request.getParameter("lineName");
		String lineColor = request.getParameter("lineColor");
		
		try {
			
			lineName= StringTools.ISO2UTF(lineName);
			dataSource.updateRouteLine(new RouteLine(lineNO, lineName, lineColor));
		} catch (SQLException e) {
			msg = "数据库执行失败";
			e.printStackTrace();
		}		
		
		request.setAttribute(MSG, msg);
		
		dispatcher(request, response, SHOW_ALL_LINE_INFO);
		
	}

	private void showUpdateLinePage(HttpServletRequest request,
			HttpServletResponse response) {
		String url = "admin/editLine.jsp";
		int lineId = Integer.parseInt(request.getParameter("lineId"));
		try {
			RouteLine routeLine = dataSource.getRouteLineById(lineId);
			if(routeLine != null){
				request.setAttribute(ACTION, "updateLine");
				request.setAttribute("routeLine", routeLine);
				dispatcher(request, response, url);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

	private void dispatcher(HttpServletRequest request,
			HttpServletResponse response,String url){
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void deleteLine(HttpServletRequest request,
			HttpServletResponse response) {
		int lineId = Integer.parseInt(request.getParameter("lineId"));
		RouteLine line = new RouteLine();
		line.setLineId(lineId);
		String msg = "删除成功";
		try {
			dataSource.deleteRouteLine(line);
			
			dataSource.deleteLinePointByLineId(lineId+"");
			
		} catch (SQLException e) {
			msg = "数据库执行失败";
			e.printStackTrace();
		}
		
			
		request.setAttribute(MSG, msg);
		dispatcher(request, response, SHOW_ALL_LINE_INFO);
		
	}

	private void addline(HttpServletRequest request,
			HttpServletResponse response) {
		String msg = "路线新增成功";
		int lineId = -1;
		try {
			
			lineId = Integer.parseInt(request.getParameter("lineNO"));
		} catch (NumberFormatException e1) {
			msg = "路线编号须为数字";
			e1.printStackTrace();
		}
		String lineName = request.getParameter("lineName");
		String lineColor = request.getParameter("lineColor");
		
		try {
			
			lineName= StringTools.ISO2UTF(lineName);
			dataSource.saveRouteLine(new RouteLine(lineId, lineName, lineColor));
			LinePoint ufida = new LinePoint(0, 116.241743f, 40.074053f, "用友软件园", lineId);
			dataSource.saveLinePoint(ufida);
		} catch (SQLException e) {
			msg = "数据库执行失败";
			e.printStackTrace();
		}		
		
		request.setAttribute(MSG, msg);
		dispatcher(request, response, SHOW_ALL_LINE_INFO);
		
		
	}

	private void edit(HttpServletRequest request, HttpServletResponse response) {
		try {
			List<RouteLine> list= getAllLinesInfo();
			String json = JSON.toJSONString(list);
			request.setAttribute("allLineInfoJson", json);
			request.setAttribute("allLineInfoList", list);
			
//			request.getRequestDispatcher("/admin/jqueryEditLine.jsp").forward(request, response);
			request.getRequestDispatcher("/admin/manageLine.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	

	private List<RouteLine> getAllLinesInfo() throws SQLException {
		List<RouteLine> routeLines = dataSource.getAllRouteLines();
		return routeLines;
	}

	private void showAllLine(HttpServletRequest request,HttpServletResponse response) {
		try {
			List<RouteLine> list = getAllLinesInfo();
			String allLineInfo = JSON.toJSONString(list);
			request.setAttribute("allLineInfoJson", allLineInfo);
			request.getRequestDispatcher("line.jsp").forward(request,response);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
