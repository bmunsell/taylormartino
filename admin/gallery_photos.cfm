<cfparam name="URL.id" default="1">
<cfset imagepath="C:\Inetpub\wwwroot\GulfShoresWeddingChapel\images">
<cfset thumbpath="C:\Inetpub\wwwroot\GulfShoresWeddingChapel\images">
<!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
<cfset imagedir="http://www.gulfshoresweddingchapel.com/images">
<cfset thumbdir="http://www.gulfshoresweddingchapel.com/images">
<!--- MUST CHANGE BEFORE SITE GOES LIVE //--->

<cfif IsDefined('FORM.plus')>
<cfset Zplus = #FORM.order# - 1>
<cfset Zminus = #FORM.order#>

<cfquery datasource="#application.ds#" name="GetPlus" maxrows="1">
  SELECT PhotoID, DOrder, GalleryID FROM gswPhoto
  Where PhotoID = #FORM.plus#
</cfquery>
<cfquery datasource="#application.ds#" name="GetMinus" maxrows="1">
  SELECT PhotoID, DOrder, GalleryID FROM gswPhoto
  Where DOrder < #GetPlus.DOrder#
  AND GalleryID = #GetPlus.GalleryID#
  Order by DOrder Desc
</cfquery>    
  
<cfquery datasource="#application.ds#" name="DeleteNews">
    UPDATE gswPhoto SET DOrder = #FORM.order# WHERE PhotoID=#GetMinus.PhotoID#
  </cfquery>
  <cfquery datasource="#application.ds#" name="DeleteNews">
    UPDATE gswPhoto SET DOrder = #Zplus# WHERE PhotoID=#GetPlus.PhotoID#
  </cfquery>
  <cfoutput>#Zplus#   - #Zminus#     pid = #GetMinus.PhotoID#</cfoutput>
</cfif>  


<cfif IsDefined('FORM.minus')>
<cfset Zplus = #FORM.order# + 1>
<cfset Zminus = #FORM.order#>

<cfquery datasource="#application.ds#" name="GetPlus" maxrows="1">
  SELECT PhotoID, DOrder, GalleryID FROM gswPhoto
  Where PhotoID = #FORM.minus#
</cfquery>
<cfquery datasource="#application.ds#" name="GetMinus" maxrows="1">
  SELECT PhotoID, DOrder, GalleryID FROM gswPhoto
  Where DOrder > #GetPlus.DOrder#
  AND GalleryID = #GetPlus.GalleryID#
  Order by DOrder Asc
</cfquery>    
  
<cfquery datasource="#application.ds#" name="DeleteNews">
    UPDATE gswPhoto SET DOrder = #FORM.order# WHERE PhotoID=#GetMinus.PhotoID#
  </cfquery>
  <cfquery datasource="#application.ds#" name="DeleteNews">
    UPDATE gswPhoto SET DOrder = #Zplus# WHERE PhotoID=#GetPlus.PhotoID#
  </cfquery>
  <cfoutput>#Zplus#   - #Zminus#     pid = #GetMinus.PhotoID#</cfoutput>
</cfif> 


<cfif IsDefined('FORM.del')>
  <cfquery datasource="#application.ds#" name="DeleteNews">
    DELETE gswPhoto WHERE PhotoID=#FORM.del#
  </cfquery>
</cfif>


<cfset edit_header="">
<cfset edit_photo="">
<cfset edit_order="">
<cfset edit_field_name="home_body_text">

<cfif IsDefined('FORM.edit')>
  <cfquery datasource="#application.ds#" name="EditNews">
     SELECT * FROM gswPhoto WHERE PhotoID=#FORM.edit#
  </cfquery>
  
   <cfquery name="ShowProducts2" datasource="#application.ds#">
SELECT *
FROM gswGallery
Where GalleryID=#EditNews.GalleryID#
Order by GalleryID
</cfquery>
 <cfquery name="ShowProducts3" datasource="#application.ds#">
SELECT *
FROM gswGallery
Where GalleryID<>#EditNews.GalleryID#
Order by GalleryID
</cfquery>
 
  <cfset edit_header = #EditNews.PName#>
    <cfset edit_photo = #EditNews.Photo#>
       <cfset edit_order = #EditNews.DOrder#>
  <cfset edit_field_name = "edit_body_text">
</cfif>

<cfif IsDefined('FORM.save_edit')>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<CFX_OPENIMAGE ACTION="iml"
DEBUGs
NAME="Photo"
FILE="#imagepath#\#FileName#" 
animation_support="full"
commands="
setimage or1=#imagepath#\#FileName#
resize 86,58
writeanimate #imagepath#\75-#FileName#
useimage or1
resize 687,460
writeanimate #imagepath#\#FileName#
">
<cfquery datasource="#application.ds#" name="InsertProperties">
	  INSERT INTO Realtors (Name, Phone1, Phone2, Email, Photo, Thumbnail, Template, Uname, Pword, WebSite) VALUES('#FORM.Name#','#FORM.Phone1#','#FORM.Phone2#','#FORM.Email#','320-#FileName#','100-#FileName#','#FORM.Template#','#FORM.Uname#','#FORM.Pword#','#FORM.WebSite#')
