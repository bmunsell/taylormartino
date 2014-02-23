<cfparam name="pid" default="0">
<cfif IsDefined('url.pid')>
<cfset pid = #url.pid#>
</cfif>
<cfif IsDefined('FORM.pid')>
<cfset pid = #FORM.pid#>
</cfif>
<cfset imagepath="/var/www/gulfsportsnet.com/html/inc/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<cfparam name="myyear" default="#Year(Now())#" />
<cfparam name="mymonth" default="#Month(Now())#" />
<cfquery name="GetPage">
Select *
From Archives
WHERE ArchiveID = <cfqueryparam value="#pid#" cfsqltype="cf_sql_integer">
</cfquery>
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
RESTORE
<cfquery name="GetRes">
Select *
From Archives
WHERE ArchiveID = <cfqueryparam value="#pid#" cfsqltype="cf_sql_integer">
</cfquery>
<cfdump var="#GetRes#">

<cfif GetRes.PageType is 'Page'>
<cfquery name="update">   
UPDATE Pages
SET PageTitle = <cfqueryparam value="#GetRes.PageTitle#" cfsqltype="cf_sql_clob" maxlength="70">
<cfif IsDefined("GetRes.PageLink") AND #GetRes.PageLink# NEQ "">
, PageLink = <cfqueryparam value="#Trim(GetRes.PageLink)#" cfsqltype="cf_sql_clob" maxlength="30">
</cfif>
<cfif IsDefined("GetRes.PageKeywords") AND #GetRes.PageKeywords# NEQ "">
, PageKeywords = <cfqueryparam value="#Trim(GetRes.PageKeywords)#" cfsqltype="cf_sql_clob" maxlength="70">
</cfif>
<cfif IsDefined("GetRes.PageDescription") AND #GetRes.PageDescription# NEQ "">
, PageDescription = <cfqueryparam value="#Trim(GetRes.PageDescription)#" cfsqltype="cf_sql_clob" maxlength="300">
</cfif>
<cfif IsDefined("GetRes.PageImage") AND #GetRes.PageImage# NEQ "">
, PageImage = <cfqueryparam value="#GetRes.PageImage#" cfsqltype="cf_sql_clob" maxlength="250">
</cfif>
<cfif IsDefined("GetRes.PageText") AND #GetRes.PageText# NEQ "">
, PageText = <cfqueryparam value="#Trim(GetRes.PageText)#" cfsqltype="cf_sql_clob" maxlength="2147483647">
</cfif>
, PageLast = <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
, LUserID = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
WHERE PageID=#GetRes.PageID#
  </cfquery>
<cflocation url="page-list.cfm?restore=yes">
</cfif>

<cfif GetRes.PageType is 'SubPage'>
<cfquery name="update">   
UPDATE SubPages
SET PageID = <cfqueryparam value="#GetRes.PageID#" cfsqltype="cf_sql_integer">
, PageTitle = <cfqueryparam value="#GetRes.PageTitle#" cfsqltype="cf_sql_clob" maxlength="70">
<cfif IsDefined("GetRes.PageLink") AND #GetRes.PageLink# NEQ "">
, PageLink = <cfqueryparam value="#Trim(GetRes.PageLink)#" cfsqltype="cf_sql_clob" maxlength="30">
</cfif>
<cfif IsDefined("GetRes.PageKeywords") AND #GetRes.PageKeywords# NEQ "">
, PageKeywords = <cfqueryparam value="#Trim(GetRes.PageKeywords)#" cfsqltype="cf_sql_clob" maxlength="70">
</cfif>
<cfif IsDefined("GetRes.PageDescription") AND #GetRes.PageDescription# NEQ "">
, PageDescription = <cfqueryparam value="#Trim(GetRes.PageDescription)#" cfsqltype="cf_sql_clob" maxlength="300">
</cfif>
<cfif IsDefined("GetRes.PageImage") AND #GetRes.PageImage# NEQ "">
, PageImage = <cfqueryparam value="#GetRes.PageImage#" cfsqltype="cf_sql_clob" maxlength="250">
</cfif>
<cfif IsDefined("GetRes.PageText") AND #GetRes.PageText# NEQ "">
, PageText = <cfqueryparam value="#Trim(GetRes.PageText)#" cfsqltype="cf_sql_clob" maxlength="2147483647">
</cfif>
, PageLast = <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
, LUserID = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
WHERE SubPageID = <cfqueryparam value="#GetRes.SubPageID#" cfsqltype="cf_sql_integer">
  </cfquery>
<cflocation url="page-list.cfm?restore=yes&sub=yes">
</cfif>

