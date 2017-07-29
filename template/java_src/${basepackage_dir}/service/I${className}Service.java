<#include "/java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.service;

import java.util.List;

import org.springframework.stereotype.Service;

<#include "/java_imports.include">
public interface I${className}Service {
    /**
     * 根据主键查询
     * 
     * @param id
     * @return
     */
    ${className} get${className}(Long id);

    /**
     * 条件查询
     * 
     * @param ${classNameLower}Query
     * @return
     */
    List<${className}> list${className}(${className}Query ${classNameLower}Query);

    /**
     * 分页查询
     * 
     * @param ${classNameLower}Query
     * @return
     */
    Page<${className}> listPage(${className}Query ${classNameLower}Query);

    /**
     * 保存
     * 
     * @param ${classNameLower}
     */
    void save(${className} ${classNameLower});

    /**
     * 更新
     * 
     * @param ${classNameLower}
     */
    void update(${className} ${classNameLower});

    /**
     * 根据主键删除
     * 
     * @param id
     */
    void removeById(Long id);
}
