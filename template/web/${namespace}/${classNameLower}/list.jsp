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
		                    <tr>
		                        <td class="search-key">
		                                                                            用户名
		                        </td>
		                        <td class="search-value">
		                              <input class="input-large" id="userName" type="text" name="userName" value="${query.userName}" placeholder="这里输入关键词" />
		                        </td>
		                        <td class="search-key">
                                                                                                    姓名
                                </td>
		                        <td class="search-value">
		                              <input class="input-large" id="name" type="text" name="name" value="${query.name}" placeholder="这里输入关键词" />
		                        </td>
		                    </tr>
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
                        <th>序号</th>
                        <th>编号</th>
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>职位</th>
                        <th>邮箱</th>
                        <th>最近登录</th>
                        <th>上次登录IP</th>
                        <th>状态</th>
                        <th class="center">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                    <c:when test="${not empty page.result}">
                        <!-- 开始循环 -->   
                        <c:forEach items="${page.result}" var="item" varStatus="vs">
                            <tr>
                                <td class='center' style="width: 20px;">
                                  <label><input type='checkbox' class="ace" name='ids' value="${item.id}" alt="${user.userName}"/><span class="lbl"></span></label>
                                </td>
                                <td>${item.userName}</td>
                                <td>${item.userName}</td>
                                <td>${item.userName}</td>
                                <td>${item.userName}</td>
                                <td>${item.userName}</td>
                                <td>${item.userName}</td>
                                <td>${item.userName}</td>
                                <td><input type="number" value="" id="jumpPageNumber" style="height:32px;width:70px;text-align:center;float:left;" placeholder="页码"></td>
                                <td class='center' style="width: 20px;">
                                    <label class="pull-center inline">
                                        <input id="id-button-borders" id="status${item.id}" <c:if test="${item.status == 0 }">checked="checked"</c:if> onclick="switchStatus(this.id,'status',${item.id})" type="checkbox" class="ace ace-switch ace-switch-7" >
                                        <span class="lbl middle"></span>
                                    </label>
                                </td>
                                <td>
                                    <a class='btn btn-xs btn-primary' title="编辑" onclick="edit(${item.id});"><i class='ace-icon fa fa-pencil-square-o'></i></a>
                                    <a class='btn btn-xs btn-warning' title="详情" onclick="show(${item.id});"><i class='ace-icon fa fa-info-circle'></i></a>
                                    <a class='btn btn-xs btn-danger' title="删除" onclick="remove(${item.id});"><i class='ace-icon fa fa-trash-o'></i></a>
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
            <simpletable:pageToolbar page="${page}">
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
            window.simpleTable = new SimpleTable('searchForm',${page.thisPageNumber},${page.pageSize},'${pageRequest.sortColumns}');
            
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
        		  content: 'systemUser/create.do'
        		});
        }
        function edit(id){
            layer.open({
                  type: 2,
                  title: '编辑',
                  area: ['800px', '650px'],
                  fixed: false,
                  maxmin: true,
                  content: 'systemUser/edit.do?id='+id
                });
        }
        function show(id){
            layer.open({
                  type: 2,
                  title: '详情',
                  area: ['800px', '650px'],
                  fixed: false,
                  maxmin: true,
                  content: 'systemUser/show.do?id='+id
                });
        }
        function remove(){
            layer.open({
                  type: 2,
                  title: '新增',
                  area: ['800px', '650px'],
                  fixed: false,
                  maxmin: true,
                  content: 'systemUser/create.do'
                });
        }
        <%-- function switchStatus(id,'status',id2){
            if(id != hcid1){
                hcid1 = id;
                qxhc1 = '';
            }
            var value = 1;
            var wqx = $("#"+id).attr("checked");
            if(qxhc1 == ''){
                if(wqx == 'checked'){
                    qxhc1 = 'checked';
                }else{
                    qxhc1 = 'unchecked';
                }
            }
            if(qxhc1 == 'checked'){
                value = 0;
                qxhc1 = 'unchecked';
            }else{
                value = 1;
                qxhc1 = 'checked';
            }
                var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
                $.get(url,function(data){
                    if(data=="success"){
                        //document.location.reload();
                    }
                });
        } --%>
        </script>
    </body>
</html>

