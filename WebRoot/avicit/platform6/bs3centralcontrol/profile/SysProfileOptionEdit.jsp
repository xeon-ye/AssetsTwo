<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "ys/sysprofileoption/sysProfileOptionController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style>
.form-fieldset{
	margin:5px 40px 5px 40px;
}
.form-legend {
	font-size:14px!important;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<fieldset class="form-fieldset">
			<legend class="form-legend">基本信息</legend>
			<input type="hidden" name="version" value='<c:out  value='${sysProfileOptionDTO.version}'/>' />
			<input type="hidden" name="id" value='<c:out  value='${sysProfileOptionDTO.id}'/>' />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="profileOptionCode">配置文件代码:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="profileOptionCode" id="profileOptionCode" value='<c:out  value='${sysProfileOptionDTO.profileOptionCode}'/>'/>
					</td>
					<th width="10%"><label for="sysApplicationId">应用ID:</label></th>
					<td width="39%">
						<select name="sysApplicationId" class="form-control input-sm" disabled="true">
							<c:forEach items="${appsList}" var="appsList">
								<option value="${appsList.id}" <c:if test="${appsList.id eq sysProfileOptionDTO.sysApplicationId}">SELECTED</c:if>>${appsList.applicationName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="profileOptionName">配置文件名称:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="profileOptionName" id="profileOptionName" value='<c:out  value='${sysProfileOptionDTO.profileOptionName}'/>'/>
					</td>
					<th width="10%"><label for="ynMultiValue">是否可分配:</label></th>
					<td width="39%">
						<select name="ynMultiValue" class="form-control input-sm">
							<c:forEach items="${mulValue}" var="mulValue">
								<option value="${mulValue.lookupCode}" <c:if test="${mulValue.lookupCode eq sysProfileOptionDTO.ynMultiValue}">SELECTED</c:if>>${mulValue.lookupName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="validFlag">有效标识:</label></th>
					<td width="39%">
						<pt6:h5radio css_class="radio-inline" name="validFlag" title="有效标识" canUse="0" defaultValue='${sysProfileOptionDTO.validFlag}' lookupCode="PLATFORM_VALID_FLAG" />
					</td>
					<th width="10%"><label for="usageModifier">使用级别:</label></th>
					<td width="39%">
						<pt6:h5select css_class="form-control input-sm" name="usageModifier" id="usageModifier" title="使用级别" defaultValue='${sysProfileOptionDTO.usageModifier}' isNull="true" lookupCode="PLATFORM_USAGE_MODIFIER" />
					</td>
				</tr>
			</table>
			</fieldset>
			<fieldset class="form-fieldset">
			<legend class="form-legend">层次结构类型的访问控制</legend>
			<table class="form_commonTable">
				<tr>
					<th width="7%"><label for="siteEnabledFlag">地点</label></th>
					<td width="3%">
						<input class="form-control input-sm" type="checkbox" value="Y"  <c:if test="${sysProfileOptionDTO.siteEnabledFlag eq 'Y' }"> checked="checked"</c:if>  name="siteEnabledFlag" id="siteEnabledFlag" avicrequired="avicrequired"/>
					</td>
					<th width="7%"><label for="appEnabledFlag">应用程序</label></th>
					<td width="3%">
						<input class="form-control input-sm" type="checkbox" value="Y"  <c:if test="${sysProfileOptionDTO.appEnabledFlag eq 'Y' }"> checked="checked"</c:if>  name="appEnabledFlag" id="appEnabledFlag" avicrequired="avicrequired"/>
					</td>
					<th width="7%"><label for="roleEnabledFlag">角色</label></th>
					<td width="3%">
						<input class="form-control input-sm" type="checkbox" value="Y"  <c:if test="${sysProfileOptionDTO.roleEnabledFlag eq 'Y' }"> checked="checked"</c:if>  name="roleEnabledFlag" id="roleEnabledFlag" avicrequired="avicrequired"/>
					</td>
					<th width="7%"><label for="userEnabledFlag">用户层</label></th>
					<td width="3%">
						<input class="form-control input-sm" type="checkbox" value="Y"  <c:if test="${sysProfileOptionDTO.userEnabledFlag eq 'Y' }"> checked="checked"</c:if>  name="userEnabledFlag" id="userEnabledFlag" avicrequired="avicrequired"/>
					</td>
					<th width="7%"><label for="deptEnabledFlag">部门 </label></th>
					<td width="3%">
						<input class="form-control input-sm" type="checkbox" value="Y"  <c:if test="${sysProfileOptionDTO.deptEnabledFlag eq 'Y' }"> checked="checked"</c:if>  name="deptEnabledFlag" id="deptEnabledFlag" avicrequired="avicrequired"/>
					</td>
					<td width="50%"> </td>
				</tr>
				</table>
				</fieldset>
			<fieldset class="form-fieldset">
			<legend class="form-legend">用于配置文件选项的值列表SQL验证</legend>
			<table class="form_commonTable">
				<tr>
					<td width="90%">
						<textarea class="form-control input-sm" type="text" name="sqlValidation" id="sqlValidation"><c:out  value='${sysProfileOptionDTO.sqlValidation}'/></textarea></td>
				</tr>
				<tr>
				</tr>
			</table>
			</fieldset>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;float:right;display:block;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
						title="保存" id="sysProfileOption_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="sysProfileOption_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.sysProfileOption.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.sysProfileOption.save($('#form'),"eidt");
		}
	
		document.ready = function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.sysProfileOption.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysProfileOption_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#sysProfileOption_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																																																																																																																																																																																																																		
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		};
	</script>
</body>
</html>