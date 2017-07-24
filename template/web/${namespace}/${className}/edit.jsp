<#include "/macro.include"/>
<#include "/custom.include"/>  
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/commons/taglibs.jsp" %>


<rapid:override name="head">
	<title><%=${className}.TABLE_ALIAS%>编辑</title>
</rapid:override>

<rapid:override name="content">
	<form action="<@jspEl 'ctx'/>${actionBasePath}/update.do" method="post">
		
		
		<table class="formTable">
		<%@ include file="form_include.jsp" %>
		</table>
		
		<div class="form-btn-wrap">
			<input id="submitButton" name="submitButton" type="submit" value="提交" />
			<input type="button" value="返回列表" onclick="window.location='<@jspEl 'ctx'/>${actionBasePath}/list.do'"/>
		</div>
	</form>
	
	<script>
		
		new Validation(document.forms[0],{onSubmit:true,onFormValidate : function(result,form) {
			var finalResult = result;
			
			//在这里添加自定义验证
			
			return disableSubmit(finalResult,'submitButton');
		}});
	</script>
</rapid:override>

<%-- jsp模板继承,具体使用请查看: http://code.google.com/p/rapid-framework/wiki/rapid_jsp_extends --%>
<%@ include file="base.jsp" %>