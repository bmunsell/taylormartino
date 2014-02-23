<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_GetPosts" default="1">
<cfquery name="GetPosts">
SELECT *
FROM Posts
ORDER BY PageDate Desc 
</cfquery>
<cfset pagecount = #GetPosts.RecordCount#>
<cfset MaxRows_GetPosts=25>
<cfset StartRow_GetPosts=Min((PageNum_GetPosts-1)*MaxRows_GetPosts+1,Max(GetPosts.RecordCount,1))>
<cfset EndRow_GetPosts=Min(StartRow_GetPosts+MaxRows_GetPosts-1,GetPosts.RecordCount)>
<cfset TotalPages_GetPosts=Ceiling(GetPosts.RecordCount/MaxRows_GetPosts)>
<cfset QueryString_GetPosts=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_GetPosts,"PageNum_GetPosts=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_GetPosts=ListDeleteAt(QueryString_GetPosts,tempPos,"&")>
</cfif>
<cfset message = ''>
<cfif IsDefined('url.add')>
<cfset message = 'Post added successfully'>
</cfif>
<cfif IsDefined('url.edit')>
<cfset message = 'Post edited successfully'>
</cfif>
<cfif IsDefined('url.d')>
<cfset message = 'Post deleted successfully'>
</cfif>
<cfif IsDefined('url.del') AND IsDefined('url.pid')>
<cfquery name="DeleteNews">
    DELETE FROM Posts WHERE PostID = <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_integer">
  </cfquery>
  <cflocation url="#CGI.SCRIPT_NAME#?d=yes">
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
	<h2 class="msg">#message#</h2> 
    <h1>Website News</h1>  
	<table border="0" cellspacing="5" width="900">
	<tr>
    <td><a href="/admin/post-add.cfm"><img src="/admin/images/Comment.png" alt="ADD POST" width="16" height="16"> ADD NEW POST</a><!---Pages #StartRow_GetPosts# to #EndRow_GetPosts# of #GetPosts.RecordCount#---></td>
	</tr>
	</table>
	<table border="0" cellspacing="5" class="a" width="900">
  	<tr>
  	<td width="160" align="left"><cfif PageNum_GetPosts GT 1>
      <a href="#CurrentPage#?PageNum_GetPosts=#Max(DecrementValue(PageNum_GetPosts),1)##QueryString_GetPosts#"><img src="images/Back.png" align="middle">PREVIOUS PAGE</a>
    </cfif></td>
  	<td colspan="2" align="center"><strong>Taylor Martino Website News (#pagecount# Total)</strong></td>
  	<td width="159" align="right"><cfif PageNum_GetPosts LT TotalPages_GetPosts>
      <a href="#CurrentPage#?PageNum_GetPosts=#Min(IncrementValue(PageNum_GetPosts),TotalPages_GetPosts)##QueryString_GetPosts#">NEXT PAGE<img src="images/Next.png" align="middle"></a>
    </cfif></td>
  	</tr>
	</table><br>
</cfoutput>
 <table cellspacing="0" cellpadding="0" class="a2" width="900">
  <tr>
    <td colspan="2"><img src="images/Comment.png" align="left" style="padding:5px;" /><h3>POST TITLE</h3></td>
    <td align="center" width="140"><img src="images/Calendar.png" /><strong> DATE</strong></td>
    <td align="center" width="140"><img src="images/comment_edit.png" /><strong> EDIT</strong></td>
    <td align="center" width="140"><img src="images/comment_delete.png" /><strong> DELETE</strong></td>
  </tr>
</table>
<cfoutput query="GetPosts"  startrow="#StartRow_GetPosts#" maxrows="#MaxRows_GetPosts#">
  <table cellspacing="0" cellpadding="0" class="#iif(currentrow MOD 2,DE('a1'),DE('a2'))#" width="900">
  	<tr>
    <td width="10">&nbsp;</td>
    <td><h3>#GetPosts.PageTitle#</h3> <!---#GetPosts.DOrder#/#GetPosts.RecordCount#<br>#GetPosts.PageTitle#---></td>
	<td width="50"><cfif GetPosts.isActive eq 1>Active<cfelse>Inactive</cfif></td>
    <td width="140" align="center">#DateFormat(GetPosts.PageDate, 'mm/dd/yyyy')#<br></td>
    <td align="center" width="140" valign="middle">
    <a href="post-edit.cfm?pid=#GetPosts.PostID#" title="Edit #GetPosts.PageTitle#">
    <img src="/admin/images/comment_edit.png" width="16" height="16" border="0" alt="Edit #GetPosts.PageTitle#"> EDIT
    </a>    
    </td>
    <td align="center" width="140" valign="middle">
    <a href="#CGI.SCRIPT_NAME#?pid=#GetPosts.PostID#&del=yes" title="Delete #GetPosts.PageTitle#" onClick="javascript:return confirm('Are you sure you want to delete this post?')">
    <img src="/admin/images/comment_delete.png" width="16" height="16" border="0" alt="Edit #GetPosts.PageTitle#"> DELETE
    </a>    
    </td>
  </tr>
</table>
</cfoutput>
</div>
</body>
</html>