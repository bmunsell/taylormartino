<cfcomponent output="false" hint="Returns Photo Galleries">
	<cfproperty name="pageService" inject="ioc:pageList" type="ioc" scope="variables" />
	
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
		 	event.paramValue("videos.id","");
		 	event.paramValue("Gallery.Name","");
		 	
		 	//Get Layout
		 	if(prc.settings.ismobile and not prc.settings.override){
				event.setLayout('Layout.Mobile');
			} else if(not prc.settings.isMobile and prc.settings.overRide){
				event.setLayout('Layout.Mobile');
			} else {
				event.setLayout('Layout.Main');
				//Get ALL MENU CATEGORIES
				prc.cats = pageService.GetCat();
				//Get FRONT PAGE NEWS TITLES
				prc.sidenews = pageService.GetNewsTitles(MaxRows=5,orderBy='isSticky Desc, PageDate Desc');
			}
		</cfscript>
		
	</cffunction>

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="index" output="false" hint="index">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			
			prc.currentpage = pageService.Getpage(PageDir='photos');
		
			prc.galleries = pageService.GetGalleries(dontUse=4);		
				
			rc.title = "Taylor Martino Photos";
			rc.description = "View photos of Taylor Martino in action";
			rc.keywords = "Taylor Martino,artificial,reef,photos";
			rc.fimage = "#getSetting('websiteUrl')#/#getSetting('imageUrl')#/#prc.galleries.GPhoto#";
			
			event.setView("photos/index");
		</cfscript>
	</cffunction>
	
	<cffunction name="gallery" output="false" hint="index">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
		
			prc.gallery = pageService.GetGallery(GLink=rc.Gallery.Name);	
			prc.photos = pageService.GetPhotos(GalleryID=prc.gallery.GalleryID);
				
			rc.title = "Taylor Martino Photos";
			rc.description = "View photos of Taylor Martino in action";
			rc.keywords = "Taylor Martino,artificial,reef,photos";
			rc.fimage = "#getSetting('websiteUrl')#/#getSetting('imageUrl')#/#prc.gallery.GPhoto#";
			
			event.setView("photos/gallery");
		</cfscript>
	</cffunction>

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

