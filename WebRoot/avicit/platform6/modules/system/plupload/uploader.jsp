<%@page import="avicit.platform6.core.rest.client.RestClientConfig"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.modules.system.plupload.service.PlUploadService"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.core.spring.SpringFactory"%>
<%@ page import="avicit.platform6.commons.utils.ComUtil"%>
<%@ page import="java.util.*"%>

<%
	String file_size_limit = ComUtil.replaceNull2Space(request.getParameter("file_size_limit"));
	String file_types = ComUtil.replaceNull2Space(request.getParameter("file_types"));
	String save_type = ComUtil.replaceNull2Space(request.getParameter("save_type"));
	String form_id = ComUtil.replaceNull2Space(request.getParameter("form_id"));
	String form_code = ComUtil.replaceNull2Space(request.getParameter("form_code"));
	String allowAdd = ComUtil.replaceNull2Space(request.getParameter("allowAdd"));
	String allowDel = ComUtil.replaceNull2Space(request.getParameter("allowDel"));
	String file_category = ComUtil.replaceNull2Space(request.getParameter("file_category"));
	String secret_level = ComUtil.replaceNull2Space(request.getParameter("secret_level"));
	String chunk = ComUtil.replaceNull2Space(request.getParameter("chunk"));
	String appId = RestClientConfig.systemid;
	String lang = SessionHelper.getCurrentUserLanguageCode(request);
	PlUploadService plUploadService = (PlUploadService) SpringFactory.getBean(PlUploadService.class);
	
	Map<String,String> para = new HashMap<String,String>();
	para.put("formId", form_id);
	para.put("allowDel", allowDel);
	para.put("secretLevel", secret_level);
	para.put("fileCategory", file_category);
	para.put("appId",appId);
	para.put("language",lang);
	
	Map<String,String> result = plUploadService.getAttachHtml(para,SessionHelper.getLoginSysUser(request));
	String attachHtml = result.get("html");
	String fileCategory = result.get("fileCategory");
	String fileSecret = result.get("fileSecret");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>文件上传</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <link href="avicit/platform6/modules/system/swfupload/swf/css/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="avicit/platform6/modules/system/plupload/js/jquery.plupload.queue/css/jquery.plupload.queue.css" type="text/css"></link>
    <script type="text/javascript" src="avicit/platform6/modules/system/attachment/jquerymutilupload/jquery.MultiFile.Add.js"></script>
	<script type="text/javascript" src="avicit/platform6/modules/system/plupload/js/plupload.full.min.js"></script>
	<script type="text/javascript" src="avicit/platform6/modules/system/plupload/js/moxie.js"></script>
    <script type="text/javascript" src="avicit/platform6/modules/system/plupload/js/i18n/zh_CN.js"></script>
    <script type="text/javascript" src="avicit/platform6/modules/system/plupload/js/jquery.plupload.queue/jquery.plupload.queue.js"></script>
    <script type="text/javascript" src="avicit/platform6/modules/system/plupload/js/plupload.dev.js"></script>
    <script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>
    
  <body style="padding: 0;margin: 0;"> 
    <table id="container" width="95%" cellspacing="1" cellpadding="1" border="0" align="center">
		<tr>
			<td>
				<div>
					<table cellpadding="1" cellspacing="1">
						<tr style="font-size: 12px; font-weight: normal; color: aaaaaa;">
							<td rowspan="2">
								<button id="pickfiles" type="button" class="btn-upload">选择文件
								<div style="display:none" id="sss"></div></button>
							</td>
							<td rowspan="2">
								<input id="btnUpload" type="button" value="上传" class="btn-upload">
							</td>
							<!-- 
							<td rowspan="2">
								<button onclick="stop()" class="btn-upload">暂停上传</button>
							</td>
							 -->
						</tr>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<TABLE id="attachView" width="100%" border="0" cellpadding="1" cellspacing="1">
					<tr style="background:url('static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/gray/images/title.jpg')" height="25px;">
							<td align="center">
								<font size="-1">附件名称</font>
							</td>
							<% if(file_category!=null && !file_category.equals("")) {%>
							<td align="center">
								<font size="-1">附件类型</font>
							</td>
							<%} %>
							<% if(secret_level!=null && !secret_level.equals("")) {%>
							<td align="center">
								<font size="-1">附件密级</font>
							</td>
							<%} %>
							<td align="center">
								<font size="-1">附件大小</font>
							</td>
							<td align="center">
								<font size="-1">状态</font>
							</td>
							<td  align="center">
								<font size="-1">操作</font>
							</td>
						</tr>
					<%=attachHtml%>
				</table>
			</td>
		</tr>
	</table>
