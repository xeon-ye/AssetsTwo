package avicit.assets.furniture.furniturecollect.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;

import avicit.assets.furniture.furniturecollect.dto.FurnitureCollectDTO;
import avicit.assets.furniture.furniturecollect.service.FurnitureCollectService;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com @创建时间： 2020-06-11 11:13
 * @类说明：请填写 @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/furniture/furniturecollect/furnitureCollectController")
public class FurnitureCollectController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(FurnitureCollectController.class);

    @Autowired
    private FurnitureCollectService furnitureCollectService;

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveUserCollectDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {

            FurnitureCollectDTO furnitureCollectDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<FurnitureCollectDTO>() {
            });

            //获取当前用户的id
            SysUser user = SessionHelper.getLoginSysUser(request);
            furnitureCollectDTO.setUserId(user.getId());
            furnitureCollectDTO.setNewNodePid("MyCollect");

            //判断当前节点是否已被收藏
            FurnitureCollectDTO oldDto = furnitureCollectService.queryUserCollectByPrimaryKey(user.getId(), furnitureCollectDTO.getNodeId());
            if (oldDto == null) {
                FurnitureCollectDTO lastDto = furnitureCollectService.getLastChildNodeByPID(user.getId(), furnitureCollectDTO.getNewNodePid());
                Long nodeSn = 1L;
                if (lastDto != null) {
                    nodeSn = lastDto.getNodeSn();
                    nodeSn = nodeSn + 1;
                }

                furnitureCollectDTO.setNodeSn(nodeSn);
                furnitureCollectService.insertUserCollect(furnitureCollectDTO);
            } else {
                mav.addObject("error", "改节点已经被收藏！");
                mav.addObject("flag", OpResult.failure);
                return mav;
            }

            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 按照id批量删除数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteUserCollectDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String nodeId = ServletRequestUtils.getStringParameter(request, "nodeId", "");
            if (nodeId.endsWith("-1")) {
                nodeId = nodeId.substring(0, nodeId.lastIndexOf("-1"));
            }

            SysUser user = SessionHelper.getLoginSysUser(request);
            furnitureCollectService.deleteUserCollectById(user.getId(), nodeId);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 上下移动节点
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/upDownNode", method = RequestMethod.POST)
    public ModelAndView upDownNodeUserCollectDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            SysUser user = SessionHelper.getLoginSysUser(request);

            String sourceId = ServletRequestUtils.getStringParameter(request, "sourceId", "");
            if (sourceId.endsWith("-1")) {
                sourceId = sourceId.substring(0, sourceId.lastIndexOf("-1"));
            }
            FurnitureCollectDTO sourceNode = furnitureCollectService.queryUserCollectByPrimaryKey(user.getId(), sourceId);

            String targetId = ServletRequestUtils.getStringParameter(request, "targetId", "");
            if (targetId.endsWith("-1")) {
                targetId = targetId.substring(0, targetId.lastIndexOf("-1"));
            }
            FurnitureCollectDTO targetNode = furnitureCollectService.queryUserCollectByPrimaryKey(user.getId(), targetId);

            //交换节点的序号
            long temp = sourceNode.getNodeSn();
            sourceNode.setNodeSn(targetNode.getNodeSn());
            targetNode.setNodeSn(temp);

            furnitureCollectService.updateUserCollect(sourceNode);
            furnitureCollectService.updateUserCollect(targetNode);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 修改节点名称
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/editNodeName", method = RequestMethod.POST)
    public ModelAndView editNameNodeUserCollectDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            SysUser user = SessionHelper.getLoginSysUser(request);

            String nodeId = ServletRequestUtils.getStringParameter(request, "nodeId", "");

            if (nodeId.endsWith("-1")) {
                nodeId = nodeId.substring(0, nodeId.lastIndexOf("-1"));
            }
            FurnitureCollectDTO nodeDto = furnitureCollectService.queryUserCollectByPrimaryKey(user.getId(), nodeId);

            String newName = ServletRequestUtils.getStringParameter(request, "newName", "");
            nodeDto.setNodeName(newName);

            furnitureCollectService.updateUserCollect(nodeDto);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
}
