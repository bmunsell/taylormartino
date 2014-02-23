<cfif IsDefined('FORM.email')>
<cfset em = #trim(FORM.email)#>
<cfelse>
<cflocation url="/login.cfm?error=reg">
</cfif>
<cfquery name="checkEmail">
   SELECT UserName, FName, LName, Pass
   FROM   Users
   WHERE  UserName = <cfqueryparam value="#em#" cfsqltype="cf_sql_char">
</cfquery>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Forgotten Password</title>
</head>

<body>
<cfif checkEmail.recordCount NEQ 0>

<cfmail to="#em#"
        from="webform@cdfolio.com" 
        type="html" 
        subject="Account Information">
Hello #checkEmail.FName#.<br />
<br />
You recently requested your password.<br />
Your username is: #checkEmail.UserName#<br />
Your password is: #checkEmail.Pass#<br />
<br />
<br />
Thank You,<br />
Webmaster
</cfmail>
Thank you, <cfoutput>#checkEmail.FName#</cfoutput>. Your password has been sent and should
arrive shortly.
<cfelse>
Sorry, We were unable to locate that email address. Please <a href="sendpass.cfm">enter your email address again</a>
</cfif>
</body>
</html>
