<cfcomponent output="false" hint="CFBuilder-Generated:posts">

	<!----
           README for sample service

          This generated sample service contains functions that illustrate typical service operations.
          Use these functions as a starting point for creating your own service implementation. Modify the function signatures, 
          references to the database, and implementation according to your needs. Delete the functions that you do not use.
                
          Save your changes and return to Flash Builder. In Flash Builder Data/Services View, refresh the service. 
          Then drag service operations onto user interface components in Design View. For example, drag the getAllItems() operation onto a DataGrid.
                                
          This code is for prototyping only.
          Authenticate the user prior to allowing them to call these methods. You can find more information at http://www.adobe.com/go/cf9_usersecurity

      ---->


	<cfset INSTANCE = {} />
	<cfset INSTANCE.com = {} />
	
	<!---- load posts components ---->
	<cfset INSTANCE.com.posts = createObject('component', 'Posts').init() />
	<cfset INSTANCE.com.postsDAO = createObject('component', 'PostsDAO').init() />
	<cfset INSTANCE.com.postsGATEWAY = createObject('component', 'PostsGateway').init() />
	

	<!---- init ---->
	<cffunction name="init" returntype="any">
		<!---- return success ---->
		<cfreturn this />
	</cffunction>

	
	
	<!----
	
	POSTS SERVICES
	
	---->
	
	<!---- Create posts ---->
	<cffunction name="createposts" returntype="posts" access="remote">
		<cfargument name="item" type="posts" required="true" />
		<!---- Auto-generated method 
		  Insert a new record in posts 
		  Add authorization or any logical checks for secure access to your data ---->
		<cfset idcol=INSTANCE.com.postsDAO.create(ARGUMENTS.item.getPostid(), ARGUMENTS.item.getPageid(), ARGUMENTS.item.getIssticky(), ARGUMENTS.item.getIsactive(), ARGUMENTS.item.getPagetitle(), ARGUMENTS.item.getPagekeywords(), ARGUMENTS.item.getPagedescription(), ARGUMENTS.item.getPageimage(), ARGUMENTS.item.getPagedir(), ARGUMENTS.item.getPagelink(), ARGUMENTS.item.getPagename(), ARGUMENTS.item.getPagetext(), ARGUMENTS.item.getPagetype(), ARGUMENTS.item.getPagevideo(), ARGUMENTS.item.getPagedate(), ARGUMENTS.item.getPagelast(), ARGUMENTS.item.getUserid(), ARGUMENTS.item.getLuserid(), ARGUMENTS.item.getGalleryid()) /> 
		<!---- return created item ---->
		<cfreturn INSTANCE.com.postsDAO.read(idcol)/>
	</cffunction>
	
	
	<!---- Delete posts ---->
	<cffunction name="deleteposts" returntype="void" access="remote">
		<cfargument name="Postid" type="numeric" required="true" />
		<!---- Auto-generated method
		         Delete a record in the database 
				 Add authorization or any logical checks for secure access to your data ---->
				 
		<cfset INSTANCE.com.postsDAO.delete(ARGUMENTS.Postid) /> 
		<!---- return success ---->
		<cfreturn />
	</cffunction>
	
	<!---- Get All posts ---->
	<cffunction name="getAllposts" returntype="posts[]" access="remote">
		<!---- Auto-generated method
		        Retrieve set of records and return them as a query or array 
				Add authorization or any logical checks for secure access to your data ---->
		<!---- return items ---->		
		<cfreturn INSTANCE.com.postsGateway.getAll() />
	</cffunction>
	
	<!---- Get All Paged posts ---->
	<cffunction name="getposts_paged" returntype="posts[]" access="remote">
		<cfargument name="startIndex" type="numeric" required="true" />
		<cfargument name="numItems" type="numeric" required="true" />
		<!---- Auto-generated method
		         Return a page of numItems number of records as an array or query from the database for this startIndex 
				 Add authorization or any logical checks for secure access to your data ---->
		<!---- return paged items ---->
		<cfreturn INSTANCE.com.postsGateway.getAll_paged(ARGUMENTS.startIndex+1, ARGUMENTS.numItems) />
	</cffunction>
	
	<!---- Get posts ---->
	<cffunction name="getposts" returntype="posts" access="remote">
		<cfargument name="Postid" type="numeric" required="true" />
		<!---- Auto-generated method
		         Retrieve a single record and return it as a query or array 
				 Add authorization or any logical checks for secure access to your data ---->
		<!---- return item ---->
		<cfreturn INSTANCE.com.postsDAO.read(ARGUMENTS.Postid) />
	</cffunction>
	
	<!---- Update posts ---->
		<cffunction name="updateposts" returntype="posts" access="remote">
		<cfargument name="item" type="posts" required="true" />
		<!---- Auto-generated method
		         Update an existing record in the database 
				 Add authorization or any logical checks for secure access to your data ---->
		<!---- update posts ---->
		<cfset INSTANCE.com.postsDAO.update(ARGUMENTS.item.getPostid(), ARGUMENTS.item.getPageid(), ARGUMENTS.item.getIssticky(), ARGUMENTS.item.getIsactive(), ARGUMENTS.item.getPagetitle(), ARGUMENTS.item.getPagekeywords(), ARGUMENTS.item.getPagedescription(), ARGUMENTS.item.getPageimage(), ARGUMENTS.item.getPagedir(), ARGUMENTS.item.getPagelink(), ARGUMENTS.item.getPagename(), ARGUMENTS.item.getPagetext(), ARGUMENTS.item.getPagetype(), ARGUMENTS.item.getPagevideo(), ARGUMENTS.item.getPagedate(), ARGUMENTS.item.getPagelast(), ARGUMENTS.item.getUserid(), ARGUMENTS.item.getLuserid(), ARGUMENTS.item.getGalleryid()) /> 
		<!---- return success ---->
		<cfreturn ARGUMENTS.item/>
	</cffunction>
	
	
	<!---- Count posts ---->
	<cffunction name="count" returntype="numeric" access="remote">
	<!---- Auto-generated method
		         Return the number of items in your table 
				 Add authorization or any logical checks for secure access to your data  ---->
		<cfreturn INSTANCE.com.postsGateway.count() /> 
	</cffunction>

</cfcomponent> 
