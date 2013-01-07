package com.ufgov.bean;

public class LinePoint {
	private String id;
	private int pointIndex;
	private float pointX;
	private float pointY;
	private String pointName;
	private int lineId;
	
	public LinePoint() {
		super();
	}
	
	public LinePoint(int lineId) {
		this.lineId = lineId;
	}
	
	public LinePoint(String id,int pointIndex, float pointX, float pointY, String pointName,int lineId) {
		this.id = id;
		this.pointIndex = pointIndex;
		this.pointX = pointX;
		this.pointY = pointY;
		this.pointName = pointName;
		this.lineId = lineId;
	}
	
	public LinePoint(int pointIndex, float pointX, float pointY, String pointName,int lineId) {
		this.pointIndex = pointIndex;
		this.pointX = pointX;
		this.pointY = pointY;
		this.pointName = pointName;
		this.lineId = lineId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getPointIndex() {
		return pointIndex;
	}

	public void setPointIndex(int pointIndex) {
		this.pointIndex = pointIndex;
	}

	public float getPointX() {
		return pointX;
	}

	public void setPointX(float pointX) {
		this.pointX = pointX;
	}

	public float getPointY() {
		return pointY;
	}

	public void setPointY(float pointY) {
		this.pointY = pointY;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public int getLineId() {
		return lineId;
	}

	public void setLineId(int lineId) {
		this.lineId = lineId;
	}
}
