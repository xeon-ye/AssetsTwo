var dialog_first_row_tip="提示：您为";var dialog_second_row_tip="密码要求：您的密码";var dialog_third_row_tip="最大长度不要超过";var dialog_fourth_row_tip="最小长度不能小于";var dialog_five_row_tip="其中大写字母、小写字母、数字、特殊字符至少要包含";var dialog_five_row_end_tip="位";var dialog_six_row_begin_tip="不能和前";var dialog_six_row_end_tip="次密码重复";var dialog_seven_row_begin_tip="不能和旧密码有";var dialog_seven_row_end_tip="位（连续）重复";var dialog_eight_row_begin_tip="请在";var dialog_eight_row_middle_tip="天";var dialog_eight_row_end_tip="前修改密码";var password_length_tip="位";var shangeSelfPasswordVo,uid=(parent&&parent.__uid)||"-1";$(function(){$("#passwordEditForm input").bind("keyup",function(a){if(a.keyCode==13){a.preventDefault();changePassword()}});$.ajax({url:"platform/sysuser/"+uid+"/getChangeSelfPasswordVo",type:"post",success:function(a){if(a){shangeSelfPasswordVo=a;generateTipContent()}},error:function(a){alert("操作失败，服务请求状态："+a.status+" "+a.statusText+" 请检查服务是否可用！")}})});function generateTipContent(){var f=$("#tipContent");var a=shangeSelfPasswordVo.maxlength;var g=shangeSelfPasswordVo.intensity;var h=shangeSelfPasswordVo.distinctBefore;var c=shangeSelfPasswordVo.minlength;var e=shangeSelfPasswordVo.difference;var b=shangeSelfPasswordVo.oldPassword;var i=shangeSelfPasswordVo.secretLevelName;helpMessage=dialog_first_row_tip+"<font color='red'>"+i+"</font><br/>";helpMessage=helpMessage+"　　　"+dialog_second_row_tip+"<br/>";if(a){helpMessage+="　　　"+dialog_third_row_tip+" <font color='red'>"+a+"</font> "+password_length_tip+"<br/>"}if(c){helpMessage+="　　　"+dialog_fourth_row_tip+" <font color='red'>"+c+"</font> "+password_length_tip+"<br/>"}if(g){helpMessage+="　　　"+dialog_five_row_tip+" <font color='red'>"+g+"</font> "+dialog_five_row_end_tip+"<br/>	"}if(h){helpMessage+="　　　"+dialog_six_row_begin_tip+" <font color='red'>"+h+"</font> "+dialog_six_row_end_tip+"<br/>"}if(e){helpMessage+="　　　"+dialog_seven_row_begin_tip+" <font color='red'>"+e+"</font> "+dialog_seven_row_end_tip+"<br/>"}if(a||g||c||h||e){}else{helpMessage="提示：您为<font color='red'>非涉密人员</font><br/>　　　密码要求：无<br/>"}var j=null;if(shangeSelfPasswordVo.howLongModify&&shangeSelfPasswordVo.howLongModify>0){j=shangeSelfPasswordVo.howLongModify}if(null!=j){var d=shangeSelfPasswordVo.sysPsw;helpMessage+="　　　"+dialog_eight_row_begin_tip+" <font color='red'>"+d+"</font>"+dialog_eight_row_end_tip+"<br/>"}helpMessage=helpMessage.substring(0,helpMessage.length-1);helpMessage+=".";f.html(helpMessage);f.css("margin-top:120px;width: 400px; overflow-x: hidden; overflow-y: auto; position: relative; left: 0px; bottom: 0px;");f.attr("visible",true)}function add0(a){return a<10?"0"+a:a}function closeParentDialog(a){if(a=="1"){alert("密码修改成功，请用新密码重新登录！");parent.$("#modifypsw").dialog("close")}else{parent.$("#modifypsw").dialog("close")}}function hasText(c,a){var b=c;if(null==b){return false}if(a){b=b.replace(/\s*/g,"")}if(0==c.length){return false}return true}function mate(d){var h=0;var f=0;var b=0;var a=0;for(var e=0;e<d.length;e++){var g=d.charAt(e);if(g<="9"&&g>="0"){h=1}else{if(g<="z"&&g>="a"){f=1}else{if(g<="Z"&&g>="A"){b=1}else{a=1}}}}return h+f+b+a}function changePassword(){var b=shangeSelfPasswordVo.maxlength;var e=shangeSelfPasswordVo.intensity;var g=shangeSelfPasswordVo.distinctBefore;var c=shangeSelfPasswordVo.minlength;var d=shangeSelfPasswordVo.difference;var h=shangeSelfPasswordVo.secretLevelName;var i=$("#newPassword").val();var f=$("#confirmPassword").val();if(!hasText(i)){$.messager.alert("提示","新密码不能为空","warning");return}if(!hasText(f)){$.messager.alert("提示","确认密码不能为空","warning");return}if(f!=i){$.messager.alert("提示","确认密码和新密码不一致","warning");return}var a=0;if(c){if(i.length<c){alert("新密码的长度不能小于"+c+"位");return false}}else{}if(b){if(i.length>b&&i.length<=100){alert("新密码的长度不能大于"+b+"位");return false}}else{}a=mate(i);if(e!=""&&e!=null&&a<e){alert("新密码的密码强度要求为"+e+",而输入的密码强度为"+a+" .(密码强度其中包含数字，小写字母，大写字母，特殊字符<包含标点符号>，它们各为一级，最高为四级)");return false}$("#confirmBtn").attr("disabled","disabled");$.ajax({url:"platform/sysuser/"+uid+"/changePassword",data:{newPassword:i},type:"post",dataType:"json",success:function(j){$("#confirmBtn").removeAttr("disabled");if(j.s){alert(j.s);parent.$("#modifypsw").dialog("close")}else{alert(j.f)}}})};