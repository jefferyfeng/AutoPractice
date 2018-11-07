<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd">

    <!-- 开启静态资源访问 -->
    <mvc:default-servlet-handler></mvc:default-servlet-handler>

    <!-- 扫描controller -->
    <context:component-scan base-package="${config.groupId}.modules.*.${config.controllerPackageName}"></context:component-scan>

    <!-- 开启springmvc注解 -->
    <mvc:annotation-driven></mvc:annotation-driven>

    <!-- 配置静态资源 -->
    <bean id="InternalResourceViewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/"></property>
        <property name="suffix" value=".jsp"></property>
    </bean>

    <!-- 配置上传文件 -->
    <bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
        <property name="maxUploadSize" value="1024000000"></property>
    </bean>

</beans>