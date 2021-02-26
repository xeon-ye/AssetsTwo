/**
 * 单表列表
 * @param datagrid 表格Id
 * @param url URL参数
 * @param searchDialogId 高级查询Id
 * @param form 高级查询formId
 * @param keyWordId 关键字查询框Id
 * @param searchNames 关键字查询项名称Array
 * @param dataGridColModel 表格列属性Array
 */
function AssetsDeviceAcheckProcSelect(datagrid, url, searchDialogId, form, keyWordId, searchNames, dataGridColModel) {
    if (!datagrid || typeof(datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = 'platform/assets/device/assetsdeviceacccheck/assetsDeviceAccCheckController/operation/';
    this.getUrl = function () {
        return _url;
    }
    this._datagridId = "#" + datagrid;
    this._jqgridToolbar = "#t_" + datagrid;
    this._doc = document;
    this._formId = "#" + form;
    this._searchDialogId = "#" + searchDialogId;
    this._keyWordId = "#" + keyWordId;
    this._searchNames = searchNames;
    this.dataGridColModel = dataGridColModel;
    this.notnullFiled = [];//非空字段
    this.notnullFiledComment = []; //非空字段注释
    //除时间,数字等类型长度校验字段
    this.lengthValidFiled = [];
    //除时间,数字等类型长度校验字段注释
    this.lengthValidFiledComment = [];
    //除时间,数字等类型长度
    this.lengthValidFiledSize = [];
    this.init.call(this);
};

var unifiedId ='';//统一编号全局变量

/**
 * 初始化操作
 */
AssetsDeviceAcheckProcSelect.prototype.init = function () {
    var _self = this;

    /*初始化即按统一编号查询-begin*/
    var names = this._searchNames;

    var param = {};
    for (var i in names) {
        var name = names[i];
        param[name] = unifiedId;
    }
    var item = sessionStorage.getItem("param");
    var obj= JSON.parse(item);
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(obj)
    }
    /*初始化即按统一编号查询-end*/

    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getAssetsDeviceAccChecksByPage.json',
        mtype: 'POST',

        //查询数据
        postData: searchdata,

        datatype: "json",
        toolbar: [true, 'top'],//启用toolbar
        colModel: _self.dataGridColModel,//表格列的属性
        height: $("#acCheckIframe").height(),//初始化表格高度        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20,//每页条数
        rowList: [200, 100, 50, 30, 20, 10],//每页条数可选列表
        altRows: true,//斑马线
        pagerpos: 'left',//分页栏位置
        hasColSet: false,//设置显隐属性
        loadComplete: function () {
            $(this).jqGrid('getColumnByUserIdAndTableName');
        },
        styleUI: 'Bootstrap', //Bootstrap风格
        viewrecords: true, //是否要显示总记录数
        multiselect: true,//可多选
        autowidth: true,//列宽度自适应
        responsive: true,//开启自适应
        pager: "#jqGridPager",
        cellEdit: false,
        cellsubmit: 'clientArray'
    });

    //放入表格toolbar中
    $(_self._jqgridToolbar).append($("#tableToolbar"));

    //初始化时间控件
    $('.date-picker').datepicker({
        beforeShow: function () {
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
    $('.time-picker').datetimepicker({
        oneLine: true,//单行显示时分秒
        showButtonPanel: true,//是否展示功能按钮面板
        closeText: '确定',
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
    //初始化校验字段
    _self.notnullFiled.push("unifiedId");
    _self.notnullFiledComment.push("统一编号");
    _self.lengthValidFiled.push("unifiedId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("统一编号");
    _self.notnullFiled.push("deviceName");
    _self.notnullFiledComment.push("设备名称");
    _self.lengthValidFiled.push("deviceName");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备名称");
    _self.lengthValidFiled.push("deviceCategory");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("设备类别");
    _self.lengthValidFiled.push("deviceModel");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备型号");
    _self.lengthValidFiled.push("positionId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("安装地点");
    _self.lengthValidFiled.push("productArea");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("产地");
    _self.lengthValidFiled.push("userId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("使用人");
    _self.lengthValidFiled.push("userDept");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("使用人部门");
    _self.lengthValidFiled.push("attachment");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("附件");
};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
AssetsDeviceAcheckProcSelect.prototype.insert = function () {
    var _self = this;
    var $info = $(_self._datagridId).jqGrid('endEditCell');
    if ($info[0].flag) {
        layer.alert("非法含有JS脚本完整标签");
        return false;
    }
    var hasvalidate = true;
    var data = $(_self._datagridId).jqGrid('getRowData');
    if (data.length > 0 && _self.notnullFiled.length > 0) {
        $.each(_self.notnullFiled, function (i, item) {
            var msg = _self.nullvalid(data, item, _self.notnullFiled, _self.notnullFiledComment);
            if (msg && msg.length > 0) {
                layer.alert(msg, {
                    icon: 7,
                    area: ['400px', ''], // 宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title: "提示"
                });
                hasvalidate = false;
                return false;
            }
        });
    }
    if (!hasvalidate) {
        return false;
    }

    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: {},
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    };
    $(_self._datagridId).jqGrid('addRow', parameters);
    newRowIndex++;
};

/**
 * 非空验证
 * @param
 * @param
 */
AssetsDeviceAcheckProcSelect.prototype.nullvalid = function (data, item, nullfiled, notnullFiledComment) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] == "") {
            temp = false;
            msg = notnullFiledComment[$.inArray(item, nullfiled)] + "为必填字段";
        }
    })
    return msg;
}
/**
 * 长度验证
 * @param
 * @param
 */
AssetsDeviceAcheckProcSelect.prototype.lengthvalid = function (data, item, lengthValidFiled, lengthValidFiledComment, lengthValidFiledSize) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] != "" && dataitem[item] != undefined && dataitem[item].replace(/[^\x00-\xff]/g, "**").length > lengthValidFiledSize[$.inArray(item, lengthValidFiled)]) {
            msg = lengthValidFiledComment[$.inArray(item, lengthValidFiled)] + "的输入长度超过预设长度" + lengthValidFiledSize[$.inArray(item, lengthValidFiled)];
        }
    })
    return msg;
}

