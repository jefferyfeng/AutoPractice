<!DOCTYPE web-app PUBLIC
        "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
        "http://java.sun.com/dtd/web-app_2_3.dtd" >

  <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd" id="WebApp_ID" version="3.0">
      <display-name>Archetype Created Web Application</display-name>
      <welcome-file-list>
          <welcome-file>index.jsp</welcome-file>
      </welcome-file-list>

      <context-param>
          <param-name>contextConfigLocation</param-name>
          <param-value>classpath:/config/spring/spring.xml</param-value>
      </context-param>

      <filter>
          <filter-name>characterEncoding</filter-name>
          <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
          <init-param>
              <param-name>encoding</param-name>
              <param-value>utf-8</param-value>
          </init-param>
      </filter>
      <filter-mapping>
          <filter-name>characterEncoding</filter-name>
          <url-pattern>/*</url-pattern>
      </filter-mapping>

      <listener>
          <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
      </listener>


      <servlet>
          <servlet-name>mvc</servlet-name>
          <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
          <init-param>
              <param-name>contextConfigLocation</param-name>
              <param-value>
                  classpath:/config/spring/spring-mvc.xml
              </param-value>
          </init-param>
          <load-on-startup>0</load-on-startup>
      </servlet>
      <servlet-mapping>
          <servlet-name>mvc</servlet-name>
          <url-pattern>/</url-pattern>
      </servlet-mapping>

      <!-- 定义服务器内出现404错误时跳转页面 -->
      <error-page>
          <error-code>404</error-code>
          <location>/index.jsp</location>
      </error-page>
  </web-app>
