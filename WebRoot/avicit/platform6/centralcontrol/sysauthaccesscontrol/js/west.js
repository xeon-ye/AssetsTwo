function getDataGridRowIndex(a,c){var b=$("#"+a);return b.datagrid("getRowIndex",c)}var functionAction=true;function initTabContainer(a){$("#comprehensiveTabControl").tabs({onSelect:function(c,b){if(b==0){tabSelectedIndex="0";loadRoleList()}if(b==1){tabSelectedIndex="1";$("#userQueryText").searchbox({width:200,searcher:function(d){if(d=="请输入查询内容"){d=""}if(d.length==0){functionAction=true}else{functionAction=false}searchData()},prompt:"请输入查询内容"});$("#dgUser").datagrid("options").url="platform/cc/sysdept/getUserDataByPage.json?_status=1";$("#dgUser").datagrid("reload",{id:"",type:""});$("#dgUser").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections")}if(b==2){tabSelectedIndex="2";$("#deptQueryText").searchbox({width:200,searcher:function(e){if(e=="请输入查询内容"){e=""}var d={search_text:e};var f="multipleOrg=n&selectType=dept&deptKeyWord="+e;ajaxRequest("POST",d,"platform/cc/sysdept/searchDept?_status=1","json","loadDeptTreeByData")},prompt:"请输入查询内容"});loadDeptTree()}if(b==3){tabSelectedIndex="3";$("#groupQueryText").searchbox({width:200,searcher:function(d){if(d=="请输入查询内容"){d=""}searchGroupFun(d)},prompt:"请输入查询内容"});loadGroupList()}if(b==4){tabSelectedIndex="4";$("#positionQueryText").searchbox({width:200,searcher:function(d){if(d=="请输入查询内容"){d=""}searchPositionFun(d)},prompt:"请输入查询内容"});loadPositionList()}}});loadRoleList()}function loadOrgTree(orgDatajson){var orgData=eval(orgDatajson.orgDatajson);$("#orgTree_user").tree({lines:true,method:"post",data:orgData,onCheck:function(node,checked){},onBeforeExpand:function(node,param){var beforeExpandUrl_="platform/cc/centralizedauthorization/getDepts.json";var paraM=node.attributes.para;if(typeof(paraM)=="undefined"){paraM=""}$("#orgTree_user").tree("options").url=beforeExpandUrl_+"?nodeType="+node.attributes.nodeType+"&deptId="+node.id+"&selectType=user&param="+paraM},onLoadSuccess:function(node,data){}})}function displayAllUsers(b){if(typeof(b)!="undefined"){var c=b.allUsers;var a=b.checked;if(a=="true"){$.each(c,function(e,f){var d=getDataGridRowIndex("selectTargetDataGrid",f.userId);if(d==-1){var g={id:f.userId,name:f.userName,type:"user",typeName:"用户"};$("#selectTargetDataGrid").datagrid("appendRow",g);$("#selectTargetDataGrid").datagrid("checkRow",getDataGridRowIndex("selectTargetDataGrid",f.userId))}})}else{if(a=="false"){$.each(c,function(f,e){var d=getDataGridRowIndex("selectTargetDataGrid",e.userId);if(d!=-1){$("#selectTargetDataGrid").datagrid("deleteRow",d)}})}}}}function expand(a){$("#orgTree_user").tree("expand",a.target)}function loadDeptTree(){var a=$("#orgTree_dept");a.tree({lines:true,method:"post",url:"platform/cc/sysdept/getChildOrgDeptByIdAndOrgId.json?_status=1",onCheck:function(c,b){},onBeforeExpand:function(c,d){if(c){var b="platform/cc/sysdept/getChildOrgDeptByIdAndOrgId.json";a.tree("options").url=b+"?_status=1&type="+c.attributes.type+"&id="+c.id}},loadFilter:function(b){if(b.data){return b.data}else{return b}},onLoadSuccess:function(b){}})}function loadDeptTreeByData(orgDatajson){var orgData=eval(orgDatajson.data);var orgTree_dept=$("#orgTree_dept");if(orgData.length==1){orgTree_dept.tree({lines:true,data:orgData,url:null,onCheck:function(node,checked){},onBeforeExpand:function(node,param){}})}}function loadRoleList(){$("#roleQueryText").searchbox({width:200,searcher:function(a){if(a=="请输入查询内容"){a=""}searchRoleFun(a)},prompt:"请输入查询内容"});$("#roleList").datagrid({fit:true,url:"platform/cc/centralizedauthorization/getSysRole.json?type=role&appId="+_APPID,idField:"id",singleSelect:true,nowrap:false,striped:true,autoRowHeight:false,checkOnSelect:true,remoteSort:false,fitColumns:true,pagination:true,pageSize:dataOptions.pageSize,pageList:dataOptions.pageList,columns:[[{field:"id",title:"角色ID",width:0,hidden:"true",fit:true},{field:"roleName",title:"角色名称",width:30,align:"left",fit:true},{field:"roleDesc",title:"角色描述",width:30,align:"left",sortable:true,fit:true}]],toolbar:"#RoleToolbar"})}function loadGroupList(){$("#groupList").datagrid({fit:true,url:"platform/cc/centralizedauthorization/getSysGroup.json?type=group&appId="+_APPID,idField:"id",singleSelect:true,nowrap:false,striped:true,autoRowHeight:false,checkOnSelect:true,pagination:true,pageSize:dataOptions.pageSize,pageList:dataOptions.pageList,remoteSort:false,fitColumns:true,columns:[[{field:"id",title:"群组ID",width:25,hidden:"true",fit:true},{field:"groupName",title:"群组名称",width:25,align:"left",fit:true},{field:"groupDesc",title:"群组描述",width:80,align:"left",sortable:true,fit:true}]],onLoadSuccess:function(a){if(a.rows.length>0){}},toolbar:"#groupToolbar"})}function loadPositionList(){$("#positionList").datagrid({fit:true,url:"platform/cc/centralizedauthorization/getSysPosition.json?type=position&appId="+_APPID,idField:"id",nowrap:false,striped:true,singleSelect:true,autoRowHeight:false,checkOnSelect:true,remoteSort:false,pagination:true,pageSize:dataOptions.pageSize,pageList:dataOptions.pageList,fitColumns:true,columns:[[{field:"id",title:"岗位ID",width:25,hidden:"true",fit:true},{field:"positionName",title:"岗位名称",width:25,align:"left",fit:true},{field:"positionDesc",title:"岗位描述",width:80,align:"left",sortable:true,fit:true}]],onLoadSuccess:function(a){if(a.rows.length>0){}},toolbar:"#positionToolbar"})}function searchRoleFun(b){if(b==null){$.messager.alert("操作提示","请输入查询条件！","info");return}var a=$("#roleList").datagrid("options").queryParams;a.roleQueryKey=b;$("#roleList").datagrid("options").queryParams=a;$("#roleList").datagrid("load")}function reloadTabData(){switch(window.TARGET_TYPE){case"R":loadRoleList();break;case"D":loadDeptTree();break;case"G":loadGroupList();break;case"P":loadPositionList();break}}function searchPositionFun(b){if(b==null){$.messager.alert("操作提示","请输入查询条件！","info");return}var a=$("#positionList").datagrid("options").queryParams;a.positionKeyWord=b;$("#positionList").datagrid("options").queryParams=a;$("#positionList").datagrid("load")}function searchGroupFun(b){if(b==null){$.messager.alert("操作提示","请输入查询条件！","info");return}var a=$("#groupList").datagrid("options").queryParams;a.queryKeyWord=b;$("#groupList").datagrid("options").queryParams=a;$("#groupList").datagrid("load")}function loadUserTreeQueryResult(queryResult){var queryJson=eval(queryResult);$("#orgTree_user").tree("loadData",queryJson);if(functionAction==false){$("#orgTree_user").tree("expandAll")}}function loadDeptTreeQueryResult(queryResult){var queryJson=eval(queryResult);$("#orgTree_dept").tree("loadData",queryJson);$("#orgTree_dept").tree("expandAll")}$(function(){$(".tabs").find("li").click(function(){window.TARGET_TYPE="R";var a=$(this).text();switch(a){case"角色":window.TARGET_TYPE="R";window.loadAuthInfoData();break;case"用户":window.TARGET_TYPE="U";window.loadAuthInfoData();break;case"部门":window.TARGET_TYPE="D";window.loadAuthInfoData();break;case"群组":window.TARGET_TYPE="G";window.loadAuthInfoData();break;case"岗位":window.TARGET_TYPE="P";window.loadAuthInfoData();break;default:window.TARGET_TYPE="R"}window.TARGET_ID=null})});$(function(){function a(){var b;switch(window.TARGET_TYPE){case"R":b=$("#roleList").datagrid("getSelections");if(!b||!b[0]){break}window.TARGET_ID=b[0].id;window.loadAuthInfoData();break;case"U":b=$("#dgUser").datagrid("getSelections");if(!b||!b[0]){break}window.TARGET_ID=b[0].ID;window.loadAuthInfoData();break;case"D":b=$("#orgTree_dept").tree("getSelected");if(!b){break}window.TARGET_ID=b.id;window.loadAuthInfoData();break;case"G":b=$("#groupList").datagrid("getSelections");if(!b||!b[0]){break}window.TARGET_ID=b[0].id;window.loadAuthInfoData();break;case"P":b=$("#positionList").datagrid("getSelections");if(!b||!b[0]){break}window.TARGET_ID=b[0].id;window.loadAuthInfoData();break;default:b=null}$(".searchbox-text").val("")}$("#roleList").datagrid({onClickRow:function(c,b){a()}});$("#dgUser").datagrid({onClickRow:function(c,b){a()}});$("#orgTree_dept").tree({onSelect:function(){a()}});$("#groupList").datagrid({onClickRow:function(c,b){a()}});$("#positionList").datagrid({onClickRow:function(c,b){a()}})});function authSelectDept(){var a=new CommonSelector("dept","deptSelectCommonDialog","authSelectedDeptId",null,null,null,null,null,null,null,600,400);a.init(false,"selectDeptDialogCallBack",1)}function selectDeptDialogCallBack(a){if(data&&data.length>0){$("#authSelectedDeptId").val(a[0].deptId);}searchDeptData()}function saveSelectedDeptId(a){$("#authSelectedDeptId").val(a);searchDeptData();$("#authSelectDeptDialog").dialog("close")}function searchData(){$("#dgUser").datagrid("options").url="platform/cc/sysdept/getUserDataByPage.json?_status=1";var b=$("#userQueryText").searchbox("getValue");var a={search_LOGIN_NAME:b,search_USER_NAME:b};$("#dgUser").datagrid("load",a);$("#dgUser").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections")}function searchDeptData(){$("#dgUser").datagrid("options").url="platform/cc/sysdept/getUserDataByPage.json?_status=1";var a=$("#authSelectedDeptId").val();var c="";if(a!=null&&a.length>0){c="dept"}var d=$("#userQueryText").searchbox("getValue");var b={search_LOGIN_NAME:d};b.id=a;b.type=c;$("#dgUser").datagrid("load",b);$("#dgUser").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections")};