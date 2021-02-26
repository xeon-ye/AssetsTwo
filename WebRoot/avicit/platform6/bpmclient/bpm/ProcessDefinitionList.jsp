<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
	String formCode = request.getParameter("formCode");
	String custom = request.getParameter("custom");

%>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
</head>

<script type="text/javascript">
var baseurl = '<%=request.getContextPath()%>';
var formCode = '<%=formCode%>';
var custom = '<%=custom%>';

function doProcessDef(){
	var processList = parent.__processList;
	//var showList = new Array();
	//if(processList!=null&&processList.length > 0){
	//	for(var i = 0 ; i < processList.length; i++){
	//		var record = {
	//				dbid : processList[i].dbid,
	//				deploymentId : processList[i].deploymentId,
	//				name : processList[i].name,
	//	    		version : processList[i].version,
	//	    		op : '查看流程'
	//		};
	//		showList[i] = record;
	//	}
	//}

	$('#Process_Definition_data').datagrid({
		width: '100%',
		height: '300',
	    nowrap: false,
	    striped: true,
	    autoRowHeight:false,
	    idField:'deploymentId',
	    singleSelect:true,//是否单选 
	    frozenColumns:[[
			{field:'deploymentId',checkbox:true}
		]],
	    rownumbers:true,//行号
	    loadMsg:' 处理中，请稍候…',
	    fitColumns: true,
	    columns:[[
	  		{field:'name',title:'流程名称',width:25,align:'left'},
  			{field:'version',title:'版本',width:10,align:'center'},
  			{field:'type',title:'类型',width:20,align:'center',
  				formatter:function(value,rec){
  					if(value == "temporary"){
  						return "自定义";
  					}else{
  						return "常规流程";
  					}
				}
  			},
  			{field:'op',title:'查看流程',width:10,align:'center',
  				formatter:function(value,rec){
  					return '&nbsp;<img src="static/images/platform/bpm/client/images/trackTask.gif" style="cursor:pointer" title="流程跟踪" onclick=\"javascript:window.ProcessPic(\''+rec.deploymentId+'\')\"/>';
				}
			}
	  	]]
	});
	if(custom == "1"){
		$('#Process_Definition_data').datagrid("showColumn","type");
	}else{
		$('#Process_Definition_data').datagrid("hideColumn","type");
	}
	$('#Process_Definition_data').datagrid('loadData',processList);
}

function ProcessPic(processdefId){
	var html= "<img id='img' src='"+getPath2()+"/platform/bpm/clientbpmdisplayaction/getfiguretrack.gif?processInstanceId="+processdefId+"'/>";
	this.img = new parent.UserSelectDialog("imgdialog","800","400",html ,"流程跟踪");
	this.img.show();
}

</script>
<body onload="doProcessDef();">
<table id="Process_Definition_data"></table>
</body>
</html>
