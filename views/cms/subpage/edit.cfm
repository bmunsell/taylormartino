<h1>Edit Page: <cfoutput>#prc.GetPage.PageLink#</cfoutput></h1> 
      <cfform method="post" name="form1" action="/cms/page/edit/" enctype="multipart/form-data">
	  	  
        <table width="940" cellspacing="5" align="left">
         <tr>
            <td colspan="2" class="formtext"><h1>Menu Name:</h1>
              <cfoutput>#prc.GetPage.PageLink#</cfoutput>
            </td>
            <td class="forminput"><input type="submit" value="Save Page" class="subform"></td>
          </tr>
         <tr><td></td><td></td>
           <!---<td width="380" class="formtext">
            	<h1>Teams:</h1>
            	<p>Choose the teams this page is relevant to.</p>
				<p><cfoutput query="GetTeams">
                <cfif ListFind(prc.GetPage.TeamID, #TeamID#)>
                <cfinput type="checkbox" 
                	name="TeamID" 
                	value="#GetTeams.TeamID#" 
                	checked="yes">
                <cfelse>
                <cfinput type="checkbox" name="TeamID" value="#GetTeams.TeamID#">
                </cfif> 	
                #GetTeams.Team#
                </cfoutput>
                </p>
            </td>
            <td width="377" class="formtext">
            	<h1>Page Categories:</h1>
            	<p>Choose the categories this page is related to. </p>
				<p><cfoutput query="GetCat">
                <cfif ListFind(prc.GetPage.CategoryID, #CategoryID#)>
                <cfinput type="checkbox" 
                	name="CategoryID" 
                	value="#GetCat.CategoryID#" 
                	checked="yes">
                <cfelse>
                <cfinput type="checkbox" name="CategoryID" value="#GetCat.CategoryID#">
                </cfif> 	
                #GetCat.Category#
                </cfoutput></p>
            </td>  --->    
           <td width="180" rowspan="9" class="formtext">
            <!---<cfoutput><h1>Page Details:</h1>
              <p>Created: <br>
              #DateFormat(prc.GetPage.PageDate, 'medium')# #TimeFormat(prc.GetPage.PageDate, 'medium')#
                <br>
                By: #GetCUser.FName# #GetCUser.LName#<br>
              </p>
                <p>&nbsp;</p>
                <p>Last Update:<br>
                #DateFormat(prc.GetPage.PageLast, 'medium')#  #TimeFormat(prc.GetPage.PageDate, 'medium')#<br>
            By: #GetLUser.FName# #GetLUser.LName#</p>
            
            <p>&nbsp;</p>
            <p>Page Image:<br>
            <cfif prc.GetPage.PageImage is not ''>
			<img src="/inc/images/#prc.GetPage.PageImage#" width="100">
            <cfelse>
            NO Image
            </cfif></p></cfoutput>
             <p>&nbsp;</p>
             <p>Previous Versions:<br>
             <cfoutput query="GetArchives">
             <a href="/admin/restore.cfm?pid=#ArchiveID#">#DateFormat(PageLast, 'medium')# #TimeFormat(PageLast, 'medium')#</a><br><br>
             </cfoutput>
             </p>---></td>
         </tr>
         <tr>
           <td colspan="2" class="formtext">
           	<h1>Active:</h1>
           	<p>use this instead of deleting a page, it will not show in links but can still be accessed directly for testing.</p>
            <p>
              <label>
                <input type="radio" name="isActive" value="1" id="isActive_0"<cfif prc.GetPage.isActive eq 1> checked</cfif>>
                Yes</label>
              <br>
              <label>
                <input type="radio" name="isActive" value="0" id="isActive_1"<cfif prc.GetPage.isActive eq 0> checked</cfif>>
                No</label>
              <br>
           </p></td>
         </tr>
         <tr>
            <td width="760" colspan="2" class="formtext">
            	<h1>Page Title:</h1>
            	<p>This text will appear at the top of the browser and is very important for search engines.<br>Limit * 70 characters<span class="forminput">
            	  <cfinput type="text" name="PageTitle" value="#prc.GetPage.PageTitle#" maxlength="70" size="70" required="yes" message="Please enter a Page Title">
            	</span></p>
            </td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Text:<span class="forminput">
              <textarea id="PageText" name="PageText"><cfoutput>#Trim(prc.GetPage.PageText)#</cfoutput>
              </textarea>
              <script type="text/javascript">
			//<![CDATA[
				CKEDITOR.replace( 'PageText',{
					skin : 'office2003',
					contentsCss: '/includes/styles/tm.css',
					width: '700',
					height: '350'
					});
			//]]>
			</script> 
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2"><hr></td>
          </tr>
          <tr>
           <td colspan="2" class="formtext"><h2>* Optional Items</h2>
             <p>These Items are not needed for page creation but are helpful with search engine placement and social media sharing.</p>
           <p></p></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Keywords:<span class="forminput">
              <cfinput type="text" name="PageKeywords" value="#prc.GetPage.PageKeywords#" size="70" maxlength="70">
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Description:<span class="forminput">
             <cfoutput><textarea name="PageDescription" cols="50" rows="5" maxlength="250">#trim(prc.GetPage.PageDescription)#</textarea></cfoutput>
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>PageImage:<span class="forminput">
              <cfinput type="file" name="Photo" size="30">
            </span></h1></td>
          </tr>
          <tr>
            <td colspan="2"><span class="forminput">
              <input type="submit" value="Save Page" class="subform">
            </span></td>
            <td class="forminput">&nbsp;</td>
          </tr>
        </table>
        <cfinput type="hidden" name="pid" value="#prc.GetPage.PageID#">
		<cfinput type="hidden" name="UserID" value="#prc.GetPage.UserID#">
		<cfinput type="hidden" name="save_edit" value="#prc.GetPage.PageID#">
		<cfinput type="hidden" name="PageImage" value="#prc.GetPage.PageImage#">
		<cfinput type="hidden" name="PageVideo" value="#prc.GetPage.PageVideo#">
		<cfinput type="hidden" name="PageDate" value="#prc.GetPage.PageDate#">
        <input type="hidden" name="MM_InsertRecord" value="form1">
      </cfform>
      <p>&nbsp;</p>