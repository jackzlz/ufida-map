package com.ufgov.bean;

import java.util.List;

public class RouteLine {
	private int id;
	private int lineId;
	private String lineName;
	private String lineColor;
	private List<LinePoint> pointList;
	
	
	public RouteLine() {
		
	}
	
	public RouteLine(int lineId, String lineName, String lineColor) {
		this.lineId = lineId;
		this.lineName = lineName;
		this.lineColor = lineColor;
	}
	
	public RouteLine(int id,int lineId, String lineName, String lineColor) {
		this.id = id;
		this.lineId = lineId;
		this.lineName = lineName;
		this.lineColor = lineColor;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getLineId() {
		return lineId;
	}
	public void setLineId(int lineId) {
		this.lineId = lineId;
	}
	public String getLineName() {
		return lineName;
	}
	public void setLineName(String lineName) {
		this.lineName = lineName;
	}
	public List<LinePoint> getPointList() {
		return pointList;
	}
	public void setPointList(List<LinePoint> pointList) {
		this.pointList = pointList;
	}

	public String getLineColor() {
		return lineColor;
	}

	public void setLineColor(String lineColor) {
		this.lineColor = lineColor;
	}
	
	
}
