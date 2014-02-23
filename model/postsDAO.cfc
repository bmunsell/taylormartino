<cfcomponent output="false">

	<!---- Auto-generated method
		         Add authroization or any logical checks for secure access to your data ---->
	<!---- init ---->
	<cffunction name="init" returntype="any">
		<cfreturn this />
	</cffunction>
	
	<!---- create ---->
	<cffunction name="create" returntype="any">
		<cfargument name="PostID" type="numeric" required="true" /><cfargument name="PageID" type="numeric" required="true" /><cfargument name="isSticky" type="numeric" required="true" /><cfargument name="isActive" type="numeric" required="true" /><cfargument name="PageTitle" type="string" required="true" /><cfargument name="PageKeywords" type="string" required="true" /><cfargument name="PageDescription" type="string" required="true" /><cfargument name="PageImage" type="string" required="true" /><cfargument name="PageDir" type="string" required="true" /><cfargument name="PageLink" type="string" required="true" /><cfargument name="PageName" type="string" required="true" /><cfargument name="PageText" type="string" required="true" /><cfargument name="PageType" type="string" required="true" /><cfargument name="PageVideo" type="string" required="true" /><cfargument name="PageDate" type="date" required="true" /><cfargument name="PageLast" type="date" required="true" /><cfargument name="UserID" type="numeric" required="true" /><cfargument name="LUserID" type="numeric" required="true" /><cfargument name="GalleryID" type="numeric" required="true" />
		
		<!---- Auto-generated method
		         Add authroization or any logical checks for secure access to your data ---->
		<cfset var IdentityCol="" />
		<cfset var qry="" />	
		<!----TODO:  Below code is for table without auto increment enabled for primary key .Change the query Appropriately---->
		<!---- insert record ---->
		<cfquery name="qry" datasource="tm">
			INSERT INTO posts
			(
				postid,pageid,issticky,isactive,pagetitle,
				pagekeywords,pagedescription,pageimage,pagedir,pagelink,
				pagename,pagetext,pagetype,pagevideo,pagedate,
				pagelast,userid,luserid,galleryid
			)
			VALUES
			(
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.PostID#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.PageID#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#ARGUMENTS.isSticky#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#ARGUMENTS.isActive#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageTitle#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageKeywords#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageDescription#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageImage#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageDir#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageLink#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageName#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#ARGUMENTS.PageText#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageType#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageVideo#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#ARGUMENTS.PageDate#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#ARGUMENTS.PageLast#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.UserID#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.LUserID#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.GalleryID#" null="false" />
			)
		</cfquery>
		
		
		<cfif arguments.PostID NEQ ''>
			<cfset IdentityCol=arguments.PostID>
					      
		<cfelse>
		<!----TODO: This logic is for diffrent db's.Delete the conditions not applicable ---->	 
      	<cfif IsDefined("qry.GENERATEDKEY")>
            <cfset identityCol = qry.GENERATEDKEY>
		<cfelseif IsDefined("qry.IDENTITYCOL")><!---- SQL Server only---->	
            <cfset identityCol = qry.IDENTITYCOL>
      	<cfelseif IsDefined("qry.GENERATED_KEY")> <!---- MySQL only---->
            <cfset identityCol = qry.GENERATED_KEY>
      	<cfelseif IsDefined("qry.GENERATED_KEYS")>
            <cfset identityCol = qry.GENERATED_KEYS>
      	<cfelseif IsDefined("qry.ROWID")><!---- Oracle only ---->
            <cfset identityCol = qry.ROWID>
      	<cfelseif IsDefined("qry.SYB_IDENTITY")><!---- Sybase only ---->
            <cfset identityCol = qry.SYB_IDENTITY>
      	<cfelseif IsDefined("qry.SERIAL_COL")> <!----Informix only---->
            <cfset identityCol = qry.SERIAL_COL>
      	<cfelseif IsDefined("qry.KEY_VALUE")>
            <cfset identityCol = qry.KEY_VALUE>
      	</cfif>
		
	  	</cfif>	
		<!---- return IdentityCol ---->
		<cfreturn IdentityCol />
	</cffunction>
	
	
	<!---- read ---->
	<cffunction name="read" returntype="Posts">
		<cfargument name="id" type="any" required="true" />
		
		<!---- Auto-generated method
		         Add authroization or any logical checks for secure access to your data ---->
		<cfset var obj = createObject('component', 'Posts').init() />
		<cfset var i = 1 />
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="tm">
			SELECT postid,pageid,issticky,isactive,pagetitle,
					pagekeywords,pagedescription,pageimage,pagedir,pagelink,
					pagename,pagetext,pagetype,pagevideo,pagedate,
					pagelast,userid,luserid,galleryid
			FROM posts
			where postid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.id#" null="false" />
		</cfquery>
		<!---- load value object ---->
		<cfset obj.setPostID(qry.PostID[i]) />
		<cfset obj.setPageID(qry.PageID[i]) />
		<cfset obj.setisSticky(qry.isSticky[i]) />
		<cfset obj.setisActive(qry.isActive[i]) />
		<cfset obj.setPageTitle(qry.PageTitle[i]) />
		<cfset obj.setPageKeywords(qry.PageKeywords[i]) />
		<cfset obj.setPageDescription(qry.PageDescription[i]) />
		<cfset obj.setPageImage(qry.PageImage[i]) />
		<cfset obj.setPageDir(qry.PageDir[i]) />
		<cfset obj.setPageLink(qry.PageLink[i]) />
		<cfset obj.setPageName(qry.PageName[i]) />
		<cfset obj.setPageText(qry.PageText[i]) />
		<cfset obj.setPageType(qry.PageType[i]) />
		<cfset obj.setPageVideo(qry.PageVideo[i]) />
		<cfset obj.setPageDate(qry.PageDate[i]) />
		<cfset obj.setPageLast(qry.PageLast[i]) />
		<cfset obj.setUserID(qry.UserID[i]) />
		<cfset obj.setLUserID(qry.LUserID[i]) />
		<cfset obj.setGalleryID(qry.GalleryID[i]) />
		<!---- return success ---->
		<cfreturn obj />
	</cffunction>
	
	<!---- update ---->
	<cffunction name="update" returntype="void">
		<cfargument name="PostID" type="numeric" required="true" />
		<cfargument name="PageID" type="numeric" required="true" />
		<cfargument name="isSticky" type="numeric" required="true" />
		<cfargument name="isActive" type="numeric" required="true" />
		<cfargument name="PageTitle" type="string" required="true" />
		<cfargument name="PageKeywords" type="string" required="true" />
		<cfargument name="PageDescription" type="string" required="true" />
		<cfargument name="PageImage" type="string" required="true" />
		<cfargument name="PageDir" type="string" required="true" />
		<cfargument name="PageLink" type="string" required="true" />
		<cfargument name="PageName" type="string" required="true" />
		<cfargument name="PageText" type="string" required="true" />
		<cfargument name="PageType" type="string" required="true" />
		<cfargument name="PageVideo" type="string" required="true" />
		<cfargument name="PageDate" type="date" required="true" />
		<cfargument name="PageLast" type="date" required="true" />
		<cfargument name="UserID" type="numeric" required="true" />
		<cfargument name="LUserID" type="numeric" required="true" />
		<cfargument name="GalleryID" type="numeric" required="true" />
		<!---- Auto-generated method
		         Add authroization or any logical checks for secure access to your data ---->
		
		<cfset var qry="" />
		<!---- update database ---->
		<cfquery name="qry" datasource="tm">
			UPDATE posts
			SET pageid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.PageID#" null="false" />,
				issticky = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#ARGUMENTS.isSticky#" null="false" />,
				isactive = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#ARGUMENTS.isActive#" null="false" />,
				pagetitle = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageTitle#" null="false" />,
				pagekeywords = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageKeywords#" null="false" />,
				pagedescription = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageDescription#" null="false" />,
				pageimage = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageImage#" null="false" />,
				pagedir = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageDir#" null="false" />,
				pagelink = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageLink#" null="false" />,
				pagename = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageName#" null="false" />,
				pagetext = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#ARGUMENTS.PageText#" null="false" />,
				pagetype = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageType#" null="false" />,
				pagevideo = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.PageVideo#" null="false" />,
				pagedate = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#ARGUMENTS.PageDate#" null="false" />,
				pagelast = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#ARGUMENTS.PageLast#" null="false" />,
				userid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.UserID#" null="false" />,
				luserid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.LUserID#" null="false" />,
				galleryid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.GalleryID#" null="false" />
			WHERE postid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.PostID#" null="false" />
		</cfquery>
		<!---- return success ---->
		<cfreturn />
	</cffunction>
	
	<!---- delete ---->
	<cffunction name="delete" returntype="void">
		<cfargument name="PostID" type="numeric" required="true" />
		<!---- Auto-generated method
		         Add authroization or any logical checks for secure access to your data ---->
		<cfset var qry="" />
		<!---- delete from database ---->
		<cfquery name="qry" datasource="tm">
			DELETE FROM posts
			WHERE postid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.PostID#" null="false" />
		</cfquery>
		<!---- return success ---->
		<cfreturn />
	</cffunction>

</cfcomponent>
