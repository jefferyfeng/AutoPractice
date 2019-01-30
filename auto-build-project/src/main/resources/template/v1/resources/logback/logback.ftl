<?xml version="1.0" encoding="UTF-8" ?>
<configuration>
    <!--定义日志文件的存储地址 勿在 LogBack 的配置中使用相对路径-->
    <!--<property name="LOG_HOME" value="${config.baseBossDir}/${config.projectName}/${config.projectName}_logs" />-->

    <!-- 日志保存文件 -->
    <#noparse>
    <!--<appender name="file" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>${LOG_HOME}/logback.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${LOG_HOME}/logback_%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
            <timeBasedFileNamingAndTriggeringPolicy
                    class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">
                <MaxFileSize>50MB</MaxFileSize>
            </timeBasedFileNamingAndTriggeringPolicy>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%5p] [%c] %m %n</pattern>
        </encoder>
    </appender>-->

    <appender name="stdout" class="ch.qos.logback.core.ConsoleAppender">
        <layout class="ch.qos.logback.classic.PatternLayout">
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%5p] [%c] %m %n</pattern>
        </layout>
    </appender>

    </#noparse>
    <!-- 全局日志等级 -->
    <root level="debug">
        <appender-ref ref="stdout"/>
    </root>
    <!-- 打印moudules包下日志 -->
    <logger name="${config.groupId}.modules" level="debug"/>

</configuration>
