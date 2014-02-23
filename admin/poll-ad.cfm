<cfset imagepath="/var/www/gulfsportsnet.com/html/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
<h2>Saving Poll....</h2>
  <cfquery name="add" result="mypoll">   
    INSERT INTO Polls (PollQuestion,PollDate)
VALUES (<cfif IsDefined("FORM.PollQuestion") AND #FORM.PollQuestion# NEQ "">
<cfqueryparam value="#FORM.PollQuestion#" cfsqltype="cf_sql_clob">
<cfelse>
''
</cfif>
, <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
)
</cfquery>
<cflocation url="poll-ad-q.cfm?add=yes&p=#mypoll.GENERATED_KEY#">
</cfif>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>GSN Banner Admin</title>
<link href="/scores/admin.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="container">
<cfinclude template="header.cfm">
<h2 align="center">Add Poll Question</h2>
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
        <table width="387" align="center" cellspacing="5">
          <tr>
          <td width="320" class="formtext">
            	<h2>Poll Question:<br>
            	  <span class="forminput">
            	  <cfinput type="text" name="PollQuestion" message="Please enter a Question" required="yes" size="40">
            	  </span></h2></td>
                  </tr>
          <tr>
            <td align="center" class="formtext"><span class="forminput">
              <input type="submit" value="Save &amp; Continue">
            </span></td>
          </tr>
        </table>
        <input type="hidden" name="MM_InsertRecord" value="form1">
      </cfform>
      <p>&nbsp;</p>

  <!-- end .container --></div>
</body>
</html>