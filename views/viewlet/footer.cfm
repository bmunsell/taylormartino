<!---<div id="centered"><img src="/includes/images/footer-logo2b.png"></div>--->
<cfoutput>
<div class="footNav">
	<cfset prc.lcount = 1>
	<cfloop query="prc.cats">
	 <a href="#prc.settings.theUrl#/#prc.cats.PageDir#">#prc.cats.PageLink#</a>
	 <cfif prc.lcount LT prc.cats.recordcount> | </cfif>
	<cfset prc.lcount ++></cfloop>
	 | <a href="/legal-disclaimer">Legal Disclaimer</a>
</div>
</cfoutput>
<table width="94%" align="center" style="margin-top:15px;">
	<tr>
		<td valign="center" align="center" width="110">
			<img src="/includes/images/Taylor-Martino-Mobile-Alabama.png" height="75" align="left" style="margin-right:15px;" />
		</td>
		<td valign="center" align="left" width="170">
			<p style="margin-top:5px;">51 St. Joseph Street<br>
			Mobile, Alabama 36602<br>
			Tel: 251-433-3131<br>
			Fax: 251-433-4207</p>
		</td>
		<td valign="center" align="center">
			<img src="/includes/images/footer-logo2b.png">
		</td>
		<td valign="center" align="center">
			<a href="http://www.lawyers.com/mobile/alabama/Taylor-Martino-P-C--31666-f.html" target="_blank">
				<img src="/includes/images/Taylor_Martino_rating.png" title="Personal Injury Lawyer Rating" alt="Taylor Martino: Personal Injury Lawyers" width="220">
			</a>
		</td>
		<td valign="center" align="right">
			<a href="http://360webpath.com" target="_blank">
				<img src="/includes/images/gulf-shores-website-design.png" alt="Gulf Shores Website Design">
			</a>
		</td>
	</tr>
</table>
<!---<div id="address">
	
</div>
<div id="footerLogos">
	<div id="centered">
		
		</div>
</div>
<div id="webpath"></div>--->