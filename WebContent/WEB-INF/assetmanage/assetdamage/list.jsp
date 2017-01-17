<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
    <meta name="robots" content="none" />
	<title>资产报损信息列表</title>
	<link href="${path}/resources/ligerUI/skins/Gray/css/ligerui-all.css" rel="stylesheet" type="text/css" />	
    <link href="${path}/resources/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css"/>
    <link href="${path}/resources/css/ui.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/main2.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/base.css" rel="stylesheet" type="text/css" />
    <script src="${path}/resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="${path}/resources/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="${path}/resources/js/config.js" type="text/javascript" ></script>
    <script src="${path}/resources/js/commonFN.js" type="text/javascript"></script>
    <script type="text/javascript">
    
	    var grid = null;
		$(document).ready(function(){
			grid = $("#maingrid").ligerGrid({
				toolbar: { items: [
					{ text: '新增', click: add, icon:'add'},               	
					{ line: true },
					{ text: '刷新', click: refresh, icon:'refresh'},
				]},
				columns: [
				{ display: '资产报损编号', name: 'assetDamageID', width: "200" },
				{ display: '资产类型', name: 'assetId', width: "150" },
				{ display: '损坏原因', name: 'assetDamageRemark', width: "200" },
				{ display: '鉴定人编号', name: 'userId', width: "150" },
				{ display: '报损理由', name: 'assetDamageReason', width: "200"}, 
				{ display: '鉴定意见', name: 'assetDamageOpinion', width: "150"},
				{ display: '鉴定时间', name: 'appDate', width: "200" },
				{ display: '审批意见', name: 'lastOpinion', width: "200" },
				
				{display: '操作',width: "234", render: function (rowdata, rowindex, value){
					var h="";
					h += "<a href='${path}/assetmanage/assetdamage/detail?id="+rowdata.assetDamageID+"' rel='pageTab' data-tabid='dwxx"+rowdata.assetDamageID+"' data-tabTxt='资产报损详细' data-parentOpen='true' style='color:teal'>详细</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:beginEdit(\"" + rowdata.assetDamageID + "\")' style='color:teal'>编辑</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:itemDel(\""+rowdata.assetDamageID+"\")' style='color:teal' >删除</a> ";
					return h;
				}}],
				usePager:true,
				delayLoad:true,//延迟加载
				root:'rows',
				record:'total',
	            url:"${path}/assetmanage/assetdamage/list",
				fixedCellHeight: false,
				rownumbers:true,
				clickToEdit:false,
				width: '100%',height:'99%'
			});
			search();
			Public.pageTab();//启用链接打开tab页
		});
		function add(){
			parent.Public.addTab("","新建资产报损","${path}/assetmanage/assetdamage/add");
		}
		function refresh(){
			window.location.reload();
		}
		function search(){
			grid.changePage("first");
			var params=$("#searchForm").serialize();
			grid.set("url","${path}/assetmanage/assetdamage/list?"+params);
			grid.reload();
			return false;
		}
		function beginEdit(assetDamageID) { 
			parent.Public.addTab("zcbsbj"+assetDamageID,"资产报损编辑","${path}/assetmanage/assetdamage/edit?id="+assetDamageID);
	    }
		//删除
	    function itemDel(assetDamageID){
	    	$.ligerDialog.confirm('请不要随意删除，如要删除，请联系管理员？', function (yes) {
	    		if(yes){
		        	parent.Public.ajaxPost("${path}/assetmanage/assetdamage/delete?id="+assetDamageID,"",function(data){
		        		data=eval(data);
		        		if(data){
		        			parent.Public.tips({type: 0, content : data.message});
		        			grid.reload();
		        		}else{
		        			parent.Public.tips({type: 0, content : data.message});
		        		}
		        	});
	    		}
	    	});
	    }
	</script>
</head>
<body>
	<div class="search-wrap">
		<form id="searchForm" onsubmit="return search();" method="post">
		<dl>
			<dd>
				<label class="b-label" for="txt_kw">资产报损编号：</label>
				<span class="ui-search"><input type="text" name="assetDamageID" value="${model.assetDamageID }" class="ui-input"></span><span class="ui-search"></span>
				
				&nbsp;&nbsp;
				<label class="b-label" for="txt_kw">资产类型：</label>
				<span class="ui-search"><input type="text" name="assetId" value="${model.assetId }" class="ui-input"></span>
				
				&nbsp;&nbsp;
				<label class="b-label" for="txt_kw">鉴定人编号：</label>
				<span class="ui-search"><input type="text" name="userId" value="${model.userId }" class="ui-input"></span>
				
				&nbsp;&nbsp;
				<label class="b-label" for="txt_kw">鉴定时间：</label>
				<span class="ui-search"><input type="text" name="appDate" value="${model.appDate }" class="ui-input"></span>
				
			    <input id="btnOK" type="submit" value="搜 索" class="ui-btn">
			    <input type="reset" value="重置" class="ui-btn" >
			</dd>
		</dl>
		</form>		
	</div>
	<div class="clear ht_10"></div>
    <div id="maingrid" style="margin:0; padding:0"></div>
</body>
</html>