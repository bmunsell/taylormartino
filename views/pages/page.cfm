<cfoutput>
	<cfif len(prc.currentpage.PageImage) and prc.currentpage.showImage>
		<ul class="gallery">
			<li><a href="/inc/images/#prc.currentpage.PageImage#" rel="prettyPhoto" title="#prc.currentpage.PageTitle#"><img src="/inc/images/th-#prc.currentpage.PageImage#" class="shadow" alt="#prc.currentpage.PageTitle# test" title="#prc.currentpage.PageTitle# 2" /></a></li>	
		</ul>			
	</cfif>
	#prc.currentpage.PageText#
	<cfif isDefined('prc.subs') AND prc.subs.recordcount GT 0>		
		<h2 align="center">More #prc.currentpage.PageLink#</h2>
		<ul class="sublist">
			<cfloop query="prc.subs">
				<li>
					<a href="/#prc.subs.PageDir#/#prc.subs.PageName#" title="#prc.subs.PageName#">
					<cfif prc.subs.PageImage is not ''>
						<img src="/inc/images/th-#prc.subs.PageImage#" title="#prc.subs.PageName#" alt="#prc.subs.PageName#"">
					<cfelse>
						<img src="/#getSetting('defaultImage')#" title="#prc.subs.PageName#" alt="#prc.subs.PageName#">
					</cfif>
						<h3>#prc.subs.PageLink#</h3>
						<p>#prc.subs.PageDescription#</p>
					</a>
				</li>
			</cfloop>
		</ul>
	</cfif>
	<cfif prc.currentRoutedURL contains 'evaluation'>
		<div style="float: left; width: 60%;">
		#html.startForm(action='contact.send',name="contactForm",id="eval-full")#
			#html.textfield(name="name",label="Name: ",size="50",required="required",class="textfield")#<br>
			#html.textfield(name="SSSphone",id="phone",label="Phone:",size="50",class="textfield")#
			#html.textfield(name="SSSemail",id="email",label="Email: ",size="50",required="required",class="textfield")#<br>
			<select name="contactPref">
				<option>Contact Preference</option>
				<option value="Email">E-mail</option>
				<option value="Phone">Phone</option>
			</select>
			<select name="reference">
				<option>How did you hear about us?</option>
				<option value="Internet Search">Seach (Google,Bing)</option>
				<option value="Referral">Referral</option>
				<option value="Phone Book">Phone Book</option>
				<option value="TV/Radio">TV/Radio</option>
				<option value="Publications">Publications</option>
			</select>
			#html.textarea(name="comments",label="Tell us about your case: ",cols="36",rows="8",required="required",class="tArea")#
			<cfimage action="captcha" height="60" text="#prc.captcha#" style="margin-left: -7px;margin-top: 5px;margin-bottom: 3px;">
			#html.hiddenField(name="captchaHash",value=prc.captchaHash)#
			#html.textfield(name="captcha",label="Enter Text Above: ",size="50",required="required",class="textfield")#<br>
			#html.submitButton(value="  Send E-mail  ",class="emailButton")#
		</div>
		<cfif prc.currentLayout does not contain 'mobile'>
		<div style="float: left; width: 35%;padding: 0 2% 0 2%">
			<h3 align="center">Call us Toll Free:<br>1-800-256-7728</h3>
			<p align="center"><strong><em>Taylor Martino<br>Personal Injury Lawyers</em></strong></p>
			<p align="center">51 St. Joseph Street<br>
				P.O. Box 894<br>
				Mobile, Alabama 36601<br>
				Tel: 251-433-3131<br>
				Fax: 251-433-4207</p>
		</div>
		</cfif>
		<br clear="all">
	</cfif>
	
</cfoutput>
