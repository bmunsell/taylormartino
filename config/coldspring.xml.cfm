<!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">
<beans default-autowire="false">

	<!-- **************** DATASOURCE *************** -->
					
	<bean id="QueryTools" class="360.QueryTools" singleton="true"/>
	<bean id="abbv" class="360.Abbv" singleton="true"/>
	<bean id="SeoTitle" class="360.seoTitle" singleton="true"/>
	<bean id="Crypt" class="360.Crypt" singleton="true"/>
    <bean id="Rss" class="360.Rss" singleton="true"/>
    <bean id="exportCSV" class="360.exportCSV" singleton="true"/>
	<bean id="youTube" class="360.youtube" singleton="true"/>
	<bean id="geocode" class="360.googlegeocode" singleton="true"/>
	

	<!-- **************** CMS *************** -->
	
	<bean id="pageList" class="360.pagesGateway" singleton="true">
		<constructor-arg name="datasource">  
            <value>${datasource}</value>  
        </constructor-arg>  		
	</bean>
	
	<bean id="pageDAO" class="360.pagesDAO" singleton="true">
		<constructor-arg name="datasource">  
            <value>${datasource}</value>  
        </constructor-arg>  		
	</bean>
	
	<bean id="SubPagesService" class="360.SubPagesGateway" singleton="true">
		<constructor-arg name="datasource">  
            <value>${datasource}</value>  
        </constructor-arg>  		
	</bean>
	
	
	<bean id="userList" class="360.usersGateway" singleton="true">
		<constructor-arg name="datasource">  
            <value>${datasource}</value>  
        </constructor-arg>  		
	</bean>
	
	<bean id="postsDAO" class="360.posts.postsDAO">
		<constructor-arg name="dsn"><value>${datasource}</value></constructor-arg>
	</bean>
	<bean id="postsGateway" class="360.posts.postsGateway">
		<constructor-arg name="dsn"><value>${datasource}</value></constructor-arg>
	</bean>
	<bean id="postsService" class="360.posts.postsService">
		<constructor-arg name="postsDAO">
			<ref bean="postsDAO"/>
		</constructor-arg>
		<constructor-arg name="postsGateway">
			<ref bean="postsGateway"/>
		</constructor-arg>
	</bean>

</beans>
