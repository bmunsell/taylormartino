<cfparam name="URL.id" default="1">
<cfset imagepath="/var/www/gulfsportsnet.com/html/inc/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
<cfset imagedir="http://www.gulfsportsnet.com/images">
<cfset thumbdir="http://www.gulfsportsnet.com/images">
<cfset message = ''>
<cfif IsDefined('url.add')>
<cfset message = 'Photo added successfully'>
</cfif>
<cfif IsDefined('url.edit')>
<cfset message = 'Photo edited successfully'>
</cfif>
<cfif IsDefined('url.del')>
<cfset message = 'Photo deleted successfully'>
</cfif>
<!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
<!---PLUS--->
<cfif IsDefined('FORM.plus')>
<cfset Zplus = #FORM.order# - 1>
<cfset Zminus = #FORM.order#>

<cfquery name="GetPlus" maxrows="1">
  SELECT PhotoID, DOrder, GalleryID FROM Photos
  Where PhotoID = #FORM.plus#
</cfquery>
<cfquery name="GetMinus" maxrows="1">
  SELECT PhotoID, DOrder, GalleryID FROM Photos
  Where DOrder < #GetPlus.DOrder#
  AND GalleryID = #GetPlus.GalleryID#
  Order by DOrder Desc
</cfquery>    
  
<cfquery name="UP1">
    UPDATE Photos SET DOrder = #FORM.order# WHERE PhotoID=#GetMinus.PhotoID#
  </cfquery>
  <cfquery name="UP2">
    UPDATE Photos SET DOrder = #Zplus# WHERE PhotoID=#GetPlus.PhotoID#
  </cfquery>
</cfif>  

<!---MINUS--->
<cfif IsDefined('FORM.minus')>
<cfset Zplus = #FORM.order# + 1>
<cfset Zminus = #FORM.order#>

<cfquery name="GetPlus" maxrows="1">
  SELECT PhotoID, DOrder, GalleryID FROM Photos
  Where PhotoID = #FORM.minus#
</cfquery>
<cfquery name="GetMinus" maxrows="1">
  SELECT PhotoID, DOrder, GalleryID FROM Photos
  Where DOrder > #GetPlus.DOrder#
  AND GalleryID = #GetPlus.GalleryID#
  Order by DOrder Asc
</cfquery>    
  
<cfquery name="DeleteNews">
    UPDATE Photos SET DOrder = #FORM.order# WHERE PhotoID=#GetMinus.PhotoID#
  </cfquery>
  <cfquery name="DeleteNews">
    UPDATE Photos SET DOrder = #Zplus# WHERE PhotoID=#GetPlus.PhotoID#
  </cfquery>
  <cfoutput>#Zplus#   - #Zminus#     pid = #GetMinus.PhotoID#</cfoutput>
</cfif> 

<!---DELETE--->
<cfif IsDefined('FORM.del')>
  <cfquery name="DeleteNews">
    DELETE FROM Photos WHERE PhotoID=#FORM.del#
  </cfquery>
  <cflocation url="photos.cfm?ID=#FORM.GalleryID#&del=yes">
</cfif>


<cfset edit_header="">
<cfset edit_photo="">
<cfset edit_order="">
<cfset edit_field_name="home_body_text">
<!---EDIT--->
<cfif IsDefined('FORM.edit')>
  <cfquery name="EditNews">
     SELECT * FROM Photos WHERE PhotoID=#FORM.edit#
  </cfquery>
  
   <cfquery name="ShowProducts2">
SELECT *
FROM Galleries
Where GalleryID=#EditNews.GalleryID#
Order by GalleryID
</cfquery>
 <cfquery name="ShowProducts3">
SELECT *
FROM Galleries
Where GalleryID<>#EditNews.GalleryID#
Order by GalleryID
</cfquery>
 
  <cfset edit_header = #EditNews.PName#>
    <cfset edit_photo = #EditNews.Photo#>
       <cfset edit_order = #EditNews.DOrder#>
  <cfset edit_field_name = "edit_body_text">
</cfif>
<!---EDIT SAVE--->
<cfif IsDefined('FORM.save_edit')>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfimage action="info" source="#imagepath#/#FileName#" structname="PDetails">
<cfif PDetails.width GT 800>
<cfimage action="resize" source="#imagepath#/#FileName#" width="800" height="" destination="#imagepath#/#FileName#" overwrite="true">
<cfelseif PDetails.height gt 600>
<cfimage action="resize" source="#imagepath#/#FileName#" height="600" width="" destination="#imagepath#/#FileName#" overwrite="true">
</cfif>
<cfimage action="resize" source="#imagepath#/#FileName#" width="200" height="" destination="#imagepath#/th-#FileName#" overwrite="true">

 <cfquery name="SaveEdit">
   UPDATE Photos SET PName = '#FORM.PName#', GalleryID = '#FORM.GalleryID#', DOrder = '#FORM.DOrder#', Photo = '#FileName#', Thumb = 'th-#FileName#' WHERE PhotoID=#FORM.save_edit#
 </cfquery>
