<h1>Website Main Pages</h1>
<!---<table border="0" cellspacing="5" width="900">
	<tr>
    <td width="263" align="left"><a href="/admin/subpage-list.cfm"><img src="/admin/images/page.png" alt="MAIN PAGEs" width="16" height="16" /></a><a href="/admin/subpage-list.cfm"> Sub Pages</a>
    </td>
    <!---<td width="264" align="center"><a href="/admin/subpage-add.cfm"><img src="/admin/images/page_add.png" alt="ADD PAGE" width="16" height="16" /></a><a href="/admin/page-add.cfm"> ADD NEW PAGE</a></td>
    <td width="349" align="right"><a href="/admin/subpage-add.cfm"><img src="/admin/images/page_add.png" alt="ADD PAGE" width="16" height="16"></a><a href="/admin/subpage-add.cfm"> ADD NEW SUB-PAGE</a></td>
	---></tr>
	</table>--->
    <!---START SORT--->
<!---<cfset lstSortItems = "" />
		<cfif structKeyExists(form,"fieldNames")>
			<!--- Form was submitted, so show put together list of items in their specified order --->
			<cfloop list="#form.fieldNames#" index="strIndex">
				<cfif left(strIndex,9) is "SortItem_">
                    <cfset lstSortItems = listAppend(lstSortItems,form[strIndex]) />
				</cfif>             
			</cfloop>
        	<cfset mycount = 1 />
          <cfloop list="#lstSortItems#" index="i" delimiters="," >
            	<cfquery name="update" datasource="#getSetting('datasource')#">   
					UPDATE Pages
					SET Dorder = <cfqueryparam value="#mycount#" cfsqltype="cf_sql_integer">
                	WHERE PageID = <cfqueryparam value="#i#" cfsqltype="cf_sql_integer">
            	</cfquery>  
        <cfset mycount++ />
            </cfloop>
            <cfset msg = 'Order Saved'>
            <cfquery name="GetPages" datasource="#getSetting('datasource')#">
  				SELECT * FROM Pages
  				Order by DOrder
			</cfquery>
  <cfelse>
			<!--- Default list of items we'll be working with --->
            <cfset lstSortItems = "" />
            
        <cfquery name="GetPages" datasource="#getSetting('datasource')#">
  				SELECT * FROM Pages
  				Order by DOrder
			</cfquery>
			<cfoutput query="GetPages">
            	<cfset lstSortItems = listAppend(lstSortItems,GetPages.PageID) />
            </cfoutput>
</cfif>--->
		
		<!--- Basic form, submitting to itself --->
		<cfform action="/cms/page/list" method="post">
		<cfoutput>
				<!--- This UL will contain the items we want to sort --->
				<ul id="SortItems" class="sortable">
					<!--- Counter to ensure each hidden field has a unique name --->
					<cfset intCounter = 0 />
					<!--- Loop over list of items to sort -- in real life this is probably a query --->
					<cfloop query="prc.GetPages">
                    <cfquery name="GetSubPages" datasource="#getSetting('datasource')#">
						Select SubPageID,PageLink,PageTitle,PageLast,DOrder
						From SubPages
        				Where PageID = #prc.GetPages.PageID#
						Order BY SubPageID
					</cfquery>
                    <cfset intCounter++ />
<li style="cursor: move;">
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
  		<tr>
    		<td width="42%"><h3>#Left(prc.GetPages.PageLink, 70)#</h3>
            Last Update: #DateFormat(prc.GetPages.PageLast, 'medium')#  
      </td>
	  		<td width="10%"><cfif prc.GetPages.isActive eq 1>Active<cfelse>Inactive</cfif></td>
    		<td width="16%" align="center">
    		<cfif GetSubPages.RecordCount GT 0>
    		<a href="cms/subpage/list/?pid=#prc.GetPages.PageID#" title="Edit #prc.GetPages.PageName# Subpages">
    		<img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #prc.GetPages.PageName# Subpages"><br /> 
    		SubPages (#GetSubPages.RecordCount#)
    		</a>
        	</cfif>
    		</td>
    		<td width="16%" align="center">
    		<a href="/cms/page/edit/?pid=#prc.GetPages.PageID#" title="Edit #prc.GetPages.PageName#">
    		<img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #prc.GetPages.PageName#"><br />
    		EDIT PAGE
    		</a>
		  </td>
    		<td width="16%" align="right">
    		<!---<a href="#CGI.SCRIPT_NAME#?pid=#prc.GetPages.PageID#&del=yes" title="Delete #prc.GetPages.PageLink#" onClick="javascript:return confirm('This will also delete any subpages for this page. 		Are you sure you want to delete this Page?')">
    <img src="/admin/images/page_delete.png" width="16" height="16" border="0" alt="Delete #prc.GetPages.PageLink#"><br />
    DELETE </a>--->
   	 		</td>
		</tr>
	</table>
	<cfinput type="hidden" name="SortItem_#intCounter#" value="#PageID#" />
</li>
	</cfloop>
</ul>
</cfoutput>
<br clear="all" />
<table width="100%">
	<tr>
    	<td align="center">	<input type="submit" value="Save Page Order" class="subform" /></td>
    </tr>
</table>
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
<!---END SORT--->