<script type="text/javascript">
var baseurl = "<%=request.getContextPath()%>";
var file_size_limit = "<%=file_size_limit%>";
var file_types = "<%=file_types%>";
var save_type = "<%=save_type%>";
var form_id = "<%=form_id%>";
var form_code = "<%=form_code%>";
var allowAdd = "<%=allowAdd%>";
var allowDel = "<%=allowDel%>";
var file_category = "<%=file_category%>";
var secret_level = "<%=secret_level%>";
var chunk = "<%=chunk%>";

var au = new AttachUtil(baseurl+"/");
var files = [];//用于储存成功上传附件信息
var errors = [];//用于储存上传失败附件信息
var type = 'file';
var _scFlag = false; //是否续传flag
var _startFlag = false;
var _errorFlag = false;

var uploader;
var _current_id;//当前记录文件ID(tr的id)
$(function() {  
	$.extend($.messager.defaults,{  
	    ok:"确定",  
	    cancel:"取消"  
	}); 
    uploader = new plupload.Uploader({  
        browse_button : 'pickfiles',//选择文件的按钮  
        container : 'container',//文件上传容器  
        runtimes : 'html5,flash',
        flash_swf_url : baseurl+'/avicit/platform6/modules/system/plupload/js/Moxie.swf',// Flash环境路径设置 
        url : baseurl+'/uploader',//上传文件路径  
        max_file_size : file_size_limit,//100b, 10kb, 10mb, 1gb  
        prevent_duplicates : true ,
        chunk_size : chunk,//分块大小，小于这个大小的不分块  
        multipart_params : {save_type : save_type,form_id:form_id,form_code:form_code,secret:'',category:'',lastdate:'',filesize:''}
        // 如果可能的话，压缩图片大小  
        // resize : { width : 320, height : 240, quality : 90 }, 
    });  
    uploader.bind('Init', function(up, params,response) {//初始化  
    	//添加文件选择过滤
    	var filters = uploader.getOption("filters"); 
    	if (file_types != null && file_types != "" && file_types != "all"){
    		filters.mime_types = [{title : "文档", extensions : file_types}];
    	}else if (file_types == "all"){
    	}else{
    		filters.mime_types = [{title : "文档", extensions : "zip,rar,txt,doc,docx,xls,xlsx,ppt,pptx,pg,gif,png"}];
    	}
    	uploader.setOption("filters",filters);
    	uploader.refresh();
    }); 
    uploader.bind('FilesAdded', function(up, files) {//选择文件后 
    	if (_scFlag){
    		//续传按钮
    		if (files.length!=1){
    			$.messager.alert('提示','续传只能选择一个文件！','warning');
    			_scFlag = false
    			return false;
    		}
    		else{
    			//检查文件一致性
				if (!checkFileSame(files[0].size,files[0].name,dateToString(files[0].lastModifiedDate),form_id,form_code)){
					$.messager.alert('提示','续传文件与原文件不符，请重新选择！','warning');
					_scFlag = false
					return false;
				}
    		}
    		//将从数据库读出的id转换成plupload自动生成的id 方便上传
			$("#"+_current_id).attr("id",files[0].id);
			if(file_category!=""){
				$("#category_"+_current_id).attr("id","category_"+files[0].id);
			}
			if(secret_level!=""){
				$("#secret_"+_current_id).attr("id","secret_"+files[0].id);
			}
			//续传标志
	    	_scFlag = false;
			//更新页面操作字段内容
	    	$("#"+files[0].id).children("td[id='continue']").html("<span id='sc'  class='link-red' onclick='javascript:cancelContinueFile(this)'>取消</span>");
    	}else{
    		//非续传添加文件，检查文件名是否重复
    		var names = document.getElementsByName("attName");
    		var isSame = false;
    		for (var i=0;i<files.length;i++) {
    			$(names).each(function(){
    				if(files[i].name == $(this).val()){
						$.messager.alert('提示',"【"+files[i].name+"】存在同名附件，无法添加。",'warning');
						isSame = true;
						return false;
					}
    			});
	        }
    		if(!isSame){
    			//绘制页面记录
        		addFileHtml("attachView",files);
    		}else{
    			return false;
    		}
    	}
    	//供用户调用，提供添加附件事件
    	if(typeof(afterFilesAdd)=="function"){
    		afterFilesAdd(files);
		}
        up.refresh();
    });
    //单个文件上传过程中事件
    uploader.bind('UploadProgress', function(up, file) {//上传进度  
    	$("#"+file.id).children("td[id='progress']").html("<center>"+file.percent + "% </center>");
    });
    //单个文件上传完成事件
    uploader.bind('FileUploaded',function(uploader,file,response){
		if(response.response){
			var rs = $.parseJSON(response.response);
			//设置已存附件返回id
			if (rs.fileId != "" && rs.fileId != null){
				file.id = rs.fileId;
			}
			if(rs.status){
				files.push(file);
			}else{
				errors.push(file);
			}
		}
	});
    //队列上传完成事件
    uploader.bind('UploadComplete', function(uploader,fs){
		var e= errors.length ? ",失败"+errors.length+"个("+errors.join("、")+")。" : "。";
		$.messager.alert('提示',"上传完成！共"+fs.length+"个。成功"+files.length+e,'info');

    	if(typeof(afterUploadComplete)=="function"){
    		afterUploadComplete(files,errors);
		}
	});
    //文件块上传事件
    uploader.bind('ChunkUploaded', function(uploader,file,responseObject){
    	var dataObj=eval("("+responseObject.response+")");
    	//出现错误停止上传
    	if (!dataObj.status){
    		$("#"+file.id).children("td[id='continue']").children().html("续传");
        	stop();
        	$.messager.alert('错误','上传出现错误 : '+ dataObj.err,'error');
    	}
    	return;
    });
    //上传前处理事件
    uploader.bind('BeforeUpload',function(up, file) {
    	//设置文件的category参数
    	if(file_category!=""){
			td.innerHTML= genfileCategory(files[i].id,file_category);
			uploader.settings.multipart_params.category = document.getElementById("category_"+file.id).value;
		}
    	//设置文件的secret_level参数
		if(secret_level!=""){
			if (document.getElementById("secret_"+file.id).getAttribute("secret") != null){
				//续传的密集参数
				uploader.settings.multipart_params.secret = document.getElementById("secret_"+file.id).getAttribute("secret");
			}else{
				//正常添加的密级参数
				uploader.settings.multipart_params.secret = document.getElementById("secret_"+file.id).value;
			}
			
		}
    	//设置文件最后修改日期参数（用于进行文件一致性校验）
		uploader.settings.multipart_params.lastdate = dateToString(file.lastModifiedDate);
    	//设置文件大小参数
		uploader.settings.multipart_params.filesize = file.size;
    	//更新操作字段内容
    	$("#"+file.id).children("td[id='continue']").html("<span id='sc' class='link-red'>暂停</span>");
    	$("#"+file.id).children("td[id='continue']").children().click(function(e){
        	makerUpload(file.id,_startFlag);
        	if (_startFlag){
        		$(this).html("暂停");
        	}else{
        		$(this).html("续传");
        	}
        });
    	
    });
    //客户端错误事件
    uploader.bind('Error',function(up,errObject) {
    	$.messager.alert('错误','上传出现错误 : '+ errObject.message,'error');
    	if (errObject.file != null){
	    	$("#"+errObject.file.id).children("td[id='continue']").children().html("续传");
	    	stop();
	    	errors.push(errObject.file);
    	}
    	//up.removeFile(errObject.file);
    	_errorFlag = true;
    	up.refresh();
    });   
    $("span[id='sc']").each(function(){
    	$(this).click(function(e){
        	var id = $(this).parent().parent().attr("id");
        	makerUpload(id,_startFlag);
    	});
    });
    uploader.init(); 
    $("#btnUpload").click(function(){
    	start();
    })
});  