<cfelse>
 <cfquery name="SaveEdit">
   UPDATE Photos SET PName = '#FORM.PName#', DOrder = '#FORM.DOrder#', GalleryID = '#FORM.GalleryID#'
   WHERE PhotoID=#FORM.save_edit#
 </cfquery>
</cfif>
<cflocation url="photos.cfm?ID=#FORM.GalleryID#&edit=yes">
</cfif>
<!---ADD--->
<cfif IsDefined('FORM.save_add')>
<cfquery name="NCount">
  SELECT PhotoID FROM Photos
  Where GalleryID = <cfqueryparam value="#FORM.GalleryID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfset porder = NCount.RecordCount + 1>
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfimage action="info" source="#imagepath#/#FileName#" structname="PDetails">
<cfif PDetails.width GT 800>
<cfimage action="resize" source="#imagepath#/#FileName#" width="800" height="" destination="#imagepath#/#FileName#" overwrite="true" name="PDetails">
<cfelseif PDetails.height gt 600>
<cfimage action="resize" source="#imagepath#/#FileName#" height="600" width="" destination="#imagepath#/#FileName#" overwrite="true" name="PDetails">
</cfif>
<cfimage action="resize" source="#imagepath#/#FileName#" width="200" height="" destination="#imagepath#/th-#FileName#" overwrite="true">

<cfset DTS = #CreateODBCDateTime(now())#>
    <cfquery name="InsertNews">
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
	    '#FORM.PName#',
		'#FORM.GalleryID#',
		'#FileName#',
		'th-#FileName#',
        '#porder#',
        '#PDetails.width#',
        '#PDetails.height#',
        <cfqueryparam value="#DTS#" cfsqltype="cf_sql_timestamp">
	  )
	</cfquery> 
</cfif>
<cflocation url="photos.cfm?ID=#FORM.GalleryID#&add=yes">
</cfif>

<cfquery name="ShowNews">
  SELECT * FROM Photos
  Where GalleryID = '#URL.ID#'
  Order by DOrder
</cfquery>
 <cfquery name="ShowProducts">
SELECT *
FROM Galleries
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
    
	<div class="container">
    <h1>Taylor Martino Gallery Photos</h1>
    <cfoutput>#message#</cfoutput>
    <!---EDIT--->
    <FORM action="#CGI.SCRIPT_NAME#?ID=#GalleryID#" method="post" name="mainform2" enctype="multipart/form-data">
	        <input type="hidden" name="checker">
        <input type="hidden" name="thumbsize" value="150">
        <input type="hidden" name="maxsize" value="640">
        <input type="hidden" name="prefix" value="sm">
	 <table width="99%" cellspacing="0" border="0" cellpadding="5" align="center" class="yhmpabd">
       <tr>
          <td colspan="2" bgcolor="#3B82D2">
          <b><cfif IsDefined('FORM.edit')>EDIT Gallery Photo<cfelse>ADD Gallery Photos</cfif></b></td>
       </tr>
       <tr>
		  <td valign="top"><b>GALLERY: </b>	* Must Be defined when Editing/Adding</td>
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
                <cfoutput query="ShowProducts"><option value="#GalleryID#"<cfif URL.ID is #GalleryID#> selected</cfif>>#GName#</option></cfoutput>
                </select>
				</cfif>
                </td>
	         </tr>
		<tr>
		  <td valign="top"><b>Photo Title:</b><input type="text" name="PName" maxlength="100" size="40" value="<cfoutput>#edit_header#</cfoutput>">
	      <b> </b>* optional</td>
	      <td rowspan="4" valign="top"><cfif IsDefined('FORM.edit')>Current Photo:<br />
		  <!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
          <cfoutput query="EditNews"><img src="../images/#Thumb#" width="200" /></cfoutput>
		  <!--- MUST CHANGE BEFORE SITE GOES LIVE //--->
		  </cfif></td>
		</tr>
		<tr>
		  <td valign="top">
          <b>Photo File: </b>
          <input type="file" name="Photo" size="40" value="<cfoutput>#edit_photo#</cfoutput>">
          </td>
        </tr>
<cfif IsDefined('FORM.edit')>
		<tr>
		  	<td valign="top">
		    <b>Photo Display Order: </b>
            </td>
        </tr>
		<tr>
			<td colspan="2">
			<input type="text" name="DOrder" maxlength="4" size="4" value="<cfoutput>#edit_order#</cfoutput>">
            </td>
		</tr>
