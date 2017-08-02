<#include "/macro.include"/> 
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags/simpletable" prefix="simpletable"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="/views/system/admin/base.jsp"%> 
    </head> 
<body>
        
<div class="main-container ace-save-state" id="main-container">


<div id="page-content">
                        
  <div class="row-fluid">
    <div class="page-content">
            <!-- 检索  -->
            <form action="${classNameLower}/list.do" method="post" name="searchForm" id="searchForm">
            <div class="tabbable">
                <div class="tab-content">
                      <div id="home" class="tab-pane fade in active">
                        <table>
                        <#list table.notPkColumns?chunk(4) as row>
		                    <tr>
		                      <#list row as column>
                              <#if !column.htmlHidden> 
		                        <td class="search-key">
		                              ${column.constantName}
		                        </td>
		                        <td class="search-value">
		                              <#if column.isDateTimeColumn>
				                        <input value="<@jspEl classNameLower+"."+column.columnNameLower+"Begin"/>" onclick="WdatePicker({dateFmt:'<%=${className}.FORMAT_${column.constantName}%>'})" id="${column.columnNameLower}Begin" name="${column.columnNameLower}Begin"  />
				                        <input value="<@jspEl classNameLower+"."+column.columnNameLower+"End"/>" onclick="WdatePicker({dateFmt:'<%=${className}.FORMAT_${column.constantName}%>'})" id="${column.columnNameLower}End" name="${column.columnNameLower}End"  />
				                       <#else>
		                                <input class="input-large" id="${column.columnNameLower}" type="text" name="${column.columnNameLower}" value="<@jspEl "query."+column.columnNameLower/>" placeholder="这里输入关键词" />
				                       </#if>
		                        </td>
		                       </#if>
                               </#list>
		                    </tr>
		                    </#list>
		                    <tr>
		                      <td colspan="10">
                                     <a class="btn btn-sm btn-primary" onclick="submit();">搜索 <i class="ace-icon glyphicon glyphicon-search"></i></a>
                                     <a class="btn btn-sm btn-primary" onclick="create();">新增 <i class="ace-icon glyphicon glyphicon-plus"></i></a>
                                </td>
		                    </tr>
		                </table>
                      </div>
                </div>
            </div>
            <!-- 检索  -->
            <table id="table_report" class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th class="center">
                            <label class="pos-rel">
                                <input type="checkbox" class="ace" />
                                <span class="lbl"></span>
                            </label>
                        </th>
                        <#list table.columns as column>
		                <#if !column.htmlHidden>
		                <th>${column.constantName}</th>
		                </#if>
		                </#list>
                        <th class="center">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                    <c:when test="<@jspEl 'not empty page.result'/>">
                        <!-- 开始循环 -->   
                        <c:forEach items="<@jspEl 'page.result'/>" var="item" varStatus="vs">
                            <tr>
                                <td class='center' style="width: 20px;">
                                  <label><input type='checkbox' class="ace" name='ids' value="<@jspEl 'item.id'/>" alt="alt内容"/><span class="lbl"></span></label>
                                </td>
                                <#list table.columns as column>
				                <#if !column.htmlHidden>
				                <td><#rt>
				                    <#compress>
				                    <#if column.isDateTimeColumn>
				                        <@jspEl "item."+column.columnNameLower+"String"/>
				                    <#else>
				                        <@jspEl "item."+column.columnNameLower/>
				                    </#if>
				                    </#compress>
				                <#lt></td>
				                </#if>
				                </#list>
                                <td>
                                    <a class='btn btn-xs btn-primary' title="编辑" onclick="edit(<@jspEl 'item.id'/>);"><i class='ace-icon fa fa-pencil-square-o'></i></a>
                                    <a class='btn btn-xs btn-warning' title="详情" onclick="show(<@jspEl 'item.id'/>);"><i class='ace-icon fa fa-info-circle'></i></a>
                                    <a class='btn btn-xs btn-danger' title="删除" onclick="remove(<@jspEl 'item.id'/>);"><i class='ace-icon fa fa-trash-o'></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </c:when>
                        <c:otherwise>
	                        <tr class="main_info">
	                            <td colspan="10" class="center">没有相关数据</td>
	                        </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <simpletable:pageToolbar page="<@jspEl 'page'/>">
            </simpletable:pageToolbar>
        </form>
    </div>
  
</div>
    
</div>
</div>
        
        <!-- 返回顶部  -->
        <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse display">
            <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
        </a>
        
        <!-- 引入 -->
        <script type="text/javascript" src="scripts/bootstrap/dist/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="scripts/ace/dist/js/ace-elements.min.js"></script>
        <script type="text/javascript" src="scripts/ace/dist/js/ace.min.js"></script>
        
        <script type="text/javascript" src="scripts/chosen/chosen.jquery.min.js"></script><!-- 下拉框 -->
        <script type="text/javascript" src="scripts/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
        <script type="text/javascript" src="scripts/bootbox.js/bootbox.min.js"></script><!-- 确认窗口 -->
        <script type="text/javascript" src="scripts/layer/layer.js"></script>
        
        <!-- 引入 -->
        
        
        <script type="text/javascript" src="<c:url value="/widgets/simpletable/simpletable.js"/>"></script>
        <script type="text/javascript">
        $(document).ready(function() {
            // 分页需要依赖的初始化动作
            window.simpleTable = new SimpleTable('searchForm',<@jspEl 'page.thisPageNumber'/>,<@jspEl 'page.pageSize'/>,'<@jspEl 'pageRequest.sortColumns'/>');
            
          //复选框
            $('table th input:checkbox').on('click' , function(){
                var that = this;
                $(this).closest('table').find('tr > td:first-child input:checkbox')
                .each(function(){
                    this.checked = that.checked;
                    $(this).closest('tr').toggleClass('selected');
                });
                    
            });
            $(top.hangge());
        });
        //检索
        function submit(){
        	$("#searchForm").submit();
        }
        function create(){
        	layer.open({
        		  type: 2,
        		  title: '新增',
        		  area: ['800px', '650px'],
        		  fixed: false,
        		  maxmin: true,
        		  content: '${classNameLower}/create.do'
        		});
        }
        function edit(id){
            layer.open({
                  type: 2,
                  title: '编辑',
                  area: ['800px', '650px'],
                  fixed: false,
                  maxmin: true,
                  content: '${classNameLower}/edit.do?id='+id
                });
        }
        function show(id){
            layer.open({
                  type: 2,
                  title: '详情',
                  area: ['800px', '650px'],
                  fixed: false,
                  maxmin: true,
                  content: '${classNameLower}/show.do?id='+id
                });
        }
        function remove(){
            layer.open({
                  type: 2,
                  title: '新增',
                  area: ['800px', '650px'],
                  fixed: false,
                  maxmin: true,
                  content: '${classNameLower}/create.do'
                });
        }
        </script>
    </body>
</html>

