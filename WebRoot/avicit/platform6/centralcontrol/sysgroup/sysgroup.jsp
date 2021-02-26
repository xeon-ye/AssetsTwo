<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="avicit.platform6.core.spring.SpringFactory"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String appId = SessionHelper.getApplicationId(); //改造后直接显示当前应用下分组
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>群组管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">

<script type="text/javascript">

var editIndex = -1;
var comboData={};
var appid="<%=appId%>"; 
var groupTypeComboData ={};
var validComboData=[{lookupCode:"3",lookupName:'无效'},{lookupCode:"1",lookupName:'正常'}];
function formatUser(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = validComboData.length; i<length;i++){
				
		if(validComboData[i].lookupCode == value){
						
			return validComboData[i].lookupName;
		}
	}
}
$(document).ready(function(){ 
	initComboData();
	
	$('#searchGroupDialog').dialog('close');
	$('#searchUserDialog').dialog('close');
	
	loadUserInfo(null);
	
	$('#searchUserDialog').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchUser();
		}
	});
	
	$('#searchGroupDialog').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchGroup();
		}
	});
});

/**
 * 加载群组信息
 */
function loadGroupInfo(appId){
	
	$("#dgGroup").datagrid("options").url ="platform/cc/sysgroup/getSysGroupListByPage.json";
	$('#dgGroup').datagrid("reload", {id: appId});
	$("#dgGroup").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');		
}

function loadSearchGroupInfo(appId, searchName, validFlag)
{
	$("#dgGroup").datagrid("options").url ="platform/cc/sysgroup/getSysGroupListByPage.json";
	$('#dgGroup').datagrid("reload", {id: appId, searchName: searchName, validFlag: validFlag});
	$("#dgGroup").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
}


function dgGroupOnClickRow(index,rowData)
{
	$('#dgGroup').datagrid('endEdit', editIndex);
	if(editIndex==-1)
	{
		$('#dgGroup').datagrid('beginEdit', index);  
		editIndex=index;
		
		// 有效无效的下拉框
		var ed = $('#dgGroup').datagrid('getEditor',{index:editIndex,field: 'validFlag'});
		$(ed.target).combobox('loadData', comboData);
		
				
		// 获取群组中的用户列表
	    loadUserInfo(rowData.id);
	}
	else
	{
		$.messager.alert('提示','不能编辑，请确保上一条数据填写完整','warning');
	}
	
    
}

function dgGroupOnAfterEdit(rowIndex, rowData, changes)
{
	//成功完成编辑，包括校验
	editIndex=-1;
} 

function dgGroupOnLoadSuccess(data)
{
	if(editIndex != -1){
		$('#dgGroup').datagrid('cancelEdit',editIndex);
		editIndex = -1;
	}
}


/**
 * 
**/
function initComboData(){
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_VALID_FLAG.json',
		type :'get',
		dataType :'json',
		success : function(r){
			r&&(comboData=r);
		}
	});
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_GROUP_TYPE.json',
		type :'get',
		dataType :'json',
		success : function(r){
			r&&(groupTypeComboData=r);
		}
	});
};

function formatcombobox(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = comboData.length; i<length;i++){
		if(comboData[i].lookupCode == value){
			return comboData[i].lookupName;
		}
	}
};

function formatGroupTypeCombobox(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = groupTypeComboData.length; i<length;i++){
		if(groupTypeComboData[i].lookupCode == value){
			return groupTypeComboData[i].lookupName;
		}
	}
}

/*增加一条记录*/

function showAddGroup()
{
	
	
	var myDatagrid=$('#dgGroup');
	myDatagrid.datagrid('endEdit',editIndex);
	if(editIndex != -1){
		$.messager.alert('提示','不能添加，请确保上一条数据填写完整','warning');
		return;
	}
	myDatagrid.datagrid('insertRow',{
		index: 0,
		row:{id:"", type:"1",belongTo :'系统',applicationId: appid, orderBy: '0', validFlag: '1'}
		});	
	myDatagrid.datagrid('selectRow', 0).datagrid('beginEdit',0);
	editIndex=0;
			
	// 有效无效的下拉框
	var ed = myDatagrid.datagrid('getEditor',{index: 0, field: 'validFlag'});
	$(ed.target).combobox('loadData', comboData);
	
	// 禁止编辑类型和应用名称
	//var ed =myDatagrid.datagrid('getEditor', { index: 0, field: "type" });
	//$(ed.target).combobox('loadData', groupTypeComboData);
	
	//$(ed.target).attr("disabled", true);
	
	//var ed2 =myDatagrid.datagrid('getEditor', { index: 0, field: "applicationName" });
	//$(ed2.target).attr("disabled", true);
	loadUserInfo(null);
};


