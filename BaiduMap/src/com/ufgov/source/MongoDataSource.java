package com.ufgov.source;

import java.net.UnknownHostException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.ufgov.bean.LinePoint;
import com.ufgov.bean.RouteLine;
import com.ufgov.inter.IDataSource;

public class MongoDataSource implements IDataSource {
	private static MongoDataSource dataSource = null;
	
	static DBCollection BusRoute, PointInfor;
	static {
		try {
			Mongo mongo = new Mongo("localhost", 27017);
			DB db = mongo.getDB("Traffic");
			BusRoute = db.getCollection("BusRoute");
			PointInfor = db.getCollection("PointInfor");
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
	
	private MongoDataSource(){}
	
	public static MongoDataSource getInstance(){
		if(dataSource == null){
			dataSource = new MongoDataSource();
		}
		return dataSource;
	}

	public void get() {
		DBCursor cur = BusRoute.find();
		while (cur.hasNext()) {
			System.out.println(JSON.toJSONString(cur.next()));
		}
		System.out.println("-------------------------");
		cur = PointInfor.find();
		while (cur.hasNext()) {
			System.out.println(cur.next());
		}
	}
	
	
	public void save42(){
		
		DBObject route = new BasicDBObject();
		route.put("lineId", 42);
		route.put("lineName", "农展馆");
		route.put("color", "blue");
		BusRoute.save(route);
		
		DBObject point = new BasicDBObject();
		point.put("carNO", 42);
		point.put("index", 0);
		point.put("x", 116.241743f);
		point.put("y", 40.074053f);
		point.put("name", "用友软件园");
		PointInfor.save(point);
		
		DBObject point1 = new BasicDBObject();
		point1.put("carNO", 42);
		point1.put("index", 1);
		point1.put("x", 116.386914f);
		point1.put("y", 39.988086f);
		point1.put("name", "祁家豁子");
		PointInfor.save(point1);
		
		DBObject point2 = new BasicDBObject();
		point2.put("carNO", 42);
		point2.put("index", 2);
		point2.put("x", 116.380752f);
		point2.put("y", 39.97431f);
		point2.put("name", "马甸桥北");
		PointInfor.save(point2);
		
		DBObject point3 = new BasicDBObject();
		point3.put("carNO", 42);
		point3.put("index", 3);
		point3.put("x", 116.463261f);
		point3.put("y", 39.966561f);
		point3.put("name", "三元桥");
		PointInfor.save(point3);

		DBObject point4 = new BasicDBObject();
		point4.put("carNO", 42);
		point4.put("index", 4);
		point4.put("x", 116.46879f);
		point4.put("y", 39.94692f);
		point4.put("name", "农业展览馆");
		PointInfor.save(point4);
				
	}
	
	public void save1(){
		DBObject route = new BasicDBObject();
		route.put("lineId", 1);
		route.put("lineName", "北京西站");
		route.put("color", "red");
		BusRoute.save(route);
		
		DBObject point = new BasicDBObject();
		point.put("carNO", 1);
		point.put("index", 0);
		point.put("x", 116.241743f);
		point.put("y", 40.074053f);
		point.put("name", "用友软件园");
		PointInfor.save(point);
		
		DBObject point1 = new BasicDBObject();
		point1.put("carNO", 1);
		point1.put("index", 1);
		point1.put("x", 116.362193f);
		point1.put("y", 39.945928f);
		point1.put("name", "西直门");
		PointInfor.save(point1);
		
		
		DBObject point2 = new BasicDBObject();
		point2.put("carNO", 1);
		point2.put("index", 2);
		point2.put("x", 116.327985f);
		point2.put("y", 39.900831f);
		point2.put("name", "西站");
		PointInfor.save(point2);
	}
	
	public void remove(){
		BusRoute.drop();
		PointInfor.drop();
	}

	
	
	public List<RouteLine> getAllRouteLines(){
		List<RouteLine> lineList = new ArrayList<RouteLine>();
		DBCursor busRouteCur = BusRoute.find();
		while (busRouteCur.hasNext()) {
			DBObject dbObject = busRouteCur.next();
			int lineId = Integer.parseInt(dbObject.get("lineId").toString());
			String lineName = dbObject.get("lineName").toString();
			String color = dbObject.get("color").toString();
			RouteLine line = new RouteLine(1,lineId, lineName, color);
			
			DBObject condition = new BasicDBObject();
			condition.put("carNO", lineId);
			DBCursor pointInforCur = PointInfor.find(condition);
			
			List<LinePoint> pointList = new ArrayList<LinePoint>();
			while(pointInforCur.hasNext()){
				DBObject pointInfor = pointInforCur.next();
				int index = Integer.parseInt(pointInfor.get("index").toString());
				float x = Float.parseFloat(pointInfor.get("x").toString());
				float y = Float.parseFloat(pointInfor.get("y").toString());
				String name = pointInfor.get("name").toString();
				LinePoint point = new LinePoint("1",index, x, y, name, lineId);
				pointList.add(point);
			}
			line.setPointList(pointList);
			lineList.add(line);
		}
		return lineList;
	}
	
	public static void main(String[] args) {
		MongoDataSource.getInstance().remove();
		MongoDataSource.getInstance().save42();
		MongoDataSource.getInstance().save1();
		System.out.println(JSON.toJSON(MongoDataSource.getInstance().getAllRouteLines()));
	}

	public RouteLine getRouteLineById(int id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean saveRouteLine(RouteLine routeLine) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean updateRouteLine(RouteLine routeLine) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean deleteRouteLine(RouteLine routeLine) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean saveLinePoint(LinePoint linePoint) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean updateLinePoint(LinePoint linePoint) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean deleteLinePoint(String id) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	public LinePoint getLinePointById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean deleteLinePointByLineId(String id) {
		// TODO Auto-generated method stub
		return false;
	}

	public int getMaxPointIndexByLineId(int lineId) {
		// TODO Auto-generated method stub
		return 0;
	}

	

	

}
