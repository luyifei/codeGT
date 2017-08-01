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
    <form action="${classNameLower}/update.do" name="saveForm" id="saveForm" method="post">
       <div class="main-container ace-save-state">
        <table class="table-info table-info-striped">
            <tr class="table-row">
                <td class="table-name" style="text-align: center;height: 40px;" colspan="2">
                     <h4>表单</h4>
                </td>
            </tr>
            <%@ include file="_form.jsp"%>
            <tr class="table-row">
                <td class="table-value" style="text-align: center;" colspan="2">
                    <a class="btn btn-sm btn-primary" onclick="save();">保存</a>
                    <a class="btn btn-sm btn-grey" onclick="cancel();">取消</a>
                </td>
            </tr>
        </table>
    </form>
<script type="text/javascript">
$(function() {
    
});

function save(){
    //加载层
    var load = layer.load(2, {shade: [0.3,'#fff'], time: 10*1000});
    $.ajax({
              url:"${classNameLower}/update.do",//提交地址
              data:$("#saveForm").serialize(),//将表单数据序列化
              type:"POST",
              dataType:"text",
              success:function(result){
                layer.close(load);
                layer.msg(result, 
                        {time: 1000, 
                         icon: 1,
                         yes: function(index){
                                layer.close(index);
                                }
                           },
                           function(){
                             parent.$('#searchForm').submit();
                           });
              }
          });
}
function cancel(){
    //先得到当前iframe层的索引
    var index = parent.layer.getFrameIndex(window.name);
    //再执行关闭   
    parent.layer.close(index); 
}
</script>
</body>
</html>