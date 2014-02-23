<cfset DTS = #DateAdd('h', 1, now())#>
<cfset DTS = #CreateODBCDateTime(DTS)#>

<cfparam name="URL.error" default="no">
<cfset message = "">
<cfif URL.error is "yes">
<cfset message = 'Invalid Login!<br /></span> <span class="regtext">Please try again'>
</cfif>
<cfset DTS = #CreateODBCDateTime(now())#>
<cfif IsDefined('FORM.Submit')>
    <!-- Check Username, Password, and Level of Administration -->
    <cfquery name="check_user">
            SELECT UserName, Pass, admin, FName, LName, UserID
            FROM Users
            WHERE UserName = '#FORM.username#' 
			AND pass = '#FORM.pass#'
    </cfquery>
    <!-- If there is a valid User then Login user -->
    <cfif check_user.recordcount is not 0>
        <!-- Log them in with a timeout of 30 minutes (1800 sec) and set level of Admin-->
        <cflogin idletimeout="7200" applicationtoken="#this.name#" cookiedomain="#this.URL#">
            <cfloginuser 
                    name = "#FORM.username#"
                    password ="#FORM.pass#"
                    roles = "#check_user.admin#">
        </cflogin>
		<cfif IsUserInRole('admin')>
		<cflock scope="session" type="exclusive" timeout="120" throwontimeout="yes">
        <cfset session.UserID = check_user.UserID>
		<cfset session.Username = check_user.UserName>
		<cfset session.FirstName = check_user.FName>
		<cfset session.LastName = check_user.LName>
		</cflock>
        <cfquery name="SaveEdit">
  		 UPDATE Users SET Last = #DTS# WHERE UserName="#check_user.UserName#"
 		</cfquery>
        <cflocation url="/admin/index.cfm" addtoken="yes">
        
		</cfif>
               
    <cfelse>
        <!-- If an invalid Login Attemp, Set invalid to 1 for invalid login script -->
        <cflocation url="/login/error=?" addtoken="no">
    </cfif>
</cfif>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Taylor Martino Login</title>

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

  <div class="content">

  <!---START PAGE EDIT //--->
   <h3 align="center"><cfoutput>#message#</cfoutput></h3>
    <h1 align="center">Website Login</h1>
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
    <p>&nbsp;</p>

  <!---END PAGE EDIT //--->

    <!-- end .content --></div>
</body>
</html>