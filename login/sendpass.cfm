<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Forgotten Password</title>
</head>

<body>
<cfform id="form1" name="form1" method="post" action="passsend.cfm">
  <table width="500" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td width="235">Please enter your email address</td>
      <td width="251"><cfinput type="text" name="email" id="email" required="yes" message="Please enter your email" /></td>
    </tr>
	<tr>
	<td>&nbsp;</td>
	<td><input type="submit" value="Submit" /></td>
	</tr>
  </table>
</cfform>
</body>
</html>
