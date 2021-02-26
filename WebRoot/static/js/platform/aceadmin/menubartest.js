/**
 * 菜单点击事件
 * @param obj 当前dom对象
 * @param tabobj tab添加所需参数
 */
function menuClick(obj,tabobj){
	addTabs(tabobj);
	menuAddActive($(obj).parent());
}

function activeTab(menuId){
	$(".tabbable .active").removeClass("active");
	$("#tab_tab_" + menuId).addClass('active');
	$("#tab_" + menuId).addClass("active");
}

/**
 * 激活当前选中菜单，及其父节点
 */
function menuAddActive(obj){
	$(obj).addClass("active");
	if ($(obj).parent().hasClass("submenu")){
		menuAddActive($(obj).parent().parent());
	}
}

/**
 * tab点击事件
 * @param menuId 菜单ID
 * @returns {Boolean}
 */
function tabClick(menuId){
	$("#menuBar").find(".active").removeClass("active");
	menuAddActive($("#"+menuId).parent());
	activeTab(menuId);
}

/**
 * tab添加事件
 * @param obj {id(tab对应ID，一般传菜单ID),close(是否可以关闭 boolean类型),title(tab标签title),content(tab页内容,没有内容，使用IFRAME打开链接),url(iframe src)}
 */
function addTabs(obj) {
    var id = "tab_" + obj.id;

	$("#menuBar").find(".active").removeClass("active");
    $(".tabbable .active").removeClass("active");
     
    //如果TAB不存在，创建一个新的TAB
    if (!$("#" + id)[0]) {
        //固定TAB中IFRAME高度
        mainHeight = $(window).height() - 100;
        //创建新TAB的title
        title = '<li id="tab_' + id + '"><a href="#'+id+'" data-toggle="tab" onclick="showPage(\''+id+'\',\''+obj.url+'\')">' + obj.title;
        //是否允许关闭
        
        if (obj.close) {
            title += ' <span class="ace-icon fa fa-times red2" onclick="closeTab(event,\'' + id + '\')"></span>';
        }
        
        title += '</a></li>';
        //是否指定TAB内容
        if (obj.content) {
            content = '<div role="tabpanel" class="tab-pane" id="' + id + '">' + obj.content + '</div>';
        } else {//没有内容，使用IFRAME打开链接
            content = '<div role="tabpanel" class="tab-pane" id="' + id + '"></div>';
        }
        //加入TABS
        $(".nav-tabs").append(title);
        $(".tab-content").append(content);
    }
     
    //激活TAB
    $("#tab_" + id).addClass('active');
    $("#" + id).addClass("active");
};

function showPage(tabId, url){
    $('#myTab a[href="#'+tabId+'"]').tab('show'); // 显示点击的tab页面
    if($('#'+tabId).html().length<20){ // 当tab页面内容小于20个字节时ajax加载新页面
      $('#'+tabId).html('<br>'+' 页面加载中，请稍后...'); // 设置页面加载时的loading图片
      $('#'+tabId).load(url); // ajax加载页面
    }
  }

/**
 * 关闭标签页
 */
function closeTab(e,id) {
	if ( e && e.stopPropagation ) {
	    // 因此它支持W3C的stopPropagation()方法 
		e.stopPropagation();
	}else{ 
	    // 否则，我们需要使用IE的方式来取消事件冒泡
		window.event.cancelBubble = true;
	}
	var menuId = "";
    //如果关闭的是当前激活的TAB，激活他的前一个TAB
    if ($("#myTab li.active").attr('id') == "tab_" + id) {
    	if ($("#tab_" + id).prev().length > 0){
    		menuId = $("#" + id).prev().attr("id").replace("tab_","");
	        $("#tab_" + id).prev().addClass('active');
	        $("#" + id).prev().addClass('active');
	        
    	}else{
    		menuId = $("#" + id).next().attr("id").replace("tab_","");
    		$("#tab_" + id).next().addClass('active');
	        $("#" + id).next().addClass('active');
    	}
        tabClick(menuId);
    }
    //关闭TAB
    $("#tab_" + id).remove();
    $("#" + id).remove();
};