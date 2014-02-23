<cfcomponent name="logon">

    <cffunction access="public" name="verifyUser">
        <!--- make sure username and password are required --->
        <cfargument name="getUsername" type="string" required="yes">
        <cfargument name="getPassword" type="string" required="yes">
        <!--- query the database for the username and password that were passed --->
        <cfquery name="verifyusername" datasource="#application.ds#">
            SELECT username, Type, FirstName, LastName
            FROM Users
            WHERE username = '#arguments.getUsername#' 
            AND pass = '#arguments.getPassword#'
        </cfquery>
        <!--- return the result --->
        <cfif verifyusername.recordCount>
            <cflogin idletimeout="3600" applicationtoken="GCOLogin" cookiedomain="gulfcoastowners.com">
            <cfloginuser 
                    name = "#FORM.username#"
                    password ="#FORM.pass#"
                    roles = "#verifyusername.Type#">
        	</cflogin>
        	<cfquery datasource="#application.ds#" name="SaveEdit">
  		 	UPDATE Users SET Last = #Now()# WHERE UserName="#verifyusername.UserName#"
 			</cfquery>
			<cfif IsUserInRole('admin')>
				<cflock scope="session" type="exclusive" timeout="120" throwontimeout="yes">
        		<cfset session.Username = verifyusername.UserName>
				<cfset session.FirstName = verifyusername.FirstName>
				<cfset session.LastName = verifyusername.LastName>
                <cfreturn session.firstname>
				</cflock>
        		<cflocation url="/admin/index.cfm" addtoken="yes">
        	</cfif>
            <cfif IsUserInRole('user')>
				<cflock scope="session" type="exclusive" timeout="120" throwontimeout="yes">
        		<cfset session.Username = verifyusername.UserName>
				<cfset session.FirstName = verifyusername.FirstName>
				<cfset session.LastName = verifyusername.LastName>
				</cflock>
        		<cflocation url="/users/index.cfm" addtoken="yes">
        	</cfif>
        <cfelse>
            <cfreturn False>
        </cfif>
    </cffunction>
    
</cfcomponent>