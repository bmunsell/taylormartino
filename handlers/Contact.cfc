<cfcomponent name="Contact" output="false" hint="I am a new handler">
	<cfproperty name="pageService" inject="ioc:pageList" type="ioc" scope="variables" />
	<cfproperty name="yt" inject="ioc:youTube" type="ioc" scope="variables" />
	<cfproperty name="rss" inject="ioc:rss" type="ioc" scope="variables" />
	<cfproperty name="geo" inject="ioc:geocode" type="ioc" scope="variables" />
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
		 	prc.lat = 30.6930436;
			prc.lng = -88.0424764;
		 	//Get Layout
		 	if(prc.settings.ismobile and not prc.settings.override){
				event.setLayout('Layout.Mobile');
			} else if(not prc.settings.isMobile and prc.settings.overRide){
				event.setLayout('Layout.Mobile');
			} else {
				event.setLayout('Layout.Contact');
			}
		</cfscript>
		
	</cffunction>

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="index" output="false" hint="index">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			
			prc.currentpage = pageService.Getpage(PageDir='contact');
			
			prc.captcha = pageService.makeRandomString();
			prc.captchaHash = hash(prc.captcha);
			
			//prc.key = "ABQIAAAAdsk6q48Nwr_ojp_P7IdmqhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxQHHFQHbi46swgbRZvC5cZMbS8uqQ";
			//prc.address = "51 Saint Joesph Street Mobile Alabama";
			//prc.map = geo.geocode(prc.key,trim(prc.address));
			
			
				
			rc.title = "Taylor Martino Contact";
			rc.description = "Contact Taylor Martino";
			rc.keywords = "Taylor Martino,,contact";
			
			event.setView("contact/index");
		</cfscript>
	</cffunction>

	<cffunction name="send" output="false" hint="Send Contact Form" >
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfscript>
		//rc.test = "suely@taylormartino.com";
		event.paramValue("emailList",getSetting('emailList'));
		//event.paramValue("emailList",rc.test);
		event.paramValue("name","");
		event.paramValue("SSSemail","webform@cdfolio.com");
		event.paramValue("SSSPhone","");
		event.paramValue("comments","");
		event.paramValue("contactPref","");
		event.paramValue("subject","Taylor Martino Website Contact");
		var details = StructNew();
		if(rc.emailList is ''){
			rc.emailList = 'suely@taylormartino.com';
		}
		</cfscript>
		<cfif isDefined('rc.fieldnames')>
		<cfif hash(ucase(rc.captcha)) neq rc.captchaHash>
			
			<cfscript>
				event.noRender();
				getPlugin("MessageBox").setMessage(type="error", message="You did not enter the right captcha text.");
    			setNextEvent("contact/index");
			</cfscript>
		<cfelse>
		<cfset details.name = rc.name>
		<cfmail to="#rc.emailList#" subject="#rc.subject#" type="html" from="#rc.SSSemail#">			
			<h2>#rc.subject#</h2>
			<p>#rc.comments#</p>
			<br>
			<h3>#rc.name#</h3>
			<p>Please contact me via: #rc.contactPref#</p>
			<p>#rc.SSSemail#</p>
			<p>#rc.SSSPhone#</p>			
		</cfmail>
			<cfscript>
				event.noRender();
				
    			setNextEvent(event="contact/thankyou", persistStruct=details);
			</cfscript>
		</cfif>
		</cfif>	
	</cffunction>
	<cffunction name="thankyou" output="false" hint="thankyou">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			event.paramValue("name","");
			//writeDump(rc);writeDump(prc);abort;
			//prc.currentpage = pageService.Getpage(PageDir='contact');
		
			//prc.galleries = pageService.GetGalleries();		
				
			rc.title = "Thank you for contacting Taylor Martino";
			rc.description = "Thank you for contacting Taylor Martino";
			rc.keywords = "Taylor Martino,contact";
			
			event.setView("contact/thankyou");
		</cfscript>
	</cffunction>

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

