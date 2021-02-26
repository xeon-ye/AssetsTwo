/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
function AssetsDeviceMcheckProcDetail(form, AssetsDeviceMcheckPlan) {
    this._formId = "#" + form;
    this.AssetsDeviceMcheckPlan = AssetsDeviceMcheckPlan;
    this._formId = "#" + form;
    DefaultForm.call(this);
};
AssetsDeviceMcheckProcDetail.prototype = new DefaultForm();
AssetsDeviceMcheckProcDetail.prototype.formcode = "assetsDeviceMcheckProc";
/**
 * 初始化操作
 */
AssetsDeviceMcheckProcDetail.prototype.initFormData = function () {
    var _self = this;
    _self.isLoading = true;
    avicAjax.ajax({
        url: 'platform/assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/toDetailJsp.json',
        data: {
            id: _self.id
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                _self.setForm($(_self._formId), result.assetsDeviceMcheckProcDTO);
            } else {
                layer.msg('数据加载失败！');
            }
        }
    });
};
/**
 * 启动流程
 */
AssetsDeviceMcheckProcDetail.prototype.start = function (defineId, callback) {
    var _self = this;
    if (!_self.validAttachRequired()) {
        return false;
    }
    //主表表单校验
    var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        $(isValidate.errorList[0].element).focus();
        return false;
    }
    //子表校验
    var msg = _self.AssetsDeviceMcheckPlan.valid();
    if (msg && msg != "") {
        layer.alert(msg, {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title: "提示"
        });
        return false;
    }
    //主表数据
    var dataVo = JSON.stringify(serializeObject($(_self._formId)));
    //子表数据
    var dataSub = _self.AssetsDeviceMcheckPlan.getSubData();
    avicAjax.ajax({
        url: 'platform/assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/operation/saveAndStartProcess',
        data: {
            processDefId: defineId,
            formCode: _self.formcode,
            data: dataVo,
            dataSub: dataSub
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                var files = $('#attachment').uploaderExt('getUploadFiles');
                //验证附件密级
                for (var i = 0; i < files.length; i++) {
                    var name = files[i].name;
                    var secretLevel = files[i].secretLevel;
                    //这里验证密级
                }
                if (files.length != 0) {
                    //遮罩
                    var maskId = layer.load();
                    afterUploadEvent = function () {
                        //去掉遮罩
                        layer.close(maskId);
                        $('#id').val(result.startResult.formId);
                        //子表刷新,不然更新时会缺少子表ID
                        _self.AssetsDeviceMcheckPlan.reLoad(result.startResult.formId);
                        // 启动成功后回调流程刷新按钮
                        callback(result.startResult);
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.startResult.formId);
                } else {
                    $('#id').val(result.startResult.formId);
                    //子表刷新,不然更新时会缺少子表ID
                    _self.AssetsDeviceMcheckPlan.reLoad(result.startResult.formId);
                    // 启动成功后回调流程刷新按钮
                    callback(result.startResult);
                    _self.initFormData();
                }
            } else {
                layer.msg('保存失败！');
            }
        }
    });
};
/**
 * 更新数据
 */
AssetsDeviceMcheckProcDetail.prototype.save = function (callback) {
    var _self = this;
    //表单校验
    var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        $(isValidate.errorList[0].element).focus();
        return false;
    }
    //附件权限校验
    if (!_self.validAttachRequired()) {
        return false;
    }
    //子表校验
    var msg = _self.AssetsDeviceMcheckPlan.valid();
    if (msg && msg != "") {
        layer.alert(msg, {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title: "提示"
        });
        return false;
    }
    //主表数据
    var dataVo = JSON.stringify(serializeObject($(_self._formId)));
    //子表数据
    var dataSub = _self.AssetsDeviceMcheckPlan.getSubData();
    avicAjax.ajax({
        url: 'platform/assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/operation/save',
        data: {
            data: dataVo,
            dataSub: dataSub
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                var files = $('#attachment').uploaderExt('getUploadFiles');
                //验证附件密级
                for (var i = 0; i < files.length; i++) {
                    var name = files[i].name;
                    var secretLevel = files[i].secretLevel;
                    //这里验证密级
                }
                if (files.length != 0) {
                    //遮罩
                    var maskId = layer.load();
                    afterUploadEvent = function () {
                        //去掉遮罩
                        layer.close(maskId);
                        //子表刷新,不然更新时会缺少子表ID
                        _self.AssetsDeviceMcheckPlan.reLoad(result.pid);
                        // 启动成功后回调流程刷新按钮
                        callback();
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.pid);
                } else {
                    //子表刷新,不然更新时会缺少子表ID
                    _self.AssetsDeviceMcheckPlan.reLoad(result.pid);
                    // 启动成功后回调流程刷新按钮
                    callback();
                    _self.initFormData();
                }
            } else {
                layer.msg('保存失败！');
            }
        }
    });
};
/**
 * 表单重载json对象数据
 */
