<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfset imagepath="/var/www/gulfsportsnet.com/html/inc/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">

<cfquery name="GetCount">
Select PageID
From Pages
</cfquery>
<cfset mycount = #GetCount.RecordCount# + 1>
  <cfquery result="pinsert">   
    INSERT INTO Pages (DOrder, PageTitle, PageKeywords, PageDescription, PageImage, PageLink, PageDir, PageName, PageText, PageDate, PageLast, UserID, LUserID)
VALUES (<cfif IsDefined("mycount") AND #mycount# NEQ "">
<cfqueryparam value="#Trim(mycount)#" cfsqltype="cf_sql_integer">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.PageTitle") AND #FORM.PageTitle# NEQ "">
<cfqueryparam value="#Trim(FORM.PageTitle)#" cfsqltype="cf_sql_clob" maxlength="70">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.PageKeywords") AND #FORM.PageKeywords# NEQ "">
<cfqueryparam value="#Trim(FORM.PageKeywords)#" cfsqltype="cf_sql_clob" maxlength="70">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.PageDescription") AND #FORM.PageDescription# NEQ "">
<cfqueryparam value="#Trim(FORM.PageDescription)#" cfsqltype="cf_sql_clob" maxlength="300">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfimage action="resize" source="#imagepath#/#FileName#" width="300" height="" destination="#imagepath#/th-#FileName#" overwrite="true">
<cfqueryparam value="#FileName#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.PageLink") AND #FORM.PageLink# NEQ "">
<cfqueryparam value="#Trim(FORM.PageLink)#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
<cfset PName = Replace(FORM.PageLink, ' ', '-', 'all')>
<cfset PName = Replace(PName, '?', '', 'all')>
<cfset PName = Replace(PName, '!', '', 'all')>
<cfset PName = Replace(PName, '##', '', 'all')>
<cfset PName = Replace(PName, '$', '', 'all')>
<cfset PName = Replace(PName, '%', '', 'all')>
<cfset PName = Replace(PName, '*', '', 'all')>
<cfset PName = Replace(PName, '/', '', 'all')>
<cfset PName = Replace(PName, '\', '', 'all')>
<cfset PName = Replace(PName, '~', '', 'all')>
<cfset PName = Replace(PName, '@', '', 'all')>
<cfset PName = Replace(PName, '^', '', 'all')>
<cfset PName = Replace(PName, '+', '', 'all')>
<cfset PName = Replace(PName, ',', '', 'all')>
<cfset PName = Replace(PName, ';', '', 'all')>
<cfset PName = Replace(PName, ':', '', 'all')>
<cfset PName = Replace(PName, '"', '', 'all')>
<cfset PName = Replace(PName, "'", "", "all")>
<cfset PName = Replace(PName, '(', '-', 'all')>
<cfset PName = Replace(PName, ')', '-', 'all')>
<cfset PName = LCase(PName)>
, <cfqueryparam value="#PName#" cfsqltype="cf_sql_clob" maxlength="50">
, <cfqueryparam value="#PName#" cfsqltype="cf_sql_clob" maxlength="50">
, <cfif IsDefined("FORM.editor_office2003") AND #FORM.editor_office2003# NEQ "">
<cfset PText = Replace(FORM.editor_office2003, '   ', '', 'all')>
<cfset PText = Replace(PText, '  ', ' ', 'all')>
<cfset PText = REReplace(PText,"#chr(13)#|\n|\r|\t","","ALL")>
<cfqueryparam value="#Trim(PText)#" cfsqltype="cf_sql_clob" maxlength="2147483647">
<cfelse>
''
</cfif>
, <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
, <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
, <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
, <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
)
  </cfquery>
  <cflocation url="page-list.cfm?add=yes">
</cfif>
<!---<cfquery name="GetCat">
Select CategoryID,Category
From Categories
Order By CategoryID
</cfquery>
<cfquery name="GetTeams">
Select TeamID,Team
From Teams
Order By TeamID
</cfquery>--->
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
<h1>Add New Page</h1>  
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
        <table width="940" cellspacing="5" align="left">
         <tr>
            <td width="760" colspan="2" rowspan="2" class="formtext">
           	<h1>Menu/Page Name:</h1>
            <p>This is the name of the page that will appear in the main menu. Limit *50 characters<br>
            </p>
            <cfinput type="text" name="PageLink" value="" size="50" maxlength="50" required="yes" message="Please enter a Page Name">
           </td>
            <td width="180">
              <input type="submit" value="Save Page" class="subform">
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <!---<tr>
            <td width="377" class="formtext">
            	<h1>Teams:</h1>
            	<p>Choose the teams this post is relevant to.</p>
				<p><cfoutput query="GetTeams">
                <cfinput type="checkbox" name="TeamID" value="#TeamID#">#Team#
				</cfoutput></p>
            </td>
              <td width="378" class="formtext"><h1> Categories:</h1>
              <p>Choose the categories this page is related to. </p>
              <p><cfoutput query="GetCat">
                <cfinput type="checkbox" name="CategoryID" value="#CategoryID#">
              #Category# </cfoutput></p></td>
            <td>&nbsp;</td>
          </tr>--->
          <tr>
            <td colspan="2" class="formtext"><h1>Page Title:</h1>
              <p>This text will appear at the top of the browser and is very important for search engines. It should contain a brief description of what the page is about.
              Limit * 70 characters</p>
              <span class="forminput">
              <cfinput type="text" name="PageTitle" value="" size="70" maxlength="70" required="yes" message="Please enter a Page Title">
            </span></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Text:</h1><textarea cols="100" id="editor_office2003" name="editor_office2003" rows="10"></textarea>
			<script type="text/javascript">
			//<![CDATA[

				CKEDITOR.replace( 'editor_office2003',
					{
						skin : 'office2003',
						contentsCss: '/includes/styles/ckEditor.css',
						width: '700',
						height: '350'
					});

			//]]>
			</script></td>
            <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="formtext"><h2>* Optional Items</h2>
             <p>These Items are not needed for page creation but are helpful with search engine placement and social media sharing.</p>
           <p></p></td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="formtext">Image:<br>
           <cfinput type="file" name="Photo" size="30"></td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="formtext">Keywords: <br>
           <cfinput type="text" name="PageKeywords" value="" size="40" maxlength="70"></td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="formtext">Description:<br>
           <textarea name="PageDescription" cols="50" rows="5" maxlength="250"></textarea>
           </td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="3">
             <input type="submit" value="Save Page" class="subform">
           </td>
          </tr>
         <tr>
           <td colspan="3">&nbsp;</td>
          </tr>
         <tr>
           <td colspan="3">&nbsp;</td>
          </tr>
        </table>
        
        <p>
          <input type="hidden" name="MM_InsertRecord" value="form1">
      </p>
  </cfform>
      
        <p>&nbsp;</p>
        <p>&nbsp;</p>
</div>
</body>
</html>