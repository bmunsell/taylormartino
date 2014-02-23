<cfparam name="URL.error" default="no">
<cfset message = "">
<cfif URL.error is "yes">
<cfset message = 'Invalid Login!<br /></span> <span class="regtext">Please try again'>
</cfif>

<cfset DTS = #CreateODBCDateTime(now())#>
<cfif IsDefined('FORM.Submit')>
<cfinvoke component="logon" 
                   method="verifyUser"
                   returnVariable="verify"
                   getUsername="#form.UserName#"
                   getPassword="#form.pass#">
</cfif>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Login</title>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=650,height=490,left = 240,top = 212');");
}
//-->
</script>
</head>
<body>

  <!---START PAGE EDIT //--->
    <h1>Website Login</h1>
    
    <cfform id="form1" name="form1" method="post" action="#CGI.SCRIPT_NAME#">
      <table width="353" border="0" align="left" cellpadding="2" cellspacing="2">
          <tr>
            <td width="87" class="Wbold">E-mail</td>
            <td width="252"><cfinput name="UserName" type="text" id="UserName" required="yes" message="Please enter your E-mail address" /></td>
          </tr>
          <tr>
            <td class="Wbold">Password</td>
            <td><input name="Pass" type="password" id="Pass" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><input type="submit" name="Submit" value="Login" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><a href="javascript:popUp('sendpass.cfm')">Forgotten your password?</a></td>
          </tr>
        </table>
      </cfform>
    <p>&nbsp;</p>
  <!---END PAGE EDIT //--->
</body>
</html>