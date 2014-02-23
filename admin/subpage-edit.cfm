<cfparam name="pid" default="1">
<cfif IsDefined('url.pid')>
<cfset pid = #url.pid#>
</cfif>
<cfif IsDefined('FORM.pid')>
<cfset pid = #FORM.pid#>
</cfif>
<cfif IsDefined('url.CFGRIDKEY')>
<cfset pid = #url.CFGRIDKEY#>
</cfif>
<cfquery name="GetPage">
Select *
From SubPages
WHERE SubPageID = <cfqueryparam value="#pid#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="GetParent">
Select *
From Pages
WHERE PageID = <cfqueryparam value="#GetPage.PageID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfset imagepath="/var/www/taylormartino.com/html/inc/images">
<cfset thumbpath="/var/www/taylormartino.com/html/inc/images">
<cfparam name="myyear" default="#Year(Now())#" />
<cfparam name="mymonth" default="#Month(Now())#" />

<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
	<cfset thumbWidth = 320>
<cfquery name="Archive">
INSERT INTO Archives
(PageType,PageID,SubPageID,DOrder,PageTitle,PageKeywords,PageDescription,PageImage,PageName,PageLink,PageDir,PageText,PageDate,PageLast,UserID,LUserID)
VALUES
('SubPage','#GetPage.PageID#','#GetPage.SubPageID#','#GetPage.DOrder#','#GetPage.PageTitle#','#GetPage.PageKeywords#','#GetPage.PageDescription#','#GetPage.PageImage#','#GetPage.PageName#','#GetPage.PageLink#','#GetPage.PageDir#','#GetPage.PageText#','#GetPage.PageDate#','#GetPage.PageLast#','#GetPage.UserID#','#GetPage.LUserID#')
</cfquery> 
<cfset PText = Replace(FORM.editor_office2003, '   ', '', 'all')>
<cfset PText = Replace(PText, '  ', ' ', 'all')>
  <cfquery name="update">   
UPDATE SubPages
SET PageTitle = <cfqueryparam value="#Trim(FORM.PageTitle)#" cfsqltype="cf_sql_clob" maxlength="70">
<cfif IsDefined("FORM.PageID") AND #FORM.PageID# NEQ "">
, PageID = <cfqueryparam value="#Trim(FORM.PageID)#" cfsqltype="cf_sql_integer">
</cfif>
<cfif IsDefined("FORM.isActive") AND #FORM.isActive# NEQ "">
, isActive = <cfqueryparam value="#Trim(FORM.isActive)#" cfsqltype="cf_sql_integer">
</cfif>
<cfif IsDefined("FORM.PageLink") AND #FORM.PageLink# NEQ "">
, PageLink = <cfqueryparam value="#Trim(FORM.PageLink)#" cfsqltype="cf_sql_clob" maxlength="50">
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
, PageName = <cfqueryparam value="#PName#" cfsqltype="cf_sql_clob" maxlength="50">
</cfif>
<cfif IsDefined("FORM.PageKeywords") AND #FORM.PageKeywords# NEQ "">
, PageKeywords = <cfqueryparam value="#Trim(FORM.PageKeywords)#" cfsqltype="cf_sql_clob" maxlength="70">
</cfif>
<cfif IsDefined("FORM.PageDescription") AND #FORM.PageDescription# NEQ "">
, PageDescription = <cfqueryparam value="#Trim(FORM.PageDescription)#" cfsqltype="cf_sql_clob" maxlength="300">
</cfif>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cffile action="rename" source="#imagepath#/#cffile.serverFile#" destination="#imagepath#/#PName#.#cffile.serverFileExt#" nameconflict="overwrite" />
<cfset FileName = "#PName#.#cffile.serverFileExt#">
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
, PageImage = <cfqueryparam value="#FileName#" cfsqltype="cf_sql_clob" maxlength="250">
</cfif>
<cfif IsDefined("FORM.PagePrice") AND #FORM.PagePrice# NEQ "">
, PagePrice = <cfqueryparam value="#Trim(FORM.PagePrice)#" cfsqltype="cf_sql_decimal" >
</cfif>
<cfif IsDefined("PText") AND #PText# NEQ "">
<cfset PText = REReplace(PText,"#chr(13)#|\n|\r|\t","","ALL")>
, PageText = <cfqueryparam value="#Trim(PText)#" cfsqltype="cf_sql_clob" maxlength="2147483647">
</cfif>
, PageLast = <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
, LUserID = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
WHERE SubPageID=#FORM.save_edit#
  </cfquery>
  <cflocation url="subpage-list.cfm?edit=yes&pid=#GetPage.PageID#">
