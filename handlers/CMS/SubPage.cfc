<cfcomponent name="Page" extends="coldbox.system.EventHandler" output="false" accessors="true" autowire="true">
	<cfproperty name="pageService" inject="ioc:pageList" type="ioc" scope="variables" />
	<cfproperty name="createService" inject="model:createService" scope="variables" />
	<cfproperty name="editService" inject="model:editService" scope="variables" />
	<cfproperty name="pageDAO" inject="ioc:pageDAO" type="ioc" scope="variables" />
	<cfproperty name="userService" inject="ioc:userList" type="ioc" scope="variables" />
	<cfproperty name="seoService" inject="ioc:SeoTitle" type="ioc" scope="variables" />
	
	<cfscript>
		this.prehandler_only 		= "cms.admin.prehandler";
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
	

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="add" output="false" hint="index">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			event.paramValue("categoryID","1");
			event.paramValue("userID","1");
			event.paramValue("pageDate",Now());
			event.paramValue("PageDescription","");
			event.paramValue("pageTitle","");
			event.paramValue("pageKeywords","");
			event.paramValue("photo","");
			event.paramValue("PageLink","");
			event.paramValue("editor_office2003","");
			var local = StructNew();
			local.CurrentPage=GetFileFromPath(GetBaseTemplatePath());
			local.imagepath=getSetting('imagepath');
			local.thumbpath=getSetting('thumbpath');
			
			local.getCount = pageService.GetAllSubPages();
			local.getTypes = pageService.GetPageTypes();
			
			local.gateway = pageService;
			local.dao = createService;
			local.users = userService;
			//writeDump(prc);abort;
			//insert new page
			event.setView("cms/subpage/add");
		</cfscript>
		<cfif(IsDefined("rc.MM_InsertRecord") AND rc.MM_InsertRecord EQ "form1")>
			<cfscript>
				local.theCount = local.GetCount.recordcount +1;
				local.cleanName = seoService.makeTitle(str='#rc.pageLink#');
			</cfscript>
			<cfif IsDefined("rc.Photo") AND #rc.Photo# NEQ "">
				<cfset local.thumbWidth = 320>
				<cffile action="upload" destination="#getSetting('imagepath')#" filefield="Photo" nameconflict="makeunique" result="local.imgResult">
				<cffile action="rename" source="#imagepath#/#cffile.serverFile#" destination="#imagepath#/#local.cleanname#.#cffile.serverFileExt#" nameconflict="overwrite" />
				<cfset local.FileName = "#local.cleanname#.#cffile.serverFileExt#">
				<cfset local.ThumbName = "th-#FileName#">
				<cfscript> 
					local.imgFile = createObject("java","javax.swing.ImageIcon").init("#getSetting('imagepath')#/#file.ServerFile#"); 
					imgFile.getImage(); 
					local.w = imgFile.getIconWidth(); 
					local.h = imgFile.getIconHeight();
					writeDump(local);abort;
				</cfscript>
				
				<cfif local.w GT getSetting('thumbWidth')>
					<cfimage action="resize" source="#getSetting('imagepath')#/#local.FileName#" width="#getSetting('thumbWidth')#" height="" destination="#getSetting('imagepath')#/#local.thumbName#" overwrite="true">
				<cfelse>
					<cffile action="copy" destination="#getSetting('imagepath')#/#local.ThumbName#" source="#getSetting('imagepath')#/#local.FileName#" > 
				</cfif>
				<cfset rc.pageText = '<h1>#rc.pageTitle#</h1><p><img src="/inc/images/#local.thumbName#" align="left" alt="#rc.pageTitle#">Sample Text. Delete me.</p>'>
			</cfif>
			<cfscript>
				prc.theid = createService.createSubPage(
				pageID=rc.pageID,
				Dorder=local.theCount,
				pageTitle=rc.pageTitle,
				PageKeywords=rc.pageKeywords,
				PageDescription=rc.PageDescription,
				PageImage=local.fileName,
				PageLink=rc.pageLink,
				PageDir=local.cleanName,
				PageName=local.cleanName,
				PageText=rc.pageText,
				PageDate=rc.pageDate,
				PageLast=rc.pageDate,
				userID=rc.userID,
				LuserID=rc.userID);
				//writeDump(rc);writeDump(prc);abort;
				location(url="/cms/subpage/edit/?pid=#prc.theid#",addToken='no');
			</cfscript>
		</cfif>
	</cffunction>
	
	<cffunction name="edit" output="false" hint="index">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			event.paramValue("pid","1");
			event.paramValue("categoryID","0");
			event.paramValue("GalleryID","0");
			event.paramValue("luserID","1");
			event.paramValue("pageLast",Now());
			event.paramValue("PageDescription","");
			event.paramValue("pageTitle","");
			event.paramValue("pageVideo","");
			event.paramValue("pageKeywords","");
			event.paramValue("PageImage","");
			event.paramValue("PageLink","");
			event.paramValue("PageText","");
			event.paramValue("PageType","");
			event.paramValue("DOrder","0");
			event.paramValue("PageLast",Now());
			var local = StructNew();
			prc.CurrentPage=GetFileFromPath(GetBaseTemplatePath());
			prc.imagepath=getSetting('imagepath');
			prc.thumbpath=getSetting('thumbpath');
			//Get Page
			prc.getPage = pageService.GetAllSubPages(pageID=rc.pid);
			
			if (not prc.getPage.recordcount){
				location(url="/cms/subpage/list/?error=1",addToken='no');
			}
			//Form Results
			if(IsDefined("rc.MM_InsertRecord") AND rc.MM_InsertRecord EQ "form1") {                						
					prc.Archive = createService.createArchive(
						PageType=prc.getPage.PageType,
						ArchiveType='Page',
						PageID=prc.getPage.PageID,
						Dorder=prc.getPage.DOrder,
						pageTitle=prc.getPage.pageTitle,
						PageKeywords=prc.getPage.pageKeywords,
						PageDescription=prc.getPage.PageDescription,
						PageImage=prc.getPage.PageImage,
						PageLink=prc.getPage.pageLink,
						PageDir=prc.getPage.PageDir,
						PageName=prc.getPage.PageName,
						PageText=prc.getPage.pageText,
						PageVideo=prc.getPage.PageVideo,
						PageDate=prc.getPage.pageDate,
						PageLast=prc.getPage.pageLast,
						userID=prc.getPage.userID,
						LuserID=prc.getPage.LuserID,
						GalleryID=prc.getPage.GalleryID,
						CategoryID=prc.getPage.CategoryID);
				}
			</cfscript>
			<!---UPLOAD IMAGE--->
		<cfif isDefined('rc.Photo') AND rc.photo NEQ ''>
			<cffile action="upload" destination="#getSetting('imagepath')#" filefield="Photo" nameconflict="makeunique" result="local.imgResult">
				<cffile action="rename" source="#getSetting('imagepath')#/#cffile.serverFile#" destination="#getSetting('imagepath')#/#prc.getPage.PageName#.#cffile.serverFileExt#" nameconflict="overwrite" />
				<cfset local.FileName = "#prc.getPage.PageName#.#cffile.serverFileExt#">
				<cfset local.ThumbName = "th-#FileName#">
				<cfscript> 
					local.imgFile = createObject("java","javax.swing.ImageIcon").init("#getSetting('imagepath')#/#file.ServerFile#"); 
					imgFile.getImage(); 
					local.w = imgFile.getIconWidth(); 
					local.h = imgFile.getIconHeight();
					writeDump(local);abort;
				</cfscript>
				
				<cfif local.w GT getSetting('thumbWidth')>
					<cfimage action="resize" source="#getSetting('imagepath')#/#local.FileName#" width="#getSetting('thumbWidth')#" height="" destination="#getSetting('imagepath')#/#local.thumbName#" overwrite="true">
				<cfelse>
					<cffile action="copy" destination="#getSetting('imagepath')#/#local.ThumbName#" source="#getSetting('imagepath')#/#local.FileName#" > 
				</cfif>
				<cfset local.myImage = local.FileName>
		<cfelse>
			<cfset local.myImage = rc.PageImage>
		</cfif>
		<cfscript>
			//Update Page 
			if(IsDefined("rc.MM_InsertRecord") AND rc.MM_InsertRecord EQ "form1") { 
				prc.update = editService.updatePage(
					PageType=rc.PageType,
					PageID=rc.PID,
					Dorder=rc.DOrder,
					pageTitle=rc.pageTitle,
					PageKeywords=rc.pageKeywords,
					PageDescription=rc.PageDescription,
					PageImage= local.myImage,
					PageLink=rc.pageLink,
					PageText=rc.pageText,
					PageVideo=rc.PageVideo,
					PageDate=rc.pageDate,
					PageLast=rc.pageLast,
					userID=rc.userID,
					LuserID=rc.LuserID,
					GalleryID=rc.GalleryID,
					CategoryID=rc.CategoryID,
					imagepath=prc.imagepath);
				location(url="/cms/page/list/?edit=yes",addToken='no'); 
			}
				
		
			event.setView("cms/page/edit");
		</cfscript>
	</cffunction>	<cffunction name="list" returntype="void" output="false" hint="">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			event.paramValue("id","1");
			event.paramValue("pid","1");
			getPlugin("MessageBox").setMessage(type="info", message="Drag & Drop to change page display order");
			
			if(IsDefined('rc.add')){
				getPlugin("MessageBox").setMessage(type="info", message="Webpage added successfully");				
			}
			if(IsDefined('rc.edit')){
				getPlugin("MessageBox").setMessage(type="info", message="Webpage edited successfully");				
			}
			if(IsDefined('rc.restore')){
				getPlugin("MessageBox").setMessage(type="info", message="Webpage restored successfully");				
			}
			
			
			
			prc.1stSortItems = "";
			
			if(structKeyExists(rc,"fieldNames")){
				var i = 0;                
				var l = ListLen(rc.fieldnames);                
              	var FieldName = "";                
	              for (i = 1; i lte l; i = i + 1)  // you also can use i++ instead                
	              {  
	              	  if(left(ListGetAt(rc.fieldnames, i),9) is "SortItem_") {
	              	  	
	              	  	prc.1stSortItems = listAppend(prc.1stSortItems,form[ListGetAt(rc.fieldnames, i)]);
	              	  }           
	
	                	
	                //FieldName = ListGetAt(rc.fieldnames, i);                
	                //form[FieldName] = rc[FieldName][1];                
	              }
            	prc.mycount =1;
            	var i = 0;                
				var l = ListLen(prc.1stSortItems);                
              	var FieldName = "";                
	              for (i = 1; i lte l; i = i + 1)  // you also can use i++ instead                
	              {  
	                prc.test = ReplaceNoCase(ListGetAt(prc.1stSortItems, i), 'SORTITEM_', '', 'all' );
	                prc.test2 = 'rc.sortitem_' & prc.test;
	                prc.update = pageService.updatePageOrder(Dorder=prc.mycount,pageID=val(prc.test));
	                prc.mycount ++;
	                //FieldName = ListGetAt(rc.fieldnames, i);                
	                //form[FieldName] = rc[FieldName][1];                
	              }
	            prc.GetPages = pageService.GetAllSubPages(pageID=rc.pid);
	            getPlugin("MessageBox").setMessage(type="info", message="Webpage order updated successfully");
	           // writeDump(rc);writeDump(prc);abort;
			} else {
				prc.GetPages = pageService.GetAllPages();
				prc.1stSortItems = listAppend(prc.1stSortItems,prc.GetPages.PageID);
			}
			
			
			event.setView("cms/page/list");
		</cfscript>
		<!---<cfif IsDefined('url.del') AND IsDefined('url.pid') AND IsUserInRole("admin")>
			<cfquery name="GNews">
			    Select *
			    FROM SubPages WHERE PageID = <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfloop query="GNews">
			<cfquery name="DeleteNews">
			    DELETE FROM SubPages WHERE SubPageID = <cfqueryparam value="#GNews.SubPageID#" cfsqltype="cf_sql_integer">
			  </cfquery>
			 </cfloop>	
			<cfquery name="DeleteNews">
			    DELETE FROM Pages WHERE PageID = <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_integer">
			 </cfquery>
			<cfset getPlugin("MessageBox").setMessage(type="info", message="Webpage deleted successfully")>
		</cfif>--->
	</cffunction>	

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

