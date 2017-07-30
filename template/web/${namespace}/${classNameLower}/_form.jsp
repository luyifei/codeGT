<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<<#list table.columns as column>
<#if column.htmlHidden>
    <input type="hidden" id="${column.columnNameLower}" name="${column.columnNameLower}" value="<@jspEl classNameLower+"."+column.columnNameLower/>"/>
</#if>
</#list>

<#list table.columns as column>
    <#if !column.htmlHidden>    
    <tr class="table-row">    
        <td class="table-name">
            <#if !column.nullable><span class="required">*</span></#if>${column.constantName}:
        </td>       
        <td class="table-value">
    <#if column.isDateTimeColumn>
        <input value="<@jspEl classNameLower+"."+column.columnNameLower+"String"/>" onclick="WdatePicker({dateFmt:'<%=${className}.FORMAT_${column.constantName}%>'})" id="${column.columnNameLower}String" name="${column.columnNameLower}String"  maxlength="0" class="${column.validateString}" />
    <#else>
        <input type="text" id="${column.columnNameLower}" name="${column.columnNameLower}" value="<@jspEl classNameLower+"."+column.columnNameLower/>" placeholder="${column.constantName}"  class="col-xs-10 col-sm-5">
    </#if>
        </td>
    </tr>   
    </#if>
</#list>
