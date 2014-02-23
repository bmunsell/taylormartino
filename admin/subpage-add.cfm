<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfset imagepath="/var/www/taylormartino.com/html/inc/images">
<cfset thumbpath="/var/www/taylormartino.com/html/images">
<cfparam name="myyear" default="#Year(Now())#" />
<cfparam name="mymonth" default="#Month(Now())#" />

<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1"> 
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
<cfquery name="GetParent">
Select PageID,PageLink,PageDir
From Pages
Where PageID = <cfqueryparam value="#FORM.PageID#" cfsqltype="cf_sql_integer">
Order By PageID
</cfquery>
<cfquery name="GetCount">
Select SubPageID
From SubPages
Where PageID = <cfqueryparam value="#FORM.PageID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfset mycount = #GetCount.RecordCount# + 1>
<cfset thumbWidth = 320>
  <cfquery result="pinsert">   
    INSERT INTO SubPages (PageID, DOrder, PageTitle, PageKeywords, PageDescription, PageImage, PageDir, PageLink, PageName, PagePrice, PageText, PageDate, PageLast, UserID, LUserID)
VALUES (<cfif IsDefined("FORM.PageID") AND #FORM.PageID# NEQ "">
<cfqueryparam value="#FORM.PageID#" cfsqltype="cf_sql_integer">
<cfelse>
''
</cfif>
, <cfif IsDefined("mycount") AND #mycount# NEQ "">
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
<cfqueryparam value="#FileName#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, <cfqueryparam value="#GetParent.PageDir#" cfsqltype="cf_sql_clob" maxlength="30">
, <cfif IsDefined("FORM.PageLink") AND #FORM.PageLink# NEQ "">
<cfqueryparam value="#Trim(FORM.PageLink)#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfqueryparam value="#PName#" cfsqltype="cf_sql_clob" maxlength="50">
, <cfif IsDefined("FORM.PagePrice") AND #FORM.PagePrice# NEQ "">
<cfqueryparam value="#val(FORM.PagePrice)#" cfsqltype="cf_sql_decimal">
<cfelse>
<cfqueryparam null="true">
</cfif>
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

  <cflocation url="page-list.cfm?add=yes&pdir=#GetParent.PageDir#">
</cfif>

<cfquery name="GetPage">
Select PageID,PageLink
From Pages
Where PageID > 5
Order By DOrder
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
<h1>Add New Sub-Page</h1>  
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
        <table width="940" cellspacing="5" align="left">
         <tr>
            <td colspan="2" class="formtext">
            	<h1>Parent Page</h1>
            	<p>Choose the Menu Item this page will appear under</p>
                <p><cfselect name="PageID" query="GetPage" value="PageID" display="PageLink"></cfselect></p>
            </td>
            <td width="180">
              <input type="submit" value="Save Page" class="subform">
            </td>
          </tr>
        <!--- <tr>
         	<td width="378" class="formtext">
            <h1>Teams:</h1>
            	<p>Choose the teams this page is relevant to.</p>
				<p><cfoutput query="GetTeams">
                <cfinput type="checkbox" name="TeamID" value="#TeamID#">#Team#
			  </cfoutput></p>
            </td>
            <td width="377" class="formtext">
            	<h1>Page Categories:</h1>
            	<p>Choose the categories this page is related to. </p>
				<p><cfoutput query="GetCat">
                <cfinput type="checkbox" name="CategoryID" value="#CategoryID#">#Category#
				</cfoutput></p>
            </td>
            <td><p>&nbsp;</p></td>
          </tr>--->
          <tr>
            <td colspan="2" class="formtext">
           	<h1>Page Name:</h1>
            <p>This is the name of the page that will appear in the main menu. Limit *50 characters<br>
            </p>
            <cfinput type="text" name="PageLink" value="" size="50" maxlength="50" required="yes" message="Please enter a Page Title">
           </td>
            <td>&nbsp;</td>
          </tr>
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
            <td colspan="2" class="formtext"><h1>Page Price:</h1>
              <p>For Products/items only, leave blank to not display.
				<br>do not use $</p>
              <span class="forminput">
              <cfinput type="text" name="PagePrice" value="" size="15" maxlength="15">
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
           <textarea name="PageDescription" cols="40" rows="7" maxlength="250"></textarea>
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