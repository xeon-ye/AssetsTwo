(function($){$.fn.serializeAll=function(){var data=$(this).serializeArray();$(':disabled[name]',this).each(function(){if($(this).attr('type')=="radio"||$(this).attr('type')=="checkbox"){if($(this).is(':checked')){data.push({name:this.name,value:$(this).val()})}}else{data.push({name:this.name,value:$(this).val()})}});return data}})(jQuery);var dataOptions={pageSize:15,pageList:[10,15,30,50,100]};function getPath(){if(typeof(dorado)!="undefined"){var a=dorado.Setting["common.contextPath"];if(!a){a=dorado.Setting.contextPath}a=a.substring(0,a.length-1);return a}var b=$("base").attr("href");if(typeof(b)!="undefined"&&b!=""){if(b.indexOf("http")==0||b.indexOf("https")==0){if(b.indexOf("//")>-1){var e=b.indexOf("/",b.indexOf("//")+2);var d=b.substring(e);if(d=="/"){d=""}if(d!=""){return d}}}}if("undefined"!=typeof baseurl&&baseurl!=null){return baseurl}var f=window.location.pathname;var c=f.indexOf("/",1);a=f.substr(0,c);if(a=="/"){a=""}return a}function getPath2(){var a=getPath();if(a.charAt(a.length-1)=="/"){a=a.substring(0,a.length-1)}return a}function getPointerX(a){return a.pageX||(a.clientX+(document.documentElement.scrollLeft||document.body.scrollLeft))}function getPointerY(a){return a.pageY||(a.clientY+(document.documentElement.scrollTop||document.body.scrollTop))}function replaceNull2Space(a){if(a==null||a=="null"){return""}return a}function serializeObject(b,a){var c={};$.each(b.serializeArray(),function(d){if(typeof(a)=="undefined"||(a!=null&&a==false)){if(c[this["name"]]){c[this["name"]]=c[this["name"]]+","+this["value"]}else{c[this["name"]]=this["value"]}}else{if(this["value"]!=null&&this["value"]!=""){if(c[this["name"]]){c[this["name"]]=c[this["name"]]+","+this["value"]}else{c[this["name"]]=this["value"]}}}});return c}function ajaxRequest(type,data,url,dataType,event){var contextPath=getPath2();var urltranslated=contextPath+"/"+url;if(dataType!=""){jQuery.ajax({type:type,data:data,url:urltranslated,dataType:dataType,success:function(msg){if(msg!=null&&msg.error!=null){easyuiUnMask();window.alert("异常信息为："+msg.error);return}else{if(event!=null){eval(event+"(msg)")}}},error:function(msg){}})}else{jQuery.ajax({type:type,data:data,url:urltranslated,success:function(msg){if(msg!=null&&msg.error!=null){window.alert("异常信息为："+msg.error);return}else{if(event!=null){eval(event+"(msg)")}}},error:function(msg){}})}}function Map(){this.elements=new Array();this.size=function(){return this.elements.length};this.isEmpty=function(){return(this.elements.length<1)};this.clear=function(){this.elements=new Array()};this.put=function(b,a){this.remove(b);this.elements.push({key:b,value:a})};this.remove=function(b){var d=false;try{for(var a=0;a<this.elements.length;a++){if(this.elements[a].key==b){this.elements.splice(a,1);return true}}}catch(c){d=false}return d};this.get=function(b){try{for(var a=0;a<this.elements.length;a++){if(this.elements[a].key==b){return this.elements[a].value}}}catch(c){return null}};this.element=function(a){if(a<0||a>=this.elements.length){return null}return this.elements[a]};this.containsKey=function(b){var d=false;try{for(var a=0;a<this.elements.length;a++){if(this.elements[a].key==b){d=true}}}catch(c){d=false}return d};this.containsValue=function(a){var d=false;try{for(var b=0;b<this.elements.length;b++){if(this.elements[b].value==a){d=true}}}catch(c){d=false}return d};this.values=function(){var a=new Array();for(var b=0;b<this.elements.length;b++){a.push(this.elements[b].value)}return a};this.keys=function(){var a=new Array();for(var b=0;b<this.elements.length;b++){a.push(this.elements[b].key)}return a}}function getRadioValue(a){var b="";var d=document.getElementsByName(a);for(var c=0;c<d.length;c++){if(d[c].checked){b=d[c].value;break}}return b}function easyuiMask(){$('<div class="datagrid-mask"></div>').css({display:"block",width:"100%",height:$(window).height()}).appendTo("body");$('<div class="datagrid-mask-msg"></div>').html("正在处理，请稍候。。。").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true)-190)/2,top:($(window).height()-45)/2})}function easyuiUnMask(){$("div.datagrid-mask-msg").remove();$("div.datagrid-mask").remove()}var FormProxyPage={url:"avicit/platform6/bpmclient/bpm/ProcessApprove.jsp"};Date.prototype.format=function(b){var c={"M+":this.getMonth()+1,"d+":this.getDate(),"h+":this.getHours(),"m+":this.getMinutes(),"s+":this.getSeconds(),"q+":Math.floor((this.getMonth()+3)/3),S:this.getMilliseconds()};if(/(y+)/.test(b)){b=b.replace(RegExp.$1,(this.getFullYear()+"").substr(4-RegExp.$1.length))}for(var a in c){if(new RegExp("("+a+")").test(b)){b=b.replace(RegExp.$1,RegExp.$1.length==1?c[a]:("00"+c[a]).substr((""+c[a]).length))}}return b};String.prototype.getLens=function(){var a=0;for(var b=0;b<this.length;b++){if(this[b].match(/[^\x00-\xff]/ig)!=null){a+=2}else{a+=1}}return a};function formatColumnDate(b,c){if(b==null||b==""){return""}var a;if(b instanceof Date){a=b}else{a=new Date(b);if(isNaN(a)){b=b.replace(/-/g,"/");a=new Date(b)}if(isNaN(a)){b=b.replace(/\/Date\((-?\d+)\)\//,"$1");a=new Date();a.setTime(b)}}return a.format("yyyy-MM-dd")}function formatColumnTime(b,c){if(b==null||b==""){return""}var a;if(b instanceof Date){a=b}else{a=new Date(b);if(isNaN(a)){b=b.replace(/\/Date\((-?\d+)\)\//,"$1");a=new Date();a.setTime(b)}}return a.format("yyyy-MM-dd hh:mm:ss")}function parserColumnDate(b){var a=Date.parse(b);if(!isNaN(a)){return new Date(a)}else{return new Date()}}function parserColumnTime(b){var a=Date.parse(b);if(!isNaN(a)){return new Date(a)}else{var c=parseDate(b);if(c instanceof Date){return c}else{return new Date()}}}function parseDate(a){if(a==""){return}var e=/(\d{4})-?(\d{2})?-?(\d{2})?\s?(\d{2})?:?(\d{2})?:?(\d{2})?/g;var d=e.exec(a);var b=new Array();for(var c=1;c<d.length;c++){if(d[c]!=undefined){b[c]=d[c]}else{if(c<=3){b[c]="01"}else{b[c]="00"}}}return new Date(b[1],b[2]-1,b[3],b[4],b[5],b[6])}String.prototype.byteLength=function(){return this.replace(/[^\x00-\xff]/g,"**").length};var MaskUtil=(function(){var b,a;var d="正在处理，请稍待。。。";function c(){if(!b){b=$('<div class="datagrid-mask mymask"></div>');$("body",parent.document).append(b)}if(!a){a=$('<div class="datagrid-mask-msg mymask">'+d+"</div>");$("body",parent.document).append(a);a.css({"font-size":"12px"})}b.css({width:"100%",height:$(parent.document).height()});a.css({left:($(parent.document.body).outerWidth(true)-190)/2,top:($(parent.window).height()-45)/2})}return{SAVE_MAG:"正在努力保存...",mask:function(e){c();b.show();a.html(e||d).show()},unmask:function(){b.hide();a.hide()}}}());String.prototype.trim=function(){return this.replace(/(^\s*)|(\s*$)/g,"")};function deepCopy(b,d){var d=d||{};for(var a in b){if(typeof b[a]==="object"){d[a]=(b[a].constructor===Array)?[]:{};deepCope(b[a],d[a])}else{d[a]=b[a]}}return d}function comboboxOnShowPanel(){var a=$(this).combobox("textbox").parent().outerWidth(true);$(this).combobox("panel").panel("resize",{width:a})}function comboboxHidePanel(){$(".easyui-combobox").combobox("hidePanel");$(".easyui-combotree").combotree("hidePanel")};