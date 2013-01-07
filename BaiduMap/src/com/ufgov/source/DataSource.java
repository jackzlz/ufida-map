package com.ufgov.source;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ufgov.bean.LinePoint;
import com.ufgov.bean.RouteLine;
import com.ufgov.inter.IDataSource;

public class DataSource implements IDataSource{
	private static DataSource source = null;
	public static DataSource getInstance(){
		if(source == null){
			source = new DataSource();
		}
		
		return source;
	}
	
	public List<RouteLine> getAllRouteLines(){
		List<RouteLine> list = new ArrayList<RouteLine>();
		
		
		for(int i=0;i<2;i++){
			
		}
		return list;
		
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

	public LinePoint getLinePointById(String pointId) {
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