AssetsDeviceMcheckProcDetail.prototype.setForm = function (formObj, jsonValue) {
    var obj = formObj;
    $.each(jsonValue, function (name, ival) {
        var oinput = obj.find("input[name=" + name + "]");
        if (oinput.attr("type") == "checkbox") {
            if (ival !== null) {
                var checkboxObj = $("[name=" + name + "]");
                var checkArray = ival.length > 0 ? ival.split(",") : ival;
                for (var i = 0; i < checkboxObj.length; i++) {
                    checkboxObj[i].checked = false;
                    for (var j = 0; j < checkArray.length; j++) {
                        if (checkboxObj[i].value == checkArray[j]) {
                            checkboxObj[i].checked = true;
                        }
                    }
                }
            }
        } else if (oinput.attr("type") == "radio") {
            oinput.each(function () {
                var radioObj = $("[name=" + name + "]");
                for (var i = 0; i < radioObj.length; i++) {
                    if (radioObj[i].value == ival) {
                        radioObj[i].checked = true;
                    }
                }
            });
        } else if ($(oinput).attr('class') == "form-control date-picker hasDatepicker") {
            if (ival != "" && ival != null) {
                obj.find("[name=" + name + "]").datepicker("setDate", new Date(ival));
            }
        } else if ($(oinput).attr('class') == "form-control time-picker hasDatepicker") {
            obj.find("[name=" + name + "]").val(ival);
        } else {
            obj.find("[name=" + name + "]").val(ival);
        }
    });
};
/**
 * 控制附件
 */
AssetsDeviceMcheckProcDetail.prototype.setAttachMagic = function (attachMagic) {
    //当流程节点配置是否允许附件功能时候，隐藏上传、下载按钮等
    if (attachMagic) {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "");
        });
        $('div.uploader-file-item').unbind("mouseover");
    } else {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "none");
        });
        $('div.uploader-file-item').bind('mouseover', function () {
            $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
        });
    }
};
/**
 * 流程控制-多附件必填
 */
AssetsDeviceMcheckProcDetail.prototype.setAttachRequired = function (tagId, required, obj) {
    eval("this.attachRequiredMap." + tagId + " = " + required);
};
AssetsDeviceMcheckProcDetail.prototype.attachRequiredMap = {};
AssetsDeviceMcheckProcDetail.prototype.validAttachRequired = function () {
    for (var tagId in this.attachRequiredMap) {
        if (this.attachRequiredMap[tagId]) {
            var itemListNum = $('#' + tagId).find('.uploader-file-item').size();
            if (itemListNum == 0) {
                layer.alert("附件不能为空！", {
                    title: "提示",
                    icon: 7
                });
                return false;
            }
        }
    }
    return true;
};

/**
 * 多附件增删控制
 */
AssetsDeviceMcheckProcDetail.prototype.setAttachCanAddOrDel = function (tagId, operability, obj) {
    if (operability) {
        $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "");
        });
        $('#' + tagId).find('div.uploader-file-item').unbind("mouseover");
    } else {
        $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "none");
        });
        $('#' + tagId).find('div.uploader-file-item').bind('mouseover', function () {
            $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
        });
    }
};
/**
 * 控制子表toolbar是否可用和子表数据是否可编辑
 */
