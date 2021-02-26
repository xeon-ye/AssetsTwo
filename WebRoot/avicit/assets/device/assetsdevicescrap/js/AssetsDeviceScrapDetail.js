/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
function AssetsDeviceScrapDetail(form){
	this._formId="#"+form;
	DefaultForm.call(this);
};
AssetsDeviceScrapDetail.prototype = new DefaultForm();
//formcode
AssetsDeviceScrapDetail.prototype.formcode = "deviceScrap";
//初始化操作
AssetsDeviceScrapDetail.prototype.initFormData = function(){
	var _self = this;
	avicAjax.ajax({
		url : 'platform/assets/device/assetsdevicescrap/assetsDeviceScrapController/toDetailJsp.json',
		data : {
			id : _self.id
		},
		type : 'POST',
		dataType : 'JSON',
		success : function(result) {
			if (result.flag == "success") {
				_self.setForm($(_self._formId),result.assetsDeviceScrapDTO);
			} else {
				layer.msg('数据加载失败！');
			}
		}
	});
};
//启动流程
AssetsDeviceScrapDetail.prototype.start = function(defineId, callback){
	var _self = this;
    //表单校验
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		$(isValidate.errorList[0].element).focus();
		return false;
	}
	//附件权限校验
	if(!_self.validAttachRequired()){
        return false;
    }
	var dataVo = JSON.stringify(serializeObject($(_self._formId)));
	avicAjax.ajax({
		url : 'platform/assets/device/assetsdevicescrap/assetsDeviceScrapController/operation/saveAndStartProcess',
		data : {
			processDefId : defineId,
			formCode : _self.formcode,
			data : dataVo
		},
		type : 'POST',
		async: false,
		dataType : 'JSON',
		success : function(result) {
			if (result.flag == "success") {
				var files = $('#attachment').uploaderExt('getUploadFiles');
				if(files != 0){
					//遮罩
					var maskId = layer.load();
					$("#id").val(result.startResult.formId);
					afterUploadEvent = function(){
						//去掉遮罩
						layer.close(maskId);
						// 启动成功后回调流程刷新按钮
						callback(result.startResult);
						//刷新页面
						_self.initFormData();
					};
					$('#attachment').uploaderExt('doUpload', result.startResult.formId);
				}else{
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
AssetsDeviceScrapDetail.prototype.save=function(callback){
	var _self = this;
	//表单校验
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		$(isValidate.errorList[0].element).focus();
		return false;
	}
	//附件权限校验
	if(!_self.validAttachRequired()){
        return false;
    }
	var dataVo = JSON.stringify(serializeObject($(_self._formId)));
	avicAjax.ajax({
		url : 'platform/assets/device/assetsdevicescrap/assetsDeviceScrapController/operation/save',
		data : {
			data : dataVo
		},
		type : 'POST',
		async: false,
		dataType : 'JSON',
		success : function(result) {
			if (result.flag == "success") {
				var files = $('#attachment').uploaderExt('getUploadFiles');
				if(files != 0){
					$("#id").val(result.id);
					//遮罩
					var maskId = layer.load();
					//附件上传完毕后执行该方法
					afterUploadEvent = function(){
						//去掉遮罩
						layer.close(maskId);
						// 启动成功后回调流程刷新按钮
						callback();
						//刷新页面
						_self.initFormData();
					};
					$('#attachment').uploaderExt('doUpload', result.id);
				}else{
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
AssetsDeviceScrapDetail.prototype.setForm = function(formObj, jsonValue){
    var obj = formObj;
    $.each(jsonValue, function (name, ival) {
        var oinput = obj.find("input[name=" + name + "]");
        if (oinput.attr("type") == "checkbox") {
            if (ival !== null) {
                var checkboxObj = $("[name=" + name + "]");
                var checkArray = ival.length > 0 ?ival.split(",") : ival;
                for (var i = 0; i < checkboxObj.length; i++) {
             	    checkboxObj[i].checked = false;
                    for (var j = 0; j < checkArray.length; j++) {
                        if (checkboxObj[i].value == checkArray[j]) {
                     	   checkboxObj[i].checked=true;
                        }
                    }
                } 
            }
        }else if (oinput.attr("type") == "radio") {
            oinput.each(function () {
                var radioObj = $("[name=" + name + "]");
                for (var i = 0; i < radioObj.length; i++) {
                    if (radioObj[i].value == ival) {
                 	   radioObj[i].checked=true;
                    }
                }
            });
        }else if ($(oinput).attr('class') == "form-control date-picker hasDatepicker"){
        	if(ival !="" && ival !=null){
        		obj.find("[name=" + name + "]").datepicker("setDate", new Date(ival));
        	}
        }else if ($(oinput).attr('class') == "form-control time-picker hasDatepicker"){
     	   obj.find("[name=" + name + "]").val(ival);
        }else {
            obj.find("[name=" + name + "]").val(ival);
        }
    });
};
//控制附件
AssetsDeviceScrapDetail.prototype.setAttachMagic = function(attachMagic) {
    //当流程节点配置是否允许附件功能时候，隐藏上传、下载按钮等
	if(attachMagic) {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "");
        });
        $('div.uploader-file-item').unbind("mouseover");
    }
    else {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "none");
        });
        $('div.uploader-file-item').bind('mouseover',function(){
            $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
        });
    }
};
//流程控制-多附件必填
AssetsDeviceScrapDetail.prototype.setAttachRequired = function(tagId,required,obj){
     eval("this.attachRequiredMap." + tagId + " = " + required);
};

AssetsDeviceScrapDetail.prototype.attachRequiredMap = {};
AssetsDeviceScrapDetail.prototype.validAttachRequired = function(){
	for(var tagId in this.attachRequiredMap){
			if(this.attachRequiredMap[tagId]){
	            var itemListNum = $('#' + tagId).find('.uploader-file-item').size();
	            if(itemListNum==0){
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
AssetsDeviceScrapDetail.prototype.setAttachCanAddOrDel = function(tagId,operability,obj){
    if(operability) {
        $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "");
        });
        $('#' + tagId).find('div.uploader-file-item').unbind("mouseover");
    }else {
        $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "none");
        });
        $('#' + tagId).find('div.uploader-file-item').bind('mouseover',function(){
            $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
        });
    }
};
//控件校验   规则：表单字段name与rules对象保持一致
AssetsDeviceScrapDetail.prototype.formValidate=function(form){
	form.validate({
		rules: {
						  		     			 		  				  				  				  				  				  				  				  		     			    				   					createdByPerson:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					createdByDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					createdByTel:{
						maxlength: 20
				    },
				    							 		  				  		     			    				   					formState:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					procName:{
						maxlength: 255
				    },
				    							 		  				  		     			    				   					procId:{
						maxlength: 100
				    },
				    							 		  				  		     			    				   					assetId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					unifiedId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceCategory:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					deviceName:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceModel:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceSpec:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					ownerId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					ownerDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					userId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					userDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					manufacturerId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   			       createdDate:{
						dateISO:true
				   },
				   							 		  				  		     			    				   					positionId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   				   originalValue:{
						number:true
				   },
				   							 		  				  		     			    				   				   totalDepreciation:{
						number:true
				   },
				   							 		  				  		     			    				   				   netValue:{
						number:true
				   },
				   							 		  				  		     			    				   				   netSalvage:{
						number:true
				   },
				   							 		  				  		     			    				   					secretLevel:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					scrapReason:{
						maxlength: 4000
				    },
				    							 		  				  		     			    				   					productRiskAnalyse:{
						maxlength: 4000
				    },
				    							 		  				  		     			    				   				   scrapMoney:{
						number:true
				   },
				   							 		  				  		     			    				   					recoveryStore:{
						maxlength: 50
				    },
				    							 		  			  }
	});
}
