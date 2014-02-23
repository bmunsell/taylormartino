<cfparam name="pid" default="1">
<cfif IsDefined('url.pid')>
<cfset pid = #url.pid#>
</cfif>
<cfif IsDefined('FORM.pid')>
<cfset pid = #FORM.pid#>
</cfif>
<cfset imagepath="/var/www/taylormartino.com/html/inc/images">
<cfset thumbpath="/var/www/taylormartino.com/html/inc/images">
<cfparam name="myyear" default="#Year(Now())#" />
<cfparam name="mymonth" default="#Month(Now())#" />
<cfset thumbWidth = 320>
<cfquery name="GetPage">
Select *
From Pages
WHERE PageID = <cfqueryparam value="#pid#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
	<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
		<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
		<cffile action="rename" source="#imagepath#/#cffile.serverFile#" destination="#imagepath#/#GetPage.PageName#.#cffile.serverFileExt#" nameconflict="overwrite" />
		<cfset FileName = "#GetPage.PageName#.#cffile.serverFileExt#">
		<cfset ThumbName = "th-#FileName#">
		<cfscript> 
			imgFile = createObject("java","javax.swing.ImageIcon").init("#imagepath#/#FileName#"); 
			imgFile.getImage(); 
			w = imgFile.getIconWidth(); 
			h = imgFile.getIconHeight();
		</cfscript>
		<cfif w GT thumbWidth>
			<cfimage action="resize" source="#imagepath#/#FileName#" width="#thumbWidth#" height="" destination="#imagepath#/#thumbName#" overwrite="true">
		<cfelse>
			<cffile action="copy" destination="#imagepath#/#ThumbName#" source="#imagepath#/#FileName#" > 
		</cfif>
	</cfif>
<cfquery name="Archive">
INSERT INTO Archives
(PageType,PageID,DOrder,PageTitle,PageKeywords,PageDescription,PageImage,PageName,PageLink,PageDir,PageText,PageDate,PageLast,UserID,LUserID)
VALUES
('Page','#GetPage.PageID#','#GetPage.DOrder#','#GetPage.PageTitle#','#GetPage.PageKeywords#','#GetPage.PageDescription#','#GetPage.PageImage#','#GetPage.PageName#','#GetPage.PageLink#','#GetPage.PageDir#','#GetPage.PageText#','#GetPage.PageDate#','#GetPage.PageLast#','#GetPage.UserID#','#GetPage.LUserID#')
</cfquery> 

<cfset PText = Replace(FORM.editor_office2003, '   ', '', 'all')>
<cfset PText = Replace(PText, '  ', ' ', 'all')>
  <cfquery name="update">   
UPDATE Pages
SET PageTitle = <cfqueryparam value="#FORM.PageTitle#" cfsqltype="cf_sql_clob" maxlength="70">
<cfif IsDefined("FORM.PageKeywords") AND #FORM.PageKeywords# NEQ "">
, PageKeywords = <cfqueryparam value="#Trim(FORM.PageKeywords)#" cfsqltype="cf_sql_clob" maxlength="70">
</cfif>
<cfif IsDefined("FORM.PageDescription") AND #FORM.PageDescription# NEQ "">
, PageDescription = <cfqueryparam value="#Trim(FORM.PageDescription)#" cfsqltype="cf_sql_clob" maxlength="300">
</cfif>
<cfif IsDefined("FORM.isActive") AND #FORM.isActive# NEQ "">
, isActive = <cfqueryparam value="#Trim(FORM.isActive)#" cfsqltype="cf_sql_integer">
</cfif>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
, PageImage = <cfqueryparam value="#FileName#" cfsqltype="cf_sql_clob" maxlength="250">
</cfif>
<cfif IsDefined("FORM.PageLink") AND #FORM.PageLink# NEQ "">
, PageLink = <cfqueryparam value="#Trim(FORM.PageLink)#" cfsqltype="cf_sql_clob" maxlength="30">
</cfif>
<cfif IsDefined("PText") AND #PText# NEQ "">
<cfset PText = REReplace(PText,"#chr(13)#|\n|\r|\t","","ALL")>
, PageText = <cfqueryparam value="#Trim(PText)#" cfsqltype="cf_sql_clob" maxlength="2147483647">
</cfif>
, PageLast = <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
, LUserID = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
WHERE PageID=#FORM.save_edit#
  </cfquery>
  <cflocation url="page-list.cfm?edit=yes">
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
<cfquery name="GetArchives" maxrows="30">
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
<link href='http://fonts.googleapis.com/css?family=Sorts+Mill+Goudy:400,400italic' rel='stylesheet' type='text/css'>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
</head>
<body>

   <cfinclude template="header.cfm">
