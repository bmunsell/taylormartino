<cfparam name="form.name" default="">
<cfparam name="form.SSSemail" default="">
<cfparam name="form.SSSPhone" default="">
<cfparam name="form.comments" default="">
<cfparam name="form.captcha" default="">
<cfparam name="form.captchaHash" default="">
<cfoutput>
	<br>
<div id="map_canvas"></div><div id="map_image"><img src="/includes/images/contact-map.jpg"></div>
<div class="article">
	#prc.currentpage.PageText#
<!---	<hr>
	<div style="width=50%;float:left;padding:0;margin:0;">
<form action="/contact/send" method="post">
	<table cellpadding="5" cellspacing="2">
		<tr>
			<td>Name:</td>
			<td><input name="name" type="text" value="#form.name#" size="26"></td>
		</tr>
		<tr>
		  <td>Email:</td>
		  <td><input name="SSSemail" type="text" value="#form.SSSemail#" size="26"></td>
	    </tr>
        <tr>
		  <td>Phone:</td>
		  <td><input name="SSSPhone" type="text" value="#form.SSSPhone#" size="26"></td>
	    </tr>
		<tr>
			<td>Comments:</td>
			<td><textarea name="comments" cols="20" rows="5">#form.comments#</textarea></td>
		</tr>
		<tr>
			<td>Enter Text Below:</td>
			<td><input type="text" name="captcha" size="26"></td>
		</tr>
		<tr>
			<td> </td>
			<td>
			<cfimage action="captcha" width="200" height="50" text="#prc.captcha#">
			<input type="hidden" name="captchaHash" value="#prc.captchaHash#">
			</td>
		</tr>		
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" name="send" value="Send Comments"></td>
		</tr>
	</table>
</form>
</div>
<div style="width=48%;float:left;padding:0;padding-left:40px;">	
	<img src="/includes/images/Taylor-Martino-Mobile-Alabama.png">
	<p style="padding-left:20px;font-size:120%;">51 Saint Joseph Street<br>Mobile, Alabama 36601</p>
	<p style="padding-left:20px;"><strong>Toll Free:</strong> 1-800-256-7728<br><strong>Tel:</strong> 251-433-3131<br><strong>Fax:</strong> 251-433-4207<br><strong>Fax:</strong> 251-405-5080</p>
</div>--->
</div>
</cfoutput>