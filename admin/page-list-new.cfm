<cfparam name="url.id" default="1">
<!---SET MESSAGES--->
<cfset msg = 'Drag & Drop to change photo display order'>
<cfif IsDefined('url.add')>
<cfset msg = 'Webpage added successfully'>
</cfif>
<cfif IsDefined('url.edit')>
<cfset msg = 'Webpage edited successfully'>
</cfif>
<cfif IsDefined('url.restore')>
<cfset msg = 'Webpage restored successfully'>
</cfif>
<!---DELETE PAGE--->
<cfif IsDefined('url.del') AND IsDefined('url.pid') AND IsUserInRole("admin")>
<cfquery name="GNews">
    Select *
    FROM SubPages WHERE PageID = <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_integer">
</cfquery>
<cfloop query="GNews">
<cfquery name="DeleteNews">
    DELETE FROM SubPages WHERE SubPageID = <cfqueryparam value="#GNews.SubPageID#" cfsqltype="cf_sql_integer">
  </cfquery>
 </cfloop>	
<cfquery name="DeleteNews">
    DELETE FROM Pages WHERE PageID = <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_integer">
 </cfquery>
<cfset message = 'Webpages deleted successfully'>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Taylor Martino Website Admin</title>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.21/jquery-ui.min.js" type="text/javascript"></script>
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>
</head>
<body>
	<cfinclude template="header.cfm">
<div class="container">
<table border="0" cellspacing="5" width="900">
	<tr>
    <td width="532" align="right"><a href="/admin/subpage-add.cfm"><img src="/admin/images/page_add.png" alt="ADD PAGE" width="16" height="16"></a><a href="/admin/page-add.cfm"> ADD NEW PAGE</a><!---Pages #StartRow_GetPages# to #EndRow_GetPages# of #GetPages.RecordCount#---></td>
    <td width="349" align="right"><a href="/admin/subpage-add.cfm"><img src="/admin/images/page_add.png" alt="ADD PAGE" width="16" height="16"></a><a href="/admin/subpage-add.cfm"> ADD NEW SUB-PAGE</a></td>
	</tr>
	</table>
    <!---START SORT--->
<cfset lstSortItems = "" />
		<cfif structKeyExists(form,"fieldNames")>
			<!--- Form was submitted, so show put together list of items in their specified order --->
			<cfloop list="#form.fieldNames#" index="strIndex">
				<cfif left(strIndex,9) is "SortItem_">
                    <cfset lstSortItems = listAppend(lstSortItems,form[strIndex]) />
				</cfif>             
			</cfloop>
        	<cfset mycount = 1 />
          <cfloop list="#lstSortItems#" index="i" delimiters="," >
            	<cfquery name="update">   
					UPDATE Pages
					SET Dorder = <cfqueryparam value="#mycount#" cfsqltype="cf_sql_integer">
                	WHERE PageID = <cfqueryparam value="#i#" cfsqltype="cf_sql_integer">
            	</cfquery>  
        <cfset mycount++ />
            </cfloop>
            <cfset msg = 'Order Saved'>
            <cfquery name="GetPages">
  				SELECT * FROM Pages
  				Order by DOrder
			</cfquery>
  <cfelse>
			<!--- Default list of items we'll be working with --->
            <cfset lstSortItems = "" />
            
        <cfquery name="GetPages">
  				SELECT * FROM Pages
  				Order by DOrder
			</cfquery>
			<cfoutput query="GetPages">
            	<cfset lstSortItems = listAppend(lstSortItems,GetPages.PageID) />
            </cfoutput>
</cfif>
		<h3 class="msg"><cfoutput>#msg#</cfoutput></h1>
		<!--- Basic form, submitting to itself --->
		<cfform action="#CGI.SCRIPT_NAME#" method="post">
		<cfoutput>
				<!--- This UL will contain the items we want to sort --->
				<ul id="SortItems" class="sortable">
					<!--- Counter to ensure each hidden field has a unique name --->
					<cfset intCounter = 0 />
					<!--- Loop over list of items to sort -- in real life this is probably a query --->
					<cfloop query="GetPages">
                    <cfquery name="GetSubPages">
						Select SubPageID,PageLink,PageTitle,PageLast,DOrder
						From SubPages
        				Where PageID = #GetPages.PageID#
						Order BY SubPageID
					</cfquery>
                    <cfset intCounter++ />
<li style="cursor: move;">
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
  		<tr>
    		<td width="60%"><h3>#Left(GetPages.PageName, 350)#</h3></td>
    		<td width="10%">
    		<cfif GetSubPages.RecordCount GT 0>
    		<a href="subpage-list.cfm?pid=#GetPages.PageID#" title="Edit #GetPages.PageName# Subpages">
    		<img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #GetPages.PageName# Subpages"> SUBPAGES (#GetSubPages.RecordCount#)
    		</a>
        	</cfif>
    		</td>
    		<td width="10%">
    		<a href="page-edit.cfm?pid=#GetPages.PageID#" title="Edit #GetPages.PageName#">
    		<img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #GetPages.PageName#"> EDIT PAGE
    		</a>
   			</td>
    		<td width="20%" align="right">
    		<a href="#CGI.SCRIPT_NAME#?pid=#GetPages.PageID#&del=yes" title="Delete #GetPages.PageLink#" onClick="javascript:return confirm('This will also delete any subpages for this page. 		Are you sure you want to delete this Page?')">
    <img src="/admin/images/page_delete.png" width="16" height="16" border="0" alt="Delete #GetPages.PageLink#"> DELETE
    </a>
   	 		</td>
		</tr>
	</table>
	<cfinput type="hidden" name="SortItem_#intCounter#" value="#PageID#" />
</li>
	</cfloop>
</ul>
</cfoutput>
<br clear="all" />
	<input type="submit" value="Save Page Order" />
</cfform>
</div>


<!--- This JS enables jQuery UI sorting (see included JS above, they're required) --->
<script type="text/javascript">
	$(function() {
		$("#SortItems").sortable({
			revert: true
		});
	});
</script>
<!---END SORT--->
</body>
</html>
