<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<html>
<head>
<%
	String curAppId = SessionHelper.getApplicationId();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
var currTreeNode;
var editIndex = -1;
var validRole={};
var validComboData=[{lookupCode:"3",lookupName:'无效'},{lookupCode:"1",lookupName:'正常'}];
var unableModifyComboData = {};
var appid;
var curAppId = "<%=curAppId%>";
var newRowCount=0;
var isFirst = true;
$(document).ready(function(){ 
	
	//添加删除editor扩展
	sysAppTree = new SysAppTree('apps','searchApp',APP_.PUBLIC);
	sysAppTree.setOnSelect(function(_sysAppTree,node){
		if (!isFirst){
			setFirstPage();
		}
		appid = node.id;
		loadRoleInfo(appid);
		loadUserInfo(null);
		isFirst = false;
	});
	
	sysAppTree.init();
	initComboData();
	$('#searchRoleDialog').css('display','block').dialog({
		title:'查询角色'
	}).dialog('close',true);
	$('#searchUserDialog').css('display','block').dialog({
		title:'查询用户'
	}).dialog('close',true);
	loadUserInfo(null);
	
	$('#searchGroupForm').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchRole();
		}
	});
	$('#searchUserForm').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchUser();
		}
	});
});

/**
 * 加载群组信息
 */
function loadRoleInfo(appId){
	$("#dgRole").datagrid("options").url ="platform/cc/sysrole/getSysRoleListByPage.json";
	$('#dgRole').datagrid("reload", {filter_EQ_sysApplicationId: appId});
	$("#dgRole").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');		
};

function setFirstPage(){
	var opts = $("#dgRole").datagrid('options');
	var pager = $("#dgRole").datagrid('getPager');
	opts.pageNumber = 1;
    opts.pageSize = opts.pageSize;
	pager.pagination('refresh',{
	    	pageNumber:1,
	    	pageSize:opts.pageSize
	});
}

function loadSearchRoleInfo(appId, roleName, roleCode)
{
	$("#dgRole").datagrid("options").url ="platform/cc/sysrole/getSysRoleListByPage.json";
	$('#dgRole').datagrid("reload", 
			{filter_EQ_sysApplicationId: appId, 
				filter_LIKE_roleName: roleName, 
				filter_LIKE_roleCode: roleCode}
	);
	$("#dgRole").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
};


function dgRoleOnClickRow(index,rowData)
{
	if(rowData.roleCode ==='comm_user'){
		loadUserInfo(rowData.id);
		var myDatagrid=$('#dgRole');
		myDatagrid.datagrid('endEdit', editIndex);
		return;
	}
	newRowCount++;
	
	var myDatagrid=$('#dgRole');
	myDatagrid.datagrid('endEdit', editIndex);
	if(editIndex==-1)
	{
		myDatagrid.datagrid('beginEdit', index);  
		editIndex=index;
		
		// 有效无效的下拉框
		var ed = myDatagrid.datagrid('getEditor',{index:editIndex,field: 'validFlag'});
		$(ed.target).combobox('loadData', validRole);
		var ed1 = myDatagrid.datagrid('getEditor',{index:editIndex,field: 'usageModifier'});
		$(ed1.target).combobox('loadData', unableModifyComboData);
		// 获取群组中的用户列表
	    loadUserInfo(rowData.id);
	}else{
		$.messager.alert('提示','不能编辑，请确保上一条数据填写完整','warning');
	}
	
    
};

function  getByteLen(str){   
    var l=str.length;   
    var n = l;   
    for ( var i=0;i <l;i++){  
        if( str.charCodeAt(i) <0 ||str.charCodeAt(i)> 255){  
            n++;   
        }   
    }   
    return n;   
}  

function dgRoleOnAfterEdit(rowIndex, rowData, changes)
{
	//成功完成编辑，包括校验
	editIndex=-1;
	
};

function dgRoleOnLoadSuccess(data)
{
	if(editIndex != -1){
		$('#dgRole').datagrid('cancelEdit',editIndex);
		editIndex = -1;
	}
};