function dateToString(date){
	if(typeof(date)=='string'){
		return date;
	}else{
	var year = date.getFullYear();
    var month =(date.getMonth() + 1).toString();
    var day = (date.getDate()).toString();
    if (month.length == 1) {
        month = "0" + month;
    }
    if (day.length == 1) {
        day = "0" + day;
    }
    var dateTime = year + month +  day;
    return dateTime;
	}
}

function addFileHtml(area_id,files){
	var html = "";
	for (var i=0;i<files.length;i++){
		var tb = document.getElementById(area_id);
		var tr = tb.insertRow(-1);
		tr.setAttribute("id",files[i].id);
		if(i%2==0){//修改平台上传附件，增加表格斑马线
			tr.className='datagrid-cell';
		}else{
			tr.className='datagrid-cello';
		}
		var td = tr.insertCell(-1);td.className='uploadTD';td.width="10%";td.align="left";
		var icon = au.countImage(files[i].name);
		//name属性用于方便查找
		td.innerHTML="<INPUT TYPE='hidden' id= '"+files[i].id+"_id'"+" name = 'attName' value='"+files[i].name+"'/><img src='"+icon+"' class='new-ico-file'/>"+files[i].name;

		if(file_category!=""){
			var td = tr.insertCell(-1);td.className='uploadTD';td.align="center";td.width="10%";
			//添加下拉类型
			td.innerHTML= genfileCategory(files[i].id,file_category);
		}
		if(secret_level!=""){
			var td = tr.insertCell(-1);td.className='uploadTD';td.align="center";td.width="10%";
			//添加下拉类型
			td.innerHTML= genSecretSelect(files[i].id,secret_level);
		}
		
		td = tr.insertCell(-1);td.className='uploadTD';td.align="center";td.width="10%";
		if(files[i].size){
			td.innerHTML=getNiceFileSize(files[i].size);
		}else{
			td.innerHTML="0B";
		}
		
		td = tr.insertCell(-1);td.className='uploadTD';td.width="10%";td.align="center";td.setAttribute("id","progress");
		td.innerHTML="等待上传";
		td = tr.insertCell(-1);td.className='uploadTD';td.align="center";td.width="10%";td.setAttribute("id","continue");
		td.innerHTML="<span id='sc'  class='link-red' onclick='javascript:cancelupLoadFile(this)'>取消</span>";   
	}
}

