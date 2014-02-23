<cfset imagepath="/var/www/gulfsportsnet.com/html/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<cfquery name="GetPolls">
Select *
From Polls
WHERE PollID = <cfqueryparam value="#url.p#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="GetQs">
Select *
From PollAnswers
WHERE PollID = <cfqueryparam value="#url.p#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
<h2>Saving Poll....</h2>
  <cfquery name="add" result="mypoll">   
    INSERT INTO PollAnswers (PollAnswer,PollID)
VALUES (<cfif IsDefined("FORM.PollAnswer") AND #FORM.PollAnswer# NEQ "">
<cfqueryparam value="#FORM.PollAnswer#" cfsqltype="cf_sql_clob">
<cfelse>
''
</cfif>
, <cfqueryparam value="#url.p#" cfsqltype="cf_sql_integer">
)
</cfquery>
<cfif FORM.a is "Save & Finish">
<cflocation url="polls.cfm?add=yes&p=#url.p#">
</cfif>
<cfif FORM.a is "Save & Continue">
<cflocation url="poll-ad-q.cfm?add=yes&p=#url.p#">
</cfif>
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
<h2 align="center">Add Poll Anwser</h2>
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#?p=#url.p#" enctype="multipart/form-data">
       <input type="hidden" name="MM_InsertRecord" value="form1">
        <table width="387" align="center" cellspacing="5">
          <tr>
            <td colspan="2" class="formtext">Poll Question: <cfoutput>#GetPolls.PollQuestion#</cfoutput></td>
          </tr>
          <cfoutput query="GetQs">
          <tr>
            <td colspan="2" class="formtext">Poll Answer###currentrow#: #PollAnswer#</td>
          </tr>
          </cfoutput>
          <tr>
          <td width="320" colspan="2" class="formtext">
            	<h2>Poll Answer:<br>
            	  <span class="forminput">
            	  <cfinput type="text" name="PollAnswer" message="Please enter a Answer" required="yes" size="40">
            	  </span></h2></td>
                  </tr>
          <tr>
          
            <td align="center" class="formtext"><span class="forminput">
              <input type="submit" value="Save &amp; Continue"  name="a">
            </span></td>
            <td align="center" class="formtext"><span class="forminput">
              <input type="submit" value="Save &amp; Finish"  name="b">
            </span></td>
          </tr>
        </table>
       
</cfform>
      <p>&nbsp;</p>

  <!-- end .container --></div>
</body>
</html>