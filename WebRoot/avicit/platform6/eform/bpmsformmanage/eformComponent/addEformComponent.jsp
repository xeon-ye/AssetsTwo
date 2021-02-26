<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='addForm'>
        <input type="hidden" id="eformTypeId" name="eformTypeId">

        <table class="form_commonTable">
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="componentName">名称：</label>
                </th>
                <td width="35%">
                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="componentName" id="componentName"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="orderBy">排序：</label>
                </th>
                <td width="35%">
                    <input title="排序" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="orderBy" id="orderBy"/>
                </td>
            </tr>

            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="componentDesc">描述：</label>
                </th>
                <td colspan="3" width="85%">
                    <textarea title="描述" rows="3" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="componentDesc" id="componentDesc"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn typeb btn-sm" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>

<script type="text/javascript">
    document.ready = function () {
    	$.validator.addMethod("integer", function (value, element) {
    	    var tel = /^-?\d+$/g;  //正、负 整数 + 0
    	    return this.optional(element) || (tel.test(value));
    	}, "请输入整数");
        $("#eformTypeId").val(parent.eformTypeTree.selectedNodeId);

        var typeData = {"eformTypeId": parent.eformTypeTree.selectedNodeId}
        var paramData = "param="+JSON.stringify(typeData);
        $.ajax({
            url: "platform/eform/bpmsManageController/getNewEformComponentNb",
            data: paramData,
            type: "post",
            dataType: "json",
            success: function (r) {
                $("#orderBy").val(r.number);
            }
        });

        parent.eformComponent.formValidate($('#addForm'));
        $('#saveForm').bind('click', function () {
            parent.eformComponent.subAdd($("#addForm"));
        });
        $('#closeForm').bind('click', function () {
            parent.eformComponent.closeDialog("add");
        });
    };
</script>
</body>
</html>
