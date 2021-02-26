/**
 * task extends MyBase
 */
function MyTask(id) {
	MyBase.call(this, id, "task");
	this.style = "image;image=static/js/platform/designer/images/48/task_human.png;";
}
MyTask.prototype = new MyBase();

/**
 * 重写了name监听事件
 *
 * @param value
 */
MyTask.prototype.labelChanged = function(value) {
	//以下代码照抄父类
	this.alias = value;
	_editor.graph.labelChanged(this.getCell(), value);

    //设置人工节点待办标题
    this.setTaskDaiBanBiaoTi();
};

/**
 * 设置人工节点待办标题
 * 人工节点待办标题根据流程名称和显示名称自动生成
 */
MyTask.prototype.setTaskDaiBanBiaoTi = function() {
    $("#" + this.id).find("#dai_ban_biao_ti").val(_myAction.getFlowName() + "：" + this.alias);
};
/**
 * 设置人工节点类型：只允许一个开始/结束节点
 */
MyTask.prototype.setTaskType = function(checked, value) {
    var allCell = _myCellMap.values();

    var haveStartNode = false;//是否存在已选开始节点
    var haveEndNode = false;//是否存在已选结束节点
    for (var i in allCell) {
        var theCell = allCell[i];
        if(theCell.tagName != "task" || theCell.id == _myCurCellId) {
            continue;
        }

        if ($("#" + theCell.id).find("#task_type_start").prop("checked") == true) {
            haveStartNode = true;
        }
        if ($("#" + theCell.id).find("#task_type_end").prop("checked") == true) {
            haveEndNode = true;
        }
    }

    if(haveStartNode && value == 'start') {
        var confirmText = "已存在且只能存在一个开始节点，确定重新设置当前节点为开始节点？";
        this.confirmStartOrEndNode(confirmText, checked, value);
    }
    if(haveEndNode && value == 'end') {
        var confirmText = "已存在且只能存在一个结束节点，确定重新设置当前节点为结束节点？";
        this.confirmStartOrEndNode(confirmText, checked, value);
	}
};
MyTask.prototype.confirmStartOrEndNode = function(confirmText, checked, value) {
    var allCell = _myCellMap.values();

    dhtmlx.message({
        title : "提示",
        type : "confirm",
        text : confirmText,
        callback: function(result) {
            if (result) {
                for (var i in allCell) {
                    var theCell = allCell[i];
                    if(theCell.tagName != "task" || theCell.id == _myCurCellId) {
                        continue;
                    }

                    if (value == 'start') {
                        $("#" + theCell.id).find("#task_type_start").prop("checked",false);
                    }
                    if (value == 'end') {
                        $("#" + theCell.id).find("#task_type_end").prop("checked",false);
                    }
                }
            }
            else {
                if (checked) {
                    if (value == 'start') {
                        $("#" + _myCurCellId).find("#task_type_start").prop("checked",false);
                    }
                    if (value == 'end') {
                        $("#" + _myCurCellId).find("#task_type_end").prop("checked",false);
                    }
                }
                else {
                    if (value == 'start') {
                        $("#" + _myCurCellId).find("#task_type_start").prop("checked",true);
                    }
                    if (value == 'end') {
                        $("#" + _myCurCellId).find("#task_type_end").prop("checked",true);
                    }
                }
            }
        }
    });
}

/**
 * 初始化属性信息
 */