/**
 * 
**/
function initComboData(){
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_VALID_FLAG.json',
		type :'get',
		dataType :'json',
		success : function(r){
			r&&(validRole =r);
		}
	});
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_USAGE_MODIFIER.json',
		type :'get',
		dataType :'json',
		success : function(r){
			r&&(unableModifyComboData =r);
		}
	});
};
function formatRole(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = validRole.length; i<length;i++){
				
		if(validRole[i].lookupCode == value){
						
			return validRole[i].lookupName;
		}
	}
};
function formatcombobox(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = validComboData.length; i<length;i++){
				
		if(validComboData[i].lookupCode == value){
						
			return validComboData[i].lookupName;
		}
	}
};

function formatcombobox4(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = unableModifyComboData.length; i<length;i++){
		if(unableModifyComboData[i].lookupCode == value){
			return unableModifyComboData[i].lookupName;
		}
	}
};


/*增加一条记录*/

function showAddRole()
{
	newRowCount++;
	
	var myDatagrid=$('#dgRole');
	myDatagrid.datagrid('endEdit',editIndex);
	if(editIndex != -1){
		$.messager.alert('提示','不能添加，请确保上一条数据填写完整','warning');
		return;
	}
	myDatagrid.datagrid('insertRow',{
		index: 0,
		row:{id:"", roleType:"1", sysApplicationId: appid,
			validFlag: '1', orderBy: '0',usageModifier:'0'}
		});	
	myDatagrid.datagrid('selectRow', 0).datagrid('beginEdit',0);
	editIndex=0;
			
	// 有效无效的下拉框
	var ed = myDatagrid.datagrid('getEditor',{index:editIndex,field: 'validFlag'});
	$(ed.target).combobox('loadData', validRole);
	
	
	var ed = myDatagrid.datagrid('getEditor',{index:editIndex,field: 'usageModifier'});
	$(ed.target).combobox('loadData', unableModifyComboData);
	
	// 清空用户
	loadUserInfo(null);
	
};

function getLength(str) { 
	///获得字符串实际长度，中文2，英文1 
	///要获得长度的字符串 
	var realLength = 0, len = str.length, charCode = -1; 
	for (var i = 0; i < len; i++) { 
	charCode = str.charCodeAt(i); 
	if (charCode >= 0 && charCode <= 128) 
	realLength += 1; 
	else realLength += 2; 
	} 
	return realLength; 
	};

function saveRole()
{
	var myDatagrid=$('#dgRole');
	myDatagrid.datagrid('endEdit',editIndex);
	
	if(editIndex!=-1)
	{
		$.messager.alert('提示','不能保存，请确保上一条数据填写完整','warning');
		return;
	}
	
	var rows = myDatagrid.datagrid('getChanges');
	
	var orderBycheck = false;
	for(var i=0;i<rows.length;i++) {
		if (rows[i].orderBy < 0) {
			orderBycheck = true;
		}
		
	}
	
	if (orderBycheck) {
		 $.messager.show({
			 title : '提示',
			 msg : '排序字段不能小于0'
		 });
		return;
	}
	
	
	if(rows.length > 0)
	{
		var reg =/\s/;
		for (var i=0;i<rows.length;i++){
			if(reg.test(rows[i].roleName)){
				$.messager.alert('提示',"角色名称含有空格字符，请检查！",'warning');
				return;
			}
			if(reg.test(rows[i].roleCode)){
				$.messager.alert('提示',"角色编码含有空格字符，请检查！",'warning');
				return;
			}
			if (getLength(rows[i].roleName)>50){
				$.messager.alert('提示',"角色名称过长，请检查！",'warning');
				return;
			}
			if (getLength(rows[i].roleCode)>50){
				$.messager.alert('提示',"角色编码过长，请检查！",'warning');
				return;
			}
			
			if (getLength(rows[i].desc)>240){
				$.messager.alert('提示',"描述过长，请检查！",'warning');
				return;
			}
			//更改appid
			if (appid == "-11"){
				rows[i].sysApplicationId = curAppId;
			}else{
				rows[i].sysApplicationId = appid;
			}
		}
		var data =JSON.stringify(rows);
		 $.ajax({
			 url:'platform/cc/sysrole/saveSysRole.json',
			 data : {datas : data},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				if(r.result==0){
					 loadRoleInfo(appid);
					 $.messager.show({
						 title : '提示',
						 msg : '保存成功'
					 });
				 }else{
					 $.messager.alert('提示',r.msg,'warning');
				 } 
			 }
		 });
	 } 
};

