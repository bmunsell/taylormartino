<cfquery name="GetPages">
SELECT *
FROM Pages
ORDER BY DOrder ASC 
</cfquery>
<table id="table1">
 <thead>
  <tr>
   <th>PAGE NAME</th>
   <th>DATE</th>
   <th>EDIT</th>
   <th>DELETE</th>
  </tr>
 </thead>
 <tbody>
<cfoutput query="GetPages">
  <tr>
   <td><h3>#GetPages.PageLink#</h3></td>
   <td>#DateFormat(GetPages.PageLast, 'mm/dd/yyyy')#</td>
   <td><a href="page-edit.cfm?pid=#GetPages.PageID#" title="Edit #GetPages.PageLink#">
    <img src="/admin/images/page_edit.png" width="16" height="16" border="0" alt="Edit #GetPages.PageLink#"> EDIT
    </a></td>
   <td><a href="#CGI.SCRIPT_NAME#?pid=#GetPages.PageID#&del=yes" title="Delete #GetPages.PageLink#" onClick="javascript:return confirm('Are you sure you want to delete this Page?')">
    <img src="/admin/images/page_delete.png" width="16" height="16" border="0" alt="Delete #GetPages.PageLink#"> DELETE
    </a></td>
  </tr>
</cfoutput>
 </tbody>
</table>
