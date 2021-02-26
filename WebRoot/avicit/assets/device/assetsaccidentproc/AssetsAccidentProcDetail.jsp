<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>

<%
    String importlibs = "common,form,table,fileupload,tree";
    String formId = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsaccidentproc/assetsAccidentProcController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>

	<%
		String userId = SessionHelper.getLoginSysUserId(request);
		SysUser user = SessionHelper.getLoginSysUser(request);
		String userName = user.getName();
		String userDeptId = SessionHelper.getCurrentDeptId(request);
		String userDeptName = SessionHelper.getCurrentDeptName(request);
	%>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

	<!-- 框架 样式 -->
	<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/style.css">
</head>

<body>
	<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp"%>

	<div id="formTab" style="display: none">
		<!-- 业务表单 Start -->
		<form id='form'>
			<input type="hidden" name="id" id="id"/>
			<input type="hidden" name="version" id="version"/>

			<table class="form_commonTable">
				<tr>
					<th width="10%">
						<label for="accidentNo">事故单编号:</label></th>
					<td width="15%">
						<input class="form-control input-sm" placeholder="系统自动生成" type="text" name="accidentNo" id="accidentNo" readonly/>
					</td>

					<th width="10%">
						<label for="createdByAlias">申请人:</label></th>
					<td width="15%">
						<input type="hidden" id="createdBy" name="createdBy" value="<%=userId%>" readonly>
						<input class="form-control" placeholder="请选择用户" type="text" id="createdByAlias" name="createdByAlias"  value="<%=userName%>" readonly>
					</td>

					<th width="10%">
						<label for="createdByDeptAlias">申请人部门:</label></th>
					<td width="15%">
						<input type="hidden" id="createdByDept" name="createdByDept" value="<%=userDeptId%>">
						<input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" value="<%=userDeptName%>">
					</td>

					<th width="10%">
						<label for="createdByTel">申请人电话:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel" value="<%=user.getMobile()%>"/>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="unifiedId">统一编号:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" readonly onclick="relateAssets()"/>
					</td>

					<th width="10%">
						<label for="deviceName">设备名称:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="deviceName" id="deviceName" readonly onclick="relateAssets()"/>
					</td>

					<th width="10%">
						<label for="deviceModel">设备型号:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel" readonly/>
					</td>

					<th width="10%">
						<label for="deviceSpec">设备规格:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec" readonly/>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="assetsOperatorAlias">设备操作者:</label></th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="assetsOperator" name="assetsOperator">
							<input class="form-control" placeholder="请选择用户" type="text" id="assetsOperatorAlias" name="assetsOperatorAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>

					<th width="10%">
						<label for="operatorDeptAlias">操作者单位:</label></th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="operatorDept" name="operatorDept" readonly>
							<input class="form-control" placeholder="请选择部门" type="text" id="operatorDeptAlias" name="operatorDeptAlias" readonly>
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-equalizer"></i>
							</span>
						</div>
					</td>

					<th width="10%">
						<label for="occurTime">事故发生时间:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="occurTime" id="occurTime"/>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>

					<th width="10%">
						<label for="reportLeaderTime">报告单位领导时间:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="reportLeaderTime" id="reportLeaderTime"/>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="reportTime">报告时间:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="reportTime" id="reportTime"/>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>

					<th width="10%">
						<label for="repairTime">修复时间:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="repairTime" id="repairTime"/>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>

					<th width="10%">
						<label for="stopWorkDays">停工天数:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input class="form-control" type="text" name="stopWorkDays" id="stopWorkDays" data-min="1" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>

					<th width="10%">
						<label for="directEconomicLoss">直接经济损失:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input class="form-control" type="text" name="directEconomicLoss" id="directEconomicLoss" data-min="0"
								   data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="accidentProperty">事故性质:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="accidentProperty"
							   id="accidentProperty"/>
					</td>

					<th width="10%">
						<label for="assetsManAlias">设备员:</label></th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="assetsMan" name="assetsMan">
							<input class="form-control" placeholder="请选择用户" type="text" id="assetsManAlias" name="assetsManAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="accidentProcess">事故发生经过:</label></th>
					<td width="90%" colspan="7">
						<textarea class="form-control input-sm" rows="3" name="accidentProcess" id="accidentProcess"></textarea>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="accidentConsequence">事故后果:</label></th>
					<td width="90%" colspan="7">
						<textarea class="form-control input-sm" rows="3" name="accidentConsequence" id="accidentConsequence"></textarea>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="reasonAnalysis">事故原因分析:</label></th>
					<td width="90%" colspan="7">
						<textarea class="form-control input-sm" rows="3" name="reasonAnalysis" id="reasonAnalysis"></textarea>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="preventionMeasures">防止事故措施:</label></th>
					<td width="90%" colspan="7">
						<textarea class="form-control input-sm" rows="3" name="preventionMeasures" id="preventionMeasures"></textarea>
					</td>
				</tr>

				<tr>
					<th><label for="attachment">附件</label></th>
					<td colspan="<%=4 * 2 - 1%>">
						<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
					</td>
				</tr>
			</table>
		</form>
		<!-- 业务表单 End -->
	</div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<!-- 框架脚本 -->
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/jquery.dragsort-0.5.2.min.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/nav.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/main.js"></script>

	<!-- 流程的js -->
	<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/CommonActor.js"></script>
	<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/BpmActor.js"></script>
	<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/FlowEditor.js"></script>

	<!-- 业务的js -->
	<script type="text/javascript" src="avicit/assets/device/assetsaccidentproc/js/AssetsAccidentProcDetail.js"></script>
	<script type="text/javascript" src="static/js/platform/eform/common.js"></script>
	<script type="text/javascript" src="avicit/assets/device/assetsaccidentproc/js/SelfStyleLayout.js"></script>


	<!-- 自动编码的js -->
	<script src="avicit/platform6/autocode/js/AutoCode.js"></script>

	<script type="text/javascript">
		//注册附件上传完毕后执行的方法
		var afterUploadEvent = null;

		function relateAssets(){
			var param =  '';
			openProductModelLayer ("true", "", "callBackFn", param);
		}

		$(document).ready(function () {
			//自动生成设备事故编号
			var autoCode = new AutoCode("ASSETS_ACCIDENT_PROC", "accidentNo", false, "autoCodeValue", "123");

			//创建业务操作JS
			var assetsAccidentProcDetail = new AssetsAccidentProcDetail('form');

			//创建流程操作JS
			new FlowEditor(assetsAccidentProcDetail);

			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine: true,//单行显示时分秒
				closeText: '确定',//关闭按钮文案
				showButtonPanel: true,//是否展示功能按钮面板
				showSecond: false,//是否可以选择秒，默认否
				beforeShow: function (selectedDate) {
					if ($('#' + selectedDate.id).val() == "") {
						$(this).datetimepicker("setDate", new Date());
						$('#' + selectedDate.id).val('');
					}
				},
			});

			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId: '<%=formId%>',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function () {
					return afterUploadEvent();
				}
			});

			//绑定表单验证规则
			assetsAccidentProcDetail.formValidate($('#form'));

			$('#createdByDeptAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
				this.blur();
				nullInput(e);
			});

			$('#assetsOperatorAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'userSelect', idFiled: 'assetsOperator', textFiled: 'assetsOperatorAlias'});
				this.blur();
				nullInput(e);
			});

			$('#operatorDeptAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'deptSelect', idFiled: 'operatorDept', textFiled: 'operatorDeptAlias'});
				this.blur();
				nullInput(e);
			});

			$('#assetsManAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'userSelect', idFiled: 'assetsMan', textFiled: 'assetsManAlias'});
				this.blur();
				nullInput(e);
			});

			//弹框选择操作者后，自动补充操作者部门信息
			$('#assetsOperatorAlias').on('blur', function (e) {
				var userId = document.getElementById('assetsOperator').value;

				if((userId != null) && (userId != undefined) && (userId != '')){
					$.ajax({
						url: "assets/device/assetstechtransformperson/assetsTechTransformPersonController/operation/userInfo",
						data: userId,
						contentType: 'application/json',
						type: 'post',
						dataType: 'json',
						success: function (r) {
							console.log(r);
							if (r.flag == "success") {
								if((r.userDto.deptName != null) && (r.userDto.deptName != undefined)){
									$("#operatorDeptAlias").val(r.userDto.deptName);   //设置b部门名称
									$("#operatorDept").val(r.userDto.deptId);   //设置部门id
								}
							} else {
								layer.alert('用户信息获取失败,请联系管理员!', {
											icon: 7,
											area: ['400px', ''], //宽高
											closeBtn: 0,
											btn: ['关闭'],
											title: "提示"
										}
								);
							}
						}
					});
				}
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
		});
	</script>
</body>
</html>