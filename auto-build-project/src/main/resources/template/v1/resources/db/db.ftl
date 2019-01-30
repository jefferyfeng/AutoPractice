${config.dbType}.driver=<#if config.dbType=="mysql">com.mysql.jdbc.Driver<#elseif config.dbType=="oracle"></#if>
${config.dbType}.url=${config.dbUrl}
${config.dbType}.username=${config.username}
${config.dbType}.password=${config.password}