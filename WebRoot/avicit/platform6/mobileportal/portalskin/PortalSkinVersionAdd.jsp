<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<html>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<head>
<!-- ControllerPath = "ims/portal/stat/portalskin/portalSkinController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value='${versionId}'> <input
				type="hidden" name="skinId" id="skinId" /> <input
				class="form-control input-sm" type="hidden"
				name="skinVersionEntrance" id="skinVersionEntrance" /> <input
				class="form-control input-sm" type="hidden"
				name="skinVersionModuleName" id="skinVersionModuleName" /> <input
				class="form-control input-sm" type="hidden"
				name="skinVersionDependance" id="skinVersionDependance" /> <input
				class="form-control input-sm" type="hidden" name="skinVersionUrl"
				id="skinVersionUrl" /> <input class="form-control input-sm"
				type="hidden" name="skinVersionIsNew" id="skinVersionIsNew"
				value="0" />
			<table class="form_commonTable">
				<tr>
					<th width="12%"><label for="skinVersionName">皮肤版本名:</label></th>
					<td width="37%"><input class="form-control input-sm"
						type="text" name="skinVersionName" id="skinVersionName" /></td>
					<th width="12%"><label for="skinVersionOpenMode">打开方式:</label></th>
					<td width="37%"><input readonly="readonly" name="skinVersionOpenMode"
							id="skinVersionOpenMode" value = "1"  type="hidden"/>
							<input readonly="readonly"  class="form-control input-sm"  value = "state"  type="text"/>
							<%--  <pt6:h5select
							css_class="form-control input-sm" name="skinVersionOpenMode"
							id="skinVersionOpenMode" title="" isNull="false"
							lookupCode="PLATFORM_PROGRAM_VERSION_OPENMODE" /> --%></td>
				</tr>
				<tr>
					<th width="12%"><label for="skinVersionState">版本状态:</label></th>
					<td width="37%"><input title="应用程序状态" checked type="radio"
						name="skinVersionState" id="skinState" value="0" />&ensp;启用&nbsp; <input
						title="应用程序状态" type="radio"
						name="skinVersionState" id="skinState" value="1" />&ensp;禁用</td>
				</tr>
				<tr>
					<th width="12%"><label for="skinVersionDesc">皮肤描述:</label></th>
					<td width="37%" colspan="3"><textarea rows="7"
							class="form-control input-sm" type="text" name="skinVersionDesc"
							id="skinVersionDesc"></textarea></td>
				</tr>
				<tr>
					<th width="12%"><label for="attachment">附件</label></th>
					<td colspan="<%=2 * 2 - 1%>">
						<div id="attachment"></div>
					</td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<form id="stateForm" enctype="multipart/form-data" method="post">
			<table class="form_commonTable">
				<tr>
					<th class="text-right" width="12%"><span id="stateRemind"
						class="remind">*</span>STATE配置文件:</th>
					<td width="37%">
						<div class="input-group  input-group-sm">
							<input name="skinVersionManifest" id="skinVersionManifest"
								type="file" title="STATE配置文件" style="display: none"
								data-options="validType:'maxLength[200]',required:true"
								accept=".json"> <input id="fileSelect"
								class="form-control input-sm" type="text"
								onclick="$('input[id=skinVersionManifest]').click();">
							<span class="input-group-addon"
								onclick="$('input[id=skinVersionManifest]').click();"> <i
								class="glyphicon glyphicon-folder-open"></i>
							</span>
						</div>
					</td>
					<th width="12%"></th>
					<td width="37%"></td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="保存" id="portalSkinVersion_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="portalSkinVersion_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript"
		src="static/h5/jquery-form/jquery.form.js"></script>
	<script type="text/javascript">
		$('input[id=skinVersionManifest]').change(
				function() {
					$('#fileSelect').val(
							$(this).val().substring(
									$(this).val().lastIndexOf("\\") + 1)); //截取字符串获得文件名
				});
		var id = '${versionId}';
		var openMode = "0";

		$(function() {
			$("#skinVersionOpenMode").change(function(e) {
				var ev = e || window.event;
				var target = ev.target || ev.srcElement;
				openMode = target.value;
				if (target.value == "1") {
					$('#stateRemind').show();
				} else {
					$('#stateRemind').hide();
				}
			});
		});
		// 关闭Dialog
		function closeForm() {
			parent.portalSkinVersion.closeDialog("insert");
		}

		//上传zip包
		function uploadForm() {
			//state文件验证
			if (document.getElementById("skinVersionManifest").value == '') {
				layer.alert('请上传state配置文件！', {
					icon : 7,
					title : "警告",
					area : [ '400px', '' ]
				});
				return;
			}
			//福建非空验证
			if (document.getElementById("attachment").children[1].firstChild.children.length == 0) {
				layer.alert('请上传附件！', {
					icon : 7,
					title : "警告",
					area : [ '400px', '' ]
				});
				return;
			}
			//验证附件密级
			var files = $('#attachment').uploaderExt('getUploadFiles');
			for (var i = 0; i < files.length; i++) {
				var name = files[i].name;
				var secretLevel = files[i].secretLevel;
				//这里验证密级
			}
			callback(form.id.value);
		}

		// 保存表单
		/* function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}

			//验证附件密级
			var files = $('#attachment').uploaderExt('getUploadFiles');
			for (var i = 0; i < files.length; i++) {
				var name = files[i].name;
				var secretLevel = files[i].secretLevel;
				//这里验证密级
			}

			$("#skinId").val(parent.portalSkinVersion.pid);
			//限制保存按钮多次点击
			$('#portalSkinVersion_saveForm').addClass('disabled');
			parent.portalSkinVersion.save($('#form'), callback);
		} */

		//上传附件
		function callback(id) {
			$("#id").val(id);
			$('#attachment').uploaderExt('doUpload', id);
		}
		//附件上传完后执行
		function afterUploadEvent() {
			saveForm();
		}

		// 加载完后初始化
		$(document).ready(function() {
			//初始化日期控件
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
				beforeShow : function(selectedDate) {
					if ($('#' + selectedDate.id).val() == "") {
						$(this).datetimepicker("setDate", new Date());
						$('#' + selectedDate.id).val('');
					}
				}
			});
			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);

			//初始化附件上传组件
			$('#attachment').uploaderExt({
				saveType : 'MobileDisk',
				secretLevel : 'PLATFORM_FILE_SECRET_LEVEL',
				fileSizeLimit : '5000MB',
                tableName : 'portal_skin_version',
				fileNumLimit : 1,
				afterUpload : afterUploadEvent,
				accept : {
					title : 'Zip',
					extensions : 'Zip',
					mimeTypes : 'zip/*'
				}
			});

			//绑定表单验证规则
			parent.portalSkinVersion.formValidate($('#form'));
			//保存按钮绑定事件
			$('#portalSkinVersion_saveForm').bind('click', function() {
				uploadForm();
			});
			//返回按钮绑定事件
			$('#portalSkinVersion_closeForm').bind('click', function() {
				closeForm();
			});

		});

		function upLoadStateFile() {
			if (document.getElementById("programSkinManifest").value != '') {
				if (checkfiletype('loadFile', [ ".zip", ".rar" ])) {
					alert("zip,rar");
				}
			}
		}
		//检查上传类型
		function checkfiletype(id, extArray) {
			var fileName = document.getElementById(id).value;
			//设置文件类型数组
			//var extArray = [ ".zip" ];
			//获取文件名称
			while (fileName.indexOf("//") != -1)
				fileName = fileName.slice(fileName.indexOf("//") + 1);
			//获取文件扩展名
			var ext = fileName.slice(fileName.lastIndexOf(".")).toLowerCase();
			//遍历文件类型
			var count = extArray.length;
			for (; count--;) {
				if (extArray[count] == ext) {
					return true;
				}
			}
			layer.alert('只能上传下列类型的文件: ' + extArray.join(" "), {
				icon : 2,
				title : "错误",
				area : [ '400px', '' ]
			});
			return false;
		}

		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			var id = '${versionId}';
			var file = null;
			var unzipPath = null;
			var stateFile = document.getElementById("skinVersionManifest").value;
			if (document.getElementById("skinVersionManifest").value == '') {
				layer.alert('请上传state配置文件！', {
					icon : 7,
					title : "警告",
					area : [ '400px', '' ]
				});
				return;
			}
			if (document.getElementById("skinVersionManifest").value != '') {
				var extArray = [ ".json" ];
				if (!checkfiletype('skinVersionManifest', extArray)) {
					return;
				}
			}
			$("#skinId").val(parent.portalSkinVersion.pid);
			//不对state配置文件进行非空校验
			$('#stateForm')
					.ajaxSubmit(
							{
								url : "platform/avicit/platform6/mobileportal/portalskin/controller/NewPortalSkinController/operation/dealUpLoadFile/"
										+ id,
								success : function(data) {
									var json = eval("(" + data + ")"); // data的值是json字符串，这行把字符串转成object
									if (json.flag == "success") {
										file = json.file;
										unzipPath = json.unzipPath;
										parent.portalSkinVersion.save(
												serializeObject($('#form')),
												"insert", id, file, unzipPath);
									} else if (json.flag == "failure") {
										layer.alert(json.message, {
											icon : 7,
											title : "警告",
											area : [ '400px', '' ]
										});
										return;
									}
								}
							});
		}
	</script>
</body>
</html>