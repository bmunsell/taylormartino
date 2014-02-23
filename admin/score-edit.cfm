<cfparam name="sid" default="1">
<cfif IsDefined('url.sid')>
<cfset sid = #url.sid#>
</cfif>
<cfif IsDefined('FORM.sid')>
<cfset sid = #FORM.sid#>
</cfif>
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
  <cfquery name="update">   
UPDATE Scores
SET Home = <cfqueryparam value="#FORM.Home#" cfsqltype="cf_sql_clob" maxlength="70">
<cfif IsDefined("FORM.Away") AND #FORM.Away# NEQ "">
, Away = <cfqueryparam value="#Trim(FORM.Away)#" cfsqltype="cf_sql_clob" maxlength="70">
</cfif>
<cfif IsDefined("FORM.HScore") AND #FORM.HScore# NEQ "">
, HScore = <cfqueryparam value="#Trim(FORM.HScore)#" cfsqltype="cf_sql_integer" maxlength="10">
</cfif>
<cfif IsDefined("FORM.AScore") AND #FORM.AScore# NEQ "">
, AScore = <cfqueryparam value="#Trim(FORM.AScore)#" cfsqltype="cf_sql_integer" maxlength="10">
</cfif>
, Period = <cfqueryparam value="#FORM.Period#" cfsqltype="cf_sql_clob" maxlength="10">
, SText = <cfqueryparam value="#Trim(SText)#" cfsqltype="cf_sql_clob" maxlength="15">

, GDate = <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
WHERE ScoreID=#FORM.save_edit#
  </cfquery>
  <cflocation url="scores.cfm?edit=yes">
</cfif>
<cfquery name="GetScore">
Select *
From Scores
WHERE ScoreID = <cfqueryparam value="#sid#" cfsqltype="cf_sql_integer">
</cfquery>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Edit Score: <cfoutput>#GetScore.ScoreID#</cfoutput></title>
<link href="/scores/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfinclude template="header.cfm">
<div class="container">
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#">
        <table width="90%" align="center">
        <tr bgcolor="#1C558A" align="center">
          <td colspan="2">&nbsp;<b><font color="#FFFFFF">Edit Score: <cfoutput>#GetScore.ScoreID#</cfoutput></font></b></span></td>
      </tr>
                    <td width="160" class="formtext">
            	  <div align="right">
            	    <cfinput type="text" name="Home" value="#GetScore.Home#" maxlength="15" size="15" required="yes" message="Please enter Home Team">
       	    </div></td>
            <td width="160" colspan="2" class="formtext">
            <select name="HScore">
      		<cfloop from="00" to="99" index="i">
      		<cfoutput>
        	<option value="#i#"<cfif i EQ GetScore.HScore> selected</cfif>>#i#</option>
        	</cfoutput>
      		</cfloop>
      		</select>
            </td>
          </tr>
          <tr>
            <td class="formtext">
              <div align="right">
                <cfinput type="text" name="Away" value="#GetScore.Away#" size="15" maxlength="15" required="yes" message="Please enter a Visitor">
            </div></td>
            <td colspan="2" class="formtext">
            <select name="AScore">
      		<cfloop from="00" to="99" index="i">
      		<cfoutput>
        	<option value="#i#"<cfif i EQ GetScore.AScore> selected</cfif>>#i#</option>
        	</cfoutput>
      		</cfloop>
      		</select></td>
          </tr>
          
          <tr>
           <td class="formtext"><div align="right">Period:</div></td>
           <td colspan="2" class="formtext"><select name="Period">
        <option value=""<cfif GetScore.Period is ''> selected</cfif>></option>
        <option value="1st"<cfif GetScore.Period is '1st'> selected</cfif>>1st</option>
        <option value="2nd"<cfif GetScore.Period is '2nd'> selected</cfif>>2nd</option>
        <option value="HT"<cfif GetScore.Period is 'HT'> selected</cfif>>HT</option>
        <option value="3rd"<cfif GetScore.Period is '3rd'> selected</cfif>>3rd</option>
        <option value="4th"<cfif GetScore.Period is '4th'> selected</cfif>>4th</option>
        <option value="5th"<cfif GetScore.Period is '5th'> selected</cfif>>5th</option>
        <option value="6th"<cfif GetScore.Period is '6th'> selected</cfif>>6th</option>
        <option value="7th"<cfif GetScore.Period is '7th'> selected</cfif>>7th</option>
        <option value="8th"<cfif GetScore.Period is '8th'> selected</cfif>>8th</option>
        <option value="9th"<cfif GetScore.Period is '9th'> selected</cfif>>9th</option>
        <option value="Final"<cfif GetScore.Period is 'Final'> selected</cfif>>Final</option>
        <option value="OT1"<cfif GetScore.Period is 'OT1'> selected</cfif>>OT1</option>
        <option value="OT2"<cfif GetScore.Period is 'OT2'> selected</cfif>>OT2</option>
        <option value="OT3"<cfif GetScore.Period is 'OT3'> selected</cfif>>OT3</option>
      </select></td>
          </tr>
          <tr>
            <td class="formtext"><div align="right">Sport/Text</div></td>
            <td class="formtext"><cfinput type="text" name="SText" id="SText" value="#GetScore.SText#" size="10" maxlength="10"></td>
          </tr>
          <tr>
            <td colspan="3" align="center"><span class="forminput">
              <input type="submit" value="Update Score" class="subform">
            </span></td>
          </tr>
        </table>
<cfinput type="hidden" name="save_edit" value="#GetScore.ScoreID#">
        <input type="hidden" name="MM_InsertRecord" value="form1">
      </cfform>
      <p>&nbsp;</p>
</div>
</body>
</html>