<!--- <cfquery name="Archive">
	  INSERT INTO Archives
      (PageType,PageID,TeamID,CategoryID,PageTitle,PageKeywords,PageDescription,PageImage,PageName,PageDir,PageText,PageDate,PageLast,UserID,LUserID)
	  VALUES	  ('Page','#GetPage.PageID#','#GetPage.TeamID#','#GetPage.CategoryID#','#GetPage.PageTitle#','#GetPage.PageKeywords#','#GetPage.PageDescription#','#GetPage.PageImage#','#GetPage.PageName#','#GetPage.PageDir#','#GetPage.PageText#','#GetPage.PageDate#','#GetPage.PageLast#','#GetPage.UserID#','#GetPage.LUserID#')
	</cfquery> 

<cfset PText = Replace(FORM.editor_office2003, '   ', '', 'all')>
<cfset PText = Replace(PText, '  ', ' ', 'all')>
  --->
  
</cfif>



<cfquery name="GetCUser">
Select *
From Users
WHERE UserID = <cfqueryparam value="#GetPage.UserID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="GetLUser">
Select *
From Users
WHERE UserID = <cfqueryparam value="#GetPage.LUserID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="GetArchives">
Select *
From Archives
WHERE PageID = <cfqueryparam value="#GetPage.PageID#" cfsqltype="cf_sql_integer">
AND PageType = <cfqueryparam value="Page" cfsqltype="cf_sql_clob">
ORDER BY PageLast Desc
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
<h1>Restore Page: <cfoutput>#GetPage.PageLink# - #DateFormat(GetPage.PageLast, 'medium')#  #TimeFormat(GetPage.PageDate, 'medium')#</cfoutput></h1> 
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
        <table width="940" cellspacing="5" align="left">
         <tr>
            <td colspan="2" class="formtext"><h1>Menu Name:</h1>
              <cfoutput>#GetPage.PageLink#</cfoutput>
            </td>
            <td width="180" rowspan="9" class="formtext"><cfoutput>
            <h1>Page Details:</h1>
              <p>Created: <br>
              #DateFormat(GetPage.PageDate, 'medium')# #TimeFormat(GetPage.PageDate, 'medium')#
                <br>
                By: #GetCUser.FName# #GetCUser.LName#<br>
              </p>
                <p>&nbsp;</p>
                <p>Last Update:<br>
                #DateFormat(GetPage.PageLast, 'medium')#  #TimeFormat(GetPage.PageDate, 'medium')#<br>
            By: #GetLUser.FName# #GetLUser.LName#</p>
            
            <p>&nbsp;</p>
            <p>Page Image:<br>
            <cfif GetPage.PageImage is not ''>
			<img src="/images/#GetPage.PageImage#" width="170">
            <cfelse>
            NO Image
            </cfif></p></cfoutput>
             <p>&nbsp;</p>
            <!---<p>Previous Versions:<br>
             <cfoutput query="GetArchives">
             #DateFormat(PageLast, 'medium')# #TimeFormat(PageLast, 'medium')#<br>
             </cfoutput>
             </p>---></td>
          </tr>
         <!---<tr>
           <td width="380" class="formtext">
            	<h1>Teams:</h1>
				<p><cfoutput query="GetTeams">
                <cfif ListFind(GetPage.TeamID, #TeamID#)><strong>#GetTeams.Team# </strong></cfif></cfoutput></p>
            </td>
            <td width="377" class="formtext">
            	<h1>Page Categories:</h1>
				<p><cfoutput query="GetCat">
                <cfif ListFind(GetPage.CategoryID, #CategoryID#)><strong>#GetCat.Category# </strong></cfif></cfoutput></p>
            </td>      
          </tr>--->
         <tr>
            <td width="760" colspan="2" class="formtext">
            	<h1>Page Title:</h1>
            	<p><span class="forminput">
            	  <cfoutput><strong>#GetPage.PageTitle#</strong></cfoutput>
            	</span></p>
            </td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Text:</h1>
              <cfoutput>#Trim(GetPage.PageText)#</cfoutput>
            </td>
          </tr>
          <tr>
            <td colspan="2"><hr></td>
          </tr>
          <tr>
           <td colspan="2" class="formtext"><h2>* Optional Items</h2></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Keywords:</h1>
              <cfoutput><strong>#GetPage.PageKeywords#</strong></cfoutput>
            </td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Description:</h1>
              <cfoutput>#GetPage.PageDescription#</cfoutput>
           </td>
          </tr>
         <!--- <tr>
            <td colspan="2" class="formtext"><h1>PageImage:<span class="forminput">
              <cfinput type="file" name="Photo" size="30">
            </span></h1></td>
          </tr>--->
          <tr>
            <td colspan="2"><span class="forminput">
              <input type="submit" value="RESTORE THIS PAGE VERSION" onClick="javascript:return confirm('Are you sure you want to restore this page?')">
            </span></td>
            <td class="forminput">&nbsp;</td>
          </tr>
        </table>
        <cfinput type="hidden" name="pid" value="#GetPage.ArchiveID#">
<cfinput type="hidden" name="save_edit" value="#GetPage.PageID#">
        <input type="hidden" name="MM_InsertRecord" value="form1">
      </cfform>
      <p>&nbsp;</p>
</div>
</body>
</html>