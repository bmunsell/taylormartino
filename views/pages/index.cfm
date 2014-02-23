<cfoutput>
	<cfif len(prc.currentpage.PageImage) and prc.currentpage.showImage>
		<ul class="gallery">
			<li><a href="/inc/images/#prc.currentpage.PageImage#" rel="prettyPhoto" title="#prc.currentpage.PageTitle#"><img src="/inc/images/th-#prc.currentpage.PageImage#" class="shadow" alt="#prc.currentpage.PageTitle# test" title="#prc.currentpage.PageTitle# 2" /></a></li>	
		</ul>			
	</cfif>
	#prc.currentpage.PageText#
	<cfif isDefined('prc.subs') AND prc.subs.recordcount GT 0>
		<div class="article">			
			<h2 align="center">More #prc.currentpage.PageLink#</h2>
			<ul class="sublist"><cfloop query="prc.subs">
			<li><a href="/#prc.subs.PageDir#/#prc.subs.PageName#" title="#prc.subs.PageName#"><img src="/inc/images/th-#prc.subs.PageImage#" class="shadowNF" title="#prc.subs.PageName#" alt=" title="#prc.subs.PageName#""><h3>#prc.subs.PageLink#</h3><p>#prc.subs.PageDescription#</p></a></li></cfloop>
		</ul>
		</div>
	</cfif>
	<cfif prc.currentRoutedURL contains 'evaluation'>
		<div style="float: left; width: 60%;">
		#html.startForm(action='contact.send',name="contactForm",id="eval")#
			#html.textfield(name="name",placeholder="Name: ",size="50",required="required",class="textfield")#<br>
			#html.textfield(name="SSSphone",id="phone",placeholder="Phone:",size="50",class="textfield")#
			#html.textfield(name="SSSemail",id="email",placeholder="Email: ",size="50",required="required",class="textfield")#<br>
			<label>Contact Preference: <input type="radio" name="contactPref" value="email" id="contactPref_0" />Email</label>
			<label><input type="radio" name="contactPref" value="phone" id="contactPref_1" />Phone</label><br>
			<select name="reference">
				<option>How did you hear about us?</option>
				<option value="isearch">Seach(google,bing)</option>
				<option value="referral">Referral</option>
			</select><br><br>
			#html.textarea(name="comments",placeholder="Tell us about your case: ",cols="36",rows="8",required="required",class="tArea")#
			<cfimage action="captcha" width="380" height="60" text="#prc.captcha#" style="margin-left: -7px;margin-top: 5px;margin-bottom: 3px;">
			#html.hiddenField(name="captchaHash",value=prc.captchaHash)#
			#html.textfield(name="captcha",placeholder="Enter Text Above: ",size="50",required="required",class="textfield")#<br>
			#html.submitButton(value="  Send E-mail  ",class="emailButton")#
		</div>
		<div style="float: left; width: 35%;padding: 0 2% 0 2%">
			<h3 align="center">Call us Toll Free:<br>1-800-256-7728</h3>
			<p align="center"><strong><em>Taylor Martino<br>Personal Injury Lawyers</em></strong></p>
			<p align="center">51 St. Joseph Street<br>
				P.O. Box 894<br>
				Mobile, Alabama 36601<br>
				Tel: 251-433-3131<br>
				Fax: 251-433-4207</p>
		</div>
		<br clear="all">
	<!---<script type="text/javascript">
var provinceName = 'Province';
var email = jQuery('##contactPref_0');
var phone = jQuery('##contactPref_1');
email.change(function () {
    if ($(this).val() == 'email') {
		$("##email").show();
		$("##phone").hide();
    } 
	
});
phone.change(function () {
    if ($(this).val() == 'phone') {
		$("##phone").show();
		$("##email").hide();
    } 
	
});
</script>--->
	</cfif>
	
</cfoutput>
