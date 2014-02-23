Add a new page
<cfform method="post" name="form1" action="/cms/page/add/" enctype="multipart/form-data">
	<table width="940" cellspacing="5" align="left">
		<input type="hidden" name="MM_InsertRecord" value="form1">
		<tr>
			<td class="formtext">
				<h1>Menu/Page Name:</h1>
            	<p>This is the name of the page that will appear in the main menu. Limit *50 characters<br></p>
            	<cfinput type="text" name="PageLink" value="" size="50" maxlength="50" required="yes" message="Please enter a Page Name">
           </td>
		</tr>
		<tr>
            <td colspan="2" class="formtext">
            	<h1>Page Title:</h1>
				<p>This text will appear at the top of the browser and is very important for search engines. It should contain a brief description of what the page is about.
				* Limit 70 characters</p>
				<span class="forminput">
					<cfinput type="text" name="PageTitle" value="" size="70" maxlength="70" required="yes" message="Please enter a Page Title">
				</span>
			</td>
		</tr>
		<tr>
            <td colspan="2" class="formtext">
            	<h1>Page Description/Abstract:</h1>
				<p>Please write a brief description of the page. This text will appear in Search Engine Descriptions and as the abstract/description text on this site.<br>
				* Limit 300 characters. * Hint: Usually the first couple sentences of page. Text should describe what the page is about.</p>
				<span class="forminput">
					<textarea name="PageDescription" cols="50" rows="5" maxlength="250"></textarea>
				</span>
			</td>
		</tr>
		<tr>
			<td class="formtext">
				<h1>Page Type:</h1>
            	<p>This will determine the layout of the new page.</p>
            	<cfselect name="PageType" query="prc.getTypes" value="PageType" display="PageType"></cfselect>
            </td>
		</tr>
		<tr>
			<td colspan="2" class="formtext"><h1>Page Image:</h1>
				<p>This image is important but not required. It is used by Social Media for sharing as well as on this site.<br>
				If you do not upload an image, the site logo will be used by default</p>
				<cfinput type="file" name="Photo" id="Photo" size="30">
			</td>
		</tr>
		<tr>
           <td colspan="3">
             <input type="submit" value="Save & Continue" class="subform">
           </td>
        </tr>
	</table>
</cfform>
<!---<cfform method="post" name="form1" action="/cms/page/add/" enctype="multipart/form-data">
        <table width="940" cellspacing="5" align="left">
         <tr>
            <td width="760" colspan="2" rowspan="2" class="formtext">
           	<h1>Menu/Page Name:</h1>
            <p>This is the name of the page that will appear in the main menu. Limit *50 characters<br>
            </p>
            <cfinput type="text" name="PageLink" value="" size="50" maxlength="50" required="yes" message="Please enter a Page Name">
           </td>
            <td width="180">
              <input type="submit" value="Save Page" class="subform">
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <!---<tr>
            <td width="377" class="formtext">
            	<h1>Teams:</h1>
            	<p>Choose the teams this post is relevant to.</p>
				<p><cfoutput query="GetTeams">
                <cfinput type="checkbox" name="TeamID" value="#TeamID#">#Team#
				</cfoutput></p>
            </td>
              <td width="378" class="formtext"><h1> Categories:</h1>
              <p>Choose the categories this page is related to. </p>
              <p><cfoutput query="GetCat">
                <cfinput type="checkbox" name="CategoryID" value="#CategoryID#">
              #Category# </cfoutput></p></td>
            <td>&nbsp;</td>
          </tr>--->
          <tr>
            <td colspan="2" class="formtext"><h1>Page Title:</h1>
              <p>This text will appear at the top of the browser and is very important for search engines. It should contain a brief description of what the page is about.
              Limit * 70 characters</p>
              <span class="forminput">
              <cfinput type="text" name="PageTitle" value="" size="70" maxlength="70" required="yes" message="Please enter a Page Title">
            </span></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h1>Page Text:</h1><textarea cols="100" id="editor_office2003" name="editor_office2003" rows="10"></textarea>
			<script type="text/javascript">
			//<![CDATA[

				CKEDITOR.replace( 'editor_office2003',
					{
						skin : 'office2003',
						contentsCss: '/includes/styles/tm.css',
						width: '700',
						height: '350'
					});

			//]]>
			</script></td>
            <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="formtext"><h2>* Optional Items</h2>
             <p>These Items are not needed for page creation but are helpful with search engine placement and social media sharing.</p>
           <p></p></td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="formtext">Image:<br>
           <cfinput type="file" name="Photo" size="30"></td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="formtext">Keywords: <br>
           <cfinput type="text" name="PageKeywords" value="" size="40" maxlength="70"></td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="2" class="formtext">Description:<br>
           <textarea name="PageDescription" cols="50" rows="5" maxlength="250"></textarea>
           </td>
           <td>&nbsp;</td>
          </tr>
         <tr>
           <td colspan="3">
             <input type="submit" value="Save Page" class="subform">
           </td>
          </tr>
         <tr>
           <td colspan="3">&nbsp;</td>
          </tr>
         <tr>
           <td colspan="3">&nbsp;</td>
          </tr>
        </table>
        
        <p>
          <input type="hidden" name="MM_InsertRecord" value="form1">
      </p>
  </cfform>--->