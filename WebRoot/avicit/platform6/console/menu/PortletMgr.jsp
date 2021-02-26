<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<a id="menuPortal_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
		
		<a id="menuportletModify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="icon icon-edit"></i> 编辑</a>
		
		<a id="menuPortal_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
	</div>
	<div class="toolbar-right">
		<div class="input-group form-tool-search">
			<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="输入名称或编码查询">
			<label id="searchPart" class="icon icon-search form-tool-searchicon"></label>
		</div>
		<div class="input-group-btn form-tool-searchbtn">
			<a id="searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
		</div>
	</div>
</div>
<table id="jqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id='form' style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="12%">小页名称:</th>
				<td width="38%">
					<input class="form-control" type="text" name="menuName" id="menuName" />
				</td>
				<th width="12%">小页编码:</th>
				<td>
					<input class="form-control" type="text" name="menuCode" id="menuCode" />
				</td>
			</tr>
			<tr>
				<th width="12%">小页地址:</th>
				<td width="38%">
					<input class="form-control" type="text" name="menuUrl" id="menuUrl" />
				</td>
				<th width="12%">跳转地址:</th>
				<td>
					<input class="form-control" type="text" name="moreUrl" id="moreUrl" />
				</td>
			</tr>
			<tr>
				<th>小页状态:</th>
				<td>
					<select class="form-control" name="menuStatus">
						<option value="">全部</option>
						<option value="1">启用</option>
						<option value="0">禁用</option>
						
					</select>
				</td>
				<th>小页描述:</th>
				<td>
					<input class="form-control" type="text" name="menuDes" id="menuDes" />
				</td>
			</tr>
			
		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/platform6/console/menu/js/Portlet.js" ></script> 
<script type="text/javascript">
var menuPortal;
var fmtStatus =function(cellvalue){
	return menuPortal.MenuStatus[cellvalue];
};
function fmtMenuIcon(cellvalue, options, rowObject) {
	return '<i class="'+cellvalue+'" ></i>';
}
$(function(){
	var searchNames =[];
	searchNames.push("menuName");//用户可自定义查询条件，修改参数。
	searchNames.push("menuCode");
	
	var dataGridColModel =  [
      { label: 'id', name: 'id', key: true,  hidden:true },
      { label: '小页名称', name: 'menuName', width: 100 ,align:'center'},
      { label: '小页编码', name: 'menuCode', width: 100,align:'center' },
      { label: '小页地址', name: 'menuUrl', width: 250,align:'left'},
      { label: '小页状态', name: 'menuStatus', width: 50,align:'center',formatter:fmtStatus},
      { label: '跳转地址', name: 'moreUrl', width: 200,align:'left' },
      /*{ label: '小页图标', name: 'menuIcon', width: 50,align:'center',formatter:fmtMenuIcon },*/
      { label: '序号', name: 'menuOrder', width: 40,sortable:false,align:'center'}
	];
	menuPortal = new MenuPortlet('jqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#menuPortal_insert').bind('click', function(){
		menuPortal.insert();
	});
	//编辑按钮绑定事件
	$('#menuportletModify').bind('click', function(){
		menuPortal.modify();
	});
	//删除按钮绑定事件
	$('#menuPortal_del').bind('click', function(){  
		menuPortal.del();
	});
	//查询按钮绑定事件
	$('#searchPart').bind('click', function(){
		menuPortal.searchByKeyWord();
	});
	//打开高级查询框
	$('#searchAll').bind('click',function(){
		menuPortal.openSearchForm(this);
	});

});

</script>
</html>