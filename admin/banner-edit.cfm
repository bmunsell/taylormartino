<cfset DTS = #CreateODBCDateTime(now())#>
<cfparam name="bid" default="1">
<cfif IsDefined('url.bid')>
<cfset bid = #url.bid#>
</cfif>
<cfif IsDefined('FORM.bid')>
<cfset bid = #FORM.bid#>
</cfif>
<cfset imagepath="/var/www/gulfsportsnet.com/html/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
<h2>Saving Banner....</h2>
<cfquery name="update">   
UPDATE Banners
SET BannerLink = <cfqueryparam value="#FORM.BannerLink#" cfsqltype="cf_sql_clob" maxlength="500">
, BannerType = <cfqueryparam value="#FORM.BannerType#" cfsqltype="cf_sql_integer">
, BannerClient = <cfqueryparam value="#FORM.BannerClient#" cfsqltype="cf_sql_clob" maxlength="250">
<cfif IsDefined("FORM.Photo") AND #FORM.Photo# NEQ ""> 
<cffile action="upload" destination="#imagepath#" filefield="Photo" nameconflict="makeunique">
<cfset FileName = "#file.ServerFile#">
<cfif FORM.BannerType is 2>
<cfimage action="resize" source="#imagepath#/#FileName#" width="300" height="" destination="#imagepath#/#FileName#" overwrite="true">
<cfelse>
<cfimage action="resize" source="#imagepath#/#FileName#" width="729" height="90" destination="#imagepath#/#FileName#" overwrite="true">
</cfif>
, Banner = <cfqueryparam value="#FileName#" cfsqltype="cf_sql_clob" maxlength="250">
</cfif>
WHERE BannerID=#FORM.save_edit#
  </cfquery>
  <cflocation url="banners.cfm?edit=yes">
</cfif>

<cfquery name="GetBanner">
Select *
From Banners
WHERE BannerID = <cfqueryparam value="#bid#" cfsqltype="cf_sql_integer">
</cfquery>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>GSN Banner Admin</title>
<link href="/scores/admin.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="container">
  <h3 align="center">Edit Banner</h3>
      <cfform method="post" name="form1" action="#CGI.SCRIPT_NAME#" enctype="multipart/form-data">
        <table width="320" align="center" cellspacing="5">
        <tr>
            <td width="71%" colspan="2" class="formtext">
            	<h2>Client:<br>
            	  <span class="forminput">
            	  <cfinput type="text" name="BannerClient" message="Please enter a Name" required="yes" size="30" value="#GetBanner.BannerClient#">
            	  </span></h2></td>
          </tr>
          <tr>
            <td width="71%" colspan="2" class="formtext">
            	<h2>Link:<br>
            	  <span class="forminput">
            	  <cfinput type="text" name="BannerLink" message="Please enter a Link" required="yes" size="30" value="#GetBanner.BannerLink#">
            	  </span></h2>
           	ie: http://www.baumhowers.com            </td>
          </tr>
          <tr>
            <td colspan="2" class="formtext"><h2>Banner:<br>
            	  <span class="forminput">
            	  <cfinput type="file" name="Photo" size="30">
           	</span></h2></td>
          </tr>
         <tr>
            <td class="formtext"><h2>Banner Type:</h2></td>
            <td class="formtext"><label>
              <input type="radio" name="BannerType" value="1" id="BannerType_0"<cfif GetBanner.BannerType is 1> checked</cfif>>
              <strong>Top</strong></label>
              <strong>
              <label> 728x90px</label>
              </strong>
              <label><br>
                <br>
                <input type="radio" name="BannerType" value="2" id="BannerType_1"<cfif GetBanner.BannerType is 0> checked</cfif>>
              <strong>Sidebar 300 width</strong></label></td> 
          </tr>
          <tr>
            <td colspan="2" align="center" class="formtext"><span class="forminput">
              <input type="submit" value="Save Banner">
            </span></td>
          </tr>
         <tr>
            <td colspan="2"><span class="formtext">Current Image:<br>
            <cfoutput><img src="/images/#GetBanner.Banner#" width="300"></cfoutput>
            </span></td>
          </tr>
        </table>
        <cfinput type="hidden" name="save_edit" value="#GetBanner.BannerID#">
      <input type="hidden" name="MM_InsertRecord" value="form1">
</cfform>
      <p>&nbsp;</p>

  <!-- end .container --></div>
</body>
</html>