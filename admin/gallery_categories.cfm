<cfset imagepath="/var/www/gulfsportsnet.com/html/inc/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
<cfset imagedir="http://www.gulfsportsnet.com/images">
<cfset thumbdir="http://www.gulfsportsnet.com/images">
<cfif IsDefined('FORM.del')>
  <cfquery name="DeleteNews">
    DELETE Galleries WHERE GalleryID=#FORM.del#
  </cfquery>
</cfif>

<cfset edit_message="">
<cfset edit_header="">
<cfset edit_f = 0>
<cfset edit_photo="">
<cfset edit_field_name="home_body_text">

<cfif IsDefined('FORM.edit')>
  <cfquery name="EditNews">
     SELECT * FROM Galleries WHERE GalleryID=#FORM.edit#
  </cfquery>
   <cfset edit_message = #EditNews.GText#>
  <cfset edit_header = #EditNews.GName#>
  <cfset edit_f = #EditNews.Featured#>
  <cfset edit_field_name = "edit_body_text">
</cfif>

<cfif IsDefined('FORM.save_edit')>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="overwrite">
<cfset FileName = "#file.ServerFile#">
<cfimage action="resize" source="#imagepath#\#FileName#" width="800" height="" destination="#imagepath#\#FileName#" overwrite="true">
<cfimage action="resize" source="#imagepath#\#FileName#" width="200" height="" destination="#imagepath#\#FileName#-th" overwrite="true">

 <cfquery name="SaveEdit">
   UPDATE Galleries SET GName = '#FORM.GName#', GPhoto = '#FileName#', GThumb ='#FileName#-th' WHERE GalleryID=#FORM.save_edit#
 </cfquery>
 <Cfelse>
  <cfquery name="SaveEdit">
   UPDATE Galleries SET GName = '#FORM.GName#' WHERE GalleryID=#FORM.save_edit#
 </cfquery>
</cfif>
</cfif>

<cfif IsDefined('FORM.addsub')>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfimage action="resize" source="#imagepath#\#FileName#" width="800" height="" destination="#imagepath#\#FileName#" overwrite="true">
<cfimage action="resize" source="#imagepath#\#FileName#" width="200" height="" destination="#imagepath#\#FileName#-th" overwrite="true">
	  <cfquery name="InsertNews">
	  INSERT INTO Galleries 
	  (
	    GName,
        GPhoto,
		GThumb
      )
	  VALUES
	  (
	    '#FORM.GName#',
		'#FileName#',
        '#FileName#-th'
	  )
	</cfquery> 
	</cfif>
</cfif>

<cfquery name="ShowNews">
  SELECT * FROM Galleries
  Order by GalleryID 
</cfquery>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Website Administration</title>
<link href="admin.css" rel="stylesheet" type="text/css" />
</head>

<body>
<cfinclude template="header.cfm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="20%" class="navbg" valign="top" align="center">
      <cfinclude template="nav.cfm">
    </td>
    <td width="80%" valign="top">
    <!--- Start Page Edit //--->   
<FORM action="#cgi.SCRIPT_NAME#?ID=#GalleryID#" method="post" name="mainform2" enctype="multipart/form-data">

<table width="99%" cellspacing="0" border="0" cellpadding="0" align="center" class="yhmpabd">
       <tr>
          <td colspan="4"><span class="style6">&nbsp;<b><font color="#FFFFFF"><cfif IsDefined('FORM.edit')>
            EDIT Galleries
            <cfelse>ADD Galleries</cfif></font></b></span></td>
        </tr>
		<tr>
		  <td width="16%" valign="top">
		    		          <b>Gallery Name: </b></td>
	      <td width="84%" colspan="2" valign="top"><input type="text" name="GName" maxlength="100" size="40" value="<cfoutput>#edit_header#</cfoutput>" /></td>
        </tr>
			 <tr>
			   <td colspan="4">&nbsp;</td>
	    </tr>
			
			
							 <tr>
							   <td colspan="2">&nbsp;</td>
	    </tr>
			 
			 <tr>
				 <td><b>Gallery Photo:</b></td>
	             <td><input type="file" name="Photo" /></td>
	             <td>&nbsp;</td>
	    </tr>
			<tr>
		  <td colspan="3">&nbsp;</td>
		</tr>
        <tr>
				 <td><b>Featured Gallery?</b></td>
	             <td><p>
	               <label>
	                 <input type="radio" name="Featured" value="1" id="Featured_1"<cfif edit_f = 1> checked="checked"</cfif> />
	                 Yes</label>
	               <br />
	               <label>
	                 <input type="radio" name="Featured" value="0" id="Featured_0"<cfif edit_f = 0> checked="checked"</cfif> />
	                 No</label>
	               <br />
                 </p></td>
	             <td>&nbsp;</td>
	    </tr>
		<tr>
		  <td height="40" colspan="3" align="center">  
		 <cfif IsDefined('FORM.edit')>
		    <div align="left">
		      <input type="submit" value="Edit Gallery">
		      <input type="hidden" name="save_edit" value="<cfoutput>#FORM.edit#</cfoutput>"></div>
	          <cfelse>
		      <div align="left">
		      <INPUT TYPE="Submit" value="Add Gallery" name="addsub">
		 </cfif></div></td>
		</tr> 
     </table>
</FORM>
	   <br />
	    <table width="400" cellspacing="0" border="0" cellpadding="0" align="left" class="yhmpabd">
	   <tr bgcolor="#1C558A">
          <td width="7%">&nbsp;<b><font color="#FFFFFF">Edit Galleries</font></b></span></td>
      </tr>
	     <tr><td><cfif IsDefined('URL.home_body_text')><cfoutput>#URL.home_body_text#</cfoutput></cfif></td></tr>
		 <cfif #ShowNews.RecordCount# eq 0>
		   <tr><td> There are no Galleries on file</td></tr>
		 <cfelse>
		 <cfoutput query="ShowNews">
		 
		  <tr>

		    <td>
			  <table width="100%">
			    <tr>
				  <td width="80%" valign="middle"><img src="../images/#GThumb#" align="middle" width="75" />#GName# 
				  </td>
				  <td width="10%" valign="middle">
				 <form method="post" action="#cgi.SCRIPT_NAME#?ID=#GalleryID#">
				     <input type="submit" value="Delete" onClick="javascript:return confirm('Are you sure you want to delete this record?')">
			       <input type="hidden" name="del" value="#GalleryID#">
				   </form>
				  </td>
				  <td width="10%" valign="middle">
				    <form method="post" action="#cgi.SCRIPT_NAME#?ID=#GalleryID#">
					  <input type="submit" value="Edit">
					  <input type="hidden" name="edit" value="#GalleryID#">
					</form>
				  </td>
				</tr>
				<tr>
				<td colspan="3"><HR /></td></tr>
			  </table></td></tr></cfoutput></cfif>
              
    <!--- End Page Edit //--->    
    </td>
  </tr>
</table>
<cfinclude template="footer.cfm">
</body>
</html>
