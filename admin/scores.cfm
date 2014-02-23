<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_GetScores" default="1">
<cfparam name="url.o" default="BannerLink Desc">
<cfset message = ''>
<cfif IsDefined('url.add')>
<cfset message = 'Score added successfully'>
</cfif>
<cfif IsDefined('url.edit')>
<cfset message = 'Score edited successfully'>
</cfif>
<cfif IsDefined('url.del') AND IsDefined('url.bid') AND IsUserInRole("admin")>
<cfquery name="DeleteNews">
    DELETE FROM Scores WHERE ScoreID = #url.bid#
  </cfquery>
<cfset message = 'Score deleted successfully'>
</cfif>
<cfquery name="GetScores">
Select *
From Scores
Order By ScoreID Desc
</cfquery>
<cfset MaxRows_GetScores=8>
<cfset StartRow_GetScores=Min((PageNum_GetScores-1)*MaxRows_GetScores+1,Max(GetScores.RecordCount,1))>
<cfset EndRow_GetScores=Min(StartRow_GetScores+MaxRows_GetScores-1,GetScores.RecordCount)>
<cfset TotalPages_GetScores=Ceiling(GetScores.RecordCount/MaxRows_GetScores)>
<cfset QueryString_GetScores=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_GetScores,"PageNum_GetScores=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_GetScores=ListDeleteAt(QueryString_GetScores,tempPos,"&")>
</cfif>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>GSN Banner Admin</title>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
</head>
<body>
<cfinclude template="header.cfm">
<div class="container">
<cfoutput>
<h2 class="msg" align="center">#message#</h2>
  <h2 align="center">GSN Scores</h2>   
	<table width="90%" border="0" align="center" cellspacing="5">
	<tr>
    <td align="right"><a href="manage.cfm"> ADD Score</a><!---Pages #StartRow_GetScores# to #EndRow_GetScores# of #GetScores.RecordCount#---></td>
	</tr>
	</table>
  <table width="90%" border="0" align="center" cellspacing="5" class="a">
  	<tr>
  	<td width="150" align="left"><cfif PageNum_GetScores GT 1>
      <a href="#CurrentPage#?PageNum_GetScores=#Max(DecrementValue(PageNum_GetScores),1)##QueryString_GetScores#"><img src="images/Back.png" width="32" height="32" align="middle">PREVIOUS PAGE</a>
    </cfif></td>
  	<td colspan="2" align="center"><strong>GSN Scores<br>
  	  (#GetScores.RecordCount# Total)</strong></td>
  	<td width="143" align="right"><cfif PageNum_GetScores LT TotalPages_GetScores>
      <a href="#CurrentPage#?PageNum_GetScores=#Min(IncrementValue(PageNum_GetScores),TotalPages_GetScores)##QueryString_GetScores#">NEXT PAGE<img src="images/Next.png" align="middle"></a>
    </cfif></td>
  	</tr>
	</table>
 <table width="90%" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" width="200">
        <strong> Game</strong></td>
    <td align="center" width="200">Date</td>
    <td width="100" align="center">Period</td>
    <td width="100" align="center">Sport</td>
    <td align="center" width="100"><strong> EDIT</strong></td>
    <td align="center" width="100"><strong> DELETE</strong></td>
  </tr>
</table>
</cfoutput>
<cfif GetScores.RecordCount lt 1>
Sorry there are no Scores on file
  <cfelse>
<cfoutput query="GetScores"  startrow="#StartRow_GetScores#" maxrows="#MaxRows_GetScores#">
  <table width="90%" align="center" cellpadding="0" cellspacing="0" class="#iif(currentrow MOD 2,DE('a1'),DE('a2'))#">
  	<tr>
  	  <td align="left" width="200">#Home# #HScore#<br>#Away# #AScore#</td>
  	  <td align="left" width="200">#DateFormat(GetScores.GDate, 'medium')#</td>
  	  <td width="100" align="center">#GetScores.Period#</td>
  	  <td width="100" align="center">#GetScores.SText#</td>
  	  <td align="center" width="100" valign="middle">
  	    <a href="score-edit.cfm?sid=#GetScores.ScoreID#">
  	      EDIT
  	      </a>    
  	    </td>
  	  <td width="100" align="center" valign="middle">
  	    <a href="#CGI.SCRIPT_NAME#?bid=#GetScores.ScoreID#&del=yes" onClick="javascript:return confirm('Are you sure you want to delete this Score?')">
  	      DELETE
  	      </a> 
  	    </td>
	  </tr>
</table>
  </cfoutput>
  </cfif>
</div>
</body>
</html>