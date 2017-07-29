<#include "/java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.base.dao.Page;
import ${basepackage}.dao.${className}Dao;

<#include "/java_imports.include">
@Service
public class ${className}ServiceImpl implements I${className}Service{

    @Autowired
    ${className} ${classNameLower}Dao;

    public ${className} get${className}(Long id) {
        return (${className}) ${classNameLower}Dao.getById(id);
    }

    @Override
    public List<${className}> list${className}(${className}Query ${classNameLower}Query) {
        return ${classNameLower}Dao.list${className}(${classNameLower}Query);
    }

    @Override
    public Page<${className}> listPage(${className}Query ${classNameLower}Query) {
        return ${classNameLower}Dao.listPage(${classNameLower}Query);
    }

    @Override
    public void save(${className} systemUser) {
        ${classNameLower}Dao.save(systemUser);
    }

    @Override
    public void update(${className} ${classNameLower}) {
        ${classNameLower}Dao.update(${classNameLower});
    }

    @Override
    public void removeById(Long id) {
        ${classNameLower}Dao.removeById(id);
    }
}
