<cfcomponent name="CMS" extends="coldbox.system.EventHandler" output="false" accessors="true" autowire="true">
	<cfproperty name="pageService" inject="ioc:pageList" type="ioc" scope="variables" />
	<cfproperty name="userService" inject="ioc:userList" type="ioc" scope="variables" />
	
	<cfscript>
		this.prehandler_only 		= "";
		this.prehandler_except 		= "";
		this.posthandler_only 		= "";
		this.posthandler_except 	= "";
		this.aroundHandler_only 	= "";
		this.aroundHandler_except 	= "";		
		// REST HTTP Methods Allowed for actions.
		// Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods 	= {};
	</cfscript>

<!----------------------------------------- IMPLICIT EVENTS ------------------------------------------>

	<!--- UNCOMMENT HANDLER IMPLICIT EVENTS
	
	<!--- preHandler --->
	<cffunction name="preHandler" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event">
		<cfargument name="action" hint="The intercepted action"/>
		<cfargument name="eventArguments" hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			var rc = event.getCollection();
		</cfscript>
	</cffunction>

	<!--- postHandler --->
	<cffunction name="postHandler" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event">
		<cfargument name="action" 			hint="The intercepted action"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
	
	<!--- aroundHandler --->
	<cffunction name="aroundHandler" returntype="void" output="false" hint="Executes around any event in this handler">
		<cfargument name="event">
		<cfargument name="targetAction" 	hint="The intercepted action UDF method"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			var rc = event.getCollection();
			// process targeted action
			argument.targetAction(event);
		</cfscript>
	</cffunction>

	<!--- onMissingAction --->
	<cffunction name="onMissingAction" returntype="void" output="false" hint="Executes if a request action (method) is not found in this handler">
		<cfargument name="event" >
		<cfargument name="missingAction" 	hint="The requested action string"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
	
	<!--- onError --->
	<cffunction name="onError" output="false" hint="Executes if ANY action causes an exception">
		<cfargument name="event">
		<cfargument name="faultAction" 		hint="The action that caused the error"/>
		<cfargument name="exception"  		hint="The exception structure"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>	
			
		</cfscript>
	</cffunction>
	
	--->
	<cffunction name="onMissingAction" returntype="void" output="false" hint="Executes if a request action (method) is not found in this handler">
		<cfargument name="event" >
		<cfargument name="missingAction" 	hint="The requested action string"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			var rc = event.getCollection();
			event.setView("404");
		</cfscript>
	</cffunction>
	
	<!---<cffunction name="onError" output="false" hint="Executes if ANY action causes an exception">
		<cfargument name="event">
		<cfargument name="faultAction" 		hint="The action that caused the error"/>
		<cfargument name="exception"  		hint="The exception structure"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>	
			var rc = event.getCollection();
			event.setView("404");
		</cfscript>
	</cffunction>--->
	
	<cffunction name="preHandler" returntype="void" output="false" hint="Gets the Services">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfscript>
			if( !getModel('securityService').isLoggedIn() ){
				getPlugin("MessageBox").setMessage(type="error", message="Login Error. Please try again");                        
            	setNextevent(URL="#getSetting('websiteurl')#/login"); 
            }
			event.setLayout('Layout.Admin');
		</cfscript>
		
	</cffunction>

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="index" output="false" hint="index">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			var local = StructNew();
			prc.GetPages = pageService.GetAllPages();
			prc.GetSubPages = pageService.GetAllSubPages();
			prc.pcount = prc.GetPages.RecordCount + prc.GetSubPages.RecordCount;
			prc.getPosts = pageService.GetNews();
			prc.getGalleries = pageService.GetAllGalleries();
			prc.GetPhotos = pageService.GetAllPhotos();
			prc.getUsers = userService.GetAllUsers();
			event.setView("cms/index");
		</cfscript>

		<cfquery name="prc.GetUsers" datasource="#getSetting('datasource')#">
		SELECT UserID
		FROM Users
		</cfquery>
		
	</cffunction>
	<cffunction name="start" returntype="void" output="false" hint="">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			

		
			event.setView("cms/test");
		</cfscript>
	</cffunction>	

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