//开始上传
function start(){
	_startFlag = true;
	 if (uploader.files.length > 0) {
		 uploader.start();
	 }
}

//上传停止控制器
function makerUpload(id,flag){
	_current_id = id;
	_scFlag = true;
	//处于停止状态
	if (!flag){
		if (_errorFlag){
			//之前因为错误停止文件，重新置入上传队列中
			for (var i=0;i< errors.length;i++){
				uploader.getFile(errors[i].id).status= plupload.QUEUED;
				//alert(JSON.stringify(errors[i]));
				//alert("plupload.QUEUED="+plupload.QUEUED+"   plupload.UPLOADING="+plupload.UPLOADING+", plupload.FAILED="+plupload.FAILED+", plupload.DONE="+plupload.DONE)
				//errors[i].status = plupload.QUEUED;
				//uploader.addFile(errors[i]);
			}
			setTimeout("_errorFlag = false;uploader.refresh();start();",2000);
		}else{
			if (typeof(uploader.getFile(id)) == "undefined"){
				$( "#pickfiles" ).trigger( 'click' );
			}else{
				start();
			}
		}
	}else{//处于上传状态
		stop();
	}
}

function stop(){
	_startFlag = false;
	if (uploader.files.length > 0) {
		uploader.stop();
	}
}

function genSecretSelect(fileId,secret_level){
	var selStr = "";
	var fileSecret = {};
	$.ajax({
		 url:'platform/syslookuptype/getLookUpCode/'+secret_level+'.json',
		 type : 'get',
		 async : false,
		 dataType : 'json',
		 success : function(r){
			 fileSecret=r;
		 }
	 });
	if(typeof(fileSecret)!="undefined"){
		selStr = "<select id='secret_"+fileId+"'  name='secret_"+fileId+"' onchange='javascript:setFilePara(\""+fileId+"\",\"secret\",this)'>";
		for(var i=0;i<fileSecret.length;i++){
			selStr+="<option value='"+fileSecret[i].lookupCode+"'>"+fileSecret[i].lookupName+"</option>";
		}
		selStr +="</select>";
	}
	return selStr;
}