MyTask.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + _countUtils.getTask();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息

    //设置人工节点待办标题
    this.setTaskDaiBanBiaoTi();
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyTask.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setTask(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	this.createRemarkDom(xmlValue);
	//首先解析人员信息
	this.createActorsDom(xmlValue);
	//基本信息
	var icon = this.getAttr(xmlValue, "icon");
	if($.notNull(icon)){
		$("#" + this.id).find("#xian_shi_tu_biao").val(icon);
		if(icon == "领导01.png"){
			this.style = "image;image=static/js/platform/designer/images/node/leader01.png;";
		}else if(icon == "领导02.png"){
			this.style = "image;image=static/js/platform/designer/images/node/leader02.png;";
		}else if(icon == "员工01.png"){
			this.style = "image;image=static/js/platform/designer/images/node/employee01.png;";
		}else if(icon == "员工02.png"){
			this.style = "image;image=static/js/platform/designer/images/node/employee02.png;";
		}
	}
	this.setDomValByMeta("dai_ban_biao_ti", xmlValue, "todo");
	this.setDomValByMeta("ti_jiao_bie_ming", xmlValue, "transitionName");
	this.setDomCheckByMeta("zddk", xmlValue, "isAutoOpen", "yes");
	this.setDomCheckByMeta("filterUser", xmlValue, "filterUser", "yes");
	this.setDomCheckByMeta("isReadTodo", xmlValue, "isReadTodo", "yes");
	this.setDomCheckByMeta("isStartNode", xmlValue, "isStartNode", "yes");
	this.setDomCheckByMeta("task_ydsp_no", xmlValue, "taskMobileApproval", "no");
	this.setDomCheckByMeta("singleyes", xmlValue, "single", "yes");

	var isAutoOpen = this.getMeta(xmlValue, "isAutoOpen");
	if(isAutoOpen == "yes"){
		this.setDomValByMeta("autoOpenTransitionName", xmlValue, "autoOpenTransitionAlias");
		this.setDomPropByMeta("autoOpenTransitionName", xmlValue, "autoOpenTransitionName", "userData");
	}
	//人员信息
	var dealtype = this.getAttr(xmlValue, "dealtype");
	$("#" + this.id).find("#dealtype").val(dealtype);
	if(dealtype == "4"){
		var self = this;
		$(xmlValue).children("meta[name='number']").each(function(){
			$("#" + self.id).find("#dealtype").next().val("number");
			$("#" + self.id).find("#dealtype").next().trigger('change');
			$("#" + self.id).find("#num").val($.trim($(this).text()));
		});
		$(xmlValue).children("meta[name='percent']").each(function(){
			$("#" + self.id).find("#dealtype").next().val("percent");
			$("#" + self.id).find("#dealtype").next().trigger('change');
			$("#" + self.id).find("#num").val($.trim($(this).text()));
		});
	}else{
		$("#" + this.id).find("#dealtype").trigger('change');
	}
	var candidateUsers = this.getAttr(xmlValue, "candidate-users");
	if($.notNull(candidateUsers)){
		$("#" + this.id).find('#hou_xuan_chu_li_ren').attr("actorsId", candidateUsers);
		$("#" + this.id).find('#hou_xuan_chu_li_ren').val(actorFactory.getActorsTextById(candidateUsers));
	}
	this.setDomCheckByMeta("zdxr", xmlValue, "userSelectType", "auto");
	this.setDomCheckByMeta("bxs", xmlValue, "isSelectUser", "no");
	this.setDomCheckByMeta("hq_yes", xmlValue, "isAutoGetUser", "yes");
	this.setDomCheckByMeta("yj_no", xmlValue, "isWorkHandUser", "no");
	this.setDomCheckByMeta("xr_no", xmlValue, "isMustUser", "no");
	this.setDomCheckByMeta("secret_yes", xmlValue, "isSecret", "yes");
	
	var isSecret = this.getMeta(xmlValue, "isSecret");
	if(isSecret == "yes"){
		this.setDomValByMeta("secret", xmlValue, "secretVar");
	}
	//意见
	this.setDomCheckByMeta("icm_yes", xmlValue, "ideaCompelManner", "yes");
	this.setDomCheckByMeta("ids_cover", xmlValue, "ideaDisplayStyle", "cover");
	var ideaType = this.getMeta(xmlValue, "ideaType");
	if($.notNull(ideaType)){
		$("#" + this.id).find("#ideaType").val(ideaType);
		$("#" + this.id).find("#ideaType").trigger('change');
	}
	this.createEventDom(xmlValue, "qian_zhi_shi_jian", "start");//event
	this.createEventDom(xmlValue, "hou_zhi_shi_jian", "end");//event
	this.createTimeEventDom(xmlValue);//超时事件
	//权限
	this.createQXDom(xmlValue, "tui_hui_ni_gao_ren", "reTreatToDraft");
	this.createQXDom(xmlValue, "tui_hui_shang_yi_bu", "reTreatToPrev");
//	this.createQXDom(xmlValue, "ren_yi_tui_hui", "reTreatToArbitrary");
	this.createQXDom(xmlValue, "liu_cheng_na_hui", "withdraw");
	this.createQXDom(xmlValue, "liu_cheng_bu_fa", "supplement");
	this.createQXDom(xmlValue, "liu_cheng_zhuan_fa", "transmit");
	this.createQXDom(xmlValue, "liu_cheng_zhuan_ban", "supersede");
	this.createQXDom(xmlValue, "liu_cheng_zeng_fa", "addUser");
	this.createQXDom(xmlValue, "liu_cheng_zeng_fa_submit", "addUserAndSubmit");
	this.createQXDom(xmlValue, "bu_fen_na_hui", "withdrawAssignee");
	this.createQXDom(xmlValue, "pei_zhi_xuan_ren", "stepUserDefined");
	
	this.createQXDom(xmlValue, "zeng_jia_du_zhe", "taskreader");
	//候选点
//	var reTreatToArbitraryScope = this.getMeta(xmlValue, "reTreatToArbitraryScope");
//	if($.notNull(reTreatToArbitraryScope)){
//		var alias = reTreatToArbitraryScope.split("@")[0];
//		var name = reTreatToArbitraryScope.split("@")[1];
//		$("#" + this.id).find("#reTreatToArbitraryScope").val(alias);
//		$("#" + this.id).find("#reTreatToArbitraryScope").attr("taskNames", name);
//	}
	
	//文档权限
	this.createWDQXDom(xmlValue);
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell());// 创建mxCell
	_myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyTask.prototype.getOtherAttr = function(node) {
	this.setXmlAttrByVal("xian_shi_tu_biao", node, "icon");
	this.setXmlMetaByVal("dai_ban_biao_ti", node, "todo");
	this.setXmlMetaByVal("ti_jiao_bie_ming", node, "transitionName");
	this.setXmlMetaByCheck("shen_pi_fang_shi", node, "isAutoOpen");
	this.setXmlMetaByCheck("guo_lv_dang_qian_ren", node, "filterUser");
	this.setXmlMetaByCheck("dai_yue_jie_dian", node, "isReadTodo");
	this.setXmlMetaByCheck("ni_gao_jie_dian", node, "isStartNode");
	this.setXmlMetaByCheck("task_yi_dong_shen_pi", node, "taskMobileApproval");
	this.setXmlMetaByCheck("single", node, "single");

	var isAutoOpen = $("#" + this.id).find("input[name='shen_pi_fang_shi']:checked").val();
	if(isAutoOpen == "yes"){
		this.setXmlMetaByVal("autoOpenTransitionName", node, "autoOpenTransitionAlias");
		this.setXmlMetaByProp("autoOpenTransitionName", node, "autoOpenTransitionName", "userData");
	}
	//人员信息
	var dealtype = $("#" + this.id).find("#dealtype").val();
	this.putAttr("dealtype", dealtype, node);
	if(dealtype == "4"){
		this.addMeta($("#" + this.id).find("#dealtype").next().val(), $("#" + this.id).find("#num").val(), node);
	}
	var candidateUsers = $("#" + this.id).find("#hou_xuan_chu_li_ren").attr("actorsId");
	this.putAttr("candidate-users", candidateUsers, node);
	if($.notNull(candidateUsers)){
		this.createActorsXml(node, candidateUsers);
	}
	this.setXmlMetaByCheck("userSelectType", node, "userSelectType");
	this.setXmlMetaByCheck("isSelectUser", node, "isSelectUser");
	this.setXmlMetaByCheck("isAutoGetUser", node, "isAutoGetUser");
	this.setXmlMetaByCheck("isWorkHandUser", node, "isWorkHandUser");
	this.setXmlMetaByCheck("isMustUser", node, "isMustUser");
	this.setXmlMetaByCheck("isSecret", node, "isSecret");
	
	var isSecret = $("#" + this.id).find("input[name='isSecret']:checked").val();
	if(isSecret == "yes"){
		this.setXmlMetaByVal("secret", node, "secretVar");
	}
	//意见
	this.setXmlMetaByCheck("ideaCompelManner", node, "ideaCompelManner");
	this.setXmlMetaByVal("ideaType", node, "ideaType");
	this.setXmlMetaByCheck("ideaDisplayStyle", node, "ideaDisplayStyle");
	this.createEventXml(node, "qian_zhi_shi_jian", "start");//
	this.createEventXml(node, "hou_zhi_shi_jian", "end");//
	this.createTimeEventXml(node);//超时事件
	//权限
	var magicsNode = ComUtils.createElement("magics");
	this.createQXXml(magicsNode, "tui_hui_ni_gao_ren", "reTreatToDraft", "退回拟稿人", node);
	this.createQXXml(magicsNode, "tui_hui_shang_yi_bu", "reTreatToPrev", "退回上一步", node);
//	this.createQXXml(magicsNode, "ren_yi_tui_hui", "reTreatToArbitrary", "任意退回", node);
	this.createQXXml(magicsNode, "liu_cheng_na_hui", "withdraw", "流程拿回", node);
	this.createQXXml(magicsNode, "liu_cheng_bu_fa", "supplement", "流程补发", node);
	this.createQXXml(magicsNode, "liu_cheng_zhuan_fa", "transmit", "流程转发", node);
	this.createQXXml(magicsNode, "liu_cheng_zhuan_ban", "supersede", "流程转办", node);
	this.createQXXml(magicsNode, "liu_cheng_zeng_fa", "addUser", "流程增发", node);
	this.createQXXml(magicsNode, "liu_cheng_zeng_fa_submit", "addUserAndSubmit", "增发并提交", node);
	this.createQXXml(magicsNode, "bu_fen_na_hui", "withdrawAssignee", "部分拿回", node);
	this.createQXXml(magicsNode, "pei_zhi_xuan_ren", "stepUserDefined", "配置选人", node);
	
	this.createQXXml(magicsNode, "zeng_jia_du_zhe", "taskreader", "增加读者", node);
	
	if(magicsNode.childNodes.length > 0){
		node.appendChild(magicsNode);
	}
	//候选点
//	var reTreatToArbitrary = $('#' + this.id).find('#ren_yi_tui_hui').prop('checked');
//	if(reTreatToArbitrary){
//		var alias = $("#" + this.id).find("#reTreatToArbitraryScope").val();
//		var name = $("#" + this.id).find("#reTreatToArbitraryScope").attr("taskNames");
//		if($.notNull(name)){
//			this.addMeta("reTreatToArbitraryScope", alias + "@" + name, node);
//		}
//	}
	
	//文档权限
	var docRights = ComUtils.createElement("docRights");
	this.createWDQXXml(docRights, "wordCreate", "创建正文", node);
	this.createWDQXXml(docRights, "wordEdit", "编辑正文", node);
	this.createWDQXXml(docRights, "wordRead", "查看正文", node);
	this.createWDQXXml(docRights, "wordPrint", "打印正文", node);
	this.createWDQXXml(docRights, "wordValue", "域值同步", node);
	this.createWDQXXml(docRights, "wordRedTemplet", "套红", node);
	this.createWDQXXml(docRights, "wordSeal", "加盖公章", node);
	this.createWDQXXml(docRights, "attachCreate", "增删附件", node);
	this.createWDQXXml(docRights, "attachEdit", "编辑附件", node);
	this.createWDQXXml(docRights, "attachPrint", "打印附件", node);
	this.createWDQXXml(docRights, "attachShowByNode", "按节点过滤", node);
	this.createWDQXXml(docRights, "formSave", "保存表单", node);
	if(docRights.childNodes.length > 0){
		node.appendChild(docRights);
	}
	this.createRemarkXml(node);//备注
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyTask.prototype.getItem = function() {
	return [ {
		id : "jbxx_" + this.id,
		text : "基本信息",
		selected : true,
		icon : "grid.gif"
	}, {
		id : "ryxx_" + this.id,
		text : "人员信息",
		icon : "grid.gif"
	}, {
		id : "yjsz_" + this.id,
		text : "意见设置",
		icon : "grid.gif"
	}, {
		id : "jdqx_" + this.id,
		text : "节点权限",
		icon : "grid.gif"
	}/*, {
		id : "wdqx_" + this.id,
		text : "文档权限",
		icon : "grid.gif"
	}, {
		id : "qzsj_" + this.id,
		text : "前置事件",
		icon : "grid.gif"
	}, {
		id : "hzsj_" + this.id,
		text : "后置事件",
		icon : "grid.gif"
	}, {
		id : "cssj_" + this.id,
		text : "超时事件",
		icon : "grid.gif"
	}, {
		id : "bzxx_" + this.id,
		text : "备注",
		icon : "grid.gif"
	}*/];
};