</cfif>
		<tr>
		  <td align="left" height="40">  
		 <cfif IsDefined('FORM.edit')>
         <input type="submit" value="Edit Gallery Photo">
		 <input type="hidden" name="save_edit" value="<cfoutput>#FORM.edit#</cfoutput>">
		 <cfelse>
         <input type="Submit" name="save_add" value="Add Gallery Photo">
		 </cfif>
         </td>
	</tr> 
</table>
</FORM>
<table width="900" border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td width="300" bgcolor="#3B82D2">&nbsp;<b>Edit Gallery Photos</b> (<cfoutput>#ShowNews.RecordCount#</cfoutput> total)</td>
    <td width="600" bgcolor="#3B82D2"><form name="form" id="form">
              <p>Select Gallery: <select name="jumpMenu" id="jumpMenu" onChange="MM_jumpMenu('parent',this,0)">
              <option value="#">Select Gallery</option>
                <cfoutput query="ShowProducts"><option value="#CGI.SCRIPT_NAME#?ID=#GalleryID#"<cfif URL.ID is #GalleryID#> selected</cfif>>#GName#</option></cfoutput>
              </select></p>
            </form></td>
  </tr>
</table>
         
<!--- Create your table here --->
<table align="center" width="750" border="0" cellspacing="0" cellpadding="2">
    <tr>
        <Td><cfif #ShowNews.RecordCount# eq 0>
		    There are no Gallery Photos on file</cfif></TD>
    </tr>
    <!--- Loop Through Your Data --->
     <cfloop query="ShowNews" startrow="1" endrow="#ShowNews.RecordCount#">
		 <cfquery name="ShowProducts2">
SELECT *
FROM Galleries
where GalleryID = '#ShowNews.GalleryID#'
</cfquery>

        <!--- This basically gets 6 records, displays it and then creates a new row. You can substitue any number for the 6 --->
        <!--- It loops through until record count divided by record count equals one --->
        <cfif ShowNews.currentrow mod 6 EQ 1>
            <tr class="PRow">
        </cfif>
        <!--- and then display the data here --->
		<cfoutput>
            <td valign="top" class="#iif(currentrow MOD 2,DE('a3'),DE('a4'))#"><div align="center" class="pgallery">#DOrder#.
            	<table width="75" border="0" cellspacing="1" cellpadding="1">    
  					<tr>
    					<td colspan="3" height="120" align="center"><img src="../images/#Thumb#" width="90" alt="#ShowNews.PName#" title="#ShowNews.PName#" /></td>
  					</tr>
                    <tr>
    					<td><div align="left" class="pgallery">Order</div></td>
    					<td>
						<cfif DOrder LTE 1><cfelse>
                    	<form method="post" action="#CGI.SCRIPT_NAME#?ID=#GalleryID#">
					 	<input type="image" src="/admin/images/arrow_left.png"  value=" + " class="pgallery">
					  	<input type="hidden" name="plus" value="#PhotoID#">
                      	<input type="hidden" name="order" value="#DOrder#">
						</form>
                    	</cfif>
                        </td>
				      <td>  
					  <cfif CurrentRow is #RecordCount#><cfelse><form method="post" action="#CGI.SCRIPT_NAME#?ID=#GalleryID#">
					  <input type="image" src="/admin/images/arrow_right.png" value=" - " class="pgallery">
					  <input type="hidden" name="minus" value="#PhotoID#">
                      <input type="hidden" name="order" value="#DOrder#">
					  </form>
					  </cfif>
                      </td>
                 </tr>
			</table>
		</div>
			<table align="center" width="80%">
    			<tr>
      			<td width="50%" align="left">      
                <form method="post" action="#CGI.SCRIPT_NAME#?ID=#GalleryID#" class="footer">
				<input type="image" src="/admin/images/picture_delete.png" value="Delete" onClick="javascript:return confirm('Are you sure you want to delete this photo?')" class="pgallery">
				<input type="hidden" name="del" value="#PhotoID#">
                <input type="hidden" name="GalleryID" value="#GalleryID#">
				</form>
                </td>
                <td width="50%" align="right">
                <form method="post" action="#CGI.SCRIPT_NAME#?ID=#GalleryID#">
				<input type="image" src="/admin/images/picture_edit.png" value="Edit" class="pgallery">
				<input type="hidden" name="edit" value="#PhotoID#">
				</form>
                </td>
                </tr>
            </table>
	</cfoutput>
    </td>
</cfloop>
</tr>
</table>
    <!---END EDIT--->
    </div>
</body>
</html>