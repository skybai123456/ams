﻿package com.ams.assetmanage.assettype.model;

/**
 * 资产类型model
 * @author simon
 * @date 2017年1月17日 下午4:13:58
 */
public class AssettypeModel {
	private String assettypeId;		//主键
	private String assettypeName;		//资产名称
	private String unitId;		//单位	
	public String getAssettypeId() {
		return assettypeId;
	}
	public void setAssettypeId(String assettypeId) {
		this.assettypeId = assettypeId;
	}
	public String getAssettypeName() {
		return assettypeName;
	}
	public void setAssettypeName(String assettypeName) {
		this.assettypeName = assettypeName;
	}
	public String getUnitId() {
		return unitId;
	}
	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}
}
