<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="uid" default="1">
<cfif IsDefined('url.uid')>
<cfset uid = #url.uid#>
</cfif>
<cfif IsDefined('FORM.uid')>
<cfset uid = #FORM.uid#>
</cfif>
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
  <cfquery>   
    UPDATE Users
    SET Admin = <cfqueryparam value="#FORM.Admin#" cfsqltype="cf_sql_clob">
<cfif IsDefined("FORM.FName") AND #FORM.FName# NEQ "">
, Fname = <cfqueryparam value="#FORM.FName#" cfsqltype="cf_sql_clob" maxlength="50">
</cfif>
<cfif IsDefined("FORM.LName") AND #FORM.LName# NEQ "">
, LName = <cfqueryparam value="#FORM.LName#" cfsqltype="cf_sql_clob" maxlength="50">
</cfif>
<cfif IsDefined("FORM.UserName") AND #FORM.UserName# NEQ "">
, UserName = <cfqueryparam value="#FORM.UserName#" cfsqltype="cf_sql_clob" maxlength="250">
</cfif>
<cfif IsDefined("FORM.Pass") AND #FORM.Pass# NEQ "">
, Pass = <cfqueryparam value="#FORM.Pass#" cfsqltype="cf_sql_clob" maxlength="50">
</cfif>
<cfif IsDefined("FORM.Address") AND #FORM.Address# NEQ "">
, Address = <cfqueryparam value="#FORM.Address#" cfsqltype="cf_sql_clob" maxlength="150">
</cfif>
<cfif IsDefined("FORM.City") AND #FORM.City# NEQ "">
, City = <cfqueryparam value="#FORM.City#" cfsqltype="cf_sql_clob" maxlength="150">
</cfif>
<cfif IsDefined("FORM.State") AND #FORM.State# NEQ "">
, State = <cfqueryparam value="#FORM.State#" cfsqltype="cf_sql_clob" maxlength="50">
</cfif>
<cfif IsDefined("FORM.Zip") AND #FORM.Zip# NEQ "">
, Zip = <cfqueryparam value="#FORM.Zip#" cfsqltype="cf_sql_clob" maxlength="25">
</cfif>
<cfif IsDefined("FORM.Phone") AND #FORM.Phone# NEQ "">
, Phone = <cfqueryparam value="#FORM.Phone#" cfsqltype="cf_sql_clob" maxlength="15">
</cfif>
WHERE UserID=#FORM.save_edit#
  </cfquery>
  <cflocation url="users.cfm?edit=yes">
</cfif>
<cfquery name="GetUser">
Select *
From Users
WHERE UserID = <cfqueryparam value="#uid#" cfsqltype="cf_sql_integer">
</cfquery>

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
<h1><img src="/admin/images/Comment.png" width="16" height="16" align="middle">Edit User: <cfoutput>#GetUser.FName# #GetUser.Lname#</cfoutput></h1>  
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#">
        <table width="940" cellspacing="5" align="left">
         <tr>
            <td width="267" class="formtext">
            	<h1>User Type</h1>
            	<cfselect name="Admin" multiple="no">
                <option value="member"<cfif GetUser.Admin is 'member'>selected</cfif>>Member</option>
                <option value="boardAdmin"<cfif GetUser.Admin is 'boardAdmin'>selected</cfif>>Board Admin</option>
                <option value="board"<cfif GetUser.Admin is 'board'>selected</cfif>>Board</option>
                <option value="admin"<cfif GetUser.Admin is 'admin'>selected</cfif>>Admin</option>
                </cfselect>
            </td>
            <td width="325" class="formtext"><h1>First Name:
           <br>              
           <cfinput type="text" name="FName" value="#GetUser.FName#" size="40" required="yes" message="Please enter a First Name">
           </h1></td>
            <td width="320" class="formtext"><h1>Last Name:<br>
  <cfinput type="text" name="LName" value="#GetUser.LName#" size="50" required="yes" message="Please enter a Last Name">
           </h1></td>
          </tr>
         <tr>
           <td colspan="2" class="formtext"><h1>Email:<br>
             <cfinput type="text" name="UserName" id="UserName" value="#GetUser.UserName#" size="60" maxlength="150">
           </h1>             <h1>&nbsp;</h1></td>
           <td class="formtext"><h1>Password: <br>
           <cfinput type="text" name="Pass" message="Please enter a First Name" required="yes" id="Pass" value="#GetUser.Pass#" size="50" maxlength="50">
           </h1></td>
          </tr>
          <tr>
           <td colspan="3" class="formtext"><h1>Address: 
           <cfinput type="text" name="Address" value="#GetUser.Address#" size="70" maxlength="150">
           <br>
           <br>
           City: 
           <cfinput type="text" name="City" value="#GetUser.City#" size="40" maxlength="150"> 
           State:<cfinput type="text" name="State" value="#GetUser.State#" size="5" maxlength="10">
           Zip:  
           <cfinput type="text" name="Zip" id="Zip" value="#GetUser.Zip#" size="10" maxlength="10">
           <br>
           <br>
           
Phone:
<cfinput type="text" name="Phone" id="Phone" value="#GetUser.Phone#" size="10" maxlength="15">
           </h1></td>
          </tr>
          
         <!---<tr>
           <td colspan="3" class="formtext"><h1>
           <cfif GetUser.Newsletter is '1'>
             <cfinput type="checkbox" name="Newsletter" value="1" id="Newsletter" checked="yes">
			 <cfelse>
			 <cfinput type="checkbox" name="Newsletter" value="1" id="Newsletter" checked="no">
			 </cfif>
             <label for="Newsletter">Receive Newsletter Email</label>
           </h1></td>
         </tr>--->
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
          <cfinput type="hidden" name="save_edit" value="#GetUser.UserID#">
      </p>
  </cfform>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
</div>
</body>
</html>