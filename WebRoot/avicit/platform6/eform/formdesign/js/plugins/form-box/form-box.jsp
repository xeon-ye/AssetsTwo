<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form class="form">
    <input type="hidden" name="elementType" id="elementType" value="text">
    <div class="accordion-style1 panel-group" id="accordion">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"
                       href="#collapse1">
                        <i data-icon-show="ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down"
                           class="bigger-110 ace-icon fa fa-angle-down"></i>
                        元素基本属性
                    </a>
                </h4>
            </div>
            <div id="collapse1" class="panel-collapse collapse in">
                <div class="panel-body">
                <table>
           			<tr><td>
                    <div class="form-group">
                        <label class="control-label">页面元素ID：</label>
                        <input type="text" name="domId" id="domId" class="input-medium" value="" style="width:100%">
                    </div>
                    </td></tr>
                    <tr><td>
             			<div class="form-group">
    					<label class="control-label">元素title：</label>
    					<input type="text" name="title" id="title" class="input-medium" value="" style="width:100%">
					</div>
					</td></tr>
					<tr><td>
                    <div class="form-group">
                        <label class="control-label">引用表单：</label>
                        <input type="text" name="formname" id="formname" class="input-medium" readonly style="width:100%">
                        <input type="hidden" name="formid" id="formid" class="input-medium">
                        <input type="hidden" name="dbid" id="dbid" class="input-medium">
                    </div>
                    </td></tr>
					<tr><td>
                    <div class="form-group" style="display:none;">
                        <label class="control-label">关联外键：</label>
                        <input type="text" name="fkcol" id="fkcol" class="input-medium" style="width:100%">
                    </div>
                        <div class="form-group">
                            <label class="control-label">查询参数配置：<a title="查询参数配置" id="addpara"><i
                                    class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                            <input type="hidden" name="paralist" id="paralist" class="input-medium">
                            <ul id="paraarea" class="item-list">
                            </ul>
                        </div>
                    </td></tr></table>
                </div>
            </div>
        </div>
    
	    <div class="panel panel-default">
	            <div class="panel-heading">
	                <h4 class="panel-title">
	                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"
	                       href="#collapse_css">
	                        <i data-icon-show="ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down"
	                           class="bigger-110 ace-icon fa fa-angle-right"></i>
	                       css扩展属性
	                    </a>
	                </h4>
	            </div>
	            <div id="collapse_css" class="panel-collapse collapse">
	                <div class="panel-body">
	                    <%--1.添加css扩展"--%>
	                    <jsp:include page="../attr-jsp/css-attr.jsp"/>
	                </div>
	            </div>
	       </div>
    
    </div>
</form>
<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>