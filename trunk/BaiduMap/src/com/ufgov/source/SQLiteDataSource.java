package com.ufgov.source;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.ufgov.bean.LinePoint;
import com.ufgov.bean.RouteLine;
import com.ufgov.inter.IDataSource;

public class SQLiteDataSource implements IDataSource {

	private static SQLiteDataSource dataSource = null;
	private static Connection connection = null;
	
	static {
		try {
			Class.forName("org.sqlite.JDBC");
			connection = DriverManager.getConnection("jdbc:sqlite:D:/Program Files/apache/tomcat-6.0.35/bin/db/ufida.db");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	private SQLiteDataSource(){}
	
	public static SQLiteDataSource getInstance(){
		if(dataSource == null){
			dataSource = new SQLiteDataSource();
		}
		return dataSource;
	}


	
	public List<RouteLine> getAllRouteLines() throws SQLException{
		List<RouteLine> lineList = new ArrayList<RouteLine>();
		PreparedStatement statement = connection.prepareStatement("select ID,lineId,lineName,lineColor from RouteLine order by lineId");
		ResultSet lineResultSet = statement.executeQuery();
		while (lineResultSet.next()) {
			int lineId = lineResultSet.getInt(1);
			int lineNo = lineResultSet.getInt(2);
			String lineName = lineResultSet.getString(3);
			String lineColor = lineResultSet.getString(4);
			RouteLine line = new RouteLine(lineId,lineNo, lineName, lineColor);
//			 System.out.println(JSON.toJSONString(line));
			
			PreparedStatement statement2 = connection.prepareStatement("select ID, pointIndex,pointX,pointY,pointName from LinePoint where lineId = ? order by lineId,pointIndex");
			statement2.setInt(1, lineNo);
			ResultSet pointResultSet = statement2.executeQuery();
			List<LinePoint> pointList = new ArrayList<LinePoint>();
			while(pointResultSet.next()){
				String id = pointResultSet.getString(1);
				int pointNo = pointResultSet.getInt(2);
				float pointX = pointResultSet.getFloat(3);
				float pointY = pointResultSet.getFloat(4);
				String pointName = pointResultSet.getString(5);
				LinePoint point = new LinePoint(id,pointNo, pointX, pointY, pointName, lineNo);
//				System.out.println(JSON.toJSONString(point));
				pointList.add(point);
			}
			line.setPointList(pointList);
			lineList.add(line);
		}
		return lineList;
	}
	
	public RouteLine getRouteLineById(int lineId) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("select lineName,lineColor from RouteLine where lineId = ?");
		statement.setInt(1, lineId);
		ResultSet resultSet = statement.executeQuery();
		while(resultSet.next()){
			String lineName = resultSet.getString(1);
			String lineColor = resultSet.getString(2);
			return new RouteLine(lineId, lineName, lineColor);
		}
		return null;
	}

	public boolean saveRouteLine(RouteLine routeLine) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("insert into RouteLine (lineId,lineName,lineColor) values (?,?,?)");
		statement.setInt(1, routeLine.getLineId());
		statement.setString(2, routeLine.getLineName());
		statement.setString(3, routeLine.getLineColor());
		return statement.execute();
	}

	public boolean updateRouteLine(RouteLine routeLine) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("update RouteLine set lineName=?,lineColor=? where lineId = ?");
		statement.setString(1, routeLine.getLineName());
		statement.setString(2, routeLine.getLineColor());
		statement.setInt(3, routeLine.getLineId());
		return statement.execute();
	}

	public boolean deleteRouteLine(RouteLine routeLine) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("delete from RouteLine where lineId = ?");
		statement.setInt(1, routeLine.getLineId());
		return statement.execute();
	}

	public boolean saveLinePoint(LinePoint linePoint) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("insert into LinePoint (pointIndex,pointX,pointY,pointName,lineId) values (?,?,?,?,?)");
		statement.setInt(1, linePoint.getPointIndex());
		statement.setFloat(2, linePoint.getPointX());
		statement.setFloat(3, linePoint.getPointY());
		statement.setString(4, linePoint.getPointName());
		statement.setInt(5, linePoint.getLineId());
		return statement.execute();
	}

	public boolean updateLinePoint(LinePoint linePoint) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("update LinePoint set pointIndex=?,pointX=?,pointY=?,pointName=?,lineId=? where id = ?");
		statement.setInt(1,linePoint.getPointIndex());
		statement.setFloat(2,linePoint.getPointX());
		statement.setFloat(3,linePoint.getPointY());
		statement.setString(4, linePoint.getPointName());
		statement.setInt(5, linePoint.getLineId());
		statement.setString(6, linePoint.getId());
		return statement.execute();
	}

	public boolean deleteLinePoint(String id) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("delete from LinePoint where id = ?");
		statement.setString(1, id);
		return statement.execute();
	}

	public LinePoint getLinePointById(String id) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("select pointIndex,pointX,pointY,pointName,lineId from LinePoint where id = ?");
		statement.setString(1, id);
		ResultSet resultSet = statement.executeQuery();
		while(resultSet.next()){
			int pointIndex = resultSet.getInt(1);
			float pointX = resultSet.getFloat(2);
			float pointY = resultSet.getFloat(3);
			String pointName = resultSet.getString(4);
			int lineId = resultSet.getInt(5);
			return new LinePoint(id, pointIndex, pointX, pointY, pointName, lineId);
		}
		return null;
	}

	public boolean deleteLinePointByLineId(String lineId) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("delete from LinePoint where lineId = ?");
		statement.setString(1, lineId);
		return statement.execute();
	}

	public int getMaxPointIndexByLineId(int lineId) throws SQLException {
		PreparedStatement statement = connection.prepareStatement("select max(pointIndex) from LinePoint where lineId = ?");
		statement.setInt(1, lineId);
		ResultSet resultSet = statement.executeQuery();
		if(resultSet.next()){
			return resultSet.getInt(1);
		}
		return -10;
	}

	public static void main(String[] args) {
		try {
			System.out.println(SQLiteDataSource.getInstance().getMaxPointIndexByLineId(11));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
