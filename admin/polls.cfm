<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_GetPolls" default="1">
<cfparam name="url.o" default="BannerLink Desc">
<cfset message = ''>
<cfif IsDefined('url.add')>
<cfset message = 'Banner added successfully'>
</cfif>
<cfif IsDefined('url.edit')>
<cfset message = 'Banner edited successfully'>
</cfif>
<cfif IsDefined('url.del') AND IsDefined('url.bid') AND IsUserInRole("admin")>
<cfquery name="DeleteNews">
    DELETE FROM Polls WHERE PollID = #url.bid#
  </cfquery>
  <cfquery name="DeleteNews">
    DELETE FROM PollAnswers WHERE PollID = #url.bid#
  </cfquery>
  <cfquery name="DeleteNews">
    DELETE FROM PollVotes WHERE PollID = #url.bid#
  </cfquery>
<cfset message = 'Banner deleted successfully'>
</cfif>
<cfquery name="GetPolls">
Select *
From Polls
Order By PollID Desc
</cfquery>
<cfset MaxRows_GetPolls=8>
<cfset StartRow_GetPolls=Min((PageNum_GetPolls-1)*MaxRows_GetPolls+1,Max(GetPolls.RecordCount,1))>
<cfset EndRow_GetPolls=Min(StartRow_GetPolls+MaxRows_GetPolls-1,GetPolls.RecordCount)>
<cfset TotalPages_GetPolls=Ceiling(GetPolls.RecordCount/MaxRows_GetPolls)>
<cfset QueryString_GetPolls=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_GetPolls,"PageNum_GetPolls=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_GetPolls=ListDeleteAt(QueryString_GetPolls,tempPos,"&")>
</cfif>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>GSN Poll Admin</title>
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
  <h2 align="center">GSN Polls</h2>   
	<table width="90%" border="0" align="center" cellspacing="5">
	<tr>
    <td align="right"><a href="poll-ad.cfm"> ADD Poll</a><!---Pages #StartRow_GetPolls# to #EndRow_GetPolls# of #GetPolls.RecordCount#---></td>
	</tr>
	</table>
  <table width="90%" border="0" align="center" cellspacing="5" class="a">
  	<tr>
  	<td width="150" align="left"><cfif PageNum_GetPolls GT 1>
      <a href="#CurrentPage#?PageNum_GetPolls=#Max(DecrementValue(PageNum_GetPolls),1)##QueryString_GetPolls#"><img src="images/Back.png" width="32" height="32" align="middle">PREVIOUS PAGE</a>
    </cfif></td>
  	<td colspan="2" align="center"><strong>GSN Polls<br>
  	  (#GetPolls.RecordCount# Total)</strong></td>
  	<td width="143" align="right"><cfif PageNum_GetPolls LT TotalPages_GetPolls>
      <a href="#CurrentPage#?PageNum_GetPolls=#Min(IncrementValue(PageNum_GetPolls),TotalPages_GetPolls)##QueryString_GetPolls#">NEXT PAGE<img src="images/Next.png" align="middle"></a>
    </cfif></td>
  	</tr>
  </table></cfoutput>
 <table width="90%" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" width="300">
        <strong> Question</strong></td>
    <td align="center" width="100">Votes</td>
    <td align="center" width="200">Results</td>
    <td align="center" width="100"><strong> ADD</strong></td>
    <!---<td align="center" width="100"><strong> EDIT</strong></td>--->
    <td align="center" width="100"><strong> DELETE</strong></td>
  </tr>
<cfif GetPolls.RecordCount lt 1>
<tr><td colspan="5">Sorry there are no Polls on file</td></tr></table>
  <cfelse>
<cfloop query="GetPolls"  startrow="#StartRow_GetPolls#" endrow="#MaxRows_GetPolls#">
<cfquery name="GetTotal">
Select VoteID
From PollVotes
Where PollID = <cfqueryparam value="#GetPolls.PollID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="GetAnswers">
Select *
From PollAnswers
Where PollID = <cfqueryparam value="#GetPolls.PollID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfoutput>
  	<tr class="#iif(currentrow MOD 2,DE('a1'),DE('a2'))#">
  	  <td align="left" width="200">#GetPolls.PollQuestion#</td>
  	  <td align="center" width="200">
      #GetTotal.RecordCount#
      </td>
  	  <td align="left">
      <cfloop query="GetAnswers">
<cfquery name="GetVotes">
Select VoteID
From PollVotes
Where PollID = <cfqueryparam value="#GetPolls.PollID#" cfsqltype="cf_sql_integer">
AND Vote = <cfqueryparam value="#GetAnswers.AnswerID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfif GetTotal.RecordCount GT 0>
<cfset per = (GetVotes.RecordCount/GetTotal.RecordCount)*100>
<cfset per = Round(per)>
<cfelse>
<cfset per = 0>
</cfif>
      #GetAnswers.PollAnswer#:<br>#per#%<span style="font-size:-2;">(#GetVotes.RecordCount# votes)</span><br>
      </cfloop>
      </td>
       <td align="center" width="100" valign="middle">
  	    <a href="poll-ad-q.cfm?p=#GetPolls.PollID#">
  	      Answers
  	      </a>     
	    </td>
  	 <!--- <td align="center" width="100" valign="middle">
  	    <a href="poll-edit.cfm?p=#GetPolls.PollID#">
  	      Question
  	      </a>
           <a href="poll-edit-q.cfm?p=#GetPolls.PollID#">
  	      Answers
  	      </a>     
	    </td>--->
  	  <td width="100" align="center" valign="middle">
  	    <a href="#CGI.SCRIPT_NAME#?bid=#GetPolls.PollID#&del=yes" onClick="javascript:return confirm('Are you sure you want to delete this Poll?')">
  	      DELETE
  	      </a> 
  	    </td>
	  </tr>
  </cfoutput>
  </cfloop>
  </cfif></table>
</div>
</body>
</html>