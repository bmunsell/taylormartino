<!---<h1 align="center">Website Login</h1>
    <cfform id="form1" name="form1" method="post" action="#CGI.SCRIPT_NAME#">
    <cfif IsDefined('url.p')>
    <cfinput type="hidden" name="page" value="#url.p#" />
    <cfelse>
    <cfinput type="hidden" name="page" value="no" />
    </cfif>
      <table width="353" border="0" cellpadding="2" cellspacing="2" align="center">
          <tr>
            <td width="87" class="Wbold">E-mail</td>
            <td width="252"><cfinput name="UserName" type="text" id="UserName" required="yes" message="Please enter your E-mail address" /></td>
          </tr>
          <tr>
            <td class="Wbold">Password</td>
            <td><cfinput name="Pass" type="password" id="Pass" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><cfinput type="submit" name="Submit" value="Login" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><a href="javascript:popUp('sendpass.cfm')">Forgotten your password?</a></td>
          </tr>
        </table>
      </cfform>
    <p>&nbsp;</p>--->
   <cfoutput>
   	#html.startForm(action='login.index',name="loginForm")#
	<!---Secured URL --->
	<!---#html.hiddenField(name="_securedURL",value=event.getValue('_securedURL',''))#--->

	<!---#html.textfield(name="username",label="Username: ",size="40",required="required",class="textfield",value=prc.rememberMe)#--->
	#html.textfield(name="username",label="Username: ",size="40",required="required",class="textfield")#<br>
	#html.passwordField(name="password",label="Password: ",size="40",required="required",class="textfield")#
	
	<div id="loginButtonbar">
	<!---#html.checkBox(name="rememberMe",value=true,checked=(len(prc.rememberMe)))# 
	#html.label(field="rememberMe",content="Remember Me  ",class="inline")#--->
	#html.submitButton(value="  Log In  ",class="buttonred")#
	</div>
	
	<br/>
	<img src="/includes/images/lock.png" alt="lostPassword" />
	<a href="/login/lost/">Lost your password?</a> 
	
#html.endForm()#
   	   
   </cfoutput>
   <cfdump var="#session#">