/**
 * 保存功能
 * @param form
 * @param callback
 */
AssetsDeviceAcheckProcSelect.prototype.save = function () {
    var _self = this;
    var $info = $(_self._datagridId).jqGrid('endEditCell');
    if ($info[0].flag) {
        layer.alert("非法含有JS脚本完整标签");
        return false;
    }
    var data = $(_self._datagridId).jqGrid('getChangedCells');
    var hasvalidate = true;
    $.each(_self.notnullFiled, function (i, item) {
        var msg = _self.nullvalid(data, item, _self.notnullFiled, _self.notnullFiledComment);
        if (msg && msg.length > 0) {
            layer.alert(msg, {
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title: "提示"
                }
            );
            hasvalidate = false;
            return false;
        }
    });
    $.each(_self.lengthValidFiled, function (i, item) {
        if (hasvalidate) {
            var msg = _self.lengthvalid(data, item, _self.lengthValidFiled, _self.lengthValidFiledComment, _self.lengthValidFiledSize);
            if (msg && msg.length > 0) {
                layer.alert(msg, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title: "提示"
                    }
                );
                hasvalidate = false;
                return false;
            }
        }
    });
    if (!hasvalidate) {
        return false;
    }
    if (data && data.length > 0) {
        for (var i = 0; i < data.length; i++) {
            if (data[i].id.indexOf(newRowStart) > -1) {
                data[i].id = '';
            }
        }

        avicAjax.ajax({
            url: _self.getUrl() + "save",
            data: {data: JSON.stringify(data)},
            type: 'post',
            dataType: 'json',
            success: function (r) {
                if (r.flag == "success") {
                    _self.reLoad();
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
    } else {
        layer.alert('请先修改数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
    }
};

/**
 * 详细页
 * @param id
 */
AssetsDeviceAcheckProcSelect.prototype.detail = function (id) {
    this.detailIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '详细',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //不显示最大化最小化按钮
        content: this.getUrl() + 'Detail/' + id
    });
};


/**
 * 删除
 */
AssetsDeviceAcheckProcSelect.prototype.del = function () {
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
                area: ['400px', ''], //宽高
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
AssetsDeviceAcheckProcSelect.prototype.reLoad = function () {
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(serializeObject($(this._formId)))
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};


/**
 * 打开高级查询框
 * @param searchBtn 高级查询按钮HTMLObject对象
 * @param contentWidth 高级查询框宽度
 * @param contentHeight 高级查询框高度
 */
AssetsDeviceAcheckProcSelect.prototype.openSearchForm = function (searchDiv) {
    var _self = this;
    var contentWidth = 800;
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
            layer.close(index);//查询框关闭
        },
        btn2: function (index, layero) {
            clearFormData(_self._formId); //清空数据
            _self.searchData(); //查询
            return false;
        },
        btn3: function (index, layero) {

        }
    });
};

/**
 * 高级查询
 */
AssetsDeviceAcheckProcSelect.prototype.searchData = function () {
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
        param: JSON.stringify(serializeObject($(this._formId)))
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};

/**
 * 关键字查询
 */
AssetsDeviceAcheckProcSelect.prototype.searchByKeyWord = function () {
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
    var names = this._searchNames;

    var param = {};
    for (var i in names) {
        var name = names[i];
        param[name] = keyWord;
    }

    var searchdata = {
        keyWord: JSON.stringify(param),
        param: null
    }

    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
}
AssetsDeviceAcheckProcSelect.prototype.submit = function(){
    var item = sessionStorage.getItem("param");
    var obj= JSON.parse(item);
    var _self = this;
    if(!callBackFn){
        layer.alert('找不到回调函数！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title:"提示"
        });
        return false;
    }
    var selectedRow = [];
    var selectIds = $(_self._datagridId).jqGrid("getGridParam","selarrrow");
    if(selectIds.length == 0){
        layer.alert('请选择要提交的数据！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title:"提示"
        });
        return false;
    }else if(selectIds.length > 1){
        if(singleSelect =='true'){
            layer.alert('只允许选择一条数据！', {
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title:"提示"
                }
            );
            return false;
        }
    }


    parent[callBackFn](selectIds.join(','), obj.nextAccCheckDateEnd,requestType);
}