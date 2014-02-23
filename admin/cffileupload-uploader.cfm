<cfquery name="GetVid">
SELECT *
FROM Videos
Where VideoID = <cfqueryparam value="#pid#" cfsqltype="cf_sql_integer"> 
</cfquery>
<cfdump var="#GetVid#">
<cffile action="uploadall" destination="/var/www/gulfsportsnet.com/html#GetVid.PageDir#" nameconflict="overwrite" result="ws" />

<!---<cfset str.STATUS = 200>
<cfset str.MESSAGE = "passed">
<cfoutput>#serializeJSON(str)#</cfoutput>--->


