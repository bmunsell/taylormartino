<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
<cfdump var="#FORM#">

  <cfquery>   
    INSERT INTO Users (Admin, FName, LName, UserName, Pass, Address, City, State, Zip, Phone)
VALUES (<cfif IsDefined("FORM.Admin") AND #FORM.Admin# NEQ "">
<cfqueryparam value="#FORM.Admin#" cfsqltype="cf_sql_clob">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.FName") AND #FORM.FName# NEQ "">
<cfqueryparam value="#FORM.FName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.LName") AND #FORM.LName# NEQ "">
<cfqueryparam value="#FORM.LName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.UserName") AND #FORM.UserName# NEQ "">
<cfqueryparam value="#FORM.UserName#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Pass") AND #FORM.Pass# NEQ "">
<cfqueryparam value="#FORM.Pass#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Address") AND #FORM.Address# NEQ "">
<cfqueryparam value="#FORM.Address#" cfsqltype="cf_sql_clob" maxlength="150">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.City") AND #FORM.City# NEQ "">
<cfqueryparam value="#FORM.City#" cfsqltype="cf_sql_clob" maxlength="150">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.State") AND #FORM.State# NEQ "">
<cfqueryparam value="#FORM.State#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Zip") AND #FORM.Zip# NEQ "">
<cfqueryparam value="#FORM.Zip#" cfsqltype="cf_sql_clob" maxlength="25">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Phone") AND #FORM.Phone# NEQ "">
<cfqueryparam value="#FORM.Phone#" cfsqltype="cf_sql_clob" maxlength="15">
<cfelse>
''
</cfif>
)
  </cfquery>
  <cflocation url="users.cfm?add=yes">
</cfif>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Taylor Martino Website Admin</title>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
</head>
<body>

<cfinclude template="header.cfm">
<div class="container">
<h1><img src="/admin/images/Comment.png" width="16" height="16" align="middle">Add New User</h1>  
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#">
        <table width="940" cellspacing="5" align="left">
         <tr>
            <td width="267" class="formtext">
            	<h1>User Type</h1>
            	<cfselect name="Admin" multiple="no">
                <option value="member">Member</option>
                <option value="admin">Admin</option>
                </cfselect>
            </td>
            <td width="325" class="formtext"><h1>First Name:
           <br>              
           <cfinput type="text" name="FName" value="" size="50" maxlength="50" required="yes" message="Please enter a First Name">
           </h1></td>
            <td width="320" class="formtext"><h1>Last Name:<br>
  <cfinput type="text" name="LName" value="" size="50" maxlength="50" required="yes" message="Please enter a Last Name">
           </h1></td>
          </tr>
         <tr>
           <td colspan="2" class="formtext"><h1>Email:<br>
             <cfinput type="text" name="UserName" message="Please enter an Email" required="yes" id="UserName" value="" size="60" maxlength="150">
           </h1>             <h1>&nbsp;</h1></td>
           <td class="formtext"><h1>Password: <br>
           <cfinput type="text" name="Pass" message="Please enter a First Name" required="yes" id="Pass" value="" size="50" maxlength="50">
           </h1></td>
          </tr>

          <tr>
           <td colspan="3" class="formtext"><h1>Address: 
           <cfinput type="text" name="Address" value="" size="70" maxlength="150">
           <br>
           <br>
           City: 
           <cfinput type="text" name="City" value="" size="40" maxlength="150"> 
           State:
           <select name="State" id="State">
             <option value="AL" selected="selected">Alabama</option>
             <option value="AK">Alaska</option>
             <option value="AZ">Arizona</option>
             <option value="AR">Arkansas</option>
             <option value="CA">California</option>
             <option value="CO">Colorado</option>
             <option value="CT">Connecticut</option>
             <option value="DE">Delaware</option>
             <option value="FL">Florida</option>
             <option value="GA">Georgia</option>
             <option value="HI">Hawaii</option>
             <option value="ID">Idaho</option>
             <option value="IL">Illinois</option>
             <option value="IN">Indiana</option>
             <option value="IA">Iowa</option>
             <option value="KS">Kansas</option>
             <option value="KY">Kentucky</option>
             <option value="LA">Louisiana</option>
             <option value="ME">Maine</option>
             <option value="MD">Maryland</option>
             <option value="MA">Massachusetts</option>
             <option value="MI">Michigan</option>
             <option value="MN">Minnesota</option>
             <option value="MS">Mississippi</option>
             <option value="MO">Missouri</option>
             <option value="MT">Montana</option>
             <option value="NE">Nebraska</option>
             <option value="NV">Nevada</option>
             <option value="NH">New Hampshire</option>
             <option value="NJ">New Jersey</option>
             <option value="NM">New Mexico</option>
             <option value="NY">New York</option>
             <option value="NC">North Carolina</option>
             <option value="ND">North Dakota</option>
             <option value="OH">Ohio</option>
             <option value="OK">Oklahoma</option>
             <option value="OR">Oregon</option>
             <option value="PA">Pennsylvania</option>
             <option value="RI">Rhode Island</option>
             <option value="SC">South Carolina</option>
             <option value="SD">South Dakota</option>
             <option value="TN">Tennessee</option>
             <option value="TX">Texas</option>
             <option value="UT">Utah</option>
             <option value="VT">Vermont</option>
             <option value="VA">Virginia</option>
             <option value="WA">Washington</option>
             <option value="WV">West Virginia</option>
             <option value="WI">Wisconsin</option>
             <option value="WY">Wyoming</option>
           </select> 
           Zip:  
           <cfinput type="text" name="Zip" id="Zip" value="" size="10" maxlength="10">
           <br>
           <br>
Phone:
<cfinput type="text" name="Phone" id="Phone" value="" size="10" maxlength="15">
           </h1></td>
          </tr>
         <tr>
           <td colspan="3">
             <input type="submit" value="Save User" class="subform">
           </td>
          </tr>
         <tr>
           <td colspan="3">&nbsp;</td>
          </tr>
        </table>
        
        <p>
          <input type="hidden" name="MM_InsertRecord" value="form1">
      </p>
  </cfform>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
</div>
</body>
</html>