AssetsDeviceMcheckProcDetail.prototype.controlSelfElement = function (tagId, operability, obj) {
    if (operability) {
        if (tagId == "assetsDeviceMcheckPlan_editable") {//判断是否允编辑子表数据
            //获取colModel数组对象
            var columnArray = $('#assetsDeviceMcheckPlan').jqGrid('getGridParam', 'colModel');
            //给每个colModel属性列设置可编辑
            $.each(columnArray, function (i, item) {
                $('#assetsDeviceMcheckPlan').setColProp(item.name, {editable: true});
            });
        } else {
            $("#" + tagId).show();
        }
    } else {
        $("#" + tagId).hide();
    }
}
/**
 * 非电子表单子表字段的显隐控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param operability 是否可显示
 * @param obj 参数对象
 */
AssetsDeviceMcheckProcDetail.prototype.controlCustomSubTableForAccess = function (tagId, operability, obj) {
    var tagArr = obj.tag.split("__");
    var subTableName = tagArr[0];
    var subTableId = $("table[name=" + subTableName + "]")[0].id
    var tag = "#" + subTableId;
    if (operability) {
        $(tag).showCol(tagId);
    } else {
        $(tag).hideCol(tagId);
    }
}
/**
 * 非电子表单子表字段的可编辑控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 * @param obj 参数对象
 */
AssetsDeviceMcheckProcDetail.prototype.controlCustomSubTableForOperability = function (tagId, operability, obj) {
    var tagArr = obj.tag.split("__");
    var subTableName = tagArr[0];
    var subTableId = $("table[name=" + subTableName + "]")[0].id
    var tag = "#" + subTableId;
    if (operability) {
        $(tag).setColProp(tagId, {editable: true});
    } else {
        $(tag).setColProp(tagId, {editable: false});
    }
}
/**
 * 非电子表单子表字段的必填控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 * @param obj 参数对象
 */
AssetsDeviceMcheckProcDetail.prototype.controlCustomSubTableForRequired = function (tagId, operability, obj) {
    //获取必填字段数组
    var notnullFiledArr = this.AssetsDeviceMcheckPlan.notnullFiled;
    var notnullFiledCommentArr = this.AssetsDeviceMcheckPlan.notnullFiledComment;
    var tagValue = tagId;
    if (tagValue.lastIndexOf("Alias") > -1) {
        tagValue = tagValue.substring(0, tagId.lastIndexOf("Alias"));
    } else if (tagId.lastIndexOf("Name") > -1) {
        tagValue = tagValue.substring(0, tagId.lastIndexOf("Name"));
    }
    if (notnullFiledArr.indexOf(tagValue) > -1 && !operability) {
        //配置错误
        layer.alert("流程建模必填项配置错误!");
        return false;
    }
    if (operability) {
        //添加必填
        var tagArr = obj.tag.split("__");
        var subTableName = tagArr[0];
        var subTableId = $("table[name=" + subTableName + "]")[0].id
        var tag = "#" + subTableId;
        $(tag).setLabel(tagId, '<span style="color:red;">*</span>' + obj.tagName, '');
        notnullFiledArr.push(tagId);
        notnullFiledCommentArr.push(obj.tagName);
    }
}
/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
AssetsDeviceMcheckProcDetail.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            maintainCode: {
                maxlength: 50
            },
            planName: {
                maxlength: 50
            },
            maintainNumber: {
                number: true
            },
            generateDate: {
                dateISO: true
            },
            implementationDepartment: {
                maxlength: 50
            },
            generateBy: {
                maxlength: 50
            },
            nextMaintainDateBegin: {
                dateISO: true
            },
            nextMaintainDateEnd: {
                dateISO: true
            },
            attachment: {
                maxlength: 50
            },
        }
    });
}


