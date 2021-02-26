/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
function AssetsUstdregisterProcDetail(form) {
    this._formId = "#" + form;
    DefaultForm.call(this);
};
AssetsUstdregisterProcDetail.prototype = new DefaultForm();
//formcode
AssetsUstdregisterProcDetail.prototype.formcode = "assetsUstdregisterProc";
//初始化操作
AssetsUstdregisterProcDetail.prototype.initFormData = function () {
    var _self = this;
    avicAjax.ajax({
        url: 'platform/assets/device/assetsustdregisterproc/assetsUstdregisterProcController/toDetailJsp.json',
        data: {
            id: _self.id
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                _self.setForm($(_self._formId), result.assetsUstdregisterProcDTO);
            } else {
                layer.msg('数据加载失败！');
            }
        }
    });
};
//启动流程
AssetsUstdregisterProcDetail.prototype.start = function (defineId, callback) {
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
    var dataVo = JSON.stringify(serializeObject($(_self._formId)));
    avicAjax.ajax({
        url: 'platform/assets/device/assetsustdregisterproc/assetsUstdregisterProcController/operation/saveAndStartProcess',
        data: {
            processDefId: defineId,
            formCode: _self.formcode,
            data: dataVo
        },
        type: 'POST',
        async: false,
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                var files = $('#attachment').uploaderExt('getUploadFiles');
                if (files != 0) {
                    //遮罩
                    var maskId = layer.load();
                    $("#id").val(result.startResult.formId);
                    afterUploadEvent = function () {
                        //去掉遮罩
                        layer.close(maskId);
                        // 启动成功后回调流程刷新按钮
                        callback(result.startResult);
                        //刷新页面
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.startResult.formId);
                } else {
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
//更新数据
AssetsUstdregisterProcDetail.prototype.save = function (callback) {
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
    var dataVo = JSON.stringify(serializeObject($(_self._formId)));
    avicAjax.ajax({
        url: 'platform/assets/device/assetsustdregisterproc/assetsUstdregisterProcController/operation/save',
        data: {
            data: dataVo
        },
        type: 'POST',
        async: false,
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                var files = $('#attachment').uploaderExt('getUploadFiles');
                if (files != 0) {
                    $("#id").val(result.id);
                    //遮罩
                    var maskId = layer.load();
                    //附件上传完毕后执行该方法
                    afterUploadEvent = function () {
                        //去掉遮罩
                        layer.close(maskId);
                        // 启动成功后回调流程刷新按钮
                        callback();
                        //刷新页面
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.id);
                } else {
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
//表单重载json对象数据
AssetsUstdregisterProcDetail.prototype.setForm = function (formObj, jsonValue) {
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
//控制附件
AssetsUstdregisterProcDetail.prototype.setAttachMagic = function (attachMagic) {
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
//流程控制-多附件必填
AssetsUstdregisterProcDetail.prototype.setAttachRequired = function (tagId, required, obj) {
    eval("this.attachRequiredMap." + tagId + " = " + required);
};

AssetsUstdregisterProcDetail.prototype.attachRequiredMap = {};
AssetsUstdregisterProcDetail.prototype.validAttachRequired = function () {
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

//多附件增删控制
AssetsUstdregisterProcDetail.prototype.setAttachCanAddOrDel = function (tagId, operability, obj) {
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
//控件校验   规则：表单字段name与rules对象保持一致
AssetsUstdregisterProcDetail.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            registerNo: {
                maxlength: 50
            },
            createdByDept: {
                maxlength: 50
            },
            createdByTel: {
                maxlength: 20
            },
            formState: {
                maxlength: 10
            },
            deviceName: {
                maxlength: 30
            },
            deviceCategory: {
                maxlength: 50
            },
            techIncharge: {
                maxlength: 50
            },
            projectDirector: {
                maxlength: 50
            },
            singleOrSet: {
                maxlength: 10
            },
            setCount: {
                number: true
            },
            budgetPrice: {
                number: true
            },
            financialEstimate: {
                number: true
            },
            financialResources: {
                maxlength: 10
            },
            belongProject: {
                maxlength: 50
            },
            projectNo: {
                maxlength: 50
            },
            simpleOrLarge: {
                maxlength: 10
            },
            installPosition: {
                maxlength: 200
            },
            isSatisfyBearing: {
                maxlength: 10
            },
            hasOutdoorUnit: {
                maxlength: 10
            },
            isAllowOutdoorunit: {
                maxlength: 10
            },
            hasFoundation: {
                maxlength: 255
            },
            useVoltage: {
                maxlength: 50
            },
            hasVoltageCondition: {
                maxlength: 10
            },
            hasHumidityNeed: {
                maxlength: 10
            },
            humidityNeed: {
                maxlength: 1024
            },
            hasCleanlinessNeed: {
                maxlength: 10
            },
            cleanlinessNeed: {
                maxlength: 1024
            },
            hasWaterNeed: {
                maxlength: 10
            },
            waterNeed: {
                maxlength: 1024
            },
            hasGasNeed: {
                maxlength: 10
            },
            gasNeed: {
                maxlength: 1024
            },
            hasLetNeed: {
                maxlength: 10
            },
            letNeed: {
                maxlength: 1024
            },
            hasOtherNeed: {
                maxlength: 10
            },
            otherNeed: {
                maxlength: 1024
            },
            hasAboveConditions: {
                maxlength: 10
            },
            supplementaryNotes: {
                maxlength: 1024
            },
        }
    });
}

/**
 * 添加技改项目页面
 */
AssetsUstdregisterProcDetail.prototype.toRelateTechTransformProject = function () {
    this.insertIndex = layer.open({
        type: 2,
        area: ['900px', '600px'],
        title: '关联技改项目',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'platform/assets/device/assetstechtransformproject/assetsTechTransformProjectController/toRelateTechTransformProject'
    });
};


/**
 * 关联技改项目
 */
AssetsUstdregisterProcDetail.prototype.relateTechTransformProject = function (rowData) {
    document.getElementById('projectNo').value = rowData.projectNo;

    var projectName = rowData.ttProjectName;
    projectName = projectName.replaceAll('</a>', '');
    projectName = projectName.substring(projectName.indexOf('>') + 1);
    document.getElementById('belongProject').value = projectName;

    layer.close(this.insertIndex);
};
