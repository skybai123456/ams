<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
    <meta name="robots" content="none" />
    <title>资产报损编辑</title>    
	<link href="${path}/resources/ligerUI/skins/Gray/css/ligerui-all.css" rel="stylesheet" type="text/css"> 
	<link href="${path}/resources/css/main2.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/ui.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/base.css" rel="stylesheet" type="text/css" />
    
    <script src="${path}/resources/My97DatePicker/WdatePicker.js"  type="text/javascript"></script>
    <script src="${path}/resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="${path}/resources/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script type="text/javascript">
	    $(document).ready(function(){
			var oldParams=$("#sub_form").serialize();
			
			$("#btnSaveNext").bind("click",function(){
				/*var flag=checkUser();
				if(!flag){*/
					var url="${path}/assetmanage/assetdamage/save";         
					var params=$("#sub_form").serialize();
					parent.Public.ajaxPost(url,params,saveNext);
				/* } */
			});
			$("#btnSave").bind("click",function(){    //保存
				/* var flag=checkUser();
				if(!flag){ */
					var url="${path}/assetmanage/assetdamage/save";
					var params=$("#sub_form").serialize();
					parent.Public.ajaxPost(url,params,save);
				/* } */
			});
			$("#btnClose").bind("click",function(){    //关闭
				var params=$("#sub_form").serialize();
				if(oldParams!=params){
					$.ligerDialog.confirm('您有信息未保存，是否关闭？', function (yes) { 
						if(yes) parent.tab.removeSelectedTabItem();
					});
				}else{
					parent.tab.removeSelectedTabItem();					
				}
			});
		});
		function saveNext(data){
			data=eval(data);
			if(data.state){
				parent.Public.reloadTab(parent.SYSTEM.dwlb);
				parent.Public.tips({type: 0, content : data.message});
				window.location.reload();
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		function save(data){
			data=eval(data);
			if(data.state){
				parent.Public.reloadTab(parent.SYSTEM.dwlb);
				parent.Public.tips({type: 0, content : data.message});
				var tabId=parent.tab.getSelectedTabItemID();
				parent.Public.addTab("zcbsxq"+data.param,"资产报损详情","${path}/assetmanage/assetdamage/detail?id="+data.param);
				parent.Public.pageTabClose(tabId);
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		
		//检查当前资产报损
		function checkUser(){
			var name=$("#assetDamageID").val();
			var flag=true;
			$.ajax({
				type:"post",
				async:false,
				url:"${path}/assetmanage/assetdamage/checkAssetdamage",
				data:{name:name,id:"${model.assetDamageID}"},
	    		dataType:'json',
	    		contentType:"application/x-www-form-urlencoded; charset=utf-8",	
	    		success:function(data){
	    			if(data){
	    				parent.Public.tips({type: 2, content : '资产报损已存在！'});
	    				flag=true;
	    			}else{
						flag=false;
	    			}
	    		},
	    		error:function(){
	    			flag=true;
	    		}
			});
			return flag;
		}
    </script>
</head>
    <body>
       <div class="man_zone">
            <form id="sub_form" action="${path }/assetmanage/assetdamage/save" method="post">
            <table class="op_tb">
            	<caption style="text-align: center;">
            		<c:choose>
            			<c:when test="${empty model.assetDamageID}">资产报损申请</c:when>
            			<c:otherwise>
            				资产报损修改
            				<input type="hidden" name="assetDamageID" value="${model.assetDamageID }" />
            			</c:otherwise>
            		</c:choose>
            	</caption>
                <tbody>
                	
                    <tr>
                        <td class="label">
                            	资产编号及名称：
                        </td>
                        <td>
                            <%-- <input type="text" name="assetId" value="${model.assetId }"/> --%>
                            <select name="assetId">
									<c:forEach items="${assetinfList }" var="item">
										<option
											<c:if test="${item.assetId eq model.assetId }">selected</c:if>
											value="${item.assetId }">${item.assetId }-${item.assettypeId}</option>
									</c:forEach>
							</select>* 
                            <%-- <select name="assetId">
                            	<c:forEach items="${assetinList }" var="item">
                            		<option
                            			<c:if test="${item.assetId eq model.assetId }">selected</c:if>
                            			value="${item.assetId }">${item.assetId }-${item.assettypeName }</option>
                            	</c:forEach>
                            </select> --%>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	鉴定人编号：
                        </td>
                        <td>
                            <input type="text" name="userId" value="${model.userId }" />*
                            <%-- <select name="userId">
                            	<c:forEach items="${userList }" var="item">
                            		<option
                            		<c:if test="${ item.user_Id eq model.userId }">selected</c:if>
											value="${item.user_Id }">${item.user_Id }</option>
                            	</c:forEach>
                            </select> --%>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	损坏原因：
                        </td>
                        <td>
                            <input type="text" name="assetDamageRemark" value="${model.assetDamageRemark }"/>*
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	报损理由：
                        </td>
                        <td>
                            <input type="text" name="assetDamageReason" value="${model.assetDamageReason}" />*
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	鉴定意见：
                        </td>
                        <td>
                            <input type="text" name="assetDamageOpinion" value="${model.assetDamageOpinion }" />
                            
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	鉴定时间：
                        </td>
                        <td>
                            <%-- <input type="text" name="appDate" value="${model.appDate }" /> --%>
                             <input type="text" name="appDate" class="Wdate" style="300px" value="${model.appDate }" 
                            onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                            datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/"
                            errormsg="请选择正确的日期" />
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	审批意见：
                        </td>
                        <td>
                            <input type="text" name="lastOpinion" value="${model.lastOpinion }" />
                        </td>
                    </tr>
                    <tr>
						<td colspan="2" class="toolbottom" align="center"><c:if
								test="${empty model.assetDamageID }">
								<input type="button" class="ui-btn ui-btn-sp" id="btnSaveNext"
									value="保存并新建" />&nbsp;&nbsp;
							</c:if> <input type="button" class="ui-btn ui-btn-sp" id="btnSave"
							value="保存" />&nbsp;&nbsp; <input type="button"
							class="ui-btn-rad button blue" id="btnClose" value="关闭" /></td>
					</tr>
                    
                </tbody>
            </table>   
            </form>
        </div>
    </body>
</html>