function saveGroup()
{
	var myDatagrid=$('#dgGroup');
	myDatagrid.datagrid('endEdit',editIndex);
	
	if(editIndex!=-1)
	{
		$.messager.alert('提示','不能保存，请确保上一条数据填写完整','warning');
		return;
	}
	
	var rows = myDatagrid.datagrid('getChanges');
	var data =JSON.stringify(rows);
	if(rows.length > 0)
	{
		 $.ajax({
			 url:'platform/cc/sysgroup/saveOrUpdateSysGroups.json',
			 data : {datas : data},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				if(r.result==0){
					 myDatagrid.datagrid('reload',{id: appid});
					 myDatagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
					 $.messager.show({
						 title : '提示',
						 msg : '保存成功'
					 });
				 }else{
					 $.messager.show({
						 title : '提示',
						 msg : r.error
					});
				 } 
			 }
		 });
	 } 
};

/*删除选中数据*/
function deleteGroup(){
  
	var myDatagrid=$('#dgGroup');
	
	var rows = myDatagrid.datagrid('getChecked');
	var ids = [];
	var l =rows.length;
	if (rows.length > 0) {
		$.messager.confirm('请确认', '您确定要删除当前所选的数据？', function(b) {
			if (b) {
				for(;l--;){
					 ids.push(rows[l].id);
				 }
				
				$.ajax({
					url : 'platform/cc/sysgroup/deleteSysGroups.json',
					data:	JSON.stringify(ids),
					contentType : 'application/json',
					type : 'post',
					dataType : 'json',
					success : function(r) {
						
						if(r.result==0){
							myDatagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
							loadGroupInfo(appid);
							loadUserInfo(null);
							editIndex = -1;
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
						else
						{
							$.messager.alert('提示','删除失败','warning');
						}
					}
				}); 
			}
		});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
};

function showSearchGroup()
{
	$('#searchGroupDialog').dialog('open');
		
	$('#filter_EQ_g_valid_flag').combobox('loadData', [{lookupCode: '', lookupName:'所有'}].concat(comboData));
};

function hideSearchGroup()
{
	$('#searchGroupDialog').dialog('close');
};

function searchGroup()
{
	
	var searchName= $('#filter_LIKE_t_group_name').val();
	var validFlag= $('#filter_EQ_g_valid_flag').combobox('getValue');
	
	//alert(searchName+","+validFlag);
	
	loadSearchGroupInfo(appid, searchName, validFlag);
	loadUserInfo(null);
};

function clearGroup()
{
	$('#filter_LIKE_t_group_name').val('');
	$('#filter_EQ_g_valid_flag').combobox('select', '');
};

function loadUserInfo(groupId)
{
	//filter_EQ_ug_groupId
	
	if(groupId==null || groupId=="")
	{
		$('#dgUser').datagrid("loadData", []);
		$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	}
	else
	{
		$("#dgUser").datagrid("options").url ="platform/cc/sysgroup/getUerListByConditionAndPage.json";
		$('#dgUser').datagrid("reload", {filter_EQ_ug_groupId: groupId});
		$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
	}
};


function showAddUser(){
	var row=$('#dgGroup').datagrid('getChecked');
	if (row.length==0){
		$.messager.alert('提示','请选择一个群组','warning');
		return;
	}else if(row.length>1){
		$.messager.alert('提示','只能选择一个群组','warning');
		return;
	}
	var comSelector = new CommonSelector("user","userSelectCommonDialog","deptId","deptName",null,null,null,false,null,null,600,400);
	comSelector.init(false,'selectUserDialogCallBack',1); //选择人员  回填部门 */
	
};

function selectUserDialogCallBack(data){
	var row=$('#dgGroup').datagrid('getChecked');
	var groupId=row[0].id;
	var ids = [];
	var l =data.length;
	if (l>0){
		for(;l--;){
			 ids.push(data[l].userId);
		 }
	$.ajax({
        cache:false,
        type: "POST",
        url:'platform/cc/sysgroup/saveUserGroupByIDs.json',
        dataType:"json",
        data: {groupId: groupId, ids: ids.join(',')},
        error: function(request) {
        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
        },
        success: function(data) {
			if(data.result==0){
				
				loadUserInfo(groupId);
				
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


function deleteUser()
{
	
	if(editIndex==-1)
	{
		$.messager.alert('提示','请选择一个群组','warning');
		return;
	}
	
	var row=$('#dgGroup').datagrid('getRows')[editIndex];
	var groupId=row.id;
	
		
	var rows = $('#dgUser').datagrid('getChecked');
	var data =JSON.stringify(rows);
	
	if (rows.length > 0) {
		$.messager.confirm('请确认', '您确定要删除当前所选的数据？', function(b) {
			if (b) {
								
				$.ajax({
					url : 'platform/cc/sysgroup/deleteUserGroup.json',
					data : {
						datas : data, groupId: groupId
					},
					type : 'post',
					dataType : 'json',
					success : function(r) {
						
						if(r.result==0){
							
							loadUserInfo(groupId);
							
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
						else
						{
							$.messager.alert('提示','删除失败','warning');
						}
					}
				}); 
			}
		});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
}

function showSearchUser()
{
	var row=$('#dgGroup').datagrid('getSelected');
	if(!row){
		$.messager.alert('提示','请选择一个群组','warning');
		return;
	}
	if(!row.id){
		$.messager.alert('提示','请保存当前群组','warning');
		return;
	}
	if(row.length>1){
		$.messager.alert('提示','只能选择一个群组','warning');
		return;
	}
	$('#filter_EQ_u_status').combobox('loadData', [{lookupCode: '', lookupName:'所有'}].concat(validComboData));
	$('#searchUserDialog').dialog("open");
}


function hideSearchUser()
{
	$('#searchUserDialog').dialog('close');
}

function searchUser()
{
	if(editIndex==-1)
	{
		$.messager.alert('提示','请选择一个群组','warning');
		return;
	}
	
	var row=$('#dgGroup').datagrid('getRows')[editIndex];
	var groupId=row.id;
	
	
	var name= $('#filter_LIKE_u_name').val();
	var loginName= $('#filter_LIKE_u_loginName').val();
	var status= $('#filter_EQ_u_status').combobox('getValue');
	
	
	loadSearchUserInfo(groupId, name, loginName,status);
}

function clearUser()
{
	$('#filter_LIKE_u_name').val('');
	$('#filter_LIKE_u_loginName').val('');
	$('#filter_EQ_u_status').combobox('select', '');
}

function loadSearchUserInfo(groupId, name, loginName,status)
{
	$("#dgUser").datagrid("options").url ="platform/cc/sysgroup/getUerListByConditionAndPage.json";
	$('#dgUser').datagrid("reload", {filter_EQ_ug_groupId: groupId, filter_LIKE_u_name: name,filter_EQ_u_status: status,filter_LIKE_u_loginName: loginName});
	$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
	
}


</script>
</head>

<body class="easyui-layout" fit="true">
	
		<div data-options="region:'north',split:true,title:''" style="height: 300px; padding:0px;">
		
			<div id="toolbarGroup" class="datagrid-toolbar">
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btAddGroup" >
					<a id="btAddGroup"  class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAddGroup();" href="javascript:void(0);">添加</a>
				</sec:accesscontrollist>
				
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btSaveGroup" >
					<a id="btSaveGroup"  class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveGroup();" href="javascript:void(0);">保存</a>
				</sec:accesscontrollist>
				
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btDeleteGroup" >
					<a id="btDeleteGroup" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="deleteGroup();" href="javascript:void(0);">删除</a>
				</sec:accesscontrollist>
				
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btSearchGroup" >
					<a id="btSearchGroup" class="easyui-linkbutton" iconCls="icon-search"  plain="true" onclick="showSearchGroup();" href="javascript:void(0);">查询</a>
				</sec:accesscontrollist>
			</div>
			
			<table id="dgGroup" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#toolbarGroup',
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					url: 'platform/cc/sysgroup/getSysGroupListByPage.json',
					queryParams:{id: '<%=appId%>'},
					pagination:true,
					pageSize:10,
					pageList:dataOptions.pageList,
					
					striped:true,
					
					onClickRow: dgGroupOnClickRow,
					onAfterEdit: dgGroupOnAfterEdit,
					onLoadSuccess: dgGroupOnLoadSuccess
					">
				<thead>
					<tr>
						<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
						<th data-options="field:'groupName', halign:'center',align:'left'" editor="{type:'validatebox',options:{required:true, validType: 'length[0,100]'}}" width="220"><font color="red">*</font>群组名称</th>
						<th data-options="field:'type',halign:'center',align:'center', formatter:formatGroupTypeCombobox" width="220">群组类型</th>
						<th data-options="field:'belongTo',required:true,halign:'center',align:'center'"  width="220">群组归属</th>
						<th data-options="field:'applicationName',hidden:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">应用名称</th>
						<th data-options="field:'groupDesc',halign:'center',align:'left'" editor="{type:'validatebox',options:{validType: 'length[0,100]'}}"  width="220">群组描述</th>
						<th data-options="field:'orderBy',halign:'center',align:'left'" editor="{type:'numberbox',options:{required:true,min:0, validType: 'length[0,10]'}}"  width="220"><font color="red">*</font>排序编号</th>
						<th data-options="field:'validFlag',halign:'center',align:'left', formatter:formatcombobox" editor="{type:'combobox',options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}"  width="220">状态</th>
					</tr>
				</thead>
			</table>		
				
		</div>	
		
		<div id="searchGroupDialog" class="easyui-dialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" 
			style="width: 600px;visible: hidden" title="查询群组">
			<form id="searchGroupForm">
	    		<table>
	    			<tr>
	    				<td>群组名称:</td><td><input type='text' class='easyui-validatebox' name="filter_LIKE_t_group_name" id="filter_LIKE_t_group_name"/></td>
	    				<td>是否有效:</td><td><input id="filter_EQ_g_valid_flag" class="easyui-combobox" name="filter_EQ_g_valid_flag"  
    						 data-options="panelHeight:'auto', editable:false,valueField:'lookupCode',textField:'lookupName', data: [{lookupCode:'1', lookupName: 'aaa'}]" /> </td>
	    			</tr>
	    			
	    		</table>
	    	</form>
	    	<div id="searchBtns">
	    		<a class="easyui-linkbutton" plain="false" onclick="searchGroup();" href="javascript:void(0);">查询</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="clearGroup();" href="javascript:void(0);">清空</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="hideSearchGroup();" href="javascript:void(0);">返回</a>
	    	</div>
	    </div>
		<div data-options="region:'center',split:true,title:''" style="padding:0px;">	
			<div id="toolbarUser" class="datagrid-toolbar">
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btAddUser" >
					<a id="btAddUser"  class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAddUser();" href="javascript:void(0);">添加用户</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btDeleteUser" >
					<a id="btDeleteUser" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="deleteUser();" href="javascript:void(0);">删除用户</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btSearchUser" >
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
						
						<th data-options="field:'name',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">用户名</th>
						<th data-options="field:'nameEn',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">英文名</th>
						<th data-options="field:'no',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">用户编号</th>
						<th data-options="field:'loginName',halign:'center',align:'left'" editor="{type:'text'}"  width="220">登录名</th>
						<th data-options="field:'status',halign:'center',align:'left', formatter: formatUser" editor="{type:'combobox',options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}"  width="220">状态</th>
						<th data-options="field:'remark',halign:'center',align:'left'" editor="{type:'text'}"  width="220">描述</th>
						
					</tr>
				</thead>
			</table>	
		</div>
		<input id="deptId" style="display:none"></input>
		<input id="deptName" style="display:none"></input>
		<div id="searchUserDialog" class="easyui-dialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchUserBtns'" 
			style="width: 500px; visible: hidden" title="查询用户">
			<form id="searchUserForm">
	    		<table>
	    			<tr style="height:5px;">
	    			</tr>
	    			<tr>
	    				<td>用户名:</td><td><input type='text' class='easyui-validatebox' name="filter_LIKE_name" id="filter_LIKE_u_name"/></td>
	    				<td>登录名:</td><td><input type='text' class='easyui-validatebox' name="filter_LIKE_loginName" id="filter_LIKE_u_loginName"/></td>
	    				
	    			</tr>
	    			<tr style="height:5px;">
	    			</tr>
	    			<tr>
	    				<td>状态:</td><td><input id="filter_EQ_u_status" class="easyui-combobox" name="filter_EQ_u_status"  
    						 data-options="panelHeight:'auto', editable:false,valueField:'lookupCode',textField:'lookupName', data: [{lookupCode:'1', lookupName: 'aaa'}]" /> </td>
	    				
	    			</tr>
	    			
	    		</table>
	    	</form>
	    	<div id="searchUserBtns">
	    		<a class="easyui-linkbutton" plain="false" onclick="searchUser();" href="javascript:void(0);">查询</a>
	    		<a class="easyui-linkbutton"  plain="false" onclick="clearUser();" href="javascript:void(0);">清空</a>
	    		<a class="easyui-linkbutton"  plain="false" onclick="hideSearchUser();" href="javascript:void(0);">返回</a>
	    	</div>
	    </div>

</body>
</html>