/**
 * 
 */
function MdaDatasource(datagrid, url, searchForm, dataGridColModel, searchDialog, afterInit, clickRowLoad,searchMainNames,demoMainDept_KeyWord){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    };
	this._datagridId = "#"+datagrid;
	this.Toolbardiv = "#t_"+datagrid;
	this.Toolbar = "#toolbar_"+datagrid;
	this._searchDialogId ="#"+searchDialog;
	this.Pagerlbar = "#" +datagrid + "Pager";
	this.searchForm = "#" + searchForm;
	this._keyWordId="#"+demoMainDept_KeyWord;
	this._searchNames = searchMainNames;
	this.dataGridColModel = dataGridColModel;
	this.afterInit = afterInit;
	this.clickRowLoad = clickRowLoad;
	this.init.call(this);
}
//初始化操作
MdaDatasource.prototype.init=function(){
	var _self = this;
	var issubinit = false;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'getMdaDatasourcesByPage.json',
        mtype: 'POST',
        multiselect:true, 
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:$(window).height()-120-17,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
        scrollOffset: 10,
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        userDataOnFooter: true,
        pagerpos:'left',
        styleUI : 'Bootstrap', 
		viewrecords: true,
		multiboxonly:true,
		autowidth: true,
		shrinkToFit: true,
		responsive:true,
        pager: _self.Pagerlbar,
        onSelectRow: function(rowid) {
        	if(issubinit){
        		_self.clickRowLoad(rowid);
        	}
        },
        loadComplete:function(){
        	$(this).jqGrid('getColumnByUserIdAndTableName');
        	var rowdata = $(_self._datagridId).jqGrid('getRowData');
        	if(issubinit == false){
		        if(rowdata != null && rowdata.length > 0){
		            $(_self._datagridId).setSelection(rowdata[0].id);
		            _self.afterInit(rowdata[0].id);
		            issubinit = true;
	        	}else{
	        		_self.afterInit("-1");
	        		issubinit = true;
	        	}
	        }else{
	        	if(rowdata != null && rowdata.length > 0){
		            $(_self._datagridId).setSelection(rowdata[0].id);
		            _self.clickRowLoad(rowdata[0].id);

	        	}else{
	        		_self.clickRowLoad("");
	        	}
        	}
        }
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
	 	oneLine:true,//单行显示时分秒
	 	closeText:'确定',//关闭按钮文案
	 	showButtonPanel:true,//是否展示功能按钮面板
	 	showSecond:false,//是否可以选择秒，默认否
	 	beforeShow: function(selectedDate) {
	 		if($('#'+selectedDate.id).val()==""){
	 			$(this).datetimepicker("setDate", new Date());
	 			$('#'+selectedDate.id).val('');
	 		}
	 		setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
	 	}
	});
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};
//添加页面
MdaDatasource.prototype.insert=function(){
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Add/null' 
	});
};

//添加页面
MdaDatasource.prototype.setFun=function(){
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '设置',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Add/null' 
	});   
};
//编辑页面
MdaDatasource.prototype.modify=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
	    layer.alert('请选择数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		);
		return false;
	}else if(ids.length > 1){
	    layer.alert('请选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		);
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Edit/'+rowData.id 
	});
};
//详细页
MdaDatasource.prototype.detail=function(id){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	}); 
};
//控件校验   规则：表单字段name与rules对象保持一致
MdaDatasource.prototype.formValidate=function(form){
	form.validate({
		rules: {
						  		     			 		  				  				  				  				  				  				  				  				  		     			    				   					name:{
						maxlength: 32
				    },
				    							 		  				  		     			    				   			       useridAlias:{
						required:true,
						maxlength: 50
				   },
				   							 		  				  		     			    				   			       createtime:{
						dateISO:true
				   },
				   							 		  				  		     			    				   			       lastmodifytime:{
						dateISO:true
				   },
				   							 		  				  		     			    				   					status:{
						maxlength: 2
				    },
				    							 		  			  }
	});
};
//保存功能
MdaDatasource.prototype.save=function(form,id){
	var _self = this;
	avicAjax.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(serializeObject(form))},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 if(id == "insert"){
					 layer.close(_self.insertIndex);
				 }else{
					 layer.close(_self.eidtIndex);
				 }
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败！' + r.error,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );
			 } 
		 }
	 });
};

//保存功能
MdaDatasource.prototype.next=function(form,id){
	var _self = this;
	avicAjax.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(serializeObject(form))},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 if(id == "insert"){
					 layer.close(_self.insertIndex);
				 }else{
					 layer.close(_self.eidtIndex);
				 }
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败！' + r.error,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );
			 } 
		 }
	 });
};
//删除
MdaDatasource.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要删除该数据吗?', {icon: 2, title:"请确认：", area: ['400px', '']}, function(index){
				for(;l--;){
					 ids.push(rows[l]);
				 }
				 avicAjax.ajax({
					 url:_self.getUrl()+'delete',
					 data:	JSON.stringify(ids),
					 contentType : 'application/json',
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.flag == "success") {
							 _self.reLoad();
						}else{
							 layer.alert('删除失败！'+ r.error, {
								  icon: 7,
								  area: ['400px', ''], //宽高
								  closeBtn: 0
							    }
					         );
							
						}
					 }
				 });
				 layer.close(index);
			});   
	}else{
		layer.alert('请选择要删除的记录！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
	}
};
//重载数据
MdaDatasource.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this.searchForm)))};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
MdaDatasource.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
MdaDatasource.prototype.openSearchForm = function(searchDiv,par){
	var _self = this;
	par = null;
	//if(!par) par = $(window);
	var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
	var top =  $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
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
		move : false,
		area: [contentWidth + 'px', '400px'],
		offset: [top + 'px', left + 'px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['查询', '清空', '取消'],
		content: $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span><span class="caret"></span></div>').appendTo(layero);
			serachLabel.bind('click', function(){
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
		},
		yes: function(index, layero){
			_self.searchData();
			layer.close(index);
		},
		btn2: function(index, layero){
			_self.clearData();
			return false;
		},
		btn3: function(index, layero){
			
		}
	});
};
//高级查询
MdaDatasource.prototype.searchData =function(){
	var searchdata = {
			keyWord: null,
			param:JSON.stringify(serializeObject($(this.searchForm)))
		};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
MdaDatasource.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
			keyWord: JSON.stringify(param),
			param: null
		};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
//隐藏查询框
MdaDatasource.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
MdaDatasource.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
};
