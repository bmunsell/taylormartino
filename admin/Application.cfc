<cfcomponent output="false">
	<cfset Application.Started = Now() />
		<cfset this.name = "www.taylormartino.com" />
		<cfset this.ApplicationTimeout = CreateTimeSpan(0,6,0,0) />
		<cfset this.sessionManagement = True />
		<cfset this.sessionTimeout = CreateTimeSpan(0,6,0,0) />
		<cfset this.customtagpaths = "CustomTags" />
		<cfset this.datasource = "tm" />
		<cfset this.GoogleMapKey = "ABQIAAAAdsk6q48Nwr_ojp_P7IdmqhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxQHHFQHbi46swgbRZvC5cZMbS8uqQ" />
		<cfset this.userFilesPath = "/admin/" />
        <cfset this.URL = "taylormartino.com" />
		<cfset this.local = "www.taylormartino.com" />
        
<cfif StructKeyExists(URL, "showdebugging")>
		<cfset this.debuggingipaddresses = "0:0:0:0:0:0:0:1%0,127.0.0.1" />
		<cfset this.enablerobustexception = True />
</cfif>

	<cffunction name="onApplicationStart" access="public" returntype="boolean" output="false" 
		hint="Runs when the application first starts">
            
		<cfreturn true />
	</cffunction>

	<cffunction name="onApplicationEnd" access="public" returntype="void" output="false"
		hint="Runs when the application ends, either because the server shut down or the application timeout was exceeded">
		<cfargument name="ApplicationScope" required="true" /> 
        <cflogout>
		<cfreturn true />
	</cffunction>

<!---	<cffunction name="onCFCRequest">
		<cfargument name="Component" type="string" />
		<cfargument name="methodName" type="String" />
		<cfargument name="methodArguments" type="struct" />
		
		<cfinvoke component="#Arguments.Component#" method="#Arguments.methodName#" argumentcollection="#Arguments.methodArguments#"
			returnvariable="LOCAL.CFCResult" />
			
		<cfdump var="#SerializeJSON(LOCAL.CFCResult)#">
		
		<cfdump var="#Arguments#" />
	
	</cffunction>--->

	<cffunction name="onRequestStart" access="public" returntype="boolean" output="false">
		<cfargument name="targetPage" type="string" required="true" />
		
		<!---<cfset session.UserID = 1>
		<cfset session.Username = 'bmunsell@cdfolio.com'>
		<cfset session.FirstName = 'Bill'>
		<cfset session.LastName = 'Munsell'>
		<cfif isDefined("session.role") and session.role is 'admin'>
		<cfelse>
		<cflocation url="/admin/login.cfm?error=1" addtoken="no">
		</cfif> --->
    	 <!---AJAX uses access="remote" and doesn't work with onRequest. This code kills the onRequest for those CFC calls---> 
		<cfif listlast(Arguments.targetPage,".") is "cfc" OR isSOAPRequest()>
			<cfset StructDelete(this, "onRequest") />
            <cfset StructDelete(variables,"onRequest")/>
        </cfif>

		<cfreturn true>

	</cffunction>

	<cffunction name="onRequest" access="public" returntype="boolean" output="true">
		<cfargument name="targetPage" type="string" required="true" />
      
		<cfinclude template="#Arguments.TargetPage#" />
       <!---<cfif IsUserInRole("admin")>
		<cfelse>
		<cflocation url="/admin/login.cfm?error=2" addtoken="no">
		</cfif>--->
		
        <cfparam name="URL.logout" default="0">
        <cfif URL.logout is 1>
    	<cflogout>
    	<cflocation url="http://www.taylormartino.com">
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
</cfcomponent>