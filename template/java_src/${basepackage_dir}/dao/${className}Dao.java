<#include "/java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.dao;

<#include "/java_imports.include">

import java.util.List;

import org.springframework.stereotype.Repository;


@Repository
public class ${className}Dao extends BaseIbatis3Dao<${className},${table.idColumn.javaType}>{
	
	@Override
	public String getIbatisMapperNamesapce() {
		return "${className}";
	}
	
	public Page<${className}> listPage(${className}Query ${classNameLower}Query){
        return pageQuery("list", ${classNameLower}Query);
    }
    public List<SystemUser> list${className}(${className}Query ${classNameLower}Query){
        return getSqlSessionTemplate().selectList("list", ${classNameLower}Query);
    }

}