function genfileCategory(fileId,file_Category){
	var selStr ="";
	var fileCategory = {};
	$.ajax({
		 url:'platform/syslookuptype/getLookUpCode/'+file_Category+'.json',
		 type : 'get',
		 async : false,
		 dataType : 'json',
		 success : function(r){
			 fileSecret=r;
		 }
	 });
	if(typeof(fileCategory)!="undefined"){
		selStr = "<select id='category_"+fileId+"' name='category_"+fileId+"' onchange='javascript:setFilePara(\""+fileId+"\",\"category\",this)'>";
		for(var i=0;i<fileCategory.length;i++){
			selStr+="<option value='"+fileCategory[i].lookupCode+"'>"+fileCategory[i].lookupName+"</option>";
		}
		selStr +="</select>";
	}
	return selStr;
}

//检查一致性
function checkFileSame(filesize,name,lastdate,formId,formCode){
	var flag = false;
	$.ajax({
		url : 'platform/plUploadController/checkFileSame.json',
		type : 'GET',
		async: false,
		data : 'filesize='+filesize+'&name='+name+'&lastdate='+lastdate+'&formId='+formId+'&formCode='+formCode,
		success : function(r){
			if (r.flag == 'success')
				flag = true;
		}
	});
	return flag;
}

//文件大小单位转换
function getNiceFileSize(bitnum){
	var _K = 1024;
	var _M = _K*1024;
	if(bitnum<_M){
		if(bitnum<_K){
			return bitnum+'B';
		}else{
			return Math.ceil(bitnum/_K)+'K';
		}
		
	}else{
		return Math.ceil(100*bitnum/_M)/100+'M';
	}
}

function deleteFile(fileId, fileName, obj) {
	//进行删除确认
	$.messager.confirm('请确认','您要删除选中的附件吗?',function(b){
			if (b){
				obj.innerText = "删除中...";
				//修改删除链接
				$.ajax({
					type : 'GET',
					url : "platform/plUploadController/doDelete",
					data : '&pkId=' + fileId + "&fileuploadBusinessId="
							+ form_id + "&fileuploadBusinessTableName="
							+ form_code + "&fileuploadIsSaveToDatabase="
							+ save_type + "&fileName="+fileName,
					success : function() {
						var tr=obj.parentNode.parentNode;
						var fileId = tr.getAttribute("id");
						var tbody=tr.parentNode;
						tbody.removeChild(tr);
						
						$.messager.alert('提示','附件删除完成','info');
					}
				});
			}
	});
}

function deleteTempFile(fileId, fileName, obj) {
	//进行删除确认
		$.messager.confirm('请确认','您要删除选中的附件吗?',function(b){
			if (b){
				obj.innerText = "删除中...";
				//修改删除链接
				$.ajax({
					type : 'GET',
					url : "platform/plUploadController/doDeleteTemp",
					data : '&pkId=' + fileId + "&fileuploadBusinessId="
							+ form_id + "&fileuploadBusinessTableName="
							+ form_code + "&fileuploadIsSaveToDatabase="
							+ save_type + "&fileName="+fileName,
					success : function() {
						var tr=obj.parentNode.parentNode;
						var fileId = tr.getAttribute("id");
						var tbody=tr.parentNode;
						tbody.removeChild(tr);
						$.messager.alert('提示','附件删除完成','info');
					}
				});
			}
		});
}

function cancelupLoadFile(obj){
	var tr=obj.parentNode.parentNode;
	var fileId = tr.getAttribute("id");
	var tbody=tr.parentNode;
	tbody.removeChild(tr);
	deletEqueuefileById(fileId);
}

function cancelContinueFile(obj){
	var tr=obj.parentNode.parentNode;
	var fileId = tr.getAttribute("id");
	deletEqueuefileById(fileId);
	$(obj).html("续传");
	$(obj).removeAttr("onclick");
	$(obj).click(function(e){
    	var id = $(this).parent().parent().attr("id");
    	makerUpload(id,_startFlag);
	});
}

//删除队列中的文件
function deletEqueuefileById(id){
	var file = uploader.getFile(id);
	uploader.removeFile(file);
	uploader.refresh();
}

function downloadFile(fileId,formId,formTable,saveType){
	window.open("<%=request.getContextPath()%>/platform/plUploadController/doDownload?fileuploadBusinessId="+formId+"&fileuploadBusinessTableName="+formTable+"&fileuploadIsSaveToDatabase=<%=save_type%>&fileId="+fileId,"_blank");
}

</script>
  </body>
</html>