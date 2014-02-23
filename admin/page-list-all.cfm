<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_GetPages" default="1">
<cfquery name="GetPages">
SELECT *
FROM Pages
ORDER BY DOrder ASC 
</cfquery>
<cfquery name="GetScount">
SELECT SubPageID
FROM SubPages
</cfquery>
<cfset pagecount = #GetPages.RecordCount# + #GetScount.RecordCount#>
<cfset MaxRows_GetPages=50>
<cfset StartRow_GetPages=Min((PageNum_GetPages-1)*MaxRows_GetPages+1,Max(GetPages.RecordCount,1))>
<cfset EndRow_GetPages=Min(StartRow_GetPages+MaxRows_GetPages-1,GetPages.RecordCount)>
<cfset TotalPages_GetPages=Ceiling(GetPages.RecordCount/MaxRows_GetPages)>
<cfset QueryString_GetPages=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_GetPages,"PageNum_GetPages=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_GetPages=ListDeleteAt(QueryString_GetPages,tempPos,"&")>
</cfif>
<cfset message = ''>
<cfif IsDefined('url.add')>
<cfset message = 'Webpage added successfully'>
</cfif>
<cfif IsDefined('url.edit')>
<cfset message = 'Webpage edited successfully'>
</cfif>
<cfif IsDefined('url.restore')>
<cfset message = 'Webpage restored successfully'>
</cfif>
<cfif IsDefined('url.del') AND IsDefined('url.pid') AND IsUserInRole("admin")>
<cfquery name="GNews">
    Select *
    FROM SubPages WHERE SubPageID = <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_integer">
  </cfquery>

<cffile action="delete" file="/var/www/gulfsportsnet.com/html/#GNews.PageDir#/#GNews.PageName#/index.cfm">
<cfdirectory action="delete" directory="/var/www/gulfsportsnet.com/html/#GNews.PageDir#/#GNews.PageName#">
<cfquery name="DeleteNews">
    DELETE FROM SubPages WHERE SubPageID = <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_integer">
  </cfquery>
<cfset message = 'Webpage deleted successfully'>
</cfif>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Taylor Martino Website Admin</title>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>
</head>
<body>

   <cfinclude template="header.cfm">
<div class="container">
<cfoutput>
	<h1>#message#</h1>   
	<table border="0" cellspacing="5" width="900">
	<tr>
    <td width="532" align="right"><a href="/admin/subpage-add.cfm"><img src="/admin/images/page_add.png" alt="ADD PAGE" width="16" height="16"></a><a href="/admin/page-add.cfm"> ADD NEW PAGE</a><!---Pages #StartRow_GetPages# to #EndRow_GetPages# of #GetPages.RecordCount#---></td>
    <td width="349" align="right"><a href="/admin/subpage-add.cfm"><img src="/admin/images/page_add.png" alt="ADD PAGE" width="16" height="16"></a><a href="/admin/subpage-add.cfm"> ADD NEW SUB-PAGE</a></td>
	</tr>
	</table>
	<table border="0" cellspacing="5" class="a" width="900">
  	<tr>
  	<td width="160" align="left"><cfif PageNum_GetPages GT 1>
      <a href="#CurrentPage#?PageNum_GetPages=#Max(DecrementValue(PageNum_GetPages),1)##QueryString_GetPages#"><img src="images/Back.png" align="middle">PREVIOUS PAGE</a>
    </cfif></td>
  	<td colspan="2" align="center"><strong>Taylor Martino Website Pages (#pagecount# Total)</strong></td>
  	<td width="159" align="right"><cfif PageNum_GetPages LT TotalPages_GetPages>
      <a href="#CurrentPage#?PageNum_GetPages=#Min(IncrementValue(PageNum_GetPages),TotalPages_GetPages)##QueryString_GetPages#">NEXT PAGE<img src="images/Next.png" align="middle"></a>
    </cfif></td>
  	</tr>
	</table>
</cfoutput>
 <table cellspacing="0" cellpadding="0" class="a2" width="900">
  <tr>
    <td colspan="2"><img src="images/page.png" align="left" style="padding:5px;" /><h3>PAGE NAME</h3></td>
    <td align="center" width="140"><img src="images/Calendar.png" /><strong> DATE</strong></td>
    <td align="center" width="140"><img src="images/page_edit.png" /><strong> EDIT</strong></td>
    <td align="center" width="140"><img src="images/page_delete.png" /><strong> DELETE</strong></td>
  </tr>
</table>
<cfoutput query="GetPages"  startrow="#StartRow_GetPages#" maxrows="#MaxRows_GetPages#">
<cfquery name="GetSubPages">
		Select SubPageID,PageLink,PageTitle,PageLast,DOrder
		From SubPages
        Where PageID = #GetPages.PageID#
		Order BY SubPageID
</cfquery>
  <table cellspacing="0" cellpadding="0" class="#iif(currentrow MOD 2,DE('a1'),DE('a'))#" width="900">
  	<tr>
    <td  width="10">&nbsp;</td>
    <td><h3>#GetPages.PageLink#</h3> <!---#GetPages.DOrder#/#GetPages.RecordCount#<br>#GetPages.PageTitle#---></td>
    <td width="140" align="center">#DateFormat(GetPages.PageLast, 'mm/dd/yyyy')#<br></td>
    <td align="center" width="140" valign="middle">
    <a href="page-edit.cfm?pid=#GetPages.PageID#" title="Edit #GetPages.PageLink#">
    <img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #GetPages.PageLink#"> EDIT
    </a>    
    </td>
    <td width="140" align="center" valign="middle">&nbsp;</td>
  </tr>
</table>
    <cfif #GetSubPages.RecordCount# GT 0>
    <cfloop query="GetSubPages" startrow="1" endrow="#GetSubPages.RecordCount#">
    <table cellspacing="0" cellpadding="0" class="#iif(currentrow MOD 2,DE('a3'),DE('a4'))#" width="900">
    <tr>
    <td width="30" valign="middle">&nbsp;--&nbsp;</td>
    <td><h3>#GetSubPages.PageLink#</h3>      <!---#GetSubPages.DOrder#/#GetSubPages.RecordCount#<br>#GetSubPages.PageTitle#---></td>
    <td width="140" align="center">#DateFormat(GetSubPages.PageLast, 'mm/dd/yyyy')#<br></td>
    <td align="center" width="140" valign="middle">
    <a href="subpage-edit.cfm?pid=#GetSubPages.SubPageID#" title="Edit #GetSubPages.PageLink#">
    <img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #GetSubPages.PageLink#"> EDIT
    </a>
    </td>
    <td align="center" width="140" valign="middle">
    <a href="#CGI.SCRIPT_NAME#?pid=#GetSubPages.SubPageID#&del=yes" title="Delete #GetSubPages.PageLink#" onClick="javascript:return confirm('Are you sure you want to delete this Page?')">
    <img src="/admin/images/page_delete.png" width="16" height="16" border="0" alt="Delete #GetSubPages.PageLink#"> DELETE
    </a>
    </td>
  </tr>
  </table>
  </cfloop>
  </cfif>
  </cfoutput>
</div>
</body>
</html>