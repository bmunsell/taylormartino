<cfset imagepath="/var/www/gulfsportsnet.com/html/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
<h2>Saving Banner....</h2>
  <cfquery name="add">   
    INSERT INTO Banners (BannerLink, BannerType, Banner)
VALUES (<cfif IsDefined("FORM.BannerLink") AND #FORM.BannerLink# NEQ "">
<cfqueryparam value="#FORM.BannerLink#" cfsqltype="cf_sql_clob">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.BannerType") AND #FORM.BannerType# NEQ "">
<cfqueryparam value="#FORM.BannerType#" cfsqltype="cf_sql_integer">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ "">
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfif FORM.BannerType is 2>
<cfimage action="resize" source="#imagepath#/#FileName#" width="300" height="" destination="#imagepath#/#FileName#" overwrite="true">
<cfelse>
<cfimage action="resize" source="#imagepath#/#FileName#" width="729" height="90" destination="#imagepath#/#FileName#" overwrite="true">
</cfif>
<cfqueryparam value="#FileName#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
)
</cfquery>
<cflocation url="banners.cfm?add=yes">
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
<h2 align="center">Add Banner</h2>
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
        <table width="387" align="center" cellspacing="5">
          <tr>
          <td width="71%" colspan="2" class="formtext">
            	<h2>Client:<br>
            	  <span class="forminput">
            	  <cfinput type="text" name="BannerClient" message="Please enter a Name" required="yes" size="30">
            	  </span></h2></td>
                  </tr>
                  <tr>
            <td colspan="2" class="formtext"><h2>Link:<br>
            	  <span class="forminput">
            	  <cfinput type="text" name="BannerLink" message="Please enter a Link" required="yes" size="30">
            	</span></h2>
              i              e. http://www.baumhowers.com </td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h2>Banner:<br>
            	  <span class="forminput">
            	  <cfinput type="file" name="Photo" size="30">
           	</span></h2></td>
          </tr>
         
          <tr>
            <td width="117" class="formtext"><h2>Banner Type:<br>
            </h2></td>
            <td width="249" class="formtext"><h2>
              <label>
                <input type="radio" name="BannerType" value="1" id="BannerType_0">
                Top 728x90<br>
                <br>
              </label>
              <label>
                <input type="radio" name="BannerType" value="2" id="BannerType_1" >
                Sidebar 300 W</label>
            </h2></td>
          </tr>
          <tr>
            <td colspan="2" align="center" class="formtext"><span class="forminput">
              <input type="submit" value="Save Banner">
            </span></td>
          </tr>
        </table>
        <input type="hidden" name="MM_InsertRecord" value="form1">
      </cfform>
      <p>&nbsp;</p>

  <!-- end .container --></div>
</body>
</html>