<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_GetUsers" default="1">
<cfparam name="url.o" default="LName Asc">
<cfparam name="url.searchtype" default="">
<cfparam name="url.search" default="">
<cfquery name="GetUsers">
SELECT *
FROM Users
WHERE 0=0
<cfif IsDefined("url.search") AND #url.search# NEQ "">
AND #url.searchtype# LIKE '%#url.search#%'
</cfif>
ORDER BY #url.o#
</cfquery>
<cfset pagecount = #GetUsers.RecordCount#>
<cfset MaxRows_GetUsers=10>
<cfset StartRow_GetUsers=Min((PageNum_GetUsers-1)*MaxRows_GetUsers+1,Max(GetUsers.RecordCount,1))>
<cfset EndRow_GetUsers=Min(StartRow_GetUsers+MaxRows_GetUsers-1,GetUsers.RecordCount)>
<cfset TotalPages_GetUsers=Ceiling(GetUsers.RecordCount/MaxRows_GetUsers)>
<cfset QueryString_GetUsers=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_GetUsers,"PageNum_GetUsers=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_GetUsers=ListDeleteAt(QueryString_GetUsers,tempPos,"&")>
</cfif>
<cfset message = ''>
<cfif IsDefined('url.add')>
<cfset message = 'User added successfully'>
</cfif>
<cfif IsDefined('url.edit')>
<cfset message = 'User edited successfully'>
</cfif>
<cfif IsDefined('url.del') AND IsDefined('url.uid')>
<cfquery name="DeleteNews">
    DELETE FROM Users WHERE UserID = <cfqueryparam value="#url.uid#" cfsqltype="cf_sql_integer">
  </cfquery>
<cfset message = 'User deleted successfully'>
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
<div class="scontainer">
<cfoutput>
	<cfif message is not ''><h2 class="msg" align="center">#message#</h2></cfif>
	<table border="0" cellspacing="5" width="900">
	<tr>
	  <td><h1>Website Users</h1></td>
	  <td colspan="2" align="right"><form name="form1" method="get" action="users.cfm">
	    USER Search By : 
	        <select name="searchtype" id="select">
	      <option value="LName">Last Name</option>
	      <option value="UserName">Email</option>
	      </select>
	    <input type="text" name="search" id="search" onClick="this.value='';" value="Search">
	    <input type="submit" name="button" id="button" value="Submit">
      </form></td>
	  </tr>
      <tr>
      	<td colspan="3"><hr></td>
      </tr>
	<tr>
    <td width="241"><a href="/admin/user-add.cfm"><img src="/admin/images/user.png" alt="ADD POST" width="16" height="16"> ADD NEW USER</a><!---Pages #StartRow_GetUsers# to #EndRow_GetUsers# of #GetUsers.RecordCount#---></td>
    <td width="317">&nbsp;<!---<a href="users-export.cfm"><img src="/admin/images/page_excel.png" width="16" height="16">Export Users to Excel</a>---></td>
    <td width="318">&nbsp;</td>
	</tr>
  </table>
	<table border="0" cellspacing="5" class="a" width="940">
  	<tr>
  	<td width="160" align="left"><cfif PageNum_GetUsers GT 1>
      <a href="#CurrentPage#?PageNum_GetUsers=#Max(DecrementValue(PageNum_GetUsers),1)##QueryString_GetUsers#"><img src="images/Back.png" align="middle">PREVIOUS PAGE</a>
    </cfif></td>
  	<td colspan="2" align="center"><strong>Taylor Martino Website Users<br>#StartRow_GetUsers# to #EndRow_GetUsers# of #GetUsers.RecordCount# </strong>
    <cfif IsDefined("url.search") AND #url.search# NEQ ""><br>
    Search for <cfif #url.searchtype# EQ "LName">Last Name<cfelse>E-mail</cfif> containing #url.search#</cfif></td>
  	<td width="159" align="right"><cfif PageNum_GetUsers LT TotalPages_GetUsers>
      <a href="#CurrentPage#?PageNum_GetUsers=#Min(IncrementValue(PageNum_GetUsers),TotalPages_GetUsers)##QueryString_GetUsers#">NEXT PAGE<img src="images/Next.png" align="middle"></a>
    </cfif></td>
  	</tr>
  </table><br>

 <table cellspacing="0" cellpadding="0" class="a2" width="940">
  <tr>
  	<td width="140">
    	<cfif url.o is 'LName Desc'>
		<a href="#CGI.SCRIPT_NAME#">
        <cfelse>
        <a href="#CGI.SCRIPT_NAME#?o=LName Desc">
		</cfif>
        <img src="images/user.png" align="left" style="padding:5px;" /><h3>Last Name</h3></a>
    </td>
    <td width="160">
    <cfif url.o is 'FName Desc'>
		<a href="#CGI.SCRIPT_NAME#?o=FName Asc">
        <cfelse>
        <a href="#CGI.SCRIPT_NAME#?o=FName Desc">
		</cfif>
    <h3>First Name</h3></a></td>
    <td width="220">
    <cfif url.o is 'UserName Desc'>
		<a href="#CGI.SCRIPT_NAME#?o=UserName Asc">
        <cfelse>
        <a href="#CGI.SCRIPT_NAME#?o=UserName Desc">
		</cfif>
    <h3>Email</h3></a>
    </td>
    <td width="140">
    <cfif url.o is 'Admin Desc'>
		<a href="#CGI.SCRIPT_NAME#?o=Admin Asc">
        <cfelse>
        <a href="#CGI.SCRIPT_NAME#?o=Admin Desc">
		</cfif>
    <h3>Type</h3></a>
    </td>
    
    <td align="center" width="100"><img src="images/Calendar.png" /><strong><br>Last Login</strong></td>
    <td align="center" width="50"><img src="images/comment_edit.png" /><strong><br>EDIT</strong></td>
    <td align="center" width="50"><img src="images/comment_delete.png" /><strong><br>DEL</strong></td>
  </tr>
</table>
</cfoutput>
<cfoutput query="GetUsers"  startrow="#StartRow_GetUsers#" maxrows="#MaxRows_GetUsers#">
<span style="font-size:11px">
  <table cellspacing="0" cellpadding="0" class="#iif(currentrow MOD 2,DE('a1'),DE('a'))#" width="940">
  	<tr>
    <td width="140">#GetUsers.LName#</td>
    <td width="160">#GetUsers.FName#</td>
    <td width="220" align="left">#UserName#<br></td>
    <td width="140" align="left">#admin#<br></td>
    <td width="100" align="center">#DateFormat(GetUsers.Last, 'mm/dd/yyyy')#<br></td>
    <td align="center" width="50" valign="middle">
    <a href="user-edit.cfm?uid=#GetUsers.UserID#" title="Edit #GetUsers.Lname#">
    <img src="/admin/images/comment_edit.png" width="16" height="16" border="0" alt="Edit #GetUsers.Lname#"></a>    
    </td>
    <td align="center" width="50" valign="middle">
    <a href="#CGI.SCRIPT_NAME#?uid=#GetUsers.UserID#&del=yes" title="Delete #GetUsers.Lname#" onClick="javascript:return confirm('Are you sure you want to delete this user?')">
    <img src="/admin/images/comment_delete.png" width="16" height="16" border="0" alt="Edit #GetUsers.Lname#"></a>    
    </td>
  </tr>
</table>
</span>
</cfoutput>
</div>
</body>
</html>