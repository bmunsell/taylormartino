<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfset imagepath="/var/www/gulfsportsnet.com/html/inc/images">
<cfset thumbpath="/var/www/gulfsportsnet.com/html/images">
<cfparam name="myyear" default="#Year(Now())#" />
<cfparam name="mymonth" default="#Month(Now())#" />
<cfquery name="GetNews">
Select *
From news
Order By NewsID
</cfquery>


<cfif GetNews.RecordCount GT 0>
<cfloop query="GetNews">
  <cfquery result="pinsert">   
    INSERT INTO Posts (PageTitle, PageDescription, PageImage, PageName, PageDir, PageText, PageDate, PageLast, UserID, LUserID)
VALUES (<cfif IsDefined("GetNews.NName") AND #GetNews.NName# NEQ "">
<cfqueryparam value="#Trim(GetNews.NName)#" cfsqltype="cf_sql_clob" maxlength="70">
<cfelse>
''
</cfif>
, <cfif IsDefined("GetNews.NIntro") AND #GetNews.NIntro# NEQ "">
<cfqueryparam value="#Trim(GetNews.NIntro)#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, <cfif IsDefined("GetNews.NPhoto") AND #GetNews.NPhoto# NEQ "">
<cfqueryparam value="#Trim(GetNews.NPhoto)#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
<cfset PName = Replace(GetNews.NName, ' ', '-', 'all')>
<cfset PName = Replace(PName, '?', '', 'all')>
<cfset PName = Replace(PName, '.', '', 'all')>
<cfset PName = Replace(PName, '!', '', 'all')>
<cfset PName = Replace(PName, '##', '', 'all')>
<cfset PName = Replace(PName, '$', '', 'all')>
<cfset PName = Replace(PName, '%', '', 'all')>
<cfset PName = Replace(PName, '*', '', 'all')>
<cfset PName = Replace(PName, '/', '', 'all')>
<cfset PName = Replace(PName, '\', '', 'all')>
<cfset PName = Replace(PName, '~', '', 'all')>
<cfset PName = Replace(PName, '@', '', 'all')>
<cfset PName = Replace(PName, '^', '', 'all')>
<cfset PName = Replace(PName, '+', '', 'all')>
<cfset PName = Replace(PName, ',', '', 'all')>
<cfset PName = Replace(PName, ';', '', 'all')>
<cfset PName = Replace(PName, ':', '', 'all')>
<cfset PName = Replace(PName, '"', '', 'all')>
<cfset PName = Replace(PName, "'", "", "all")>
<cfset PName = Replace(PName, '(', '-', 'all')>
<cfset PName = Replace(PName, ')', '-', 'all')>
<cfset PName = LCase(PName)>
, <cfqueryparam value="#PName#" cfsqltype="cf_sql_clob" maxlength="100">
, <cfqueryparam value="news/#myyear#" cfsqltype="cf_sql_clob" maxlength="100">
, <cfif IsDefined("GetNews.NText") AND #GetNews.NText# NEQ "">
<cfset PText = Replace(GetNews.NText, '   ', '', 'all')>
<cfset PText = Replace(PText, '  ', ' ', 'all')>
<cfset PText = REReplace(PText,"#chr(13)#|\n|\r|\t","","ALL")>
<cfqueryparam value="#Trim(PText)#" cfsqltype="cf_sql_clob" maxlength="2147483647">
<cfelse>
''
</cfif>
, <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
, <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
, <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
, <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
)
</cfquery>
</cfloop>
  <cflocation url="posts.cfm?add=yes">
</cfif>
