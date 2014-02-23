<cfcomponent name="News" extends="coldbox.system.EventHandler" output="false" accessors="true" autowire="true">
	<cfproperty name="pageService" inject="ioc:pageList" type="ioc" scope="variables" />
	<cfproperty name="yt" inject="ioc:youTube" type="ioc" scope="variables" />
	<cfproperty name="rss" inject="ioc:rss" type="ioc" scope="variables" />
	
	<cfproperty name="siteService" inject="model:siteService" type="model" scope="variables" />
	<cfproperty name="postService" inject="ioc:postsService" type="ioc" scope="variables" />
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
		 	event.paramValue("PageName","");
		 	event.paramValue("Year","#DatePart('yyyy', Now())#");
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
			prc.myPostsService = postService;
			prc.myPosts = postService.GETPOSTSS();
		</cfscript>
		
	</cffunction>

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="index" output="false" hint="index">
		<cfargument name="event">
		<cfargument name="prc"> 
		<cfset var rc = event.getCollection()>
		<cfscript>
			prc.news = pageService.GetYear(Year=rc.Year);
			try {                           
            	prc.current = pageService.GetPage(PageDir='news');                      
            }                                    
            catch(any e) {                                    
            	getPlugin("MessageBox").setMessage(type="error", message="We're sorry an error has occurred or this page does not exist.");                        
            	event.setView("404");                        
            }
			
			if(prc.news.recordcount lt 5) {	
				prc.news = pageService.GetNews(maxRows=5);
			}
			prc.years = pageService.GetNewsArchives();
			
			rc.title = "#rc.year#: #prc.current.PageTitle#";
			rc.description = "#rc.year#: #prc.current.PageDescription#";
			rc.keywords = "#rc.year#: #prc.current.PageKeywords#";
			if(len(prc.current.pageimage)) {
				rc.fimage = "#getSetting('websiteUrl')#/#getSetting('imageUrl')#/#prc.current.PageImage#";
			}
			
			event.setView("news/index");
		</cfscript>
	</cffunction>	<cffunction name="year" output="false" hint="year">
		<cfargument name="event">
		<cfargument name="prc">
		<cfset var rc = event.getCollection()>
		
		<cfscript>
			prc.mName = 'News';
		 	prc.mLink = '#getSetting('websiteurl')#/news';
			prc.news = pageService.GetYear(Year=rc.Year);
			try {                           
            	prc.current = pageService.GetPage(PageDir='news');                      
            }                                    
            catch(any e) {                                    
            	getPlugin("MessageBox").setMessage(type="error", message="We're sorry an error has occurred or this page does not exist.");                        
            	event.setView("404");                        
            }
			prc.years = pageService.GetNewsArchives();
			
			rc.title = "#prc.current.PageTitle#";
			rc.description = "#prc.current.PageDescription#";
			rc.keywords = "#prc.current.PageKeywords#";
			if(len(prc.current.pageimage)) {
				rc.fimage = "#getSetting('websiteUrl')#/#getSetting('imageUrl')#/#prc.current.PageImage#";
			}
			
			event.setView("news/index");
		</cfscript>
	</cffunction>	<cffunction name="article" output="false" hint="detail">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc"> 
		<cfscript>
			prc.mName = 'News';
		 	prc.mLink = '#getSetting('websiteurl')#/news';
		 	try {                           
            	prc.article = pageService.GetArticle(PageName=rc.PageName,Year=rc.Year);                     
            }                                    
            catch(any e) {                                    
            	getPlugin("MessageBox").setMessage(type="error", message="We're sorry an error has occurred or this page does not exist.");                        
            	event.setView("404");                        
            }
			
			
			rc.title = "#prc.article.PageTitle#";
			rc.description = "#prc.article.PageDescription#";
			rc.keywords = "#prc.article.PageKeywords#";
			if(len(prc.article.pageimage)) {
				rc.fimage = "#getSetting('websiteUrl')#/#getSetting('imageUrl')#/#prc.article.PageImage#";
			}
			
			event.setView("news/article");
		</cfscript>
	
	</cffunction>

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

