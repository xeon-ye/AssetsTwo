<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<% 
String importlibs = "common,tree,table,form";	
String _treeNodeId = "\'"+request.getParameter("_treeNodeId")+"\'";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基于用户的流程效率分析</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>
<style type="text/css">
div#customText {
    font-size:  14px;
    padding-left: 14px;
    padding-top: 6px;
}
</style>
</head>
<body>
	<div>
        <img style="height: 287px;width:  900px;" src="avicit/platform6/flowMonitoring/bpaDataAnalyze/photo/userProcessEfficiency.jpg"  alt="基于用户的流程效率分析" />
    </div>
	<div id="customText" class="text" style="visibility: visible;">
	 	<p>
			<span>维度X：用户</span>
		</p>
		<p>
			<span>维度Y：完成用时(h)</span>
		</p>
		<p>
			<span>维度Z：(1)最大用时  (2)最小用时  (3)平均用时</span>
	    </p>
	    <p>
			<span>描   述  ：流程处理时间=流程结束时间-流程启动时间</span>
	    </p>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">

</script>
</html>