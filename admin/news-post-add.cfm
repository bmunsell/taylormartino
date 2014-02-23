<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfset imagepath="/var/www/gulfsportsnet.com/html/inc/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<cfparam name="myyear" default="#Year(Now())#" />
<cfparam name="mymonth" default="#Month(Now())#" />
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">

  <cfquery result="pinsert">   
    INSERT INTO Posts (PageID, PageType, PageTitle, PageKeywords, PageDescription, PageImage, PageName, PageDir, PageText, PageDate, PageLast, UserID, LUserID)
VALUES (<cfif IsDefined("FORM.PageID") AND #FORM.PageID# NEQ "">
<cfqueryparam value="#Trim(FORM.PageID)#" cfsqltype="cf_sql_integer">
<cfelse>
''
</cfif>
, <cfqueryparam value="article" cfsqltype="cf_sql_clob" maxlength="70">
, <cfif IsDefined("FORM.PostTitle") AND #FORM.PostTitle# NEQ "">
<cfqueryparam value="#Trim(FORM.PostTitle)#" cfsqltype="cf_sql_clob" maxlength="70">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.PostKeywords") AND #FORM.PostKeywords# NEQ "">
<cfqueryparam value="#Trim(FORM.PostKeywords)#" cfsqltype="cf_sql_clob" maxlength="70">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.PostDescription") AND #FORM.PostDescription# NEQ "">
<cfqueryparam value="#Trim(FORM.PostDescription)#" cfsqltype="cf_sql_clob" maxlength="250">
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
<cfset PName = Replace(FORM.PostTitle, ' ', '-', 'all')>
<cfset PName = Replace(PName, '?', '', 'all')>
<cfset PName = Replace(PName, '.', '', 'all')>
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
, <cfqueryparam value="#PName#" cfsqltype="cf_sql_clob" maxlength="100">
, <cfqueryparam value="news/#myyear#" cfsqltype="cf_sql_clob" maxlength="100">
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

  <cflocation url="posts.cfm?add=yes">
</cfif>
<cfquery name="GetPage">
Select PageID,PageLink
From Pages
WHERE PageID > 5
Order By DOrder
</cfquery>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Taylor Martino Website Admin</title>
<link rel="stylesheet" type="text/css" href="/includes/styles/Taylor Martino.css">
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
</head>
<body>

   <cfinclude template="header.cfm">
<div class="container">
<h1><img src="/admin/images/Comment.png" width="16" height="16" align="middle">Add New Post</h1>  
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
        <table width="940" cellspacing="5" align="left"> 
          <tr>
            <td colspan="2" class="formtext"><h1>News Title:</h1>
              <p>This text will appear at the top of the browser and is very important for search engines. It should contain a brief description of what the post is about.<br>
Limit * 70 characters</p>
              <span class="forminput">
              <cfinput type="text" name="PostTitle" value="" size="70" maxlength="70" required="yes" message="Please enter a Post Title">
            </span></td>
            <td>&nbsp;</td>
          </tr>           
       <tr>
          	<td width="335" class="formtext">
            	<h1>News Category Page</h1>
            	<p>By default all News posts will display on the News and Home pages.</p>
                <p>You can also choose a category Page and this post will appear under related news on that page category.</p>
                <p><select name="PageID">
                <option>Select a Page Category</option>
                <cfoutput query="GetPage">
                <option value="#PageID#">#PageLink#</option>
                </cfoutput>
                </select></p>
            </td>
            <td width="335" class="formtext">
            <h1>Sticky Post:</h1>
            	<p>Check this box if you want this item to remain at the top of the listings, regardless of date.</p>
                <p><strong>Sticky this post:</strong><input name="isSticky" type="checkbox" value="1"></p>
            </td>
        </tr>  
       
          <tr>
<td colspan="2" class="formtext"><h1>News Text:</h1><textarea cols="100" id="editor_office2003" name="editor_office2003" rows="10"></textarea></td>
<script type="text/javascript">
//<![CDATA[
CKEDITOR.replace( 'editor_office2003',
{
	skin : 'office2003',
	extraPlugins : 'stylesheetparser',
	width: '760'
});
//]]></script>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3"><hr></td>
          </tr>
          <tr>
           <td colspan="2" class="oformtext"><h2>* Optional Items</h2>
             <p>These Items are not needed for post creation but are helpful with search engine placement and social media sharing.</p>
           <p></p></td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="oformtext">Image:<br>
           <cfinput type="file" name="Photo" size="30"></td>
           <td>&nbsp;</td>
          </tr>
          <tr>
           <td colspan="2" class="oformtext"><h2>* SEO Items</h2>
             <p>These Items are important for Search Engine Optimization.</p>
           <p></p></td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="oformtext">Keywords: <br>
           <p>comma separated list of article keywords</p>
           <cfinput type="text" name="PostKeywords" value="" size="40" maxlength="70"></td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="oformtext">Description:<br>
           <p>description of page/article usually the first paragraph<br>* 250 Character max.</p>
           <cftextarea name="PostDescription" richtext="false" cols="50" rows="5" maxlength="250"></cftextarea>
           </td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="3">
             <input type="submit" value="Save Post" class="subform">
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