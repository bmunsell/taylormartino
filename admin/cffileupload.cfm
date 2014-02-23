<cfparam name="pid" default="1">
<cfif IsDefined('url.pid')>
<cfset pid = #url.pid#>
</cfif>
<cfif IsDefined('FORM.pid')>
<cfset pid = #FORM.pid#>
</cfif>
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
<cflocation url="videos.cfm?add=yes">
</cfif>
<cfquery name="GetVid">
SELECT *
FROM Videos
Where VideoID = <cfqueryparam value="#pid#" cfsqltype="cf_sql_integer"> 
</cfquery>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Taylor Martino Website Admin</title>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
</head>
<body>

   <cfinclude template="header.cfm">
<div class="container">
<h1><img src="images/film_go.png" width="16" height="16"> Video Upload</h1>
<p>Please browse your computer for the video files you want to upload. Then click on the upload files button within the uploader. Once the uploader is completed, click on the finished uploading button</p> 
<!---<cfdump var="#GetVid#">---><cfoutput>#GetVid.PageDir#</cfoutput><br />
<cffileupload url="cffileupload-uploader.cfm?pid=#pid#" maxuploadsize="300" />
<hr>
<p>&nbsp;</p>
<cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
<cfinput type="hidden" name="MM_InsertRecord" value="form1">
<cfinput type="submit" name="submit" value="Finished Uploading" class="subform">
</cfform>
<!---<script type="text/javascript">
doneUploading = function(){
	document.write (done);
}	
</script>
<cfloop query="pages">
<cfquery name="subpages">
 SELECT *
 FROM SubPages
 WHERE SubPages.PageID = <cfqueryparam value="#pages.PageID#" cfsqltype="cf_sql_integer">
 Order by DOrder
</cfquery>
	<cfset queryAddRow(data,1)>
	<cfset querySetCell(data,"title","#PageTitle#")>
	<cfset querySetCell(data,"body","#PageText#")>
	<cfset querySetCell(data,"link","http://littlagoon.org/#PageDir#/#PageName#.cfm")>
	<cfset querySetCell(data,"subject","#PageDescription#")>
	<cfset querySetCell(data,"date",now())>--->
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>
</body>
</html>
