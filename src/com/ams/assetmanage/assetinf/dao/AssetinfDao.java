package com.ams.assetmanage.assetinf.dao;

import java.util.List;
import java.util.Map;

import com.ams.assetmanage.assetinf.entity.Assetinf;
import com.ams.assetmanage.assetinf.model.AssetinfModel;
import com.core.dao.BaseDao;
import com.util.page.Pager;

/**
 * 资产信息管理
 * 
 * @author 
 * @Data 
 * 
 */
public interface AssetinfDao extends BaseDao<Assetinf> {

	/**
	 * 条件查询
	 * 
	 * @param model
	 * @param page
	 * @return
	 */
	List<Assetinf> findByCondition(Assetinf model, Pager page);

	/**
	 * 视图条件查询
	 * @param model
	 * @param page
	 * @return
	 */
	List<AssetinfModel> findModelByCondition(AssetinfModel model,Pager page);
	
	/**
	 * 检查当前资产是否存在
	 * 
	 * @param name
	 * @return
	 */
	List<Assetinf> checkAssetinf(String id);

	/**
	 * 根据名称id获取资产信息
	 * 
	 * @param id
	 * @return
	 */
	Assetinf getByName(String name);
	
	/***
	 * 根据id找model
	 * @author simon
	 * @date 2016年11月15日 下午12:56:07
	 * @param id
	 * @return
	 */
	AssetinfModel getModelById(String id);
	
	/**
	 * 统计资产数量 通过资产类型
	 * @author simon
	 * @date 2017年1月18日 下午2:48:48
	 * @return 含有value和name两列值的数据集
	 */
	List<Map<String, Object>> getCountByAssettype();

}
