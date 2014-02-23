<cfcomponent name="Pages" extends="coldbox.system.EventHandler" output="false" accessors="true" autowire="true">
	<cfproperty name="pageService" inject="ioc:pageList" type="ioc" scope="variables" />
	<cfproperty name="yt" inject="ioc:youTube" type="ioc" scope="variables" />
	<cfproperty name="rss" inject="ioc:rss" type="ioc" scope="variables" />
	<cfproperty name="securityService" inject="model:securityService" type="model" scope="variables" />
	
	<cfproperty name="siteService" inject="model:siteService" type="model" scope="variables" />
	
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
	<cffunction name="preHandler" returntype="void" output="false" hint="Gets the Services">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfscript>	
		 	//Defaults
		 	event.paramValue("Page.PageDir","");
		 	event.paramValue("SubPage.PageDir","");
		 	
		 	//Get Layout
		 	if(prc.settings.ismobile and not prc.settings.override){
				event.setLayout('Layout.Mobile');
			} else if(not prc.settings.isMobile and prc.settings.overRide){
				event.setLayout('Layout.Mobile');
			} else {
				event.setLayout('Layout.Test');
				//Get ALL MENU CATEGORIES
				prc.cats = pageService.GetCat();
				//Get FRONT PAGE NEWS TITLES
				prc.sidenews = pageService.GetNewsTitles(MaxRows=5,orderBy='isSticky Desc, PageDate Desc');
			}
			//Get FRONT PAGE NEWS TITLES
			/*prc.theNews = siteService.GetNews(videoUser='holtonmediagroup');*/
		</cfscript>
		
	</cffunction>

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="index" output="false" hint="index">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			prc.DTS = CreateODBCDateTime(now());
			event.paramValue("error","0");
			if(rc.error) {
				getPlugin("MessageBox").setMessage(type="error", message="Login Error. Please try again");
			}
			prc.currentpage = pageService.Getpage(PageDir=rc.Page.PageDir);
			prc.subs = pageService.GetAllSubPages(PageID=prc.currentpage.PageID);
				
			rc.title = "Login";
			rc.description = "Login";
			rc.keywords = "login";
			//rc.fimage = "#getSetting('websiteUrl')#/inc/images/#prc.currentpage.PageImage#";
			//writeDump(session);
			
			if(isDefined('rc.username')) {
				try {                           
            	prc.login=securityService.authorize(username=rc.username,password=rc.password,url=getSetting('websiteurl'));                      
            	}                                    
            	catch(any e) {                                    
            		getPlugin("MessageBox").setMessage(type="error", message="Login Error Catch. Please try again");                        
            		setNextevent(URL="#getSetting('websiteurl')#/login");                           
           		}
           		if(prc.login) {
           			location(url="/cms",addToken='no');
           		} else {
           			getPlugin("MessageBox").setMessage(type="error", message="Login Error. Please try again");                        
            		setNextevent(URL="#getSetting('websiteurl')#/login"); 
           		}
			}
		
			event.setView("login/index");
		</cfscript>
	</cffunction>
	<cffunction name="auth" returntype="void" output="false" hint="My main event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			//event.noRender();
			
			prc.DTS = CreateODBCDateTime(now());
			event.paramValue("error","0");
			if(rc.error) {
				getPlugin("MessageBox").setMessage(type="error", message="Login Error. Please try again");
			}
			try {                           
            	prc.login=siteService.auth(username=rc.username,password=rc.password,url=getSetting('websiteurl'));                      
            }                                    
            catch(any e) {                                    
            	getPlugin("MessageBox").setMessage(type="error", message="Login Error Catch. Please try again");                        
            	setNextevent(URL="#getSetting('websiteurl')#/login");                           
            }
            if(prc.login.error){
            	getPlugin("MessageBox").setMessage(type="error", message="Login Error. Please try again");                        
            	setNextevent(URL="#getSetting('websiteurl')#/login"); 
            }
			if(prc.login.role is 'admin' and not prc.login.error){
				prc.success=true;
				location(url="/cms/");
			} else if(prc.login.role is 'user' and not prc.login.error) {
				prc.success=true;
				location(url="/");
			} else {
				prc.success=false;
				location(url="/login");
			}
			
			/*
<cfif IsDefined('FORM.Submit')>
    <!-- Check Username, Password, and Level of Administration -->
    <cfquery name="check_user">
            SELECT UserName, Pass, admin, FName, LName, UserID
            FROM Users
            WHERE UserName = '#FORM.username#' 
			AND pass = '#FORM.pass#'
    </cfquery>
    <!-- If there is a valid User then Login user -->
    <cfif check_user.recordcount is not 0>
        <!-- Log them in with a timeout of 30 minutes (1800 sec) and set level of Admin-->
        <cflogin idletimeout="7200" applicationtoken="#this.name#" cookiedomain="#this.URL#">
            <cfloginuser 
                    name = "#FORM.username#"
                    password ="#FORM.pass#"
                    roles = "#check_user.admin#">
        </cflogin>
		<cfif IsUserInRole('admin')>
		<cflock scope="session" type="exclusive" timeout="120" throwontimeout="yes">
        <cfset session.UserID = check_user.UserID>
		<cfset session.Username = check_user.UserName>
		<cfset session.FirstName = check_user.FName>
		<cfset session.LastName = check_user.LName>
		</cflock>
        <cfquery name="SaveEdit">
  		 UPDATE Users SET Last = #DTS# WHERE UserName="#check_user.UserName#"
 		</cfquery>
        <cflocation url="/admin/index.cfm" addtoken="yes">
        
		</cfif>
               
    <cfelse>
        <!-- If an invalid Login Attemp, Set invalid to 1 for invalid login script -->
        <cflocation url="/login/error=?" addtoken="no">
    </cfif>
</cfif>*/
			//writeDump(rc);
			//writeDump(prc);
			//writeDump(session);
			//abort;
			//event.setView("login/auth");
		</cfscript>
	</cffunction>
	
	<cffunction name="lost" returntype="void" output="false" hint="My main event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			
			writeDump(rc);abort;
			event.setView("login/lost");
		</cfscript>
	</cffunction>	

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