<div class="container">
<h1>Edit Page: <cfoutput>#GetPage.PageLink#</cfoutput></h1> 
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
        <table width="940" cellspacing="5" align="left">
         <tr>
            <td colspan="2" class="formtext"><h1>Menu Name:</h1>
              <cfoutput>#GetPage.PageLink#</cfoutput>
            </td>
            <td class="forminput"><input type="submit" value="Save Page" class="subform"></td>
          </tr>
         <tr><td></td><td></td>
           <!---<td width="380" class="formtext">
            	<h1>Teams:</h1>
            	<p>Choose the teams this page is relevant to.</p>
				<p><cfoutput query="GetTeams">
                <cfif ListFind(GetPage.TeamID, #TeamID#)>
                <cfinput type="checkbox" 
                	name="TeamID" 
                	value="#GetTeams.TeamID#" 
                	checked="yes">
                <cfelse>
                <cfinput type="checkbox" name="TeamID" value="#GetTeams.TeamID#">
                </cfif> 	
                #GetTeams.Team#
                </cfoutput>
                </p>
            </td>
            <td width="377" class="formtext">
            	<h1>Page Categories:</h1>
            	<p>Choose the categories this page is related to. </p>
				<p><cfoutput query="GetCat">
                <cfif ListFind(GetPage.CategoryID, #CategoryID#)>
                <cfinput type="checkbox" 
                	name="CategoryID" 
                	value="#GetCat.CategoryID#" 
                	checked="yes">
                <cfelse>
                <cfinput type="checkbox" name="CategoryID" value="#GetCat.CategoryID#">
                </cfif> 	
                #GetCat.Category#
                </cfoutput></p>
            </td>  --->    
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
			<img src="/inc/images/#GetPage.PageImage#" width="100">
            <cfelse>
            NO Image
            </cfif></p></cfoutput>
             <p>&nbsp;</p>
             <p>Previous Versions:<br>
             <cfoutput query="GetArchives">
             <a href="/admin/restore.cfm?pid=#ArchiveID#">#DateFormat(PageLast, 'medium')# #TimeFormat(PageLast, 'medium')#</a><br><br>
             </cfoutput>
             </p></td>
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
            	<h1>Page Title:</h1>
            	<p>This text will appear at the top of the browser and is very important for search engines.<br>Limit * 70 characters<span class="forminput">
            	  <cfinput type="text" name="PageTitle" value="#GetPage.PageTitle#" maxlength="70" size="70" required="yes" message="Please enter a Page Title">
            	</span></p>
            </td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Text:<span class="forminput">
              <textarea id="editor_office2003" name="editor_office2003"><cfoutput>#Trim(GetPage.PageText)#</cfoutput>
              </textarea>
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
            <td colspan="2" class="formtext"><h1>Page Keywords:<span class="forminput">
              <cfinput type="text" name="PageKeywords" value="#GetPage.PageKeywords#" size="70" maxlength="70">
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Description:<span class="forminput">
             <cfoutput><textarea name="PageDescription" cols="50" rows="5" maxlength="250">#trim(GetPage.PageDescription)#</textarea></cfoutput>
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>PageImage:<span class="forminput">
              <cfinput type="file" name="Photo" size="30">
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2"><span class="forminput">
              <input type="submit" value="Save Page" class="subform">
            </span></td>
            <td class="forminput">&nbsp;</td>
          </tr>
        </table>
        <cfinput type="hidden" name="pid" value="#GetPage.PageID#">
<cfinput type="hidden" name="save_edit" value="#GetPage.PageID#">
        <input type="hidden" name="MM_InsertRecord" value="form1">
      </cfform>
      <p>&nbsp;</p>
</div>
</body>
</html>