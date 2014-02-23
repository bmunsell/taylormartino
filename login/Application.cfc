<cfcomponent output="false">
	<cfset Application.Started = Now() />
		<cfset this.name = "gsnlogin" />
		<cfset this.ApplicationTimeout = CreateTimeSpan(0,6,0,0) />
		<cfset this.sessionManagement = True />
		<cfset this.sessionTimeout = CreateTimeSpan(0,6,0,0) />
		<cfset this.customtagpaths = "CustomTags" />
		<cfset this.datasource = "gsn" />
		<cfset this.GoogleMapKey = "ABQIAAAAdsk6q48Nwr_ojp_P7IdmqhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxQHHFQHbi46swgbRZvC5cZMbS8uqQ" />
        <cfset this.URL = "gulfsportsnet.com" />
		<cfset this.local = "gsn.360webpath.com" />
		
	
	<!--- define custom coldfusion mappings. Keys are mapping names, values are full paths  --->
	<cfset this.mappings = structNew()>
	<cfset this.mappings["/root"] = getDirectoryFromPath(getCurrentTemplatePath())>
	
	<!--- Run when application starts up --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfreturn true>
	</cffunction>
<cffunction name="onApplicationEnd" access="public" returntype="void" output="false"
		hint="Runs when the application ends, either because the server shut down or the application timeout was exceeded">
		<cfargument name="ApplicationScope" required="true" /> 
        <cflogout>
		<cfreturn true />
	</cffunction>

	

	<cffunction name="onRequestStart" access="public" returntype="boolean" output="false">
		<cfargument name="targetPage" type="string" required="true" />
		 
    	 <!---AJAX uses access="remote" and doesn't work with onRequest. This code kills the onRequest for those CFC calls---> 
		<!---<cfif listlast(Arguments.targetPage,".") is "cfc" OR isSOAPRequest()>
			<cfset StructDelete(this, "onRequest") />
            <cfset StructDelete(variables,"onRequest")/>
        </cfif>--->

		<cfreturn true>

	</cffunction>

	<cffunction name="onRequest" access="public" returntype="boolean" output="true">
		<cfargument name="targetPage" type="string" required="true" />
      
		<cfinclude template="#Arguments.TargetPage#" />
        <cfparam name="URL.logout" default="0">
        <cfif URL.logout is 1>
    	<cflogout>
    	<cflocation url="http://#this.URL#/" addtoken="no">
		</cfif>
		<cfreturn true>
	</cffunction>

	<cffunction name="onRequestEnd" access="public" returntype="void" output="false">
		<cfargument name="targetPage" type="string" required="true" />

	</cffunction>

	<cffunction name="onSessionStart" access="public" returntype="void" output="false"
		hint="Runs on the first page request of a new session">
	
		<cfset Session.Started = Now() />

	</cffunction>

	<cffunction name="onSessionEnd" access="public" returntype="void" output="false"
		hint="Runs when a session times out"> 
		<cfargument name="SessionScope" required="True" /> 
		<cfargument name="ApplicationScope" required="False" /> 
		<cflogout>
	</cffunction>
	<!--- Runs on error --->
	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		<cfdump var="#arguments#" label="onError"><cfabort>
	</cffunction>

</cfcomponent>