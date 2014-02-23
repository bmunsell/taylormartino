<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_GetBanner" default="1">
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
    DELETE FROM Banners WHERE BannerID = #url.bid#
  </cfquery>
<cfset message = 'Banner deleted successfully'>
</cfif>
<cfquery name="GetBanner">
Select *
From Banners
</cfquery>
<cfset MaxRows_GetBanner=8>
<cfset StartRow_GetBanner=Min((PageNum_GetBanner-1)*MaxRows_GetBanner+1,Max(GetBanner.RecordCount,1))>
<cfset EndRow_GetBanner=Min(StartRow_GetBanner+MaxRows_GetBanner-1,GetBanner.RecordCount)>
<cfset TotalPages_GetBanner=Ceiling(GetBanner.RecordCount/MaxRows_GetBanner)>
<cfset QueryString_GetBanner=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_GetBanner,"PageNum_GetBanner=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_GetBanner=ListDeleteAt(QueryString_GetBanner,tempPos,"&")>
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
  <h2 align="center">GSN Banners</h2>   
	<table width="90%" border="0" align="center" cellspacing="5">
	<tr>
    <td align="right"><a href="banner-ad.cfm"> <img src="/scores/images/picture_add.png" width="16" height="16" border="0" align="absmiddle">ADD Banner</a><!---Pages #StartRow_GetBanner# to #EndRow_GetBanner# of #GetBanner.RecordCount#---></td>
	</tr>
	</table>
  <table width="90%" border="0" align="center" cellspacing="5" class="a">
  	<tr>
  	<td width="150" align="left"><cfif PageNum_GetBanner GT 1>
      <a href="#CurrentPage#?PageNum_GetBanner=#Max(DecrementValue(PageNum_GetBanner),1)##QueryString_GetBanner#"><img src="images/Back.png" width="32" height="32" align="middle">PREVIOUS PAGE</a>
    </cfif></td>
  	<td colspan="2" align="center"><strong>GSN Banners<br>
  	  (#GetBanner.RecordCount# Total)</strong></td>
  	<td width="143" align="right"><cfif PageNum_GetBanner LT TotalPages_GetBanner>
      <a href="#CurrentPage#?PageNum_GetBanner=#Min(IncrementValue(PageNum_GetBanner),TotalPages_GetBanner)##QueryString_GetBanner#">NEXT PAGE<img src="images/Next.png" align="middle"></a>
    </cfif></td>
  	</tr>
	</table>
 <table width="90%" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" width="400">
        <strong> Banner</strong></td>
    <td width="100" align="center">Views</td>
    <td width="100" align="center">Clicks</td>
    <td align="center" width="100"><strong> EDIT</strong></td>
    <td align="center" width="100"><strong> DELETE</strong></td>
  </tr>
</table>
</cfoutput>
<cfif GetBanner.RecordCount lt 1>
Sorry there are no Banners on file
  <cfelse>
<cfoutput query="GetBanner"  startrow="#StartRow_GetBanner#" maxrows="#MaxRows_GetBanner#">
  <table width="90%" align="center" cellpadding="0" cellspacing="0" class="#iif(currentrow MOD 2,DE('a1'),DE('a2'))#">
  	<tr>
  	  <td align="left" width="400">&nbsp;</td>
  	  <td width="100" align="left">&nbsp;</td>
  	  <td width="100" align="left">&nbsp;</td>
  	  <td align="center" width="100">&nbsp;</td>
  	  <td align="center" width="100">&nbsp;</td>
	  </tr>
  	<tr>
    <td align="left" width="400"><a href="#GetBanner.BannerLink#" target="_blank"><img src="/images/#GetBanner.Banner#" width="200" align="middle"> <br>
      #GetBanner.BannerClient#</a></td>
    <td width="100" align="center">#GetBanner.BannerViews#</td>
    <td width="100" align="center">#GetBanner.BannerHits#</td>
    <td align="center" width="100" valign="middle">
      <a href="banner-edit.cfm?bid=#GetBanner.BannerID#" title="Edit #GetBanner.BannerLink#">
        <img src="/scores/images/picture_edit.png" width="16" height="16" border="0">EDIT </a>    
    </td>
    <td width="100" align="center" valign="middle">
    <a href="#CGI.SCRIPT_NAME#?bid=#GetBanner.BannerID#&del=yes" title="DELETE #GetBanner.BannerLink#"onClick="javascript:return confirm('Are you sure you want to delete this Banner?')">
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