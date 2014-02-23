<cfparam name="url.Psort" default="0">
<cfinvoke 
	component="Taylor Martino "
    method="sPages" 
    Psort="#url.Psort#" 
    returnvariable="results">
<cfif results.recordcount is 0>
<h4 align="center" style="background-color:#333">Sorry there are no results for your search</h4>
<cfelse>
<ul id="cfresults">
<cfloop query="results">
<cfquery name="SPage">
SELECT *
FROM SPages
Where PageID = <cfqueryparam value="#results.PageID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfoutput>
<li>#results.PageTitle# </li>
	<cfif SPage.RecordCount GT 0><ul><cfloop query="SPage"><li>- #Spage.PageTitle#</li></cfloop></ul></cfif>
</cfoutput>
</cfloop>
</ul>
</cfif>