/*删除选中数据*/
function deleteRole(){
  
	var myDatagrid=$('#dgRole');
	
	var rows = myDatagrid.datagrid('getChecked');
	var data =JSON.stringify(rows);
	
	if (rows.length > 0) {
		$.messager.confirm('请确认', '您确定要删除当前所选的数据？', function(b) {
			if (b) {
				$.ajax({
					url : 'platform/cc/sysrole/deleteSysRole.json',
					data : {
						datas : data
					},
					type : 'post',
					dataType : 'json',
					success : function(r) {
						
						if(r.result==0){
							loadRoleInfo(appid);
							loadUserInfo(null);
							editIndex = -1;
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
						else
						{
							$.messager.alert('提示',r.msg,'warning');
						}
					}
				}); 
			}
		});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
};

function showSearchRole(){
	$('#searchRoleDialog').dialog('open');
};

function hideSearchRole(){
	$('#searchRoleDialog').dialog('close');
};

function searchRole(){
	
	var roleName= $('#filter_LIKE_roleName').val();
	var roleCode= $('#filter_LIKE_roleCode').val();
	
	expSearchParams={filter_LIKE_roleName: roleName, filter_LIKE_roleCode: roleCode};
	
	loadSearchRoleInfo(appid, roleName, roleCode);
};

function clearRole(){
	$('#filter_LIKE_roleName').val('');
	$('#filter_LIKE_roleCode').val('');
};
function loadUserInfo(roleId){
	if(!roleId){
		
		$('#dgUser').datagrid("loadData", []);
		$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	}
	else
	{
		$("#dgUser").datagrid("options").url ="platform/cc/sysrole/getUerListByRoleId.json";
		$('#dgUser').datagrid("reload", {filter_EQ_ur_sysRoleId: roleId});
		$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
	}
}
function showAddUser(){
	var row=$('#dgRole').datagrid('getSelected');
	if(!row){
		$.messager.alert('提示','请选择一个角色','warning');
		return;
	}
	if(!row.id){
		$.messager.alert('提示','请保存当前角色','warning');
		return;
	}
	if(row.length>1){
		$.messager.alert('提示','只能选择一个角色','warning');
		return;
	}
	var comSelector = new CommonSelector("user","userSelectCommonDialog","deptId","deptName",null,null,null,false,null,null,600,400);
	comSelector.init(false,'selectUserDialogCallBack','1'); //选择人员  回填部门 */
	
};

function selectUserDialogCallBack(data){
	var row=$('#dgRole').datagrid('getChecked');
	var roleId=row[0].id;
	var ids = [];
	var l =data.length;
	var applicationId;
	if (appid == "-11"){
		applicationId = curAppId;
	}else{
		applicationId = appid;
	}
	if (l>0){
	for(;l--;){
		 ids.push(data[l].userId);
	 }
	$.ajax({
        type: "POST",
        url:'platform/cc/sysrole/saveUserRole.json',
        dataType:"json",
        data: {roleIds: roleId, ids: ids.join(','),appId:applicationId},
        error: function(request) {
        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
        },
        success: function(data) {
			if(data.result==0){
				
				loadUserInfo(roleId);
				
				$.messager.show({
					title : '提示',
					msg : '添加成功,已存在用户不会被重新添加！'
				});
			}else{
				$.messager.alert('提示',data.msg,'warning');
			}
        }
    }); 
	}
};
	
function deleteUser(){
	
	/* if(editIndex==-1)
	{
		$.messager.alert('提示','请选择一个角色','warning');
		return;
	} */
	
	//var row=$('#dgRole').datagrid('getRows')[editIndex];
	var row=$('#dgRole').datagrid('getChecked');
	if(row.length >1){
		$.messager.alert('提示','请选择一个角色','warning');
		return;
	}
	var roleId=row[0].id;
	var applicationId;
	if (appid == "-11"){
		applicationId = curAppId;
	}else{
		applicationId = appid;
	}
		
	var rows = $('#dgUser').datagrid('getChecked');
	var data =JSON.stringify(rows);
	
	if (rows.length > 0) {
		$.messager.confirm('请确认', '您确定要删除当前所选的数据？', function(b) {
			if (b) {
								
				$.ajax({
					url : 'platform/cc/sysrole/deleteUserRole.json',
					data : {
						datas : data, roleId: roleId,appId:applicationId
					},
					type : 'post',
					dataType : 'json',
					success : function(r) {
						
						if(r.result==0){
							
							loadUserInfo(roleId);
							
							$.messager.show({
								title : '提示',
								msg : '删除成功！(只有一个角色的用户不能删除)'
							});
						}
						else
						{
							$.messager.alert('提示',r.msg,'warning');
						}
					}
				}); 
			}
		});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
};

function showSearchUser(){
	var row=$('#dgRole').datagrid('getChecked');
	if (row.length==0){
		$.messager.alert('提示','请选择一个角色','warning');
		return;
	}else if(row.length>1){
		$.messager.alert('提示','只能选择一个角色','warning');
		return;
	}
	var roleId=row[0].id;
	if(!roleId){
		$.messager.alert('提示','请保存当前角色','warning');
		return;
	}
	
	$('#filter_EQ_u_status').combobox('loadData', [{lookupCode: '', lookupName:'请选择'}].concat(validComboData));
	$('#searchUserDialog').dialog("open");
};


function hideSearchUser(){
	$('#searchUserDialog').dialog('close');
};

function searchUser(){
	var row=$('#dgRole').datagrid('getChecked');
	var roleId = row[0].id;
	var name= $('#filter_LIKE_u_name').val();
	var loginName= $('#filter_LIKE_u_loginName').val();
	var status= $('#filter_EQ_u_status').combobox('getValue');
	
	loadSearchUserInfo(roleId, name, loginName,status);
};

function clearUser(){
	$('#filter_LIKE_u_name').val('');
	$('#filter_LIKE_u_loginName').val('');
	$('#filter_EQ_u_status').combobox('select', '');
};

function loadSearchUserInfo(roleId, name, loginName,status){
	$("#dgUser").datagrid("options").url ="platform/cc/sysrole/getUerListByRoleId.json";
	$('#dgUser').datagrid("reload", {filter_EQ_ur_sysRoleId: roleId,filter_EQ_u_status: status, filter_LIKE_u_name: name, filter_LIKE_u_loginName: loginName});
	$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
	
};

var expSearchParams={};
 
function importRole()
{
	var applicationId;
	if (appid == "-11"){
		applicationId = curAppId;
	}else{
		applicationId = appid;
	}
	var imp = new CommonDialog("importData","700","400",'platform/excelImportController/excelimport/importRole/xls?extPara='+JSON.stringify({appid:applicationId}),"Excel数据导入",false,true,false);
	imp.show();
}


function closeImportData(){
	$("#importData").dialog('close');
}

/**
 * 导出岗位(客户端数据)
 */
function exportClientData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('dgRole');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            var rows = $('#dgRole').datagrid('getRows');
            var datas = JSON.stringify(rows);
            var myParams = {
                dataGridFields: dataGridFields,//表头信息集合
                datas: datas,//数据集
                hasRowNum : true,//默认为Y:代表第一列为序号
                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
                unContainFields : 'id,sysApplicationId',
                fileName: '平台角色导出数据'//导出的Excel文件名
            };
            var url = "platform/cc/sysrole/exportClient";
            var ep = new exportData("xlsExport","xlsExport",myParams,url);
            ep.excuteExport();
        }
       });
}
/**
 * 导出岗位(服务端数据)
 */
