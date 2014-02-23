<cfcomponent output="false">

	<!---- init ---->
	<cffunction name="init" returntype="any">
		<cfset INSTANCE = {} />
		<cfset INSTANCE.dao = createObject('component', 'PostsDAO').init() />
		<cfreturn this />
	</cffunction>

	<!---- getAll ---->
	<cffunction name="getAll" returntype="Posts[]">
		<cfset var collection = [] />
		<cfset var obj = '' />
		<cfset var qry = '' />
		<cfset var i = 0 />
		<!---- get all records from database ---->
		<cfquery name="qry" datasource="tm">
			SELECT * FROM posts
		</cfquery>
		<!---- load value objects ---->
		<cfloop from="1" to="#qry.recordcount#" index="i">
			<cfset obj = createObject('component', 'Posts').init() />
			<cfset obj.setPostid(qry.Postid[i]) />
			<cfset obj.setPageid(qry.Pageid[i]) />
			<cfset obj.setIssticky(qry.Issticky[i]) />
			<cfset obj.setIsactive(qry.Isactive[i]) />
			<cfset obj.setPagetitle(qry.Pagetitle[i]) />
			<cfset obj.setPagekeywords(qry.Pagekeywords[i]) />
			<cfset obj.setPagedescription(qry.Pagedescription[i]) />
			<cfset obj.setPageimage(qry.Pageimage[i]) />
			<cfset obj.setPagedir(qry.Pagedir[i]) />
			<cfset obj.setPagelink(qry.Pagelink[i]) />
			<cfset obj.setPagename(qry.Pagename[i]) />
			<cfset obj.setPagetext(qry.Pagetext[i]) />
			<cfset obj.setPagetype(qry.Pagetype[i]) />
			<cfset obj.setPagevideo(qry.Pagevideo[i]) />
			<cfset obj.setPagedate(qry.Pagedate[i]) />
			<cfset obj.setPagelast(qry.Pagelast[i]) />
			<cfset obj.setUserid(qry.Userid[i]) />
			<cfset obj.setLuserid(qry.Luserid[i]) />
			<cfset obj.setGalleryid(qry.Galleryid[i]) />
			<cfset arrayAppend(collection, obj) />
		</cfloop>
		<!---- return success ---->
		<cfreturn collection />
	</cffunction>
	
	<!---- getAll_paged ---->
	<cffunction name="getAll_paged" returntype="Posts[]">
		<cfargument name="start" type="numeric" required="true" />
		<cfargument name="count" type="numeric" required="true" />
		<cfset var collection = [] />
		<cfset var obj = '' />
		<cfset var qry = '' />
		<cfset var i = 0 />
		<cfset var end=0 />
		<!---- get all records from database ---->
		<cfquery name="qry" datasource="tm">
			SELECT * FROM posts			
		</cfquery>
		<!---- load value objects ---->
		<cfif (ARGUMENTS.start + ARGUMENTS.count - 1) GTE qry.recordcount >
			<cfset end =  qry.recordcount />
		<cfelse>
			<cfset end= ARGUMENTS.start + ARGUMENTS.count - 1 />
		</cfif>
		<cfloop from="#ARGUMENTS.start#" to="#end#" index="i">
			<cfset obj = createObject('component', 'Posts').init() />
			<cfset obj.setPostid(qry.Postid[i]) />
			<cfset obj.setPageid(qry.Pageid[i]) />
			<cfset obj.setIssticky(qry.Issticky[i]) />
			<cfset obj.setIsactive(qry.Isactive[i]) />
			<cfset obj.setPagetitle(qry.Pagetitle[i]) />
			<cfset obj.setPagekeywords(qry.Pagekeywords[i]) />
			<cfset obj.setPagedescription(qry.Pagedescription[i]) />
			<cfset obj.setPageimage(qry.Pageimage[i]) />
			<cfset obj.setPagedir(qry.Pagedir[i]) />
			<cfset obj.setPagelink(qry.Pagelink[i]) />
			<cfset obj.setPagename(qry.Pagename[i]) />
			<cfset obj.setPagetext(qry.Pagetext[i]) />
			<cfset obj.setPagetype(qry.Pagetype[i]) />
			<cfset obj.setPagevideo(qry.Pagevideo[i]) />
			<cfset obj.setPagedate(qry.Pagedate[i]) />
			<cfset obj.setPagelast(qry.Pagelast[i]) />
			<cfset obj.setUserid(qry.Userid[i]) />
			<cfset obj.setLuserid(qry.Luserid[i]) />
			<cfset obj.setGalleryid(qry.Galleryid[i]) />
			<cfset arrayAppend(collection, obj) />
		</cfloop>
		<!---- return success ---->
		<cfreturn collection />
	</cffunction>
	
	<!---- count ---->
	<cffunction name="count" returntype="numeric">
		<cfset var qry = "" />
		<cfquery name="qry" datasource="tm">
			SELECT COUNT(PostID) AS total
			FROM posts
		</cfquery>
		<cfreturn qry.total[1] />
	</cffunction>

</cfcomponent>
