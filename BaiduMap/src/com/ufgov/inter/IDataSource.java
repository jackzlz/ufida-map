package com.ufgov.inter;

import java.sql.SQLException;
import java.util.List;

import com.ufgov.bean.LinePoint;
import com.ufgov.bean.RouteLine;

public interface IDataSource {
	/**
	 * 得到所有的线路及站点信息
	 * @return
	 * @throws SQLException
	 */
	public List<RouteLine> getAllRouteLines() throws SQLException;
	/**
	 * 得到某条线路及站点信息
	 * @return
	 * @throws SQLException
	 */
	public RouteLine getRouteLineById(int lineId) throws SQLException;
	/**
	 * 保存一条线路信息，不保存站点信息
	 * @param linePoints
	 * @return
	 * @throws SQLException
	 */
	public boolean saveRouteLine(RouteLine routeLine) throws SQLException;
	/**
	 * 更新一条线路信息，线路编号不更新
	 * @param linePoints
	 * @return
	 * @throws SQLException
	 */
	public boolean updateRouteLine(RouteLine routeLine) throws SQLException;	
	/**
	 * 删除一条线路及其站点信息
	 * @return
	 * @throws SQLException
	 */
	public boolean deleteRouteLine(RouteLine routeLine) throws SQLException;
	/**
	 * 保存一个站点
	 * @return
	 * @throws SQLException
	 */
	public boolean saveLinePoint(LinePoint linePoint) throws SQLException;
	/**
	 * 更新一个站点
	 * @return
	 * @throws SQLException
	 */
	public boolean updateLinePoint(LinePoint linePoint) throws SQLException;	
	/**
	 * 删除一个站点
	 * @return
	 * @throws SQLException
	 */
	public boolean deleteLinePoint(String id) throws SQLException;
	/**
	 * 根据ID查找站点
	 * @param pointId
	 */
	public LinePoint getLinePointById(String id) throws SQLException;
	/**
	 * 根据路线ID删除所有的站点
	 * @param id
	 * @return
	 * @throws SQLException 
	 */
	public boolean deleteLinePointByLineId(String id) throws SQLException;
	/**
	 * 获取路线的所有站点中的最大序号
	 * @param lineId
	 * @return
	 * @throws SQLException 
	 */
	public int getMaxPointIndexByLineId(int lineId) throws SQLException;
}
