<cfparam name="url.id" default="1">
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
</head>
<body>
	<cfinclude template="header.cfm">
<div class="container">
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
			<input type="submit" value="Save Page Order" />
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
