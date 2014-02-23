<cfcomponent>
	<cffunction name="getStatus" access="remote" returntype="struct">
		<cfset LOCAL.retVal = {} />
	
		<cfif NOT StructKeyExists(Session, "Progress")>
			<cfset Session.Progress = 0 />
		</cfif>    
	
		<cfset Session.Progress += .1 />
		<cfif Session.Progress GT 1>
			<cfset Session.Progress = 1 />
		</cfif>
	
		<cfset LOCAL.retVal.Status = Session.Progress />
	
		<cfif LOCAL.retVal.Status LTE .2>
			<cfset LOCAL.retVal.message = "Starting" />
		</cfif>
		<cfif LOCAL.retVal.Status GTE .25>
			<cfset LOCAL.retVal.message = "1/4 Finished" />
		</cfif>
		<cfif LOCAL.retVal.Status GTE .5>
			<cfset LOCAL.retVal.message = "1/2 Finished" />
		</cfif>
		<cfif LOCAL.retVal.Status GTE .75>
			<cfset LOCAL.retVal.message = "3/4 Finished" />
		</cfif>
		<cfif LOCAL.retVal.Status EQ 1>
			<cfset LOCAL.retVal.message = "Finished" />
			<cfset StructDelete(Session, "Progress") />
		</cfif>
	
		<cfreturn LOCAL.retVal />
	</cffunction>

</cfcomponent>