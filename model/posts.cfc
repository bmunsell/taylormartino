<cfcomponent output="false">

	<!---- properties ---->
	<cfproperty name="Postid" type="numeric"  />
	<cfproperty name="Pageid" type="numeric"  />
	<cfproperty name="Issticky" type="numeric"  />
	<cfproperty name="Isactive" type="numeric"  />
	<cfproperty name="Pagetitle" type="string"  />
	<cfproperty name="Pagekeywords" type="string"  />
	<cfproperty name="Pagedescription" type="string"  />
	<cfproperty name="Pageimage" type="string"  />
	<cfproperty name="Pagedir" type="string"  />
	<cfproperty name="Pagelink" type="string"  />
	<cfproperty name="Pagename" type="string"  />
	<cfproperty name="Pagetext" type="string"  />
	<cfproperty name="Pagetype" type="string"  />
	<cfproperty name="Pagevideo" type="string"  />
	<cfproperty name="Pagedate" type="date"  />
	<cfproperty name="Pagelast" type="date"  />
	<cfproperty name="Userid" type="numeric"  />
	<cfproperty name="Luserid" type="numeric"  />
	<cfproperty name="Galleryid" type="numeric"  />
	
	<cfset INSTANCE = {} />
	<cfset INSTANCE.Postid = "" />
	<cfset INSTANCE.Pageid = "" />
	<cfset INSTANCE.Issticky = "" />
	<cfset INSTANCE.Isactive = "" />
	<cfset INSTANCE.Pagetitle = "" />
	<cfset INSTANCE.Pagekeywords = "" />
	<cfset INSTANCE.Pagedescription = "" />
	<cfset INSTANCE.Pageimage = "" />
	<cfset INSTANCE.Pagedir = "" />
	<cfset INSTANCE.Pagelink = "" />
	<cfset INSTANCE.Pagename = "" />
	<cfset INSTANCE.Pagetext = "" />
	<cfset INSTANCE.Pagetype = "" />
	<cfset INSTANCE.Pagevideo = "" />
	<cfset INSTANCE.Pagedate = "" />
	<cfset INSTANCE.Pagelast = "" />
	<cfset INSTANCE.Userid = "" />
	<cfset INSTANCE.Luserid = "" />
	<cfset INSTANCE.Galleryid = "" />
	

	<!---- init ---->
	<cffunction name="init" returntype="any">
		<cfreturn this />
	</cffunction>

	
	 <!----INFO:If This Application is to be run under ColdFusion 9 then the following getters and setters can be removed.
	 			If you delete the getters and setters you should enable use-implicit-getters option in serviceconfig.xml present in webroot/WEB-INF/flex ---->
	
	<!---- Postid accesor ---->
	<cffunction name="getPostid" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Postid />
	</cffunction>
	<cffunction name="setPostid" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Postid = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pageid accesor ---->
	<cffunction name="getPageid" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pageid />
	</cffunction>
	<cffunction name="setPageid" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pageid = ARGUMENTS.value />
	</cffunction>
	
	<!---- Issticky accesor ---->
	<cffunction name="getIssticky" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Issticky />
	</cffunction>
	<cffunction name="setIssticky" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Issticky = ARGUMENTS.value />
	</cffunction>
	
	<!---- Isactive accesor ---->
	<cffunction name="getIsactive" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Isactive />
	</cffunction>
	<cffunction name="setIsactive" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Isactive = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagetitle accesor ---->
	<cffunction name="getPagetitle" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagetitle />
	</cffunction>
	<cffunction name="setPagetitle" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagetitle = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagekeywords accesor ---->
	<cffunction name="getPagekeywords" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagekeywords />
	</cffunction>
	<cffunction name="setPagekeywords" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagekeywords = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagedescription accesor ---->
	<cffunction name="getPagedescription" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagedescription />
	</cffunction>
	<cffunction name="setPagedescription" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagedescription = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pageimage accesor ---->
	<cffunction name="getPageimage" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pageimage />
	</cffunction>
	<cffunction name="setPageimage" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pageimage = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagedir accesor ---->
	<cffunction name="getPagedir" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagedir />
	</cffunction>
	<cffunction name="setPagedir" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagedir = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagelink accesor ---->
	<cffunction name="getPagelink" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagelink />
	</cffunction>
	<cffunction name="setPagelink" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagelink = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagename accesor ---->
	<cffunction name="getPagename" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagename />
	</cffunction>
	<cffunction name="setPagename" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagename = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagetext accesor ---->
	<cffunction name="getPagetext" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagetext />
	</cffunction>
	<cffunction name="setPagetext" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagetext = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagetype accesor ---->
	<cffunction name="getPagetype" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagetype />
	</cffunction>
	<cffunction name="setPagetype" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagetype = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagevideo accesor ---->
	<cffunction name="getPagevideo" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagevideo />
	</cffunction>
	<cffunction name="setPagevideo" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagevideo = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagedate accesor ---->
	<cffunction name="getPagedate" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagedate />
	</cffunction>
	<cffunction name="setPagedate" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagedate = ARGUMENTS.value />
	</cffunction>
	
	<!---- Pagelast accesor ---->
	<cffunction name="getPagelast" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Pagelast />
	</cffunction>
	<cffunction name="setPagelast" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Pagelast = ARGUMENTS.value />
	</cffunction>
	
	<!---- Userid accesor ---->
	<cffunction name="getUserid" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Userid />
	</cffunction>
	<cffunction name="setUserid" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Userid = ARGUMENTS.value />
	</cffunction>
	
	<!---- Luserid accesor ---->
	<cffunction name="getLuserid" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Luserid />
	</cffunction>
	<cffunction name="setLuserid" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Luserid = ARGUMENTS.value />
	</cffunction>
	
	<!---- Galleryid accesor ---->
	<cffunction name="getGalleryid" access="remote" output="false" returnType="Any">
		<cfreturn INSTANCE.Galleryid />
	</cffunction>
	<cffunction name="setGalleryid" access="remote" output="false" returnType="void">
		<cfargument name="value" required="true" type="any" />
		<cfset INSTANCE.Galleryid = ARGUMENTS.value />
	</cffunction>
	

</cfcomponent>
