<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdevicetransfer/assetsDeviceTransferController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style type="text/css">
        #t_assetsTransferprocDevice {
            display: none;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsDeviceTransferDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsDeviceTransferDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsDeviceTransferDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               readonly="readonly" name="createdByDeptAlias"
                               value="<c:out  value='${assetsDeviceTransferDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                           readonly="readonly" value="<c:out  value='${assetsDeviceTransferDTO.createdByTel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="formState">单据状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState" readonly="readonly"
                           value="<c:out  value='${assetsDeviceTransferDTO.formState}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="procName">流程名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="procName" id="procName" readonly="readonly"
                           value="<c:out  value='${assetsDeviceTransferDTO.procName}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="receiverAlias">接收人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="receiver" name="receiver"
                               value="<c:out  value='${assetsDeviceTransferDTO.receiver}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="receiverAlias"
                               readonly="readonly" name="receiverAlias"
                               value="<c:out  value='${assetsDeviceTransferDTO.receiverAlias}'/>">
                        <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="receiverDeptAlias">接收人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="receiverDept" name="receiverDept"
                               value="<c:out  value='${assetsDeviceTransferDTO.receiverDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="receiverDeptAlias"
                               readonly="readonly" name="receiverDeptAlias"
                               value="<c:out  value='${assetsDeviceTransferDTO.receiverDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="receiverTel">接收人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="receiverTel" id="receiverTel"
                           readonly="readonly" value="<c:out  value='${assetsDeviceTransferDTO.receiverTel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="receivePositionId">接收安装地点ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="receivePositionId" id="receivePositionId"
                           readonly="readonly" value="<c:out  value='${assetsDeviceTransferDTO.receivePositionId}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="transferReason">移交原因:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="transferReason"
                              id="transferReason"><c:out value='${assetsDeviceTransferDTO.transferReason}'/></textarea>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="procId">流程ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="procId" id="procId" readonly="readonly"
                           value="<c:out  value='${assetsDeviceTransferDTO.procId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersonAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson"
                               value="<c:out  value='${assetsDeviceTransferDTO.createdByPerson}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias"
                               readonly="readonly" name="createdByPersonAlias"
                               value="<c:out  value='${assetsDeviceTransferDTO.createdByPersonAlias}'/>">
                        <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <table id="assetsTransferprocDevice"></table>
                </th>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1%>">
                    <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/assets/device/assetsdevicetransfer/js/AssetsTransferprocDevice.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var secretLevelData = ${secretLevelData};
    var assetsTransferprocDevice;
    var assetsTransferprocDeviceGridColModel = [
        {label: 'id', name: 'id', key: true, width: 75, hidden: true}
        , {label: '资产编号', name: 'assetId', width: 150, editable: false}
        , {label: '设备类别', name: 'deviceCategory', width: 150, editable: false}
        , {label: '设备名称', name: 'deviceName', width: 150, editable: false}
        , {label: '设备型号', name: 'deviceModel', width: 150, editable: false}
        , {label: '设备规格', name: 'deviceSpec', width: 150, editable: false}
        , {
            label: '责任人',
            name: 'ownerIdAlias',
            width: 150,
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'ownerId'}
        }
        , {label: '责任人id', name: 'ownerId', width: 75, hidden: true, editable: false}
        , {
            label: '责任人部门',
            name: 'ownerDeptAlias',
            width: 150,
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}
        }
        , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true, editable: false}
        , {
            label: '使用人',
            name: 'userIdAlias',
            width: 150,
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'userId'}
        }
        , {label: '使用人id', name: 'userId', width: 75, hidden: true, editable: false}
        , {
            label: '使用人部门',
            name: 'userDeptAlias',
            width: 150,
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'userDept'}
        }
        , {label: '使用人部门id', name: 'userDept', width: 75, hidden: true, editable: false}
        , {label: '生产厂家', name: 'manufacturerId', width: 150, editable: false}
        , {
            label: '立卡日期',
            name: 'createdDate',
            width: 150,
            editable: false,
            edittype: 'custom',
            formatter: format,
            editoptions: {custom_element: dateElem, custom_value: dateValue}
        }
        , {label: '安装地点ID', name: 'positionId', width: 150, editable: false}
        , {label: '密级id', name: 'secretLevel', width: 75, hidden: true}
        , {
            label: '密级',
            name: 'secretLevelName',
            width: 150,
            editable: false,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'secretLevel',
                value: secretLevelData
            }
        }
        , {label: '是否统管设备', name: 'isManage', width: 150, editable: false}
        , {label: '是否在流程中', name: 'isInWorkflow', width: 150, editable: false}
        , {label: '统一编号', name: 'unifiedId', width: 150, editable: false}
    ];
    $(document).ready(function () {
        var pid = "${assetsDeviceTransferDTO.id}";
        var isReload = "edit";
        var searchSubNames = "";
        var surl = "platform/assets/device/assetsdevicetransfer/assetsDeviceTransferController/operation/sub/";
        assetsTransferprocDevice = new AssetsTransferprocDevice('assetsTransferprocDevice', surl,
            "formSub",
            assetsTransferprocDeviceGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsTransferprocDevice_keyWord', isReload);
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
        });

        parent.assetsDeviceTransfer.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsDeviceTransferDTO.id}',
            allowAdd: false,
            allowDelete: false
        });
    });
    //form控件禁用
    setFormDisabled();
    $(document).keydown(function (event) {
        event.returnValue = false;
        return false;
    });
</script>
</body>
</html>