</cfif>

<cfquery name="GetPages">
Select *
From Pages
WHERE PageID > 5
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
<cfquery name="GetArchives" maxrows="30">
Select *
From Archives
WHERE SubPageID = <cfqueryparam value="#GetPage.SubPageID#" cfsqltype="cf_sql_integer">
AND PageType = <cfqueryparam value="SubPage" cfsqltype="cf_sql_clob">
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

<h1>Edit SubPage: <cfoutput>#GetPage.PageLink#</cfoutput></h1> 
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
       <table width="940" cellspacing="5" align="left">
         <tr>
            <td colspan="2" class="formtext">
            	<h1>Parent Page&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;current:&nbsp;<cfoutput>#GetParent.PageLink#</cfoutput></h1>
                <cfselect name="PageID" query="GetPages" value="PageID" display="PageLink" selected="#GetParent.PageID#"></cfselect>
            </td>
          <td width="180">
              <input type="submit" value="Save Page" class="subform">
            </td>
          </tr>
         <tr><td></td><td></td>
         	

            <td rowspan="9" class="formtext">
            <cfoutput>
            <h1>Page Details:</h1>
              <p>Created: <br>
              #DateFormat(GetPage.PageDate, 'medium')# #TimeFormat(GetPage.PageDate, 'medium')#
                <br>
                By: #GetCUser.FName# #GetCUser.LName#<br>
              </p>
                <p>&nbsp;</p>
                <p>Last Update:<br>
                #DateFormat(GetPage.PageLast, 'medium')#  #TimeFormat(GetPage.PageLast, 'medium')#<br>
            By: #GetLUser.FName# #GetLUser.LName#</p>
            
            <p>&nbsp;</p>
            <p>Page Image:<br>
            <cfif GetPage.PageImage is not ''>
			<img src="/inc/images/#GetPage.PageImage#" width="170">
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
            <td colspan="2" class="formtext"><h1>Page Name:<span class="forminput">
              <cfinput type="text" name="PageLink" value="#GetPage.PageLink#" size="50" maxlength="50" required="yes" message="Please enter a Page Name">
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext">
            	<h1>Page Title:</h1>
            	<p>This text will appear at the top of the browser and is very important for search engines.<br>Limit * 70 characters<span class="forminput">
            	  <cfinput type="text" name="PageTitle" value="#GetPage.PageTitle#" maxlength="70" size="70" required="yes" message="Please enter a Page Title">
            	</span></p>
            </td>
          </tr>
		  <cfif GetPage.PagePrice is not ''>
		  	<cfset myprice = #NumberFormat(GetPage.PagePrice, '____.__')#>
			<cfelse>
			<cfset myprice = ''>
		  </cfif>
		  <tr>
            <td colspan="2" class="formtext">
            	<h1>Page Price:</h1>
            	<p>For Products/items only, leave blank to not display.
				<br>do not use $</p><span class="forminput">
            	  <cfinput type="text" name="PagePrice" value="#trim(myprice)#" maxlength="15" size="15">
            	</span></p>
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
            <td colspan="2" class="formtext"><h1>Page Image:<span class="forminput">
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
<cfinput type="hidden" name="pid" value="#GetPage.SubPageID#">
<cfinput type="hidden" name="save_edit" value="#GetPage.SubPageID#">
        <input type="hidden" name="MM_InsertRecord" value="form1">
  </cfform>
      <p>&nbsp;</p>

<!-- end .container --></div>
</body>
</html>