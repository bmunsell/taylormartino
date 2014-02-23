<cfparam name="pid" default="1">
<cfif IsDefined('url.pid')>
<cfset pid = #url.pid#>
</cfif>
<cfif IsDefined('FORM.pid')>
<cfset pid = #FORM.pid#>
</cfif>
<cfset imagepath="/var/www/taylormartino.com/html/inc/images">
<cfset thumbpath="/var/www/taylormartino.com/html/images">
<cfparam name="myyear" default="#Year(Now())#" />
<cfparam name="mymonth" default="#Month(Now())#" />
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
<cfset PText = Replace(FORM.editor_office2003, '   ', '', 'all')>
<cfset PText = Replace(PText, '  ', ' ', 'all')>
<!---<cfdump var="#PText#">--->
  <cfquery name="update">   
UPDATE Posts
SET PageTitle = <cfqueryparam value="#Trim(FORM.PageTitle)#" cfsqltype="cf_sql_clob" maxlength="70">
<cfif IsDefined("FORM.PageKeywords") AND #FORM.PageKeywords# NEQ "">
, PageKeywords = <cfqueryparam value="#Trim(FORM.PageKeywords)#" cfsqltype="cf_sql_clob" maxlength="70">
</cfif>
<cfif IsDefined("FORM.PageDescription") AND #FORM.PageDescription# NEQ "">
, PageDescription = <cfqueryparam value="#FORM.PageDescription#" cfsqltype="cf_sql_clob" maxlength="250">
</cfif>
<cfif IsDefined("FORM.isActive") AND #FORM.isActive# NEQ "">
, isActive = <cfqueryparam value="#Trim(FORM.isActive)#" cfsqltype="cf_sql_integer">
</cfif>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfimage action="resize" source="#imagepath#/#FileName#" width="300" height="" destination="#imagepath#/th-#FileName#" overwrite="true">
, PageImage = <cfqueryparam value="#FileName#" cfsqltype="cf_sql_clob" maxlength="250">
</cfif>
<cfif IsDefined("PText") AND #PText# NEQ "">
<cfset PText = REReplace(PText,"#chr(13)#|\n|\r|\t","","ALL")>
, PageText = <cfqueryparam value="#Trim(PText)#" cfsqltype="cf_sql_clob" maxlength="2147483647">
</cfif>
<cfif IsDefined("FORM.PageDate") AND #FORM.PageDate# NEQ "">
, PageDate = <cfqueryparam value="#FORM.PageDate# #TimeFormat(now(), 'HH:mm:ss')#" cfsqltype="cf_sql_timestamp">
</cfif>
, PageLast = <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
WHERE PostID=#FORM.save_edit#
  </cfquery>
  <cflocation url="posts.cfm?edit=yes">
</cfif>
<cfquery name="GetPage">
Select *
From Posts
WHERE PostID = <cfqueryparam value="#pid#" cfsqltype="cf_sql_integer">
</cfquery>
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
<h1>Edit Post: 
  <cfoutput>#GetPage.PageTitle#</cfoutput></h1> 
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
        <table width="940" cellspacing="5" align="left">
         <tr>
            <td width="760" colspan="2" class="formtext">
            	<h1>Post Title:</h1>
            	<p>This text will appear at the top of the browser and is very important for search engines.<br>Limit * 70 characters<span class="forminput"><br>
            	  <cfinput type="text" name="PageTitle" value="#GetPage.PageTitle#" maxlength="70" size="70" required="yes" message="Please enter a Page Title">
            	</span></p>
            </td>
            <td width="180">
              <input type="submit" value="Save Post" class="subform">
            </td>
            
          </tr>
          <tr>
           <td colspan="2" class="formtext">
           	<h1>Active:</h1>
           	<p>use this instead of deleting a page, it will not show in links but can still be accessed directly for testing.</p>
            <p>
              <label>
                <input type="radio" name="isActive" value="1" id="isActive_0"<cfif GetPage.isActive eq 1> checked</cfif>>
                Yes</label>
              <br>
              <label>
                <input type="radio" name="isActive" value="0" id="isActive_1"<cfif GetPage.isActive eq 0> checked</cfif>>
                No</label>
              <br>
           </p></td>
         </tr>
          <tr>
          	<td width="760" colspan="2" class="formtext">
            	<h1>Post Date:</h1>
            	<p>The Post Date is: <strong><cfoutput>#DateFormat(GetPage.PageDate, 'yyyy-mm-dd')#</cfoutput></strong> it can be changed if needed, otherwise leave blank<br>
                <cfinput type="datefield" name="PageDate" mask="yyyy-mm-dd">
            </td>
                
            <td rowspan="7" class="formtext">
            <cfoutput>
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
			<img src="/inc/images/#GetPage.PageImage#" width="100">
            <cfelse>
            NO Image
            </cfif></p></cfoutput>
            </td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Post Text:<br>
              <span class="forminput">
              <textarea id="editor_office2003" name="editor_office2003"><cfoutput>#Trim(GetPage.PageText)#</cfoutput></textarea>
              <script type="text/javascript">
			//<![CDATA[
				CKEDITOR.replace( 'editor_office2003',{
					skin : 'office2003',
					contentsCss: '/includes/styles/ckEditor.css',
					width: '700',
					height: '350'
				});
			//]]>
			</script>     
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2"><hr></td>
          </tr>
          <tr>
           <td colspan="2" class="formtext"><h2>* Optional Items</h2>
             <p>These Items are not needed for page creation but are helpful with search engine placement and social media sharing.</p>
           <p></p></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Post Keywords:<span class="forminput">
              <cfinput type="text" name="PageKeywords" value="#GetPage.PageKeywords#" size="70" maxlength="70" >
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Post Description:<span class="forminput"><br>
              <cfoutput><textarea name="PageDescription" cols="50" rows="5" maxlength="250">#trim(GetPage.PageDescription)#</textarea></cfoutput>          
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Post Image:<span class="forminput">
              <cfinput type="file" name="Photo" size="30">
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2"><span class="forminput">
              <input type="submit" value="Save Post" class="subform">
            </span></td>
            <td class="forminput">&nbsp;</td>
          </tr>
        </table>
<cfinput type="hidden" name="save_edit" value="#GetPage.PostID#">
        <input type="hidden" name="MM_InsertRecord" value="form1">
      </cfform>
      <p>&nbsp;</p>
<br class="clearfloat"> 
</div><br class="clearfloat">
</body>
</html>