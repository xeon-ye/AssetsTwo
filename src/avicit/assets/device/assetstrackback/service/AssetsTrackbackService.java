package avicit.assets.device.assetstrackback.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import avicit.platform6.modules.system.sysfileupload.service.SwfUploadService;
import org.springframework.util.Assert;

import avicit.platform6.bpm.api.listener.InstanceDeleteEventListener;
import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.bpmreform.bpmbusiness.service.BusinessService;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.spring.SpringFactory;
import avicit.assets.device.assetstrackback.dto.AssetsTrackbackDTO;
import avicit.assets.device.assetstrackback.dao.AssetsTrackbackDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 17:35
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsTrackbackService implements Serializable, InstanceDeleteEventListener {

	private static final Logger logger = LoggerFactory.getLogger(AssetsTrackbackService.class);

	@Autowired
	private BpmOperateService bpmOperateService;

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsTrackbackDao assetsTrackbackDao;

	@Autowired
	private SwfUploadService sysAttachmentAPI;

	@Autowired
	private BusinessService businessService;

	/**
	 * 可注册为流程的删除事件
	 * @param processInstanceId 流程实例id
	 * @param executionId 
	 * @param formId 表单id
	 * @throws Exception
	 */
	@Override
	public void notify(String processInstanceId, String executionId, String formId) throws Exception {
		AssetsTrackbackDao assetsTrackbackDao = SpringFactory.getBean(AssetsTrackbackDao.class);
		assetsTrackbackDao.deleteAssetsTrackbackById(formId);
	}

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTrackbackDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTrackbackDTO> searchAssetsTrackbackByPage(QueryReqBean<AssetsTrackbackDTO> queryReqBean,
			String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTrackbackDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTrackbackDTO> dataList = assetsTrackbackDao.searchAssetsTrackbackByPage(searchParams, orderBy);
			QueryRespBean<AssetsTrackbackDTO> queryRespBean = new QueryRespBean<AssetsTrackbackDTO>();
			for (AssetsTrackbackDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTrackbackByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTrackbackDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTrackbackDTO> searchAssetsTrackbackByPageOr(
			QueryReqBean<AssetsTrackbackDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTrackbackDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTrackbackDTO> dataList = assetsTrackbackDao.searchAssetsTrackbackByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsTrackbackDTO> queryRespBean = new QueryRespBean<AssetsTrackbackDTO>();
			for (AssetsTrackbackDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTrackbackByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 流程的编码转换成名称
	* @param stateCode 编码
	* @return String
	*/
	private String processStateCode2StateName(String stateCode) {
		String stateName = "";
		if (stateCode != null && "active".equals(stateCode)) {
			stateName = "流转中";
		} else if (stateCode != null && "ended".equals(stateCode)) {
			stateName = "结束";
		} else if (stateCode != null && "start".equals(stateCode)) {
			stateName = "草稿";
		}
		return stateName;
	}

	/**
	 * 按条件查询，不分页
	 * @param queryReqBean 查询条件
	 * @return List<AssetsTrackbackDTO>
	 * @throws Exception
	 */
	public List<AssetsTrackbackDTO> searchAssetsTrackback(QueryReqBean<AssetsTrackbackDTO> queryReqBean)
			throws Exception {
		try {
			AssetsTrackbackDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsTrackbackDTO> dataList = assetsTrackbackDao.searchAssetsTrackback(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsTrackback出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsTrackbackDTO
	 * @throws Exception
	 */
	public AssetsTrackbackDTO queryAssetsTrackbackByPrimaryKey(String id) throws Exception {
		try {
			AssetsTrackbackDTO dto = assetsTrackbackDao.findAssetsTrackbackById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsTrackbackByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertAssetsTrackback(AssetsTrackbackDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsTrackbackDao.insertAssetsTrackback(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsTrackback出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsTrackbackList(List<AssetsTrackbackDTO> dtoList) throws Exception {
		List<AssetsTrackbackDTO> beanList = new ArrayList<AssetsTrackbackDTO>();
		for (AssetsTrackbackDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsTrackbackDao.insertAssetsTrackbackList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsTrackbackList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTrackback(AssetsTrackbackDTO dto) throws Exception {
		try {
			//记录日志
			AssetsTrackbackDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int ret = assetsTrackbackDao.updateAssetsTrackbackAll(old);
			if (ret == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		} catch (Exception e) {
			logger.error("updateAssetsTrackback出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTrackbackSensitive(AssetsTrackbackDTO dto) throws Exception {
		try {
			//记录日志
			AssetsTrackbackDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int ret = assetsTrackbackDao.updateAssetsTrackbackSensitive(old);
			if (ret == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		} catch (Exception e) {
			logger.error("updateAssetsTrackbackSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTrackbackList(List<AssetsTrackbackDTO> dtoList) throws Exception {
		try {
			return assetsTrackbackDao.updateAssetsTrackbackList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsTrackbackList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTrackbackById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsTrackbackDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsTrackbackDao.deleteAssetsTrackbackById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsTrackbackById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTrackbackByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			sysAttachmentAPI.deleteAttachByFormId(id);
			deleteAssetsTrackbackById(id);
			String flowInstanceId = bpmOperateService.getInstanceIdByFormid(id);
			if (flowInstanceId != null && !"".equals(flowInstanceId)) {
				bpmOperateService.deleteProcessInstanceCascade(flowInstanceId);
			}
			result++;
		}
		return result;
	}

	/**
	 * 批量删除数据2
	 * @param idList 主键集合
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTrackbackList(List<String> idList) throws Exception {
		try {
			return assetsTrackbackDao.deleteAssetsTrackbackList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsTrackbackList出错：", e);
			throw e;
		}
	}

	/**
	* 日志专用，内部方法，不再记录日志
	* @param id 主键id
	* @return AssetsTrackbackDTO
	* @throws Exception
	*/
	private AssetsTrackbackDTO findById(String id) throws Exception {
		try {
			AssetsTrackbackDTO dto = assetsTrackbackDao.findAssetsTrackbackById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 保存表单并启动流程
	* @param bean 表单对象
	* @param parameter 启动流程所需要的参数
	* @return StartResultBean
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public StartResultBean insertAssetsTrackbackAndStartProcess(AssetsTrackbackDTO bean, Map<String, Object> parameter)
			throws Exception {
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String) parameter.get("processDefId");
		String formCode = (String) parameter.get("formCode");
		String jsonString = (String) parameter.get("jsonString");
		String userId = (String) parameter.get("userId");
		String deptId = (String) parameter.get("deptId");
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		//业务操作
		this.insertAssetsTrackback(bean);
		//
		Map<String, Object> variables = new HashMap<String, Object>();
		//web表单传递过来(除表单对象外)的变量，可以为空
		if (jsonString != null && !"".equals(jsonString)) {
			Map<String, Object> extVariables = JsonUtil.parseJSON2Map((String) jsonString);
			variables.putAll(extVariables);
		}
		//把表单对象转换成map,传递给流程变量
		Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
		variables.putAll(pojoMap);
		String processInstanceId = bpmOperateService.startProcessInstanceById(processDefId, formCode, userId, deptId,
				variables);
		// 返回对象
		return businessService.getStartResultBean(processInstanceId, bean.getId(), userId);
	}
}