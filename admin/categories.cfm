<cfset imagepath="/var/www/gulfsportsnet.com/html/inc/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
<cfset imagedir="http://www.gulfsportsnet.com/images">
<cfset thumbdir="http://www.gulfsportsnet.com/images">
<cfset DTS = #CreateODBCDateTime(now())#>
<cfif IsDefined('FORM.del')>
  <cfquery name="DeleteNews">
    DELETE FROM Categories WHERE CategoryID=#FORM.del#
  </cfquery>
</cfif>

<cfset edit_message="">
<cfset edit_header="">
<cfset edit_f = 0>
<cfset edit_photo="">
<cfset edit_field_name="home_body_text">

<cfif IsDefined('FORM.edit')>
  <cfquery name="EditNews">
     SELECT * FROM Categories WHERE CategoryID=#FORM.edit#
  </cfquery>
  <cfset edit_header = #EditNews.Category#>
  <cfset edit_field_name = "edit_body_text">
</cfif>

<cfif IsDefined('FORM.save_edit')>

<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="overwrite">
<cfset FileName = "#file.ServerFile#">
<cfimage action="resize" source="#imagepath#/#FileName#" width="800" height="" destination="#imagepath#/#FileName#" overwrite="true">
<cfimage action="resize" source="#imagepath#/#FileName#" width="200" height="" destination="#imagepath#/th-#FileName#" overwrite="true">

 <cfquery name="SaveEdit">
   UPDATE Categories SET Category = '#FORM.Category#', CPhoto = '#FileName#', CThumb ='th-#FileName#' WHERE CategoryID=#FORM.save_edit#
 </cfquery>
 <Cfelse>
  <cfquery name="SaveEdit">
   UPDATE Categories SET Category = '#FORM.Category#' WHERE CategoryID=#FORM.save_edit#
 </cfquery>
</cfif>
</cfif>

<cfif IsDefined('FORM.addsub')>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfimage action="resize" source="#imagepath#/#FileName#" width="200" height="" destination="#imagepath#/th-#FileName#" overwrite="true">
<cfimage action="resize" source="#imagepath#/#FileName#" width="800" height="" destination="#imagepath#/#FileName#" overwrite="true" name="PDetails">
<cfset info=ImageInfo(PDetails)> 
	  <cfquery name="InsertNews" result="Gnew">
	  INSERT INTO Categories 
	  (Category)
	  VALUES
	  ('#FORM.Category#')
	</cfquery> 
	</cfif>
</cfif>

<cfquery name="ShowNews">
  SELECT * FROM Categories
  Order by CategoryID 
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

</head>
<body>
	<cfinclude template="header.cfm">
    
	<div class="container">
    <h1>Taylor Martino Categories</h1>
    <cfoutput><FORM action="#CGI.SCRIPT_NAME#" method="post" name="mainform2" enctype="multipart/form-data"></cfoutput>
    <table width="700" border="0" cellspacing="0" cellpadding="5">
  <tr bgcolor="#1C558A">
    <td colspan="3"><strong><font color="#FFFFFF"><cfif IsDefined('FORM.edit')> EDIT Category<cfelse> ADD Category</cfif></font></strong></td>
  </tr>
  <tr>
    <td width="117">Category Name:</td>
    <td width="273"><input type="text" name="Category" maxlength="100" size="40" value="<cfoutput>#edit_header#</cfoutput>" /></td>
    <td width="180" rowspan="2">
    	<cfif IsDefined('FORM.edit')>
        <cfoutput>
        <img src="../images/#EditNews.CThumb#" width="150" />
		</cfoutput>
		</cfif>
    </td>
  </tr>
 <!--- <tr>
    <td>Category Photo:</td>
    <td><input type="file" name="Photo" /></td>
  </tr>--->
  <td>&nbsp;<!---<input type="reset" value="Reset" name="reset">---></td>
    <td>
      <cfif IsDefined('FORM.edit')>
        <div align="left">
          <input type="submit" value="Edit Category">
          <input type="hidden" name="save_edit" value="<cfoutput>#FORM.edit#</cfoutput>"></div>
        <cfelse>
        <div align="left">
        <INPUT TYPE="Submit" value="Add Category" name="addsub">
        </cfif>
      </td>
  </tr>
</table>
</FORM>
	   <br /><hr>
	    <table width="700" cellspacing="0" border="0" cellpadding="0" align="left" class="yhmpabd">
	   <tr bgcolor="#1C558A">
          <td width="7%">&nbsp;<b><font color="#FFFFFF">Edit Categories</font></b></span></td>
      </tr>
	     <tr><td><cfif IsDefined('URL.home_body_text')><cfoutput>#URL.home_body_text#</cfoutput></cfif></td></tr>
		 <cfif #ShowNews.RecordCount# eq 0>
		   <tr><td> There are no Categories on file</td></tr>
		 <cfelse>
		 <cfoutput query="ShowNews">
		 
		  <tr>

		    <td>
			  <table width="100%">
			    <tr>
				  <td width="60%" valign="middle"><img src="../images/#CThumb#" align="middle" width="75" /><strong>#Category#</strong> 
				  </td>
				  <td width="10%" valign="middle">
				    <form method="post" action="#cgi.SCRIPT_NAME#?ID=#CategoryID#">
					  <input type="submit" value="Edit Category">
					  <input type="hidden" name="edit" value="#CategoryID#">
					</form>
				  </td>
                  <td width="10%" valign="middle">
				   <form method="post" action="#cgi.SCRIPT_NAME#?ID=#CategoryID#">
				   <input type="submit" value="Delete Category" onClick="javascript:return confirm('Are you sure you want to delete this Category?')">
			       <input type="hidden" name="del" value="#CategoryID#">
				   </form>
				  </td>
				</tr>
				<tr>
				<td colspan="4"><HR /></td></tr>
  </table></cfoutput></cfif></td></tr>
              </table>
             <br class="clearfloat"> 
</div><br class="clearfloat">
</body>
</html>
              