/* 设备通用选择框选择回填 */
function addAssetsRow(rowJson) {
    //获取待调拨台账定检计划列表中的数据
    var allData = $('#assetsDeviceMcheckPlan').jqGrid('getRowData');

    //判断待调拨台账定检计划列表中的数据是否为空
    if ((allData != null) && (allData != undefined) && (allData.length > 0)) {
        for (j = 0; j < allData.length; j++) {
            //判断待调拨的设备是否已添加
            if (allData[j].unifiedId == rowJson.unifiedId) {
                layer.msg('编号' + rowJson.unifiedId + '的设备已添加！');
                return;
            }
        }
    }
    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: rowJson,
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    };
    $('#assetsDeviceMcheckPlan').jqGrid('addRow', parameters);

    newRowIndex++;
};

//弹框选择设备台账定检的回调函数
function callBackFn(rows, endDate, requestType) {
    switch (requestType) {
        case "productModelSelect":
            avicAjax.ajax({
                url: 'platform/assets/device/assetsdevicemchecktemporary/assetsDeviceMcheckTemporaryController/operation/deleteAll',
                data: {},
                type: 'POST',
                dataType: 'JSON',
                success: function (result) {
                    avicAjax.ajax({
                        url: 'platform/assets/device/assetsdevicemchecktemporary/assetsDeviceMcheckTemporaryController/operation/saveOrSelect',
                        data: {
                            ids: rows, endDate: endDate
                        },
                        type: 'POST',
                        dataType: 'JSON',
                        success: function (result) {
                            var _self = this;
                            $('#assetsDeviceMcheckPlan').jqGrid(
                                'setGridParam', {
                                    url: 'platform/assets/device/assetsdevicemchecktemporary/assetsDeviceMcheckTemporaryController/operation/getAssetsDeviceMcheckTemporarysByPage',
                                    mtype: 'POST',
                                    multiselect: true,
                                    datatype: "json",
                                    toolbar: [true, 'top'],
                                    colModel: _self.dataGridColModel,
                                    scrollOffset: 10,
                                    rowNum: 20,
                                    rowList: [200, 100, 50, 30, 20, 10],
                                    altRows: true,
                                    userDataOnFooter: true,
                                    pagerpos: 'left',
                                    hasColSet: false,//设置显隐属性
                                    styleUI: 'Bootstrap',
                                    viewrecords: true,
                                    multiboxonly: true,
                                    autowidth: true,
                                    shrinkToFit: true,
                                    responsive: true,
                                    pager: _self.Pagerlbar,
                                    onSelectAll: function () {
                                        _self.clickRowLoad("");
                                    },
                                    onSelectRow: function (rowid, status) {
                                        var rows = $(_self._datagridId).jqGrid('getGridParam',
                                            'selarrrow');
                                        if (issubinit && rows.length == 1) {
                                            _self.clickRowLoad(rows[0]);
                                        } else {
                                            if (issubinit) {
                                                _self.clickRowLoad("");
                                            }
                                        }
                                    }
                                }).trigger("reloadGrid");
                        }
                    });
                }
            });

            break;
        case "productSerySelect":
            $('#seryCode').val(row.seryCode);
            $('#seriesId').val(row.id);
            break;
    }

    closeLayer(openIndex);
}

//弹窗关闭函数
function closeLayer() {
    layer.close(openIndex);


}

/**
 * 设备台账定检信息选择框
 * param:
 *  singleSelect -是否单选（true-单选，false为多选；字符串）；
 *  requestType-页面请求标记，用于同一页面有多个相同弹出页时，调用回调函数赋值时使用，可为空字符串，代码默认取值‘productModelSelect’；
 *  callBackFn-回调函数名称，用户声明的“弹框选择设备台账的回调函数”的函数名字符串；
 */
function openProductModelLayer(singleSelect, requestType, callBackFn, param) {
    sessionStorage.setItem("param", param);
    this.openIndex = layer.open({
        type: 2,
        area: ['60%', '70%'],
        title: '台账定检信息选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetsdevicemcheckproc/AssetsDeviceMcheckProcSelect.jsp?singleSelect=" + singleSelect + "&requestType=" + requestType + "&callBackFn=" + callBackFn

    });
};
