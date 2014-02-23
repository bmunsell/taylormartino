<!---<!-- AddThis Button BEGIN -->
<div class="addthis_toolbox addthis_default_style addthis_32x32_style" style="margin-bottom: 15px;margin-top: 10px;margin-left: 15px;text-align:center;">
	<!---<a class="addthis_button_preferred_1" style="margin-right: 10px;"></a>--->
	<a class="addthis_button_preferred_2" style="margin-right: 10px;"></a>
	<a class="addthis_button_preferred_3" style="margin-right: 10px;"></a>
	<a class="addthis_button_preferred_4" style="margin-right: 10px;"></a>
	<a class="addthis_button_compact"></a>
	<!-- <a class="addthis_counter addthis_bubble_style"></a> -->
</div>
<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=xa-513b5ea55c75ce85"></script>
<!-- AddThis Button END -->--->
<cfoutput>
<form id="siteSearch" method="post" name="siteSearch" action="/search/">
	<input type="text" name="term"placeholder="Site Search" size="30"><input type="image" src="/includes/images/Search.png" alt="Submit Form" align="absmiddle" />
</form>
<h2 class="sideTitle"><a href="#prc.settings.TheURL#/news" title="Taylor Martino News Articles">Taylor Martino<br>News & Articles</a></h2>
<ul class="sidenav">
<cfloop query="prc.sidenews">	
<li><a href="#prc.settings.theUrl#/#PageDir#/#PageName#">
	<cfif PageImage is not ''>					
		<img src="/inc/images/th-#prc.sidenews.PageImage#" alt="#prc.sidenews.PageTitle#" width="50" height="40" style="float: left;">		
	<cfelse>
		<img src="/#getSetting('defaultImage')#" alt="#prc.sidenews.PageTitle#" width="50" height="40" style="float: left;">		
	</cfif><div style="margin-left: 60px; font-weight:600;">#PageTitle#</div></a></li>
</cfloop>
</ul>
<h2 class="sideTitle"><a href="#prc.settings.TheURL#/free-evaluation" title="Free Personal Injury Case Evaluation">Taylor Martino<br>Free Evaluation</a></h2>
	<ul class="sidenav">
		<li style="padding: 10px 0px 10px 0px;">
			#html.startForm(action='contact.send',name="contactForm",id="eval")#
			#html.textfield(name="name",label="Name: ",required="required",class="textfield")#
			#html.textfield(name="SSSphone",label="Phone:",class="textfield")#
			#html.textfield(name="SSSemail",label="Email: ",required="required",class="textfield")#			
			#html.textarea(name="comments",label="Tell us about your case: ",cols="22",rows="5",required="required",class="tArea")#
			<cfimage action="captcha" width="240" height="35" text="#prc.captcha#" style="margin-left: 3px;margin-top: 5px;margin-bottom: 3px;">
			#html.hiddenField(name="captchaHash",value=prc.captchaHash)#
			#html.textfield(name="captcha",label="Enter Text Above: ",required="required",class="textfield")#
			#html.submitButton(value="  Send E-mail  ",class="emailButton")#
		</li>
	</ul>
<br clear="all">
</cfoutput>