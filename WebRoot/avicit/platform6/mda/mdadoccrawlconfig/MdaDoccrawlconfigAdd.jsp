<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdadoccrawlconfig/mdaDoccrawlconfigController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<table class="form_commonTable">
				<tr>
																																		 									 									 									 									 									 									 									 																	 													<th width="10%">
						    						  	<label for="crawlitemsid">CRAWLITEMSID:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="crawlitemsid"  id="crawlitemsid" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="taskname">TASKNAME:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="taskname"  id="taskname" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="modifytime">MODIFYTIME:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="modifytime" id="modifytime" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="lasttimecrawl">LASTTIMECRAWL:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="lasttimecrawl" id="lasttimecrawl" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="updatemode">UPDATEMODE:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="updatemode"  id="updatemode" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="docaddr">DOCADDR:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="docaddr"  id="docaddr" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="docport">DOCPORT:</label></th>
						    							<td width="39%">
														  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
								  <input  class="form-control"  type="text" name="docport" id="docport"  data-min="0" data-max="999999999999" data-step="1" data-precision="0">
								  <span class="input-group-addon">
								    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
								  </span>
								</div>	
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="loginuser">LOGINUSER:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="loginuser"  id="loginuser" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="loginpassword">LOGINPASSWORD:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="loginpassword"  id="loginpassword" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="fstype">FSTYPE:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="fstype"  id="fstype" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="crawlrate">CRAWLRATE:</label></th>
						    							<td width="39%">
														  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
								  <input  class="form-control"  type="text" name="crawlrate" id="crawlrate"  data-min="0" data-max="999999999999" data-step="1" data-precision="0">
								  <span class="input-group-addon">
								    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
								  </span>
								</div>	
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="crawldepth">CRAWLDEPTH:</label></th>
						    							<td width="39%">
														  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
								  <input  class="form-control"  type="text" name="crawldepth" id="crawldepth"  data-min="0" data-max="999999999999" data-step="1" data-precision="0">
								  <span class="input-group-addon">
								    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
								  </span>
								</div>	
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="filebegnumberime">FILEBEGNUMBERIME:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="filebegnumberime" id="filebegnumberime" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="fileendtime">FILEENDTIME:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="fileendtime" id="fileendtime" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="copyfile">COPYFILE:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="copyfile"  id="copyfile" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="crawlfiletype">CRAWLFILETYPE:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="crawlfiletype"  id="crawlfiletype" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="parsecolumns">PARSECOLUMNS:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="parsecolumns"  id="parsecolumns" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="indexcolumns">INDEXCOLUMNS:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="indexcolumns"  id="indexcolumns" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="storemethod">STOREMETHOD:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="storemethod"  id="storemethod" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="serverip">SERVERIP:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="serverip"  id="serverip" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="serverport">SERVERPORT:</label></th>
						    							<td width="39%">
														  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
								  <input  class="form-control"  type="text" name="serverport" id="serverport"  data-min="0" data-max="999999999999" data-step="1" data-precision="0">
								  <span class="input-group-addon">
								    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
								  </span>
								</div>	
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="username">USERNAME:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="username"  id="username" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="password">PASSWORD:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="password"  id="password" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="databasename">DATABASENAME:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="databasename"  id="databasename" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="tablename">TABLENAME:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="tablename"  id="tablename" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="docname">DOCNAME:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="docname"  id="docname" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="collections">COLLECTIONS:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="collections"  id="collections" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="status">STATUS:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="status"  id="status" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="keywords">关键字:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="keywords"  id="keywords" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="filterwords">过滤关键字:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="filterwords"  id="filterwords" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="itemid">ITEMID:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="itemid"  id="itemid" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="fsIp">文件系统服务器IP:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="fsIp"  id="fsIp" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="midSaveDir">中间文件保存路径:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="midSaveDir"  id="midSaveDir" />
													   </td>
																														   									 						</tr>
					</table>
			</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="mdaDoccrawlconfig_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="mdaDoccrawlconfig_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.mdaDoccrawlconfig.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.mdaDoccrawlconfig.save($('#form'),"insert");
		}
	
		$(document).ready(function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
				beforeShow: function(selectedDate) {
					if($('#'+selectedDate.id).val()==""){
						$(this).datetimepicker("setDate", new Date());
						$('#'+selectedDate.id).val('');
					}
				}
			});
			
			parent.mdaDoccrawlconfig.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mdaDoccrawlconfig_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mdaDoccrawlconfig_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																								
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>