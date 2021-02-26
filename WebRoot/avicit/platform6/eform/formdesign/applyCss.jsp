<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<title>CSS文件扩展</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div id="tableToolbar" class="tollbar">
		<div>
			<a id="csslist_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			<a id="csslist_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			<a id="csslist_save" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="保存"><i class="fa fa-floppy-o"></i> 保存</a>
			<a id="csslist_up" href="javascript:void(0)"
			   class="btn btn-primary form-tool-btn btn-sm" role="button"
			   title="上移"><i class="fa fa-arrow-up"></i> 上移</a>
			<a id="csslist_down" href="javascript:void(0)"
			   class="btn btn-primary form-tool-btn btn-sm" role="button"
			   title="下移"><i class="fa fa-arrow-down"></i> 下移</a>
		</div>
	</div>
	<table id="csslistjqGrid"></table>
</body>

<script tpye="text/javascript">
	var csslist;
	var dataGridColModel=[{
		label:'CSS文件',
	    name:'cssFile',
	    width : 50,
	    editable : true ,
	    edittype : 'text'
	    }                 
	];
	$(document).ready(function(){
		$("#csslistjqGrid").jqGrid({
	    	url: "",
	        mtype: 'POST',
	        datatype: "json",
	        toolbar: [false,'top'],//启用toolbar
	        colModel: dataGridColModel,//表格列的属性
	        height:$(window).height() - 100,//初始化表格高度
	        scrollOffset: 20, //设置垂直滚动条宽度
	        altRows:true,//斑马线
	        styleUI : 'Bootstrap', //Bootstrap风格
			viewrecords: true, //是否要显示总记录数
			multiselect: true,//可多选
			autowidth: true,//列宽度自适应
			responsive:true,//开启自适应
	        cellEdit:true,
	        cellsubmit: 'clientArray'
	    });
		//加载当前csslist
		var r = toJson(parent.EformEditor.eformUrlCss);
		if(r[0].cssFile!==""){
			for(var i=0;i<r.length;i++){
				$("#csslistjqGrid").jqGrid("addRowData",i+1,r[i]);
			}	
		}
		
		$('#csslist_insert').bind('click', function() {
			insert();
		});
		$("#csslist_del").bind('click',function(){
			del();
		});
		$("#csslist_save").bind('click',function(){
			save();
		});
		$("#csslist_up").bind('click',function(){
			moveRow("up");
		});
		$("#csslist_down").bind('click',function(){
			moveRow("down");
		});
	}
	);
	/**
	 * 上移下移
	 * */
	 function moveRow(type){
         var grid = $("#csslistjqGrid");
         grid.jqGrid('endEditCell');
         var ids = grid.getDataIDs();
         var selRowid = grid.getGridParam("selrow");
         var selRowData = grid.getRowData(selRowid);//所选行数据
         var selRowNum = $.inArray(selRowid,ids);//所选行号
         var movRowNum = null;//移动行号
         var movRowid = null;
         var movRowData = null;//移动数据
         var datas = grid.jqGrid('getRowData');

	     if(type === "up"){
             movRowNum = selRowNum - 1;
         }else if(type === "down"){
             movRowNum = selRowNum + 1;
         }else {
	         return false;
         }

         //移动
         if(movRowNum>=0 && selRowNum>=0 && movRowNum<datas.length){
             movRowid = ids[movRowNum] ;
             movRowData = grid.getRowData(movRowid);

             datas[movRowNum] = selRowData;
             datas[selRowNum] = movRowData;

             grid.jqGrid("clearGridData");
             for(var i=0; i<datas.length; i++){
                 grid.jqGrid("addRowData", i+1, datas[i]);
             }
             $(grid[0]).find("tr.jqgrow").addClass('edited');

             //默认选中移动的这个行
             grid.jqGrid('resetSelection');
             grid.jqGrid('setSelection', movRowNum+1);
         }else {
	         return false;
         }
	 }


	/**
	 * 添加页面
	 */
	var newRowIndex = 0;
    var newRowStart = "new_row";
	function insert(){
		$("#csslistjqGrid").jqGrid('endEditCell');
		var newRowId = newRowStart + newRowIndex;
		var parameters = {
			rowID : newRowId,
			initdata : {},
			position :"first",
			useDefValues : true,
			useFormatter : true,
			addRowParams : {extraparam:{}}
		};
		$("#csslistjqGrid").jqGrid('addRow', parameters);
		newRowIndex++;

}
    /*
    *删除
    */
	function del(){
		$("#csslistjqGrid").jqGrid('endEditCell');
		var rows = $("#csslistjqGrid").jqGrid('getGridParam','selarrrow');
		var ids = [];
		var l =rows.length;
		if(l>0){
			layer.confirm('确定要删除该数据吗？',{icon:2,title:"请确认：",area:['400px','']},function(index){
				for(var i=0;i<l;i++){
					$("#csslistjqGrid").jqGrid('delRowData',rows[i]);
				}
				var data = $("#csslistjqGrid").jqGrid('getRowData');
				var temp = "";
		    	for(var i=0;i<data.length;i++){
		    		temp = temp + "," +data[i].cssFile;
		    	}
		    	parent.EformEditor.eformUrlCss = temp.substr(1);
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
		$("#csslistjqGrid").trigger("reloadGrid");
	}
	//保存
	function save(){
		//取消行编辑
		$("#csslistjqGrid").jqGrid('endEditCell');
		var data = $("#csslistjqGrid").jqGrid('getRowData');
		if(data.length == 0){
			layer.alert('请先添加数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
			return false;
		}
		var datas = $("#csslistjqGrid").jqGrid('getChangedCells');
		if(datas.length == 0){
			layer.alert('请先修改数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
			return false;
		}
		var msg = nullvalid(data);
		if(msg && msg.length>0){
			layer.alert(msg , {
    			  icon: 7,
    			  area: ['400px', ''], //宽高
    			  closeBtn: 0
    			 }
    		);
			return false;
		}
		var temp = "";
    	for(var i=0;i<data.length;i++){
    		temp = temp + "," +data[i].cssFile;
    	}
    	parent.EformEditor.eformUrlCss = temp.substr(1);
        layer.msg('操作成功！', {icon: 1});
	}
	//输入判断
	function nullvalid(data){
	var msg = "";
	var re = /[,]/im;
    var re2 = /[ ]/im;
	if(data && data.length > 0){
		$.each(data,function(i,dataitem){
			if(dataitem.cssFile == ""){
				msg = "不能保存空值";
				return msg;
		    }
			if(re.test(dataitem.cssFile)){
				msg = "不能含有“,”";
				return msg;
			}
            if(re2.test(dataitem.cssFile)){
                msg = "不能含有空格";
                return msg;
            }
		})
	}else{
		layer.alert('请先修改数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			});
	}
	
	return msg;
}
	//JS字符串转换为Json
	function toJson(eformCssList){
		var list = eformCssList.split(",");
		var eformCss = "";
		for(var i=0;i<list.length;i++){
			eformCss = eformCss + ",{\"cssFile\":\""+list[i]+"\"}";
		}
		eformCss = eformCss.substr(1);
		eformCss = "[" + eformCss + "]";
		return $.parseJSON(eformCss);
	}
	 
</script>
</html>