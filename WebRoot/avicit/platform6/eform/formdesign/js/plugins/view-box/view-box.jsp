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
                    <%--1.添加公共"基本属性"--%>
                    <%--<jsp:include page="../attr-jsp/base-attr.jsp"/>--%>
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
                            <label class="control-label">视图选择：</label>
                            <input type="hidden" name="viewid" id="viewid" class="input-medium" value="" style="width:100%">
                            <input type="text" name="viewname" id="viewname" readonly class="input-medium" value="" style="width:100%">
                        </div>
                    </td></tr>
                    <tr><td>
                        <div class="form-group">
                            <label class="control-label">视图高度：</label>
                            <input type="text" name="viewheight" id="viewheight" class="input-medium" value="300" style="width:100%">
                        </div>
                    </td></tr>
                </table>
                    


                        <%--1.添加公共"基本属性"--%>
   <%--                      <jsp:include page="../attr-jsp/base-attr.jsp">
                            <jsp:param value="unique,column,required,readonly,bpm" name="except"/>
                        </jsp:include> --%>
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"
                       href="#collapse3">
                        <i data-icon-show="ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down"
                           class="bigger-110 ace-icon fa fa-angle-right"></i>
                        元素事件属性
                    </a>
                </h4>
            </div>
            <div id="collapse3" class="panel-collapse collapse">
                <div class="panel-body">
                    <%--1.添加公共"事件属性"--%>
                    <jsp:include page="../attr-jsp/event-attr.jsp">
                        <jsp:param value="focus,before,keyup,change,blur" name="except"/>
                    </jsp:include>

                    <%--2.添加当前元素特定"事件属性"--%>
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
