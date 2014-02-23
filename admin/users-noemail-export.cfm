
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>LLPS Website Admin</title>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
</head>
<body>
<cfinclude template="header.cfm">
<div class="container">
<cfquery name="GetUsers">
 SELECT LName,FName,UserName,Pass,Address,City,State,Zip,Area,Phone
 FROM Users
 WHERE UserName = ''
 Order by LName Asc
</cfquery>


<cffile action="write"
             file="/var/www/littlelagoon.org/html/admin/files/llps-noemail-users.csv"
             output="Last Name,First Name,Email,Password,Address,City,State,Zip,Area,Phone"
             addnewline="yes">



<!--- Output the contents of the export_contacts query --->
    <cfoutput>
        <cfloop query="GetUsers">
    	<cfset Last = Replace(LName, ',', ' ')>
        <cfset First = Replace(FName, ',', ' ')>
        <cfset Add = Replace(Address, ',', ' ')>
        <!--- Append (Insert) the contents of the query into the already created CSV file. Make sure that you keep all the output on one line exactly like the column header--->
        <cffile action="append"
                 file="/var/www/littlelagoon.org/html/admin/files/llps-noemail-users.csv"
                  output="#TRIM(Last)#,#TRIM(First)#,#TRIM(UserName)#,#TRIM(Pass)#,#TRIM(Add)#,#TRIM(City)#,#TRIM(State)#,#TRIM(Zip)#,#TRIM(Area)#,#TRIM(Phone)#" 
                 addnewline="yes">
        </cfloop>
    </cfoutput>

    <!--- This will pop up the file for downloading. You can open it in excel or any other text editing software. --->
   
<cflocation url="http://www.littlelagoon.org/admin/files/llps-noemail-users.csv">
</div>
</body>
</html>