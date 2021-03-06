<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop" xmlns:tx="http://www.springframework.org/schema/tx"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
						   http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context
						   http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop
         				   http://www.springframework.org/schema/aop/spring-aop.xsd http://www.springframework.org/schema/tx
     					   http://www.springframework.org/schema/tx/spring-tx.xsd">

    <!-- 扫描${config.servicePackageName} -->
    <context:component-scan base-package="${config.groupId}.modules.**.service" />

    <!-- 引入db.properties配置文件 -->
    <context:property-placeholder location="classpath:/config/db/db.properties" />

    <!-- 启动AspectJ支持   只对扫描过的bean有效-->
    <aop:aspectj-autoproxy proxy-target-class="true" expose-proxy="true" />

    <!-- Druid数据源配置-->
    <bean id="dataSource" class="com.alibaba.druid.pool.DruidDataSource">
        <property name="driverClassName" value="${"$"}{${config.dbType}.driver}"></property>
        <property name="url" value="${"$"}{${config.dbType}.url}"></property>
        <property name="username" value="${"$"}{${config.dbType}.username}"></property>
        <property name="password" value="${"$"}{${config.dbType}.password}"></property>
    </bean>

    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="dataSource" ref="dataSource"></property>
        <property name="typeAliasesPackage" value="${typeAliasesPackage}"></property>
        <property name="mapperLocations" value="${mapperLocations}"></property>
        <property name="plugins">
            <list>
                <!-- ibatis分页插件拦截器配置 -->
                <bean id="pageInterceptor" class="${interceptorPackage}.PageInterceptor">
                    <property name="dialect" value="mysql" />
                    <property name="pageSqlId" value=".*Page$" />
                </bean>
            </list>
        </property>
    </bean>

    <bean id="mapperScannerConfigurer" class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <property name="sqlSessionFactoryBeanName" value="sqlSessionFactory"></property>
        <property name="basePackage" value="${basePackage}"></property>
    </bean>

    <!-- 配置事务 -->
    <bean id ="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="dataSource"></property>
    </bean>

    <!-- 开启事务注解 -->
    <tx:annotation-driven transaction-manager="transactionManager"></tx:annotation-driven>

</beans>