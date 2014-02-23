<cfset imagepath="/var/www/taylormartino.com/html/includes/images">
<cfset thumbpath="/var/www/taylormartino.com/html/includes/images">
<!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
<cfset imagedir="http://tm.360webpath.com/includes/images">
<cfset thumbdir="http://tm.360webpath.com/includes/images">
<cfset DTS = #CreateODBCDateTime(now())#>
<cfset message = ''>
<cfif IsDefined('url.add')>
<cfset message = 'Document added successfully'>
</cfif>
<cfif IsDefined('url.edit')>
<cfset message = 'Document edited successfully'>
</cfif>
<cfif IsDefined('url.del')>
<cfset message = 'Document deleted successfully'>
</cfif>
<!---DELETE--->
<cfif IsDefined('FORM.del')>
  <cfquery name="DeleteNews">
    DELETE FROM Background WHERE BackgroundID=#FORM.del#
  </cfquery>
  <cflocation url="backgrounds.cfm?del=yes">
</cfif>

<!---ADD--->
<cfif IsDefined('FORM.addsub') AND IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfimage action="resize" source="#imagepath#/#FileName#" width="1920" height="" destination="#imagepath#/#FileName#" overwrite="true" name="PDetails">
<cfset info=ImageInfo(PDetails)> 
	  <cfquery name="InsertNews" result="Gnew">
	  INSERT INTO Background 	
	  (Background)
	  VALUES
	  ('#FileName#')
	</cfquery>    
<cflocation url="backgrounds.cfm?add=yes">
</cfif>

<cfquery name="ShowNews">
  SELECT * FROM Background
  Order by BackgroundID 
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
    <h1>Taylor Martino Website Backgrounds</h1>
    <cfoutput>#message#</cfoutput>
    <p> * Note all backgrounds will be resized to 1920 x 1000 pixels. All uploads should be at least 1920 pixels or wider for best results.
    <FORM action="#CGI.SCRIPT_NAME#?ID=#BackgroundID#" method="post" name="mainform2" enctype="multipart/form-data">
    <table width="700" border="0" cellspacing="0" cellpadding="5">
  <tr bgcolor="#1C558A">
    <td colspan="2"><font color="#FFFFFF"><strong>ADD New Background</strong></font></td>
  </tr>

  <tr>
    <td>Background:</td>
    <td><input type="file" name="Photo" /></td>
    </tr>
  <tr>
    <td></td>
    <td><INPUT TYPE="Submit" value="Add Background" name="addsub"> </td>
    </tr>
</table>
</FORM>
	   <br /><hr>
	    <table width="700" cellspacing="0" border="0" cellpadding="0" align="left" class="yhmpabd">
	   <tr bgcolor="#1C558A">
          <td colspan="2">&nbsp;<font color="#FFFFFF"><b>Edit Backgrounds</b></font></td>
      </tr>
		 <cfif #ShowNews.RecordCount# eq 0>
		   <tr>
           <td colspan="2"> There are no Background on file</td>
           </tr>
		 <cfelse>
		 <cfoutput query="ShowNews">
		  <tr>
			  <td width="80%" valign="middle">
              <img src="#imagedir#/#Background#" align="middle" width="200" />
			  </td>
              <td width="10%" valign="middle">
				   <form method="post" action="#cgi.SCRIPT_NAME#?ID=#BackgroundID#">
				   <input type="submit" value="Delete Background" onClick="javascript:return confirm('Are you sure you want to delete this Gallery?')">
			       <input type="hidden" name="del" value="#BackgroundID#">
				   </form>
			</td>
		</tr>
		<tr>
			<td colspan="2"><HR /></td>
        </tr>
		</cfoutput></cfif>
  </table>
<br class="clearfloat"> 
</div>
<br class="clearfloat">
</body>
</html>
              