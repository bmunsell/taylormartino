<cfparam name="url.id" default="1">
<!---inject--->
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
<!---inject--->

<cfset msg = 'Drag & Drop to change photo display order'>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Taylor Martino Website Admin</title>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.21/jquery-ui.min.js" type="text/javascript"></script>
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
<!---INJECT--->
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
<!---INJECT--->
<cfset lstSortItems = "" />
		<cfif structKeyExists(form,"fieldNames")>
			<!--- Form was submitted, so show put together list of items in their specified order --->
			<cfloop list="#form.fieldNames#" index="strIndex">
				<cfif left(strIndex,9) is "SortItem_">
                    <cfset lstSortItems = listAppend(lstSortItems,form[strIndex]) />
				</cfif>             
			</cfloop>
        	<cfset mycount = 1 />
          <cfloop list="#lstSortItems#" index="i" delimiters="," >
            	<cfquery name="update">   
					UPDATE Photos
					SET Dorder = <cfqueryparam value="#mycount#" cfsqltype="cf_sql_integer">
                	WHERE PhotoID = <cfqueryparam value="#i#" cfsqltype="cf_sql_integer">
            	</cfquery>  
        <cfset mycount++ />
            </cfloop>
            <cfset msg = 'Order Saved'>
            <cfquery name="GetPhotos">
  				SELECT * FROM Photos
  				Where GalleryID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
  				Order by DOrder
			</cfquery>
  <cfelse>
			<!--- Default list of items we'll be working with --->
            <cfset lstSortItems = "" />
            
        <cfquery name="GetPhotos">
  				SELECT * FROM Photos
  				Where GalleryID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
  				Order by DOrder
			</cfquery>
			<cfoutput query="GetPhotos">
            	<cfset lstSortItems = listAppend(lstSortItems,GetPhotos.PhotoID) />
            </cfoutput>
</cfif>
		<h1><cfoutput>#msg#</cfoutput></h1>
		<!--- Basic form, submitting to itself --->
		<cfform action="#CGI.SCRIPT_NAME#" method="post">
		<cfoutput>
				<!--- This UL will contain the items we want to sort --->
				<ul id="SortItems" class="sortablephotos">
					<!--- Counter to ensure each hidden field has a unique name --->
					<cfset intCounter = 0 />
					<!--- Loop over list of items to sort -- in real life this is probably a query --->
					<cfloop query="GetPhotos">
                    <cfoutput>
						<cfset intCounter++ />
<li style="cursor: move;"><img src="/images/#GetPhotos.Thumb#"  /><h3>#Left(GetPhotos.PName, 30)#</h3>
	<table width="95%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    
    <td><a href="page-edit.cfm?pid=#GetPhotos.PhotoID#" title="Edit #GetPhotos.PName#">
    <img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #GetPhotos.PName#"> EDIT
    </a></td>
    <td>
    <a href="page-edit.cfm?pid=#GetPhotos.PhotoID#" title="Edit #GetPhotos.PName#">
    <img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #GetPhotos.PName#"> EDIT
    </a>
    </td>
  </tr>
</table>

                            <cfinput type="hidden" name="SortItem_#intCounter#" value="#PhotoID#" /></li>
					</cfoutput>
                    </cfloop>
		</ul>
                <br clear="all" />
		</cfoutput>
			<input type="submit" value="Save Photo Order" />
</cfform>
 </div>

<!--- This JS enables jQuery UI sorting (see included JS above, they're required) --->
<script type="text/javascript">
	$(function() {
		$("#SortItems").sortable({
			revert: true
		});
	});
</script>

</body>
</html>
