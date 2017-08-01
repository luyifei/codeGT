<#include "/macro.include"/> 
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <base href="<%=basePath%>">
        <meta charset="utf-8" />
        <%@ include file="/views/system/admin/base.jsp"%> 
    </head>
<body class="main-content">
       <div class="main-container ace-save-state">
        <#list table.columns as column>
		    <#if column.pk>
		        <input type="hidden" id="${column.columnNameLower}" name="${column.columnNameLower}" value="<@jspEl classNameLower+"."+column.columnNameLower/>"/>
		    </#if>
	    </#list>
	    
	    <table class="table-info table-info-striped">
	        <tr class="table-row">
                <td class="table-name" style="text-align: center;height: 40px;" colspan="2">
                     <h4>表单</h4>
                </td>
            </tr>
	        <#list table.columns as column>
		        <#if !column.htmlHidden>
		            <tr class="table-row">
		                <td class="table-name">
		                    ${column.constantName}:
		                </td>
		                <td class="table-value">
		                <#rt>
		                    <#compress>
		                        <#if column.isDateTimeColumn>
		                          <@jspEl classNameLower+"."+column.columnNameLower+"String"/>
		                        <#else>
		                          <@jspEl classNameLower+"."+column.columnNameLower/>
		                        </#if>
	                        </#compress>
		                <#lt>
		                </td> 
		            </tr>
		        </#if>
	        </#list>
	        <tr class="table-row">
                <td class="table-value" style="text-align: center;" colspan="2">
                    <a class="btn btn-sm btn-grey" onclick="cancel();">关闭</a>
                </td>
            </tr>
        </table>
<script type="text/javascript">
function cancel(){
    //先得到当前iframe层的索引
    var index = parent.layer.getFrameIndex(window.name);
    //再执行关闭   
    parent.layer.close(index); 
}
</script>
</body>
</html>