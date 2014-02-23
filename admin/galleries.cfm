<cfset imagepath="/var/www/gulfsportsnet.com/html/inc/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/inc/images">

<!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
<cfset imagedir="http://www.gulfsportsnet.com/inc/images">
<cfset thumbdir="http://www.gulfsportsnet.com/inc/images">
<cfset DTS = #CreateODBCDateTime(now())#>
<cfif IsDefined('FORM.del')>
  <cfquery name="DeleteNews">
    DELETE FROM Galleries WHERE GalleryID=#FORM.del#
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
<cfif FORM.Featured is 1>
<cfquery name="News">
  SELECT * FROM Galleries
  Order by GalleryID 
</cfquery>
<cfloop query="News">
<cfquery name="SaveEdit">
   UPDATE Galleries SET Featured = '0' WHERE GalleryID=#News.GalleryID#
 </cfquery>
 </cfloop>
</cfif>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="overwrite">
<cfset FileName = "#file.ServerFile#">
<cfimage action="resize" source="#imagepath#/#FileName#" width="800" height="" destination="#imagepath#/#FileName#" overwrite="true">
<cfimage action="resize" source="#imagepath#/#FileName#" width="200" height="" destination="#imagepath#/th-#FileName#" overwrite="true">

 <cfquery name="SaveEdit">
   UPDATE Galleries SET GName = '#FORM.GName#', Featured = '#FORM.Featured#', GPhoto = '#FileName#', GThumb ='th-#FileName#' WHERE GalleryID=#FORM.save_edit#
 </cfquery>
<!--- add to photos--->
<cfquery name="NCount">
  SELECT PhotoID FROM Photos
  Where GalleryID = <cfqueryparam value="#FORM.save_edit#" cfsqltype="cf_sql_integer">
</cfquery>
<cfset porder = NCount.RecordCount + 1>
<cfquery name="InsertP">
	  INSERT INTO Photos 
	  (
	    PName,
		GalleryID,
		Photo,
        Thumb,
        DOrder,
        Width,
        Height,
        PDate      		
      )
	  VALUES
	  (
	    '#FORM.GName#',
		'#FORM.save_edit#',
		'#FileName#',
		'th-#FileName#',
        '#porder#',
        '#info.width#',
        '#info.height#',
        <cfqueryparam value="#DTS#" cfsqltype="cf_sql_timestamp">
	  )
	</cfquery>
<!--- add to photos--->
<Cfelse>
  <cfquery name="SaveEdit">
   UPDATE Galleries SET GName = '#FORM.GName#', Featured = '#FORM.Featured#' WHERE GalleryID=#FORM.save_edit#
 </cfquery>
</cfif>
</cfif>

<cfif IsDefined('FORM.addsub')>
<cfif FORM.Featured is 1>
<cfquery name="News">
  SELECT * FROM Galleries
  Order by GalleryID 
</cfquery>
<cfloop query="News">
<cfquery name="SaveEdit">
   UPDATE Galleries SET Featured = '0' WHERE GalleryID=#News.GalleryID#
 </cfquery>
 </cfloop>
</cfif>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfimage action="resize" source="#imagepath#/#FileName#" width="200" height="" destination="#imagepath#/th-#FileName#" overwrite="true">
<cfimage action="resize" source="#imagepath#/#FileName#" width="1024" height="" destination="#imagepath#/#FileName#" overwrite="true" name="PDetails">
<cfset info=ImageInfo(PDetails)> 
	  <cfquery name="InsertNews" result="Gnew">
	  INSERT INTO Galleries 
	  (
	    GName,
        Featured,
        GPhoto,
		GThumb
      )
	  VALUES
	  (
	    '#FORM.GName#',
        '#FORM.Featured#',
		'#FileName#',
        'th-#FileName#'
	  )
	</cfquery> 
    
    <cfquery name="InsertP">
	  INSERT INTO Photos 
	  (
	    PName,
		GalleryID,
		Photo,
        Thumb,
        DOrder,
        Width,
        Height,
        PDate      		
      )
	  VALUES
	  (
	    '#FORM.GName#',
		'#GNew.GENERATED_KEY#',
		'#FileName#',
		'th-#FileName#',
        '1',
        '#info.width#',
        '#info.height#',
        <cfqueryparam value="#DTS#" cfsqltype="cf_sql_timestamp">
	  )
	</cfquery>
	</cfif>
