if($.messager){$.messager.defaults.ok="确定";$.messager.defaults.cancel="取消"}var MIME_TYPE={"-2":"fileIcon","-1":"dirIcon","1":"wordIcon","2":"wordIcon","3":"txtIcon","4":"fileIcon","5":"excelIcon","6":"excelIcon","7":"pptIcon","8":"pptIcon","9":"fileIcon","10":"fileIcon","11":"excelIcon","12":"pdfIcon","13":"fileIcon","100":"rarIcon","101":"rarIcon","102":"rarIcon","103":"rarIcon","104":"rarIcon","200":"imgIcon","201":"imgIcon","202":"imgIcon","203":"imgIcon","204":"imgIcon","205":"imgIcon","206":"imgIcon","300":"videoIcon","301":"videoIcon","302":"videoIcon","303":"videoIcon","304":"videoIcon","305":"videoIcon","306":"videoIcon","307":"videoIcon","308":"videoIcon","309":"videoIcon","310":"videoIcon"};var formatSize=function(a){if(a<1024){return a+"B"}else{a=a/1024;if(a<1024){return a.toFixed(2)+"KB"}else{a=a/1024;if(a<1024){return a.toFixed(2)+"M"}else{a=a/1024;if(a<1024){return a.toFixed(2)+"G"}else{a=a/1024;return a.toFixed(2)+"T"}}}}};Date.prototype.format=function(b){if(isNaN(this)){return""}var c={"m+":this.getMonth()+1,"d+":this.getDate(),"h+":this.getHours(),"n+":this.getMinutes(),"s+":this.getSeconds(),S:this.getMilliseconds(),W:["日","一","二","三","四","五","六"][this.getDay()],"q+":Math.floor((this.getMonth()+3)/3)};if(b.indexOf("am/pm")>=0){b=b.replace("am/pm",(c["h+"]>=12)?"下午":"上午");if(c["h+"]>=12){c["h+"]-=12}}if(/(y+)/.test(b)){b=b.replace(RegExp.$1,(this.getFullYear()+"").substr(4-RegExp.$1.length))}for(var a in c){if(new RegExp("("+a+")").test(b)){b=b.replace(RegExp.$1,RegExp.$1.length==1?c[a]:("00"+c[a]).substr((""+c[a]).length))}}return b};