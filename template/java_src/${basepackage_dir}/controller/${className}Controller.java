<#include "/custom.include">
<#include "/java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

<#include "/java_imports.include">

@Controller
@RequestMapping(value = "/${classNameLower}")
public class ${className}Controller extends BaseController{
    private final String LIST_ACTION = "redirect:/${actionBasePath}/list.do";
    @Autowired
    private I${className}Service ${classNameLower}Service;
	
	
    @RequestMapping(value = "/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response,
            ${className}Query ${classNameLower}Query) {
        ModelAndView mav = new ModelAndView();
        Page<${className}> page = ${classNameLower}Service.listPage(${classNameLower}Query);
        mav.addObject("page", page);
        mav.addObject("query", ${classNameLower}Query);
        mav.setViewName("${classNameLower}/list");
        return mav;
    }

    /**
     * 查看对象
     **/
    @RequestMapping(value = "/show")
    public ModelAndView show(HttpServletRequest request, HttpServletResponse response, Long id) throws Exception {
        ${className} ${classNameLower} = ${classNameLower}Service.getSystemUser(id);
        return new ModelAndView("${classNameLower}/show", "${classNameLower}", ${classNameLower});
    }
    
    /**
     * 进入新增页面
     **/
    @RequestMapping(value = "/create")
    public ModelAndView create(HttpServletRequest request, HttpServletResponse response, ${className} ${classNameLower})
            throws Exception {
        return new ModelAndView("${classNameLower}/create", "${classNameLower}", ${classNameLower});
    }
    /**
     * 保存新增对象
     */
    @ResponseBody
    @RequestMapping(value = "/save")
    public void save(HttpServletRequest request, HttpServletResponse response, ${className} ${classNameLower}) {
        systemUserService.save(${classNameLower});
        outJson(response, "保存成功");
    }
    
    /**
     * 进入更新页面
     **/
    @RequestMapping(value = "/edit")
    public ModelAndView edit(HttpServletRequest request, HttpServletResponse response, Long id) throws Exception {
        ${className} systemUser = ${classNameLower}Service.get${className}(id);
        return new ModelAndView("${classNameLower}/edit", "${classNameLower}", ${classNameLower});
    }
    
    /**
     * 保存更新对象
     **/
    @RequestMapping(value = "/update")
    public ModelAndView update(HttpServletRequest request, HttpServletResponse response, ${className} ${classNameLower})
            throws Exception {
        ${classNameLower}Service.update(${classNameLower});
        return new ModelAndView(LIST_ACTION);
    }
    
    public void outJson(HttpServletResponse response, Object obj) {
        try {
            Gson gson = new Gson();
            String json = gson.toJson(obj.toString());
            response.setContentType("text/json;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.write(json);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

<#macro generateIdParameter>
	<#if table.compositeId>
		${className}Id id = new ${className}Id();
		bind(request, id);
	<#else>
		<#list table.compositeIdColumns as column>
		${column.javaType} id = new ${column.javaType}(request.getParameter("${column.columnNameLower}"));
		</#list>
	</#if>
</#macro>