function exportServerData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('dgRole');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            expSearchParams = expSearchParams?expSearchParams:{};
     
            expSearchParams.dataGridFields=dataGridFields;
            expSearchParams.hasRowNum=true;
            expSearchParams.sheetName='sheet1';
            expSearchParams.fileName='平台角色导出数据';
            expSearchParams.unContainFields='id,sysApplicationId';
            
            expSearchParams.filter_EQ_sysApplicationId=appid;
            var roleName= $('#filter_LIKE_roleName').val();
        	var roleCode= $('#filter_LIKE_roleCode').val();
        	
        	expSearchParams.filter_LIKE_roleName=roleName;
        	expSearchParams.filter_LIKE_roleCode=roleCode;
        	
            var url = "platform/cc/sysrole/exportServer";

            var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
            ep.excuteExport();
        }
       });
}

</script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="width:200px;height:0; overflow:hidden;">
	 <div id="toolbarTree" class="datagrid-toolbar">
	 	<table width="100%">
	 		<tr>
	 			<td width="100%"><input type="text"  name="searchApp" id="searchApp"></input></td>
	 		</tr>
	 	</table>
 	 </div>
	 <ul id="apps">正在加载应用列表...</ul>
 </div>   
  <div data-options="region:'center',split:true" style="padding:0px;height:0; overflow:hidden;">   
 	<div class="easyui-layout" data-options="fit:true"> 
		<div data-options="region:'north',split:true,title:''" style="height: 300px; padding:0px;">
			<div id="toolbarRole" class="datagrid-toolbar">
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysrole_toolbar_showAddRole" permissionDes="添加角色">
					<a id="btAddRole"  class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAddRole();" href="javascript:void(0);">添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysrole_toolbar_saveRole" permissionDes="保存角色">
					<a id="btSaveRole"  class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveRole();" href="javascript:void(0);">保存</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysrole_toolbar_importRole" permissionDes="导入角色">
				<td>
					<a id="btImportRole" class="easyui-linkbutton" iconCls="icon-import"  plain="true" onclick="importRole();" href="javascript:void(0);">导入角色</a>
				</td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysrole_toolbar_exportRole" permissionDes="导出角色">
					<a class="easyui-menubutton"  data-options="menu:'#export',iconCls:'icon-export'" href="javascript:void(0);">导出角色</a>
					<div id="export" style="width:150px;">
						<div data-options="iconCls:'icon-excel'" onclick="exportClientData();">Excel导出(客户端)</div>
						<div data-options="iconCls:'icon-excel'" onclick="exportServerData();">Excel导出(服务器端)</div>
					</div>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysrole_toolbar_deleteRole" permissionDes="删除角色">	
					<a id="btDeleteRole" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="deleteRole();" href="javascript:void(0);">删除</a>
				</sec:accesscontrollist>
				<a id="btSearchRole" class="easyui-linkbutton" iconCls="icon-search"  plain="true" onclick="showSearchRole();" href="javascript:void(0);">查询</a>
			</div>
			<table id="dgRole" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#toolbarRole',
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					pagination:true,
					pageSize:10,
					pageList:dataOptions.pageList,
					striped:true,
					onClickRow: dgRoleOnClickRow,
					onAfterEdit: dgRoleOnAfterEdit,
					onLoadSuccess: dgRoleOnLoadSuccess
					">
				<thead>
					<tr>
						<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
						<th data-options="field:'roleName', halign:'center',align:'left'" editor="{type:'validatebox',options:{required:true, validType: 'length[0,50]'}}" width="220"><font color="red">*</font>角色名称</th>
						<th data-options="field:'roleCode', halign:'center',align:'left'" editor="{type:'validatebox',options:{required:true, validType: 'length[0,50]'}}" width="220"><font color="red">*</font>角色编码</th>
						<th data-options="field:'usageModifier', halign:'center',align:'left', formatter: formatcombobox4" editor="{type:'combobox',options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}" width="220">应用范围</th>
						<th data-options="field:'desc',halign:'center',align:'left'" editor="{type:'validatebox',options:{validType: 'length[0,240]'}}"  width="220">描述</th>
						<th data-options="field:'orderBy',halign:'center',align:'left'" editor="{type:'numberbox',options:{required:true, validType: 'length[0,10]'}}"  width="220"><font color="red">*</font>排序编号</th>
						<th data-options="field:'validFlag',halign:'center',align:'left', formatter: formatRole" editor="{type:'combobox',options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}"  width="220">状态</th>
					</tr>
				</thead>
			</table>		
		</div>	
		<div data-options="region:'center',split:true,title:''" style="padding:0px;">	
			<div id="toolbarUser" class="datagrid-toolbar">
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysrole_toolbar_showAddUser" permissionDes="添加用户">
					<a id="btAddUser"  class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAddUser();" href="javascript:void(0);">添加用户</a>
				</sec:accesscontrollist>	
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysrole_toolbar_deleteUser" permissionDes="删除用户">
					<a id="btDeleteUser" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="deleteUser();" href="javascript:void(0);">删除用户</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysrole_toolbar_showSearchUser" permissionDes="查询用户">
					<a id="btSearchUser" class="easyui-linkbutton" iconCls="icon-search"  plain="true" onclick="showSearchUser();" href="javascript:void(0);">查询用户</a>
				</sec:accesscontrollist>
			</div>
					
			<table id="dgUser" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#toolbarUser',
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					pagination:true,
					pageSize:dataOptions.pageSize,
					pageList:dataOptions.pageList,
					striped:true
					">
				<thead>
					<tr>
						<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
						<th data-options="field:'no',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">用户编号</th>
						<th data-options="field:'name',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">用户名</th>
						<th data-options="field:'loginName',halign:'center',align:'left'" editor="{type:'text'}"  width="220">登录名</th>
						<th data-options="field:'deptCode',halign:'center',align:'left'" editor="{type:'text'}"  width="220">部门编号</th>
						<th data-options="field:'deptName',halign:'center',align:'left'" editor="{type:'text'}"  width="220">所属部门</th>
						<th data-options="field:'status',halign:'center',align:'left', formatter: formatcombobox" editor="{type:'combobox',options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}"  width="220">状态</th>
						<th data-options="field:'remark',halign:'center',align:'left'" editor="{type:'text'}"  width="220">描述</th>
						
					</tr>
				</thead>
			</table>	
		</div>
		</div>
		</div>
		<input id="deptId" style="display:none"></input>
							<input id="deptName" style="display:none"></input>
		<div id="searchUserDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchUserBtns'" 
			style="width: 500px;display: none;">
			<form id="searchUserForm">
	    		<table>
	    			<tr style="height:5px;">
	    			</tr>
	    			<tr>
	    				<td>用户名:</td><td><input type='text' class="easyui-validatebox" name="filter_LIKE_name" id="filter_LIKE_u_name"/></td>
	    				<td>登录名:</td><td><input type='text' class="easyui-validatebox" name="filter_LIKE_loginName" id="filter_LIKE_u_loginName"/></td>
	    				
	    			</tr>
	    			<tr style="height:5px;">
	    			</tr>
	    			<tr>
	    				<td>状态:</td><td><input id="filter_EQ_u_status" class="easyui-combobox" name="filter_EQ_u_status"  
    						 data-options="panelHeight:'auto', editable:false,valueField:'lookupCode',textField:'lookupName'" /> </td>
	    				
	    			</tr>
	    		</table>
	    	</form>
	    	<div id="searchUserBtns">
	    		<a class="easyui-linkbutton" plain="false" onclick="searchUser();" href="javascript:void(0);">查询</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="clearUser();" href="javascript:void(0);">清空</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="hideSearchUser();" href="javascript:void(0);">返回</a>
	    	</div>
	    </div>
	    <div id="searchRoleDialog"  data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" 
			style="width: 600px;height:150px;display: none;">
			<form id="searchGroupForm">
	    		<table>
	    			<tr>
	    				<td>角色名称:</td><td><input type='text' class="easyui-validatebox" name="filter_LIKE_roleName" id="filter_LIKE_roleName"/></td>
	    				<td>角色编码:</td><td><input type='text' class="easyui-validatebox" name="filter_LIKE_roleCode" id="filter_LIKE_roleCode"/></td>
	    			</tr>
	    		</table>
	    	</form>
	    	<div id="searchBtns">
	    		<a class="easyui-linkbutton" onclick="searchRole();" href="javascript:void(0);">查询</a>
	    		<a class="easyui-linkbutton" onclick="clearRole();" href="javascript:void(0);">清空</a>
	    		<a class="easyui-linkbutton" onclick="hideSearchRole();" href="javascript:void(0);">返回</a>
	    	</div>
	    </div>
</body>
</html>