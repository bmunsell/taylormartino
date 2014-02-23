<cfparam name="url.pid" default="6">
<!---SET MESSAGES--->
<cfset msg = 'Drag & Drop to change subpage display order'>
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
<cfif IsDefined('url.del') AND IsDefined('url.spid') AND IsUserInRole("admin")>

<cfquery name="DeleteNews">
    DELETE FROM SubPages WHERE SubPageID = <cfqueryparam value="#url.spid#" cfsqltype="cf_sql_integer">
  </cfquery>

<cfset message = 'Webpages deleted successfully'>
</cfif>
<cfquery name="getall">
	SELECT * 
    FROM Pages
	Where PageID > 5
</cfquery>
<cfquery name="getcurrent">
	SELECT * 
    FROM Pages
	Where PageID = <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_integer">
</cfquery>
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
<script type="text/javascript">
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
</script>
</head>
<body>
	<cfinclude template="header.cfm">
<div class="container">
<h1><cfoutput>#getcurrent.PageLink# Sub Pages</cfoutput></h1>

<table border="0" cellspacing="5" width="900">
	<tr>
    <td width="259" align="left"><a href="/admin/page-list.cfm"><img src="/admin/images/page.png" alt="MAIN PAGEs" width="16" height="16" /></a><a href="/admin/page-list.cfm"> Main Pages</a></td>
    <td colspan="2" align="center"><a href="/admin/subpage-add.cfm"><img src="/admin/images/page_add.png" alt="ADD PAGE" width="16" height="16" /></a><a href="/admin/page-add.cfm"> ADD NEW PAGE</a></td>
    <td width="312" align="right"><a href="/admin/subpage-add.cfm"><img src="/admin/images/page_add.png" alt="ADD PAGE" width="16" height="16"></a><a href="/admin/subpage-add.cfm"> ADD NEW SUB-PAGE</a></td>
	</tr>
     <tr>
     <td align="left">&nbsp;</td>
      <td width="127" align="left">&nbsp;</td>
       <td width="161" align="left">&nbsp;</td>
        <td align="left">&nbsp;</td>
   </tr>
	<tr>
	  <td align="right" colspan="2">Select Parent Page:</td>
	  <td align="left" colspan="2">
      <form name="form" id="form">
  <select name="jumpMenu" id="jumpMenu" onchange="MM_jumpMenu('parent',this,0)">
  <option>Select Parent Page</option>
  <cfoutput query="getall">
    <option value="#CGI.ScriptName#?pid=#getall.PageID#"<cfif url.pid is getall.PageID> selected="selected"</cfif>>#PageLink#</option>
    </cfoutput>
  </select>
</form>
      </td>
	  <td width="1" align="left">&nbsp;</td>
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
					UPDATE SubPages
					SET Dorder = <cfqueryparam value="#mycount#" cfsqltype="cf_sql_integer">
                	WHERE SubPageID = <cfqueryparam value="#i#" cfsqltype="cf_sql_integer">
            	</cfquery>  
        <cfset mycount++ />
            </cfloop>
            <cfset msg = 'Order Saved'>
            <cfquery name="GetPages">
  				SELECT * FROM SubPages
                WHERE PageID = #url.pid#
  				Order by DOrder
			</cfquery>
  <cfelse>
			<!--- Default list of items we'll be working with --->
            <cfset lstSortItems = "" />
            
        <cfquery name="GetPages">
  				SELECT * FROM SubPages
                WHERE PageID = #url.pid#
  				Order by DOrder
			</cfquery>
			<cfoutput query="GetPages">
            	<cfset lstSortItems = listAppend(lstSortItems,GetPages.SubPageID) />
            </cfoutput>
</cfif>
		<h3 class="msg"><cfoutput>#msg#</cfoutput></h3>
		<!--- Basic form, submitting to itself --->
		<cfform action="#CGI.SCRIPT_NAME#?pid=#url.pid#" method="post">
		<cfoutput>
				<!--- This UL will contain the items we want to sort --->
				<ul id="SortItems" class="sortable">
					<!--- Counter to ensure each hidden field has a unique name --->
					<cfset intCounter = 0 />
					<!--- Loop over list of items to sort -- in real life this is probably a query --->
					<cfloop query="GetPages">
                    	<cfset intCounter++ />
						<li style="cursor: move;">
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
  		<tr>
    		<td width="50%"><h3>#Left(GetPages.PageLink, 70)#</h3>
            Last Update: #DateFormat(GetPages.PageLast, 'medium')#  
</td>
    		<td width="10%"><cfif GetPages.isActive eq 1>Active<cfelse>Inactive</cfif></td>
    		<td width="20%" align="center">
    		<a href="subpage-edit.cfm?pid=#GetPages.SubPageID#" title="Edit #GetPages.PageName#">
    		<img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #GetPages.PageName#"><br />
EDIT PAGE
    		</a>
   			</td>
    		<td width="20%" align="right">
    		<a href="#CGI.SCRIPT_NAME#?spid=#GetPages.SubPageID#&del=yes" title="Delete #GetPages.PageLink#" onClick="javascript:return confirm('Are you sure you want to delete this Page?')">
    <img src="/admin/images/page_delete.png" width="16" height="16" border="0" alt="Delete #GetPages.PageLink#"> DELETE
    </a>
   	 		</td>
		</tr>
	</table>
	<cfinput type="hidden" name="SortItem_#intCounter#" value="#SubPageID#" />
</li>
	</cfloop>
</ul>
</cfoutput>
<br clear="all" />
<table width="100%">
	<tr>
    	<td align="center">	<input type="submit" value="Save Page Order" class="subform" /></td>
    </tr>
</table>
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
