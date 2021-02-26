<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
	<head>
		<title>编辑页面示例</title>
		<base href="<%=ViewUtil.getRequestPath(request)%>">
		<link href="static/css/platform/themes/default/index/style/platform_blue.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.js"></script>
	</head>
	<%
		//此处生成业务对象ID
		//String id = ComUtil.getId();
		String id = "8a58ab2a485e5c9d01485e5f29fd0002";
	%>
	<script>
	/**
	   附件选择后处理 
	 files：所选的文件集合
	**/
	function afterFilesAdd(files){
	}
	
	/**
	   上传完成后处理 
	 files：上传成功文件集合 
	 errors：上传失败文件集合
	**/
	function afterUploadComplete(files,errors){
		window.location.reload();
	} 
	</script>
	<body scroll="no">
		<form action="" >
			<!-- 在业务表单中把ID做为隐藏域传到后台，后台不能再重新生成ID,否则业务数据和附件对不上号 -->
			<input type="hidden" name="id" value="<%= id %>" />
		</form>
		<!-- 
			参数说明:
			file_size_limit:附件大小限制，可以带单位，合法的单位有:B、KB、MB、GB，如果省略单位，则默认为KB。该属性为0时，表示不限制文件的大小。
			file_types:允许上传的文件类型，当有多个类型时使用逗号隔开，比如：jpg,png ,允许所有类型时请使用 all,使用默认值时请使用default
			file_upload_limit:上传附件的数量限制，0表示不限制。
			save_type: disk表示保存到硬盘,fastdfs表示由FastDFS进行处理
			form_id:业务表ID,新增页面需要通过ConUtil.getId()先生成好ID！
			form_code:业务表的表名
			allowDel:是否有删除已存附件权限，false-无  true-有
			file_category(可选):附件分类通用代码，大小写敏感,可以为空。一般不需要
			secret_level（可选）:附件密级通用代码，大小写敏感,可以为空。此字段会和用户密级进行比较，只能上传或查看低于用户密级的附件。
			chunk:文件分块大小。是否启用续传功能。如果文件小于此值则不开启续传
		-->
		<jsp:include page="/avicit/platform6/modules/system/plupload/uploader.jsp">
			<jsp:param name="file_size_limit" value="5000MB" />
			<jsp:param name="file_types" value="all" />
			<jsp:param name="save_type" value="disk" /> 
			<jsp:param name="form_id" value="<%= id %>" />
			<jsp:param name="form_code" value="pm_project" />
			<jsp:param name="allowDel" value="true" />
			<jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL" />
			<jsp:param name="chunk" value="5mb" />
		</jsp:include>
	</body>
</html>