</cfif>

<cfquery name="ShowNews">
  SELECT * FROM Galleries
  Order by GalleryID 
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
    <h1>Taylor Martino Photo Galleries</h1>
    <cfform action="#CGI.SCRIPT_NAME#" method="post" name="mainform2" enctype="multipart/form-data" >

    <table width="700" border="0" cellspacing="0" cellpadding="5">
  <tr bgcolor="#1C558A">
    <td colspan="3"><strong><font color="#FFFFFF"><cfif IsDefined('FORM.edit')> EDIT Gallery<cfelse> ADD Gallery</cfif></font></strong></td>
  </tr>
  <tr>
    <td width="117">Gallery Name:</td>
    <td width="273"><cfinput type="text" name="GName" maxlength="100" size="40" value="#edit_header#" /></td>
    <td width="180" rowspan="2">
    	<cfif IsDefined('FORM.edit')>
        <cfoutput>
        <img src="/inc/images/#EditNews.GThumb#" width="150" />
		</cfoutput>
		</cfif>
    </td>
  </tr>
  <tr>
    <td>Gallery Photo:</td>
    <td><cfinput type="file" name="Photo" /></td>
  </tr>
  <tr>
				 <td><b>Featured Gallery?</b></td>
	             <td><p>
	               <label>
	                 <input type="radio" name="Featured" value="1" id="Featured_1"<cfif edit_f eq 1> checked="checked"</cfif> />
	                 Yes</label>
	               <br />
	               <label>
	                 <input type="radio" name="Featured" value="0" id="Featured_0"<cfif edit_f eq 0> checked="checked"</cfif> />
	                 No</label>
	               <br />
                 </p></td>
        </tr>
    <td>&nbsp;<!---<input type="reset" value="Reset" name="reset">---></td>
    <td>
      <cfif IsDefined('FORM.edit')>
        <div align="left">
          <cfinput type="submit" name="submit" value="Edit Gallery">
          <cfinput type="hidden" name="save_edit" value="#FORM.edit#"></div>
        <cfelse>
        <div align="left">
        <INPUT TYPE="Submit" value="Add Gallery" name="addsub">
        </cfif>
    </td>
    </tr>
</table>
</cfform>
	   <br /><hr>
	    <table width="700" cellspacing="0" border="0" cellpadding="0" align="left" class="yhmpabd">
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
				  <td width="60%" valign="middle"><img src="/inc/images/#GThumb#" align="middle" width="75" /><strong>#GName#</strong> <cfif ShowNews.Featured eq 1><br>Featured</cfif>
				  </td>
				  <td width="10%" valign="middle">
                  <cfform method="post" action="photos.cfm?ID=#GalleryID#">
					  <input type="submit" value="Add/Edit Photos">
					  <cfinput type="hidden" name="add" value="#GalleryID#">
					</cfform>
				 
				  </td>
				  <td width="10%" valign="middle">
				    <cfform method="post" action="#cgi.SCRIPT_NAME#?ID=#GalleryID#">
					  <input type="submit" value="Edit">
					  <cfinput type="hidden" name="edit" value="#GalleryID#">
					</cfform>
				  </td>
                  <td width="10%" valign="middle">
				   <cfform method="post" action="#cgi.SCRIPT_NAME#?ID=#GalleryID#">
				   <input type="submit" value="Delete Gallery" onClick="javascript:return confirm('Are you sure you want to delete this Gallery?')">
			       <cfinput type="hidden" name="del" value="#GalleryID#">
				   </cfform>
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
              