</cfquery>
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<CFX_OPENIMAGE ACTION="iml"
DEBUGs
NAME="Photo"
FILE="#imagepath#\#FileName#" 
animation_support="full"
commands="
setimage or1=#imagepath#\#FileName#
resize 86,58
writeanimate #imagepath#\75-#FileName#
useimage or1
resize 687,460
writeanimate #imagepath#\#FileName#
">

 <cfquery datasource="#application.ds#" name="SaveEdit">
   UPDATE gswPhoto SET PName = '#FORM.PName#', GalleryID = '#FORM.GalleryID#', DOrder = '#FORM.DOrder#', Photo = '#FileName#', Thumb = '75-#FileName#' WHERE PhotoID=#FORM.save_edit#
 </cfquery>
<cfelse>
 <cfquery datasource="#application.ds#" name="SaveEdit">
   UPDATE gswPhoto SET PName = '#FORM.PName#', DOrder = '#FORM.DOrder#', GalleryID = '#FORM.GalleryID#'
   WHERE PhotoID=#FORM.save_edit#
 </cfquery>
</cfif>

</cfif>

<cfif IsDefined('FORM.save_add')>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<CFX_OPENIMAGE ACTION="iml"
DEBUGs
NAME="Photo"
FILE="#imagepath#\#FileName#" 
animation_support="full"
commands="
setimage or1=#imagepath#\#FileName#
resize 86,58
writeanimate #imagepath#\75-#FileName#
useimage or1
resize 687,460
writeanimate #imagepath#\#FileName#
">
    <cfquery datasource="#application.ds#" name="InsertNews">
	  INSERT INTO gswPhoto 
	  (
	    PName,
		GalleryID,
		Photo,
        Thumb,
        DOrder        		
      )
	  VALUES
	  (
	    '#FORM.PName#',
		'#FORM.GalleryID#',
		'#FileName#',
		'75-#FileName#',
        '#FORM.DOrder#'
	  )
	</cfquery> 
</cfif>
</cfif>

<cfquery datasource="#application.ds#" name="ShowNews">
  SELECT * FROM gswPhoto
  Where GalleryID = '#URL.ID#'
  Order by DOrder
</cfquery>
 <cfquery name="ShowProducts" datasource="#application.ds#">
SELECT *
FROM gswGallery
Order by GalleryID
</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Website Administration</title>
<link href="admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
<style type="text/css">
<!--


.PRow {
	border-bottom-width: 2px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
}
-->
</style>
</head>

<body>
<cfinclude template="header.cfm">
<table width="900" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="150" class="navbg" valign="top" align="center">
      <cfinclude template="nav.cfm">
    </td>
    <td width="750" valign="top">
    <!--- Start Page Edit //--->   
        <FORM action="#CGI.SCRIPT_NAME#?ID=#GalleryID#" method="post" name="mainform2" enctype="multipart/form-data">
	        <input type="hidden" name="checker">
        <input type="hidden" name="thumbsize" value="150">
        <input type="hidden" name="maxsize" value="640">
        <input type="hidden" name="prefix" value="sm">
	 <table width="99%" cellspacing="0" border="0" cellpadding="0" align="center" class="yhmpabd">
       <tr>
          <td width="7%" colspan="2" bgcolor="#3B82D2"><span class="style6">&nbsp;<b>
         <cfif IsDefined('FORM.edit')>EDIT Gallery Photo<cfelse>ADD Gallery Photos</cfif></b></span></td>
       </tr>
		<tr>
		  <td valign="top">
		    		          <b>Photo Title: </b>		  </td>
	      <td rowspan="7" valign="top"><cfif IsDefined('FORM.edit')>Current Photo:<br />
		  <!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
          <cfoutput query="EditNews"><img src="../images/#Thumb#" width="75" /></cfoutput>
		  <!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
		  </cfif></td>
		</tr>
				 <tr>
			    <td>
				   <input type="text" name="PName" maxlength="100" size="40" value="<cfoutput>#edit_header#</cfoutput>">				</td>
	         </tr>
			 	<tr>
			   <td>&nbsp;</td>
			   </tr>
			   		<tr>
		  <td valign="top">
		    		          <b>GALLERY: </b>	* Must Be defined when Editing/Adding	  </td>
        </tr>

		
				 <tr>
			    <td>
				<cfif IsDefined('FORM.edit')>
                <select name="GalleryID">
				
  <cfoutput query="ShowProducts2"> <option value="#GalleryID#" selected="selected">#GName#</option></cfoutput>
   <cfoutput query="ShowProducts3"> <option value="#GalleryID#">#GName#</option></cfoutput>
