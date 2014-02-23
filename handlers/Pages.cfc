<cfcomponent name="Pages" extends="coldbox.system.EventHandler" output="false" accessors="true" autowire="true">
	<cfproperty name="pageService" inject="ioc:pageList" type="ioc" scope="variables" />
	<cfproperty name="yt" inject="ioc:youTube" type="ioc" scope="variables" />
	<cfproperty name="rss" inject="ioc:rss" type="ioc" scope="variables" />
	
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
		 	prc.mName = 'Home';
		 	prc.mLink = '#getSetting('websiteurl')#/';
		 	//Get Layout
		 	if(prc.settings.ismobile and not prc.settings.override){
				event.setLayout('Layout.Mobile');
			} else if(not prc.settings.isMobile and prc.settings.overRide){
				event.setLayout('Layout.Mobile');
			} else {
				event.setLayout('Layout.Test');
			}
		</cfscript>
		
	</cffunction>
	
	<cffunction name="onMissingAction" returntype="void" output="false" hint="Executes if a request action (method) is not found in this handler">
		<cfargument name="event" >
		<cfargument name="missingAction" 	hint="The requested action string"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			var rc = event.getCollection();
			event.setView("404");
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="index" output="false" hint="index">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			prc.captcha = pageService.makeRandomString();
			prc.captchaHash = hash(prc.captcha);                        
            prc.currentpage = pageService.Getpage(PageDir=rc.Page.PageDir);                       
           
			if (isDefined('prc.currentpage.recordcount') AND prc.currentpage.recordcount) {				 
				event.setView("pages/page");
			} else {
				getPlugin("MessageBox").setMessage(type="error", message="We're sorry an error has occurred or this page does not exist.");                        
            	event.setView("404"); 
			}
			prc.subs = pageService.GetAllSubPages(PageID=prc.currentpage.PageID);
				
			rc.title = "#prc.currentpage.PageTitle#";
			rc.description = "#prc.currentpage.PageDescription#";
			rc.keywords = "#prc.currentpage.PageKeywords#";
			if(len(prc.currentpage.pageimage)) {
				rc.fimage = "#getSetting('websiteUrl')#/#getSetting('imageUrl')#/#prc.currentpage.PageImage#";
			}
			if(prc.currentpage.galleryID > "0"){
				prc.photos = pageService.GetPhotos(GalleryID=rc.galleryID);
			}		
			
		</cfscript>
	</cffunction>
	<cffunction name="subpage" returntype="void" output="false" hint="My main event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			
			prc.parent = pageService.Getpage(PageDir=rc.Page.PageDir);
			                        
            prc.subpage = pageService.GetSubPage(PageName=rc.SubPage.PageDir,PageID=prc.parent.PageID);                       
            
            if (!isDefined('prc.subpage.recordcount') OR prc.subpage.recordcount LT 1) {
				getPlugin("MessageBox").setMessage(type="error", message="We're sorry an error has occurred or this page does not exist.");                        
            	event.setView("404");  
			} else {
				event.setView("pages/subpage");
			}
						
			rc.title = "#prc.subpage.PageTitle#";
			rc.description = "#prc.subpage.PageDescription#";
			rc.keywords = "#prc.subpage.PageKeywords#";
			if(len(prc.subpage.pageimage)) {
				rc.fimage = "#getSetting('websiteUrl')#/#getSetting('imageUrl')#/#prc.subpage.PageImage#";
			}
		
			
		</cfscript>
	</cffunction>	

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

