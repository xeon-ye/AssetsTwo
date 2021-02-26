package avicit.assets.device.assetssdequipcollect.rest;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsSupplierDTO;
import avicit.assets.device.assetsstdtempapplyproc.service.AssetsSupplierService;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectDTO;
import avicit.assets.device.dynsdcollecmain.service.AssetsSdequipCollectService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-22 15:34
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetssdequipcollect/AssetsSdequipCollectRest")
public class AssetsSdequipCollectRest{
    private static final Logger LOGGER =  LoggerFactory.getLogger(AssetsSdequipCollectRest.class);
    
	@Autowired
	private AssetsSdequipCollectService assetsSdequipCollectService;
	
	@Autowired
	private AssetsSupplierService assetsSupplierService;
	
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsSdequipCollectDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsSdequipCollectDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsSdequipCollectDTO> responseMsg = new ResponseMsg<AssetsSdequipCollectDTO>();
		AssetsSdequipCollectDTO dto = assetsSdequipCollectService.queryAssetsSdequipCollectByPrimaryKey(id);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	/**
	 * 新增主表对象
	 * @param dto 保存对象
	 * @return ResponseMsg<String>
	 * @throws Exception
	 */
	@POST
	@Path("/saveMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<String> saveMain(AssetsSdequipCollectDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id =  assetsSdequipCollectService.insertAssetsSdequipCollect(dto);
		responseMsg.setResponseBody(id);
		return responseMsg;
	}
	/**
	 * 更新主表数据
	 * @param dto 更新对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateMainSensitive(AssetsSdequipCollectDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsSdequipCollectService.updateAssetsSdequipCollectSensitive(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 修改主表全部对象字段
	 * @param dto 修改对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateMainAll/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateMainAll(AssetsSdequipCollectDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsSdequipCollectService.updateAssetsSdequipCollect(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsSdequipCollectDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsSdequipCollectDTO>> searchMainByPage(QueryReqBean<AssetsSdequipCollectDTO> queryReqBean,String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsSdequipCollectDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsSdequipCollectDTO>>();
			    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    	    	    QueryRespBean<AssetsSdequipCollectDTO> queryRespBean = assetsSdequipCollectService.searchAssetsSdequipCollectByPage(queryReqBean,sfnConditions);
	    		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsSdequipCollectDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsSdequipCollectDTO>> searchMain(QueryReqBean<AssetsSdequipCollectDTO> queryReqBean) throws Exception {
		ResponseMsg<List<AssetsSdequipCollectDTO>> responseMsg = new ResponseMsg<List<AssetsSdequipCollectDTO>>();
		List<AssetsSdequipCollectDTO> queryRespBean = assetsSdequipCollectService.searchAssetsSdequipCollect(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
	/**
	 * 按照ID删除一条主表记录
	 * @param id 主键id
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/deleteMainById/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> deleteMainById(String id) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsSdequipCollectService.deleteAssetsSdequipCollectById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	
	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsSupplierDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsSupplierDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AssetsSupplierDTO>> responseMsg = new ResponseMsg<List<AssetsSupplierDTO>>();
		List<AssetsSupplierDTO> dto = assetsSupplierService.queryAssetsSupplierByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	
	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsSupplierDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsSupplierDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsSupplierDTO> responseMsg = new ResponseMsg<AssetsSupplierDTO>();
		AssetsSupplierDTO dto = assetsSupplierService.queryAssetsSupplierByPrimaryKey(id);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	/**
	 * 更新子表数据
	 * @param dto 更新对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateSub/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateSubSensitive(AssetsSupplierDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsSupplierService.updateAssetsSupplier(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 修改子表一条记录的全部字段
	 * @param dto 更新对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateSubAll/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateSubAll(AssetsSupplierDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsSupplierService.updateAssetsSupplierSensitive(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 按照ID删除一条子表记录
	 * @param id 主键id
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/deleteSubById/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> deleteSubById(String id) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsSupplierService.deleteAssetsSupplierById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