</select>
                <cfelse>
				<select name="GalleryID">
				
  <cfloop query="ShowProducts"><cfoutput> <option value="#GalleryID#"<cfif URL.ID is #GalleryID#> selected</cfif>>#GName#</option></cfoutput></cfloop>
</select></cfif>  				   </td>
	         </tr>
             <tr>
			   <td>&nbsp;</td>
			   </tr>
				 <tr>
		  <td valign="top">
		    		          <b>Photo File: </b>		  </td>
        </tr>
				 <tr>
			    <td colspan="2">
				   <input type="file" name="Photo" size="40" value="<cfoutput>#edit_photo#</cfoutput>">				</td>
		     </tr>
			 	<tr>
			   <td>&nbsp;</td>
			   </tr>
				
				 <tr>
		  <td valign="top">
		    		          <b>Photo Display Order: </b>		  </td>
        </tr>
				 <tr>
			    <td colspan="2">
				   <input type="text" name="DOrder" maxlength="4" size="4" value="<cfoutput>#edit_order#</cfoutput>">				</td>
		     </tr>
		<tr>
		  <td align="left" height="40">  
		 <cfif IsDefined('FORM.edit')>

		    <input type="submit" value="Edit Gallery Photo">
			<input type="hidden" name="save_edit" value="<cfoutput>#FORM.edit#</cfoutput>">
		   <cfelse>

<INPUT TYPE="Submit" name="save_add" value="Add Gallery Photo">
		  </cfif>	      </td>
		</tr> 
     </table>
</FORM>
<table width="900" border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td width="35%" bgcolor="#3B82D2">&nbsp;<b>Edit Gallery Photos</b></td>
    <td width="65%" bgcolor="#3B82D2"><form name="form" id="form">
              <select name="jumpMenu" id="jumpMenu" onChange="MM_jumpMenu('parent',this,0)">
              <option value="#">Select Category</option>
                <cfoutput query="ShowProducts"><option value="#CGI.SCRIPT_NAME#?ID=#GalleryID#"<cfif URL.ID is #GalleryID#> selected</cfif>>#GName#</option></cfoutput>
              </select>
            </form></td>
  </tr>
</table>
         
<!--- Create your table here --->
<table align="center" width="750" border="0" cellspacing="0" cellpadding="2">
    <tr>
        <Td><cfif #ShowNews.RecordCount# eq 0>
		    There are no Category Photos on file</cfif></TD>
    </tr>
    <!--- Loop Through Your Data --->
     <cfloop query="ShowNews" startrow="1" endrow="#ShowNews.RecordCount#">
		 <cfquery name="ShowProducts2" datasource="#application.ds#">
SELECT *
FROM gswGallery
where GalleryID = '#ShowNews.GalleryID#'
</cfquery>

        <!--- This basically gets 6 records, displays it and then creates a new row. You can substitue any number for the 6 --->
        <!--- It loops through until record count divided by record count equals one --->
        <cfif ShowNews.currentrow mod 6 EQ 1>
            <tr class="PRow">
        </cfif>
        <!--- and then display the data here --->
            <td class="PRow"><cfoutput><div align="center" class="pgallery">#DOrder#. #ShowNews.PName#<br />
            <table width="75" border="0" cellspacing="1" cellpadding="1">
    <tr>
    <td><div align="left" class="pgallery">Display</div></td>
    <td><cfif DOrder LTE 1><cfelse>
                    <form method="post" action="#CGI.SCRIPT_NAME#?ID=#GalleryID#">
					  <input type="submit" value=" + " class="pgallery">
					  <input type="hidden" name="plus" value="#PhotoID#">
                      <input type="hidden" name="order" value="#DOrder#">
					</form>
                    </cfif></td>
    <td>  <cfif CurrentRow is #RecordCount#><cfelse><form method="post" action="#CGI.SCRIPT_NAME#?ID=#GalleryID#">
					  <input type="submit" value=" - " class="pgallery">
					  <input type="hidden" name="minus" value="#PhotoID#">
                      <input type="hidden" name="order" value="#DOrder#">
					</form></cfif></td>
  </tr>
  <tr>
    <td colspan="3"><img src="../images/#Thumb#" width="75" /></td>
  </tr>

</table>
</div>
<table align="center" width="75" border="0">
    <tr>
      <td>      <form method="post" action="#CGI.SCRIPT_NAME#?ID=#GalleryID#" class="footer">
				     <input type="submit" value="Delete" onClick="javascript:return confirm('Are you sure you want to delete this record?')" class="pgallery">
				     <input type="hidden" name="del" value="#PhotoID#">
				   </form>
                   </td>
                   <td><form method="post" action="#CGI.SCRIPT_NAME#?ID=#GalleryID#">
					  <input type="submit" value="Edit" class="pgallery">
					  <input type="hidden" name="edit" value="#PhotoID#">
					</form></td></tr>
                    </table></cfoutput></td>
    </cfloop>
</tr>
</table>
    <!--- End Page Edit //--->    
    </td>
  </tr>
</table>
<cfinclude template="footer.cfm">
</body>
</html>
