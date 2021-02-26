function DocumentItem(datagrid, url, formSub, dataGridColModel, searchDialogSub, pid, searchSubNames, demoSubUser_KeyWord) {
    if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = url;
    this.getUrl = function () {
        return _url;
    }
    this._searchDialogId = "#" + searchDialogSub;
    this.searchForm = "#" + formSub;
    this.pid = pid;
    this._datagridId = "#" + datagrid;
    this.Toolbardiv = "#t_" + datagrid;
    this.Toolbar = "#toolbar_" + datagrid;
    this.Pagerlbar = "#" + datagrid + "Pager";
    this._keyWordId = "#" + demoSubUser_KeyWord;
    this._searchNames = searchSubNames;
    this.dataGridColModel = dataGridColModel;
    this.init.call(this);
};
/**
 * 初始化操作
 * 回车查询
 */
DocumentItem.prototype.init = function (pid) {
    var _self = this;
    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getDocumentItem',
        postData: {pid: _self.pid},
        mtype: 'POST',
        datatype: "json",
        toolbar: [true, 'top'],
        colModel: _self.dataGridColModel,
        height: $(window).height()*2/5,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
        scrollOffset: 10, //设置垂直滚动条宽度
        rowNum: 20,
        rowList: [200, 100, 50, 30, 20, 10],
        altRows: true,
        pagerpos: 'left',
        hasColSet: false,//设置显隐属性
        loadComplete: function () {
            $(this).jqGrid('getColumnByUserIdAndTableName');
        },
        styleUI: 'Bootstrap',
        viewrecords: true, //
        multiselect: true,
        autowidth: true,
        shrinkToFit: true,
        responsive: true,//开启自适应
        pager: _self.Pagerlbar
    });

    $(_self.Toolbardiv).append($(_self.Toolbar));

    $('.date-picker').datepicker({
        beforeShow: function () {
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
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
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
    //禁止时间和日期格式手输
    $('.date-picker').on('keydown', nullInput);
    $('.time-picker').on('keydown', nullInput);
    //回车查询
    $(_self._keyWordId).on('keydown', function (e) {
        if (e.keyCode == '13') {
            _self.searchByKeyWord();
        }
    });
};
/**
 * 添加页面
 */
DocumentItem.prototype.insert = function (pid) {
    if (pid == "null" || pid == "undefined") {
        layer.alert('请选择一条主表数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    } else {
        this.insertIndex = layer.open({
            type: 2,
            title: '添加',
            skin: 'bs-modal',
            area: ['100%', '100%'],
            maxmin: false,
            content: this.getUrl() + 'Add/null'
        });
    }
};
/**
 * 编辑页面
 */
DocumentItem.prototype.modify = function () {
    if (this.pid == null || this.pid == "") {
        layer.alert('请选择一条要编辑的主表数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    }
    var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    if (ids.length == 0) {
        layer.alert('请选择要编辑的数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    } else if (ids.length > 1) {
        layer.alert('只允许选择一条数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    }

    var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
    this.editIndex = layer.open({
        type: 2,
        title: '编辑',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: this.getUrl() + 'Edit/' + rowData.id
    });
};
/**
 * 详情页面
 */
DocumentItem.prototype.detail = function (id) {
    this.detailIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '详细页',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Detail/' + id
    });
};
/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
DocumentItem.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            packageId: {
                required: true,
                maxlength: 50
            },
            createdByAlias: {
                required: true,
                maxlength: 50
            },
            createdByDeptAlias: {
                required: true,
                maxlength: 50
            },
            creationDate: {
                required: true,
                dateISO: true
            },
            documentName: {
                required: true,
                maxlength: 100
            },
            documentType: {
                maxlength: 50
            },
            documentCategory: {
                maxlength: 50
            },
            lifeStage: {
                maxlength: 50
            },
            documentAuthor: {
                maxlength: 50
            },
            authorDept: {
                maxlength: 50
            },
            keyWord: {
                maxlength: 50
            },
            currentVersion: {
                maxlength: 50
            },
            lastVersion: {
                maxlength: 50
            },
            documentState: {
                maxlength: 50
            },
            languageCategory: {
                maxlength: 50
            },
            secretLevel: {
                maxlength: 50
            },
            documentAbstract: {
                maxlength: 1024
            },
            documentDescribe: {
                maxlength: 255
            },
            personLiable: {
                maxlength: 50
            },
            participants: {
                maxlength: 500
            },
            documentUpdateBy: {
                maxlength: 50
            },
            documentUpdateDate: {
                dateISO: true
            },
            belongProject: {
                maxlength: 50
            },
            warehouseCatelog: {
                maxlength: 50
            },
            knowScope: {
                maxlength: 500
            },
            documentLabel: {
                maxlength: 100
            },
            clickCount: {
                number: true
            },
            downloadCount: {
                number: true
            },
            commentCount: {
                number: true
            },
            evaluateScore: {
                number: true
            },
            shareCount: {
                number: true
            },
            likedCount: {
                number: true
            },
            documentUrl: {
                maxlength: 200
            },
        }
    });
}
/**
 * 保存方法
 */
DocumentItem.prototype.save = function (form, id, callback) {
    var _self = this;
    avicAjax.ajax({
        url: _self.getUrl() + "save",
        data: {data: JSON.stringify(serializeObject(form))},
        type: 'post',
        dataType: 'json',
        success: function (result) {
            if (result.flag == "success") {
                _self.reLoad();
                if(typeof(callback) == "function"){
                    callback(result.documentId);
                }
                layer.msg('保存成功！');
            } else {
                layer.alert('保存失败,请联系管理员!', {
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
};
/**
 * 删除方法
 */
DocumentItem.prototype.del = function () {
    var _self = this;
    var rows = $(_self._datagridId).jqGrid('getGridParam', 'selarrrow');
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        layer.confirm('确认要删除选中的数据吗?', {icon: 3, title: "提示", area: ['400px', '']}, function (index) {
            for (; l--;) {
                ids.push(rows[l]);
            }
            avicAjax.ajax({
                url: _self.getUrl() + 'delete',
                data: JSON.stringify(ids),
                contentType: 'application/json',
                type: 'post',
                dataType: 'json',
                success: function (r) {
                    if (r.flag == "success") {
                        _self.reLoad();
                    } else {
                        layer.alert('删除失败,请联系管理员!', {
                                icon: 7,
                                area: ['400px', ''],
                                closeBtn: 0,
                                btn: ['关闭'],
                                title: "提示"
                            }
                        );
                    }
                }
            });
            layer.close(index);
        });
    } else {
        layer.alert('请选择要删除的数据！', {
                icon: 7,
                area: ['400px', ''],
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
    }
};
/**
 * 重载数据
 */
DocumentItem.prototype.reLoad = function (pid) {
    if (pid != undefined) {
        this.pid = pid;
    }
    var searchdata = {pid: pid};
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
DocumentItem.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};
/**
 * 打开高级查询框
 */
DocumentItem.prototype.openSearchForm = function (searchDiv, par) {
    var _self = this;
    par = null;
    var contentWidth = 600;
    var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
    var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
    var text = $(searchDiv).text();
    var width = $(searchDiv).innerWidth();


    layer.config({
        extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
    });
    layer.open({
        type: 1,
        shift: 5,
        title: false,
        scrollbar: false,
        move: false,
        area: [contentWidth + 'px', '400px'],
        offset: [top + 'px', left + 'px'],
        closeBtn: 0,
        shadeClose: true,
        btn: ['查询', '清空', '取消'],
        content: $(_self._searchDialogId),
        success: function (layero, index) {
            var serachLabel = $('<div class="serachLabel"><span>' + text + '</span><span class="caret"></span></div>').appendTo(layero);
            serachLabel.bind('click', function () {
                layer.close(index);
            });
            serachLabel.css('width', width + 'px');
        },
        yes: function (index, layero) {
            _self.searchData();
            layer.close(index);
        },
        btn2: function (index, layero) {
            _self.clearData();
            return false;
        },
        btn3: function (index, layero) {

        }
    });
};

/**
 * 去后台查询
 */
DocumentItem.prototype.searchData = function (dataGridColModel) {
    /*新增代码，将表头搜索框内的搜索数据同步至高级搜索——开始*/
    if (dataGridColModel != undefined && dataGridColModel != null) {
        for (n = 0; n < dataGridColModel.length; n++) {
            var colName = dataGridColModel[n].name;

            //日期类型
            if (colName.endWith('Date')) {
                var headEle = document.getElementById(colName + 'Begin_head');
                var searchEle = document.getElementById(colName + 'Begin');

                if ((headEle != null && headEle != undefined) && (searchEle != null && searchEle != undefined)) {
                    searchEle.value = headEle.value;
                }

                headEle = document.getElementById(colName + 'End_head');
                searchEle = document.getElementById(colName + 'End');

                if ((headEle != null && headEle != undefined) && (searchEle != null && searchEle != undefined)) {
                    searchEle.value = headEle.value;
                }
            } else {
                var headEle = document.getElementById(colName + '_head');
                var searchEle = document.getElementById(colName);

                if ((headEle != null && headEle != undefined) && (searchEle != null && searchEle != undefined)) {
                    searchEle.value = headEle.value;
                }

                if (colName.indexOf('Alias') > -1) {
                    var headIdStr = colName.replace('Alias', '_head');
                    var searchIdStr = headIdStr.replace('_head', '');

                    var headEle1 = document.getElementById(headIdStr);
                    var searchEle1 = document.getElementById(searchIdStr);

                    if ((headEle1 != null && headEle1 != undefined) && (searchEle1 != null && searchEle1 != undefined)) {
                        searchEle1.value = headEle1.value;
                    }
                }
            }
        }
    }

    var datebox = $('.date-picker,.time-picker');
    var data = [];
    $.each(datebox, function (i, item) {
        data[i] = $(item).val();
    });
    for (var i = 0; i < (data.length / 2); i++) {
        if (data[2 * i] == "" || data[2 * i + 1] == "" || data[2 * i] == null || data[2 * i + 1] == null) {
            continue;
        }
        if (data[2 * i] > data[2 * i + 1]) {
            layer.alert("查询时,结束日期不能小于起始日期 ！", {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            });
            return;
        }
    }
    var searchdata = {
        keyWord: null,
        pid: this.pid,
        param: JSON.stringify(serializeObject($(this.searchForm)))
    };
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};

/**
 * 关键字段查询
 */
DocumentItem.prototype.searchByKeyWord = function () {
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
    var names = this._searchNames;

    var param = {};
    for (var i in names) {
        var name = names[i];
        param[name] = keyWord;
    }

    var searchdata = {
        keyWord: JSON.stringify(param),
        pid: this.pid,
        param: null
    };
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
}
/**
 * 隐藏查询框
 */
DocumentItem.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};
/**
 * 清空查询条件
 */
DocumentItem.prototype.clearData = function () {
    clearFormData(this.searchForm);
    this.searchData();
};

/*表头搜索、拖拽、视图模块新增代码——开始*/
/**
 * 打开视图选择框
 */
DocumentItem.prototype.openSelectView = function (selectBtn, contentWidth, contentHeight) {
    var _self = this;
    var _resizeFunc;

    var _top = $(selectBtn).offset().top + $(selectBtn).outerHeight(true);
    var _left = $(selectBtn).offset().left + $(selectBtn).outerWidth() - contentWidth;
    var _text = $(selectBtn).text();

    layer.open({
        type: 1,
        shift: 5,
        title: false,
        scrollbar: false,
        move: false,
        area: [contentWidth + 'px', contentHeight + 'px'],
        offset: [_top + 'px', _left + 'px'],
        closeBtn: 0,
        shadeClose: true,
        content: $('#selectViewDialog'),
        end: function () {
            $(window).unbind('resize', _resizeFunc);
        }
    });
};

/**
 * 添加视图页面
 */
DocumentItem.prototype.addView = function () {
    this.insertIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '添加视图',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'assets/device/usertablemodel/userTableModelController/operation/Add/DocumentItem/null'
    });
};

/**
 * 保存视图方法
 */
DocumentItem.prototype.saveView = function(form,id){
    var _self = this;
    avicAjax.ajax({
        url : "assets/device/usertablemodel/userTableModelController/operation/save",
        data : {data :JSON.stringify(serializeObject(form))},
        type : 'post',
        dataType : 'json',
        success : function(r){
            if (result.flag == "success"){
                _self.reLoad();
                if(id == "insert"){
                    id = result.viewName;
                    document.getElementById('tableViewSelect').value = result.viewName;
                    layer.close(_self.insertIndex);
                }
                else{
                    layer.close(_self.editIndex);
                }
                layer.msg('保存成功！');
            }
            else{
                layer.alert('保存失败,请联系管理员!', {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title:"提示"
                    }
                );
            }
        }
    });
};

/**
 * 更新列表视图
 */
function SubUpdateTableHead(dataGridColModel, currentView){
    var modelList = [];
    modelList.push('DocumentItem');
    modelList.push(currentView);

    for(var i = 0;i<dataGridColModel.length;i++){
        modelList.push(JSON.stringify(dataGridColModel[i]));
    }

    avicAjax.ajax({
        url : "assets/device/usertablemodel/userTableModelController/operation/save",
        data : JSON.stringify(modelList),
        contentType : 'application/json',
        type : 'post',
        dataType : 'json',
        success : function(r){
            document.getElementById('tableViewSelect').value = currentView;
            if (r.flag == "success"){
                layer.msg('视图更新成功！');
            }else{
                layer.alert('视图更新失败,请联系管理员：'+r.message, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title:"提示"
                    }
                );
                return;
            }
        }
    });
}

/**
 * 为表头元素添加拖拽、鼠标右键事件
 */
function SubBuildDrag(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId, jqGridObject, toolBar){
    //解决拖拽刷新列表后，列表上方的按钮、搜索框消失的问题
    var tool = document.getElementById('toolbar_' + tableId);

    if (tool == undefined || tool == null) {
        toolFather = document.getElementById('t_' + tableId);
        toolFather.innerHTML += toolBar.outerHTML;

        //添加按钮绑定事件
        $('#' + tableId + '_insert').bind('click', function () {
            jqGridObject.insert();
        });

        //查询按钮绑定事件
        $('#' + tableId + '_searchPart').bind('click', function () {
            jqGridObject.searchByKeyWord();
        });

        //搜索框enter事件监控：enter触发搜索
        $('#' + keywordId).on('keydown', function (e) {
            if (e.keyCode == '13') {
                jqGridObject.searchByKeyWord();
            }
        });

        //视图切换弹框绑定事件
        $('#tableViewSelect').bind('click', function(){
            jqGridObject.openSelectView(this,140,200);
        });
    }

    for (i = 0; i < dataGridColModel.length; i++) {
        thEle = document.getElementById(tableId + '_' + dataGridColModel[i].name);

        if (thEle == undefined || thEle == null) {
            continue;
        }

        //禁用元素的windows右键菜单
        thEle.addEventListener('contextmenu', function (event) {
            event.preventDefault();   // 阻止浏览器鼠标右击事件。
        }, false);

        //为表头元素添加拖拽事件
        thEle.onmousedown = function myMousedown(event) {
            var firstDragWidth = true;
            //鼠标左键按下事件
            if (event.which == 1) {
                //防止拖拽事件误触发
                var targetSrc = event.target.outerHTML;

                if (targetSrc.indexOf('Alias_head') > -1) {
                    var textFiledStr = event.target.id;
                    var idFiledStr = textFiledStr.replace('Alias', '');

                    if (targetSrc.indexOf('选择部门') > -1) {
                        new H5CommonSelect({
                            type: 'deptSelect',
                            idFiled: idFiledStr,
                            textFiled: textFiledStr,
                            selectModel: 'multi'
                        });
                        this.blur();
                        nullInput(event);
                    }
                    else if (targetSrc.indexOf('选择用户') > -1) {
                        new H5CommonSelect({
                            type: 'userSelect',
                            idFiled: idFiledStr,
                            textFiled: textFiledStr,
                            selectModel: 'multi'
                        });
                        this.blur();
                        nullInput(event);
                    }
                }
                else if (targetSrc.indexOf('selectCategory') > -1) {
                    var textFiledStr = event.target.id;
                    var idFiledStr = textFiledStr.replace('Names', '');

                    var lookupCode = targetSrc.substring(targetSrc.indexOf('lookupcode=') + 12);
                    lookupCode = lookupCode.substring(0, lookupCode.indexOf('"'));

                    //获取当前已选中的分类
                    var defaultLoadCategoryId = $('#' + idFiledStr).val();

                    new H5CommonSelect({
                        type: 'categorySelect',
                        idFiled: idFiledStr,
                        textFiled: textFiledStr,
                        selectModel: 'multi',
                        currentCategory: lookupCode,
                        defaultLoadCategoryId: defaultLoadCategoryId
                    });
                    this.blur();
                    nullInput(event);
                }
                else if (targetSrc.indexOf('selectLookup') > -1) {
                    var textFiledStr = event.target.id;
                    var idFiledStr = textFiledStr.replace('Names', '');

                    var lookupCode = targetSrc.substring(targetSrc.indexOf('lookupcode=') + 12);
                    lookupCode = lookupCode.substring(0, lookupCode.indexOf('"'));

                    //获取当前已选中的分类
                    var defaultLoadLookupId = $('#' + idFiledStr).val();

                    new H5CommonSelect({
                        type: 'lookupSelect',
                        idFiled: idFiledStr,
                        textFiled: textFiledStr,
                        selectModel: 'multi',
                        lookupcode: lookupCode,
                        defaultLookupcodeId: defaultLoadLookupId
                    });
                    this.blur();
                    nullInput(event);
                }

                if (targetSrc.indexOf('<input') == 0) {
                    return;
                }

                var event = event || window.event;  //兼容IE浏览器
                var dragIndex = -1;  //被拖拽表头的下标

                //点击的元素为搜索框图标元素
                if (targetSrc.indexOf('<span class="input-group-addon') == 0) {
                    return;
                }

                var currentView = $("#tableViewSelect").val();

                //点击的元素为列宽调整元素
                if (targetSrc.indexOf('<span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"') == 0) {
                    //鼠标移动结束后鼠标弹起事件
                    document.onmouseup = function (event) {
                        //更新dataGridColModel中的列宽
                        for (n = 1; n < dataGridColModel.length - 1; n++) {
                            var ele = document.getElementById(tableId + '_' + dataGridColModel[n].name);

                            dataGridColModel[n].width = ele.offsetWidth;
                        }

                        //更新视图，firstDragWidth防止死循环更新视图的问题
                        if (firstDragWidth) {
                            UpdateTableHead(dataGridColModel, currentView);
                            firstDragWidth = false;
                            return;
                        }

                    }
                }

                //点击的元素为非列宽调整元素及控件图标
                if (targetSrc.indexOf('<span') != 0 && targetSrc.indexOf('<i') != 0) {
                    var dragElementId = event.target.id;
                    var drag = document.getElementById(dragElementId);

                    if (typeof drag.setCapture !== 'undefined') {
                        drag.setCapture();
                    }

                    //鼠标移动结束后鼠标弹起事件
                    document.onmouseup = function (event) {
                        this.onmousemove = null;  //清除鼠标移动事件
                        this.onmouseup = null;  //清除鼠标按下事件

                        if (typeof drag.releaseCapture != 'undefined') {
                            drag.releaseCapture();
                        }

                        var toElementId = event.target.id;
                        //元素移动起始元素为同意元素，元素未移动
                        if (dragElementId == toElementId) {
                            return;
                        }

                        //元素移动
                        else {
                            var dragIndex = -1;
                            var newIndex = -1;

                            //获取移动元素和目标元素的下标
                            for (j = 0; j < dataGridColModel.length; j++) {
                                var tempId = dataGridColModel[j].name;

                                if (dragElementId.endWith('_' + tempId)) {
                                    dragIndex = j;
                                } else if (toElementId.endWith('_' + tempId)) {
                                    newIndex = j;
                                }

                                if ((dragIndex != -1) && (newIndex != -1)) {
                                    break;
                                }
                            }

                            if ((dragIndex == -1) || (newIndex == -1)) {
                                return;
                            }

                            //左移
                            if (dragIndex > newIndex) {
                                //更新表头数组
                                var dragEle = dataGridColModel[dragIndex];
                                for (m = dragIndex; m > newIndex; m--) {
                                    dataGridColModel[m] = dataGridColModel[m - 1];
                                    jqGridObject.dataGridColModel[m] = dataGridColModel[m - 1];
                                }
                                dataGridColModel[newIndex] = dragEle;

                                //清除列表后刷新
                                $.jgrid.gridUnload(tableId);
                                jqGridObject = new DocumentItem(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId);

                                //添加表头拖拽
                                SubBuildDrag(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId, jqGridObject, toolBar);

                                //添加表头搜索
                                SubAddHeaderSearch(dataGridColModel, tableId, jqGridObject);

                                //更新视图
                                SubUpdateTableHead(dataGridColModel, currentView);
                                return;
                            }

                            //右移
                            if (dragIndex < newIndex) {
                                //更新表头数组
                                var dragEle = dataGridColModel[dragIndex];
                                for (m = dragIndex; m < newIndex; m++) {
                                    dataGridColModel[m] = dataGridColModel[m + 1];
                                }
                                dataGridColModel[newIndex] = dragEle;

                                //清除列表后刷新
                                $.jgrid.gridUnload(tableId);
                                jqGridObject = new DocumentItem(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId);

                                //添加表头拖拽
                                SubBuildDrag(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId, jqGridObject, toolBar);

                                //添加表头搜索
                                SubAddHeaderSearch(dataGridColModel, tableId, jqGridObject);

                                //更新视图
                                SubUpdateTableHead(dataGridColModel, currentView);
                                return;
                            }
                        }
                    }
                }
            }

            //鼠标右键按下事件
            else if (event.which == 3) {
                showSelect('rightMenu');
            }
        }
    }
}

/**
 * 添加表头搜索
 */
function SubAddHeaderSearch(dataGridColModel, tableId, jqGridObject) {
    for (n = 0; n < dataGridColModel.length; n++) {
        var colName = dataGridColModel[n].name;
        var thEle = document.getElementById(tableId + '_' + colName);

        if ((thEle != null) && (thEle != undefined)) {
            thEle.style.height = '36px';

            //日期类型
            if (colName.endWith('Date')) {
                var searchEle = document.getElementById(colName + 'Begin').parentNode;
                var searchEleHtml = '<div>';

                if ((searchEle != undefined) && (searchEle != null)) {
                    searchEleHtml += '<div style="width:40%; float:left;">' + searchEle.outerHTML + '</div>';
                    searchEleHtml = searchEleHtml.replaceAll(colName + 'Begin', colName + 'Begin_head');
                }

                searchEleHtml += '<div style="width:15%; height:30px; float:left;  text-align:center; line-height:30px; ">至</div>';

                searchEle = document.getElementById(colName + 'End').parentNode;
                if ((searchEle != undefined) && (searchEle != null)) {
                    searchEleHtml += '<div style="width:40%; float:left; vertical-align:middle;">' + searchEle.outerHTML + '</div>';
                    searchEleHtml = searchEleHtml.replaceAll(colName + 'End', colName + 'End_head');
                }

                searchEleHtml = searchEleHtml.replaceAll('hasDatepicker', '');
                thEle.innerHTML = searchEleHtml + '</div>' + thEle.innerHTML;
            }
            //非日期类型
            else {
                var searchEle = document.getElementById(colName);

                if ((searchEle != undefined) && (searchEle != null)) {
                    var searchEleHtml = searchEle.outerHTML;

                    if (searchEleHtml.indexOf('<textarea') == 0) {
                        searchEleHtml = searchEleHtml.replace('id="' + colName + '"', 'id="' + colName + '_head"');
                        searchEleHtml = searchEleHtml.replace('name="' + colName + '"', 'name="' + colName + '_head"');

                        thEle.innerHTML = "<input title='" + dataGridColModel[n].label + "' class='form-control input-sm' type='text' name='" + colName + "_head' id='" + colName + "_head' />" + thEle.innerHTML;
                    } else if (searchEleHtml.indexOf('Alias') > -1) {
                        var parentNode = searchEle.parentNode;
                        searchEleHtml = parentNode.outerHTML;

                        searchEleHtml = searchEleHtml.replaceAll('Alias', 'Alias_head');

                        var colnumName = colName;
                        colnumName = colnumName.replace('Alias', '');

                        searchEleHtml = searchEleHtml.replace('id="' + colnumName + '"', 'id="' + colnumName + '_head"');
                        searchEleHtml = searchEleHtml.replace('name="' + colnumName + '"', 'name="' + colnumName + '_head"');

                        thEle.innerHTML = searchEleHtml + thEle.innerHTML;
                    } else if (searchEleHtml.indexOf('selectCategory') > -1 || searchEleHtml.indexOf('selectLookup') > -1) {
                        var parentNode = searchEle.parentNode;
                        searchEleHtml = parentNode.outerHTML;

                        var colnumName = colName;
                        searchEleHtml = searchEleHtml.replace('id="' + colnumName + 'Names"', 'id="' + colnumName + 'Names_head"');
                        searchEleHtml = searchEleHtml.replace('id="' + colnumName + '"', 'id="' + colnumName + '_head"');

                        searchEleHtml = searchEleHtml.replace('name="' + colnumName + 'Names"', 'name="' + colnumName + 'Names_head"');
                        searchEleHtml = searchEleHtml.replace('name="' + colnumName + '"', 'name="' + colnumName + '_head"');

                        thEle.innerHTML = searchEleHtml + thEle.innerHTML;
                    } else {
                        searchEleHtml = searchEleHtml.replace('id="' + colName + '"', 'id="' + colName + '_head"');
                        searchEleHtml = searchEleHtml.replace('name="' + colName + '"', 'name="' + colName + '_head"');

                        thEle.innerHTML = searchEleHtml + thEle.innerHTML;
                    }
                }
            }
        }
    }

    //表头搜索enter事件监控：enter触发搜索
    $('#' + tableId + '_id').parent().on('keydown', function (e) {
        if (e.keyCode == '13') {
            jqGridObject.searchData(dataGridColModel);
        }
    });
}
/*表头搜索、拖拽、视图模块新增代码——结束*/