package avicit.assets.furniture.assetsfurniturerecoveryproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurniturerecoveryproc.dto.AssetsFurnitureRecoverySubDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-18 08:50
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureRecoverySubDao {

	/**
	 * 分页查询  家具回收子表
	 * @param assetsFurnitureRecoverySubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureRecoverySubDTO>
	 */
	public Page<AssetsFurnitureRecoverySubDTO> searchAssetsFurnitureRecoverySubByPage(
            @Param("bean") AssetsFurnitureRecoverySubDTO assetsFurnitureRecoverySubDTO,
            @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 家具回收子表
	 * @param assetsFurnitureRecoverySubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureRecoverySubDTO>
	 */
	public Page<AssetsFurnitureRecoverySubDTO> searchAssetsFurnitureRecoverySubByPageOr(
            @Param("bean") AssetsFurnitureRecoverySubDTO assetsFurnitureRecoverySubDTO,
            @Param("pOrderBy") String orderBy);

	/**
	 * 查询 家具回收子表 
	 * @param id 主键id
	 * @return AssetsFurnitureRecoverySubDTO
	 */
	public AssetsFurnitureRecoverySubDTO findAssetsFurnitureRecoverySubById(String id);

	/**
	 * 查询 家具回收子表
	 * @param pid 父id
	 * @return List<AssetsFurnitureRecoverySubDTO>
	 */
	public List<AssetsFurnitureRecoverySubDTO> findAssetsFurnitureRecoverySubByPid(String pid);

	/**
	 * 新增家具回收子表
	 * @param assetsFurnitureRecoverySubDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureRecoverySub(AssetsFurnitureRecoverySubDTO assetsFurnitureRecoverySubDTO);

	/**
	 * 批量新增 家具回收子表
	 * @param assetsFurnitureRecoverySubDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureRecoverySubList(
            List<AssetsFurnitureRecoverySubDTO> assetsFurnitureRecoverySubDTOList);

	/**
	 * 更新部分对象 家具回收子表
	 * @param assetsFurnitureRecoverySubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureRecoverySubSensitive(AssetsFurnitureRecoverySubDTO assetsFurnitureRecoverySubDTO);

	/**
	 * 更新全部对象 家具回收子表
	 * @param assetsFurnitureRecoverySubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureRecoverySubAll(AssetsFurnitureRecoverySubDTO assetsFurnitureRecoverySubDTO);

	/**
	 * 批量更新对象 家具回收子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureRecoverySubList(@Param("dtoList") List<AssetsFurnitureRecoverySubDTO> dtoList);

	/**
	 * 按主键删除 家具回收子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureRecoverySubById(String id);

	/**
	 * 按主键批量删除 家具回收子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureRecoverySubList(List<String> idList);
}
