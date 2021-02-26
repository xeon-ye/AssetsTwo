<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form class="form">
    <input type="hidden" name="elementType" id="elementType" value="text">
    <input type="hidden" name="colRuleName" id="colRuleName" value="user">
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
                    <jsp:include page="../attr-jsp/base-attr.jsp"/>

                    <%--2.添加当前元素特定"基本属性"--%>
               <table>
                 <tr><td>
                    <div class="form-group" style="display: none">
                        <label class="control-label">字段长度：</label>
                        <input type="text" name="colLength" id="colLength" value="1000" class="input-medium">
                    </div>
                 </td></tr>
                 <tr><td>
                    <div class="form-group">
                    <table><tr><td>
                        <div class="form-group">
                        <table>
                        <tr>
                            <label class="control-label">是否关联密级：</label>
                        </tr>
                        <tr>
                            <td ><label>
                                <input name="allowSecret" type="radio" class="ace" value="true">
                                <span class="lbl">是</span>
                            </label></td>
                            <td style="padding-left: 30px;"><label >
                                <input name="allowSecret" type="radio" class="ace" value="false" checked>
                                <span class="lbl">否</span>
                            </label></td>
                        </tr>
                        </table>
                        </div>
                        </td></tr>
                        <tr><td>
                        <div class="form-group" id="formSecretDiv" style="width:99%">
                            <label class="control-label">表单密级字段：</label>
                            <%--<input type="text" name="formSecret" id="formSecret" class="input-medium">--%>
                            <select name="formSecret" id="formSecret" class="input-medium" style="width:100%">
                                <!--  <option value="">请选择</option> -->
                            </select>
                        </div>
                        </td></tr>
                        <tr><td>
                        <div class="form-group">
                        <table>
                        <tr><label class="control-label">选择属性：</label></tr>
                        <tr><td><label>
                                <input name="selectModel" type="radio" class="ace" value="single" checked>
                                <span class="lbl">单选</span>
                            </label></td>
                            <td style="padding-left: 15px;"><label>
                                <input name="selectModel" type="radio" class="ace" value="multi">
                                <span class="lbl">多选</span>
                            </label></td>
                         </tr></table>
                        </div>
                        </td></tr>
                        <tr><td>
                            <div class="form-group" style="width:99%">
                                <label class="control-label">关联组织字段：</label>
                                <select name="defaultOrgId" id="defaultOrgId" class="input-medium" style="width:100%">
                                    <!--  <option value="">请选择</option> -->
                                </select>
                            </div>
                        </td></tr>
                        <tr><td>
                            <div class="form-group" style="width:99%">
                                <label class="control-label">关联部门字段：</label>
                                <select name="defaultDeptId" id="defaultDeptId" class="input-medium" style="width:100%">
                                    <!--  <option value="">请选择</option> -->
                                </select>
                            </div>
                        </td></tr>
                        <tr><td>
                            <div class="form-group">
                                <label>
                                    <input id="redundance" name="redundance" type="checkbox" class="ace" value="Y">
                                    <span class="lbl">&nbsp;是否冗余</span>
                                </label>
                            </div>
                            <div id="redundanceColNameDiv" class="form-group" style="width:98%">
                                <label class="control-label">冗余字段名称：</label>
                                <div class="input-group">
                                    <input class="form-control" type="text" id="redundanceColName" name="redundanceColName"/>
                                    <span class="input-group-addon" id="redundanceColNameBtn"><i class="glyphicon glyphicon-menu-hamburger"></i></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>
                                    <input id="chuantou" name="chuantou" type="checkbox" class="ace" value="Y">
                                    <span class="lbl">&nbsp;是否穿透</span>
                                </label>
                            </div>
                            <div id="chuantouurldiv">
                                <div class="form-group">
                                    <label class="control-label">穿透页面URL：</label>
                                    <input name="chuantouurl" type="text" id="chuantouurl" class="input-medium">
                                </div>
                                <div class="form-group" style="width: 99%;">
                                    <label class="control-label">宽：</label><input type="text" name="chuantouwidth"
                                                                                  id="chuantouwidth" class="input-medium"
                                                                                  style="width:31%"><label
                                        class="control-label">高：</label><input type="text" name="chuantouheight"
                                                                               id="chuantouheight" class="input-medium"
                                                                               style="width:31%">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>
                                    <input name="defaultUser" type="checkbox" class="ace" value="Y">
                                    <span class="lbl">&nbsp;默认值（登录人）</span>
                                </label>
                            </div>
                        </td></tr>
                        <tr><td>
                        <label class="control-label">可选维度：</label>
				        <select name="selectDomain" multiple="multiple" placeholder="请选择维度" class="SlectBox 4col active" style="width:150px" required="required">
					        <!-- <option value="dept">部门</option>
						    <option value="group">群组</option>
						    <option value="role">角色</option>
						    <option value="position">岗位</option> -->
		 			    </select>
		 			    </td></tr>

		 			    </table>
                    </div>

                    </td></tr>
                   <tr><td>
                       <div class="form-group" id="deptarrayDiv" style="display: none">
                           <input type="hidden" id="deptlist" name="deptlist" class="input-medium">
                           <label class="control-label">部门范围：<a title="部门范围" id="deptpropertyBtn"><i
                                   class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                       </div>
                   </td></tr>
                   <tr><td>
                       <div class="form-group" id="grouparrayDiv" style="display: none">
                           <input type="hidden" id="grouplist" name="grouplist" class="input-medium">
                           <label class="control-label">群组范围：<a title="群组范围" id="grouppropertyBtn"><i
                                   class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                       </div>
                   </td></tr>
                   <tr><td>
                       <div class="form-group" id="rolearrayDiv" style="display: none">
                           <input type="hidden" id="rolelist" name="rolelist" class="input-medium">
                           <label class="control-label">角色范围：<a title="角色范围" id="rolepropertyBtn"><i
                                   class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                       </div>
                   </td></tr>
                   <tr><td>
                       <div class="form-group" id="positionarrayDiv" style="display: none">
                           <input type="hidden" id="positionlist" name="positionlist" class="input-medium">
                           <label class="control-label">岗位范围：<a title="岗位范围" id="positionpropertyBtn"><i
                                   class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                       </div>
                   </td></tr>
                   </table>
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
                    <div class="form-group">
                        <label class="control-label">回填部门：</label>
                        <select name="callbackdept" id="callbackdept" class="input-medium" style="width:100%">
                            <!--  <option value="">请选择</option> -->
                        </select>
                    </div>
                    <%--1.添加公共"事件属性"--%>
                        <jsp:include page="../attr-jsp/event-attr.jsp">
                            <jsp:param value="click,change,blur,focus,keyup" name="except"/>
                        </jsp:include>

                    <%--2.添加当前元素特定"事件属性"--%>
                    <div class="form-group">
                        <label class="control-label">
                            选择框回调事件：
                            <span class="help-button" data-rel="popover" data-trigger="hover" data-placement="left"
                                  data-original-title="提示"
                                  data-content="参数：user 选中的用户对象"
                            >?</span>
                        </label>
                        <textarea name="onCallbackEvent" id="onCallbackEvent" style="width: 100%;"></textarea>
                    </div>
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
<script>
    $('[data-rel=popover]').popover({container:'body'});
    $("#onCallbackEvent").click(function () {
        var _this = this;
        eventEdit(_this, '选择框回调事件');
    });
    $(function () {
        $('select[multiple].active.4col').multiselect({
            columns: 1,
            placeholder: '请配置选择维度',
            selectAll: false
        });
        var options = [{name   : '部门',value  : 'dept',checked: true},
                       {name   : '群组',value  : 'group',checked: true},
                       {name   : '角色',value  : 'role',checked: true},
                       {name   : '岗位',value  : 'position',checked: true}];
        $('select[multiple]').multiselect( 'loadOptions', options);

        $('select[multiple].active.4col').on("change", function() {
            setDisplay();
        });
        setDisplay();
    });

    function setDisplay(){
        var options = $('select[multiple].active.4col')[0];
        for(var i=0; i<options.length; i++){
            if(options[i].selected == true){
                $("#" + options[i].value + "arrayDiv").css("display","block");
            }else{
                $("#" + options[i].value + "arrayDiv").css("display","none");
            }
        }
    }

    $('input[type=radio][name=allowSecret]').change(function() {
        if (this.value == 'true') {
            $("#formSecretDiv").css("display","block");
        }else if (this.value == 'false') {
            $("#formSecret").val("");
            $("#formSecretDiv").css("display","none");
        }
    });
    $('input[name=redundance]').click(function(event){
        var flag = $(this).is(":checked")
        if (flag) {
            $("#redundanceColNameDiv").css("display","block");
        }else{
            $("#redundanceColName").val("");
            $("#redundanceColNameDiv").css("display","none");
        }
    });
    $("#redundanceColNameBtn").click(function () {
        var selectDbColumnName = new SelectDbColumnName(EformEditor.nowDbid);
        selectDbColumnName.init(function (data) {
            if (data.hasOwnProperty("colLength") && data.colLength!=""){
                $("#colLength").val(data.colLength);
            }
            $("#redundanceColName").val(data.colName).trigger("keyup");
        });
    });
    $('input[name=chuantou]').click(function(event){
        for(var j=0;j<labels.length;j++)
        {
            if(labels[j].getAttribute("for")==$currentColName&&$currentColName!="")
            {
                var flag = $(this).is(":checked")
                var $bindLabel=$(labels[j]);
                var bindLabelAttr={};//存放label的所有属性，json
                if($bindLabel.next().length!=0)
                {
                    bindLabelAttr=$.parseJSON($bindLabel.next().html());
                }
                if (flag) {
                    bindLabelAttr.ischuantou = $(this).val();
                }else{
                    bindLabelAttr.ischuantou = "";
                }
                $bindLabel.next().html(JSON.stringify(bindLabelAttr));
            }
        }
    });
</script>