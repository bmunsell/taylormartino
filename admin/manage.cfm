<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
  <cfquery datasource="gsn">   
    INSERT INTO Scores (Home, Away, HScore, AScore, Period, SText, GDate)
VALUES (<cfif IsDefined("FORM.Home") AND #FORM.Home# NEQ "">
<cfqueryparam value="#FORM.Home#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Away") AND #FORM.Away# NEQ "">
<cfqueryparam value="#FORM.Away#" cfsqltype="cf_sql_clob" maxlength="50">	
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.HScore") AND #FORM.HScore# NEQ "">
<cfqueryparam value="#FORM.HScore#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.AScore") AND #FORM.AScore# NEQ "">
<cfqueryparam value="#FORM.AScore#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.Period") AND #FORM.Period# NEQ "">
<cfqueryparam value="#FORM.Period#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.SText") AND #FORM.SText# NEQ "">
<cfqueryparam value="#FORM.SText#" cfsqltype="cf_sql_clob">
<cfelse>
NULL
</cfif>
, <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
)
  </cfquery>
  <cflocation url="manage.cfm?add=yes">
</cfif>
<cfquery name="ShowNews">
  SELECT * FROM Scores
  Order by ScoreID Desc
</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>GSN scoreboard management</title>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
</head>

<body>
<cfinclude template="header.cfm">
<div class="container">
<cfform action="#CGI.SCRIPT_NAME#" method="post" name="form1" id="form1">
<table width="90%" align="center">
<tr>
  <td colspan="2" align="center"><strong>GSN Scoreboard Management</strong></td>
</tr>
<tr bgcolor="#1C558A">
  <td colspan="2">&nbsp;<b><font color="#FFFFFF">Add Score</font></b></td>
</tr>
<tr valign="baseline">
  <td width="131" align="right" nowrap="nowrap">Home:</td>
  <td width="177"><input type="text" name="Home" value="" size="15" /></td>
</tr>
<tr valign="baseline">
  <td nowrap="nowrap" align="right">Away:</td>
  <td><input type="text" name="Away" value="" size="15" /></td>
</tr>
<tr valign="baseline">
  <td nowrap="nowrap" align="right">Home Score:</td>
  <td><select name="HScore">
    <cfloop from="00" to="99" index="i">
      <cfoutput>
        <option value="#i#" >#i#</option>
        </cfoutput>
      </cfloop>
  </select></td>
</tr>
<tr valign="baseline">
  <td nowrap="nowrap" align="right">Away Score:</td>
  <td><select name="AScore">
    <cfloop from="00" to="99" index="i">
      <cfoutput>
        <option value="#i#" >#i#</option>
        </cfoutput>
      </cfloop>
  </select></td>
</tr>
<tr valign="baseline">
  <td nowrap="nowrap" align="right">Period:</td>
  <td><select name="Period">
    <option value="" ></option>
    <option value="1st" >1st</option>
    <option value="2nd" >2nd</option>
    <option value="HT" >HT</option>
    <option value="3rd" >3rd</option>
    <option value="4th" >4th</option>
    <option value="5th" >5th</option>
    <option value="6th" >6th</option>
    <option value="7th" >7th</option>
    <option value="8th" >8th</option>
    <option value="9th" >9th</option>
    <option value="Final" >Final</option>
    <option value="OT1" >OT1</option>
    <option value="OT2" >OT2</option>
    <option value="OT3" >OT3</option>
  </select></td>
</tr>
<tr valign="baseline">
  <td nowrap="nowrap" align="right">Sport/Text:</td>
  <td><input name="SText" type="text" id="SText" value="" size="10" /></td>
</tr>
<!---    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Game Date</td>
      <td><cfinput type="datefield" name="GDate" mask="mm/dd/yy" size="15" /></td>
    </tr>--->
<tr valign="baseline">
  <td colspan="2" align="center" nowrap="nowrap"><input type="submit" value="Add Score" /></td>
  </tr>
</table>
<input type="hidden" name="MM_InsertRecord" value="form1" />
</cfform>
<!---<br />
<table width="320" border="0" align="center">
<tr bgcolor="#1C558A">
          <td colspan="4">&nbsp;<b><font color="#FFFFFF">Edit Scores</font></b></span></td>
      </tr>
		 <cfif #ShowNews.RecordCount# eq 0>
		   <tr><td colspan="4"> There are no Scores on file</td></tr>
		 <cfelse>
		 <cfoutput query="ShowNews">
		  <tr bgcolor="###iif(currentrow MOD 2,DE('ffffff'),DE('eeeeee'))#">
		    <td width="60%" valign="middle">#Home# <strong>#HScore#</strong> <BR> #Away# <strong>#AScore#</strong></td>
			<td width="15%" valign="middle">ID:<br><strong>#ScoreID#</strong></td>
			<td width="15%" valign="middle">
				    <form method="post" action="score-edit.cfm">
					  <input type="submit" value="Edit">
					  <input type="hidden" name="sid" value="#ScoreID#">
					</form>
			</td>
            <td width="15%" valign="middle">
				   <form method="post" action="#cgi.SCRIPT_NAME#?ID=#ScoreID#">
				   <input type="submit" value="Delete" onClick="javascript:return confirm('Are you sure you want to delete this Score?')">
			       <input type="hidden" name="del" value="#ScoreID#">
				   </form>
		    </td>
		 </tr>
</cfoutput></cfif>
</table>--->
</div>
</body>
</html>