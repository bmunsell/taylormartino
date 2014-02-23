<cfcomponent hint="I am a new Model Object" output="false" singleton>
	<cfproperty name="pageService" inject="ioc:pageList" type="ioc" scope="variables" />
	<cfproperty name="yt" inject="ioc:youTube" type="ioc" scope="variables" />
	<cfproperty name="rss" inject="ioc:rss" type="ioc" scope="variables" />
	<cfproperty name="SeoTitle" inject="ioc:SeoTitle" type="ioc" scope="variables" />
	<!---<cfproperty name="acl" inject="ioc:acl" type="ioc" required="true" />
	<cfproperty name="user" inject="ioc:user" type="ioc" required="true" />
	<cfproperty name="profileDAO" inject="ioc:profileDAO" type="ioc" required="true" />--->
<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<cffunction name="init" access="public" returntype="siteService" output="false" hint="constructor">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------->
	<cffunction name="adminSecure" access="public" returntype="any">
		<cfargument name="Username" type="string" required="yes">
        <cfargument name="Password" type="string" required="yes">
		<cfargument name="admin" type="string" required="yes">
		<cfargument name="dsn" type="string" default="tm" />
		<cfscript>
			var local = StructNew();
			
		</cfscript>
		<cfquery name="local.results" datasource="#arguments.dsn#">
            SELECT UserName, Pass, admin, FName, LName, UserID
            FROM Users
            WHERE username = <cfqueryparam value="#arguments.Username#" cfsqltype="cf_sql_varchar">
            AND pass = <cfqueryparam value="#arguments.Password#" cfsqltype="cf_sql_varchar">
			AND admin = <cfqueryparam value="#arguments.admin#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn local.results>
	</cffunction>
	
	<cffunction name="auth" access="public" returntype="any">
		<cfargument name="dsn" type="string" default="tm" />
		<cfargument name="url" type="string" default="tm.360webpath.com" />
		<cfargument name="Username" type="string" required="yes">
        <cfargument name="Password" type="string" required="yes">
		
		<cfscript>
			var local = StructNew();
			
		</cfscript>
        <!--- query the database for the username and password that were passed --->
        <cfquery name="verifyusername" datasource="#arguments.dsn#">
            SELECT UserName, Pass, admin, FName, LName, UserID
            FROM Users
            WHERE username = <cfqueryparam value="#arguments.Username#" cfsqltype="cf_sql_varchar">
            AND pass = <cfqueryparam value="#arguments.Password#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <!--- return the result --->
        <cfif verifyusername.recordCount>
            <cflogin idletimeout="3600" applicationtoken="tmlogin" cookiedomain="#arguments.url#">
            <cfloginuser 
                    name = "#verifyusername.fname# #verifyusername.lname#"
                    password ="#verifyusername.pass#"
                    roles = "#verifyusername.admin#">
        	</cflogin>
        	<cfquery datasource="#arguments.dsn#" name="SaveEdit">
  		 	UPDATE Users SET Last = #Now()# WHERE UserName=<cfqueryparam value="#arguments.Username#" cfsqltype="cf_sql_varchar">
 			</cfquery>
			<cfif IsUserInRole('admin')>
				<cflock scope="session" type="exclusive" timeout="120" throwontimeout="yes">
        		<cfset session.Username = verifyusername.UserName>
				<cfset session.FirstName = verifyusername.FName>
				<cfset session.LastName = verifyusername.LName>
				<cfset session.role = 'admin'>
				</cflock>
				<cfset local.result.role = 'admin'>
				<cfset local.result.error = 0>
        		<!---<cflocation url="/admin/index.cfm" addtoken="yes">--->
        	</cfif>
            <cfif IsUserInRole('user')>
				<cflock scope="session" type="exclusive" timeout="120" throwontimeout="yes">
        		<cfset session.Username = verifyusername.UserName>
				<cfset session.FirstName = verifyusername.FName>
				<cfset session.LastName = verifyusername.LName>
				<cfset session.role = 'user'>
				</cflock>
				<cfset local.result.role = 'user'>
				<cfset local.result.error = 0>
        		<!---<cflocation url="/users/index.cfm" addtoken="yes">--->
        	</cfif>
        	
        <cfelse>
			<cfset local.result.role = 'none'>
			<cfset local.result.error = 1>
        </cfif>
        
		<cfreturn local.result>
	</cffunction>
	
	
	<cffunction name="getNews" access="public" returntype="any">
		<cfargument name="dsn" type="string" default="tm" />
		<cfargument name="videoUser" type="string" default="holtonmediagroup" />
		
		<cfscript>
			var local = StructNew();
			local.sidenews = pageService.GetNews(MaxRows=10,orderBy='isSticky Desc, PageDate Desc');
			local.video = yt.getVideosByUser('#arguments.videoUser#');
			local.newsAll = QueryNew("Title,Text,Img,Link,Type,PDate");
			for( i=1; I LTE local.video.recordCount; i++ ) { 
				if(not len(local.video.THUMBNAIL_URL[i])) {
					local.myImg = '/images/no-image.png';
				} else {
					local.myImg = local.video.THUMBNAIL_URL[i];
				}
						local.myID = Replace(local.video.ID[i], 'http://gdata.youtube.com/feeds/api/videos/', '');
						local.myDate = CreateODBCDateTime(local.video.published[i]);
						queryAddRow(local.newsAll,1);
						querySetCell(local.newsAll,"Title","#local.video.title[i]#");
						querySetCell(local.newsAll,"Text","#local.video.description[i]#");
						querySetCell(local.newsAll,"Img","#local.myImg#");
						querySetCell(local.newsAll,"Link","/videos/#local.myID#/#seotitle.maketitle(str='#local.video.title[i]#')#");
						querySetCell(local.newsAll,"Type","Video");
						querySetCell(local.newsAll,"PDate","#local.myDate#");
					}
			for( i=1; I LTE local.sidenews.recordCount; i++ ) { 
				if(not len(local.sidenews.PAGEIMAGE[i])) {
					local.myImg = '/images/no-image.png';
				} else {
					local.myImg = '/inc/images/#local.sidenews.PAGEIMAGE[i]#';
				}
						local.myDate = CreateODBCDateTime(local.sidenews.PageDate[i]);
						queryAddRow(local.newsAll,1);
						querySetCell(local.newsAll,"Title","#local.sidenews.PAGETITLE[i]#");
						querySetCell(local.newsAll,"Text","#Left(local.sidenews.PageText[i], 300)#");
						querySetCell(local.newsAll,"Img","#local.myImg#");
						querySetCell(local.newsAll,"Link","/news/#Year(Now())#/#local.sidenews.PageName#");
						querySetCell(local.newsAll,"Type","#local.sidenews.PageType[i]#");
						querySetCell(local.newsAll,"PDate","#local.myDate#");
					}
		</cfscript>
		
		<cfquery name="local.newsFinal" dbtype="query">
			SELECT *
			FROM newsAll
			Order by PDate Desc
		</cfquery>
		
		<cfreturn local.newsFinal>
	</cffunction>
	
	<cffunction name="getScores" access="public" returntype="any">
		<cfargument name="dsn" type="string" default="tm" />
		
		<cfscript>
			var local = StructNew();
		</cfscript>
		
		<cfquery name="local.Scores" datasource="#arguments.dsn#">
			SELECT *
			FROM Scores
			Order by ScoreID Desc
		</cfquery>
		
		<cfreturn local.Scores>
	</cffunction>
	<!---Ads--->
	<cffunction name="getAd" access="public" returntype="any">
		<cfargument name="dsn" type="string" default="tm" />
		<cfargument name="BannerType" type="numeric" required="true" />
		<cfargument name="maxrows" type="numeric" default="1" />
		
		<cfscript>
			var local = StructNew();
		</cfscript>
		<cfquery name="local.ad" datasource="#arguments.dsn#" maxrows="#arguments.maxrows#">
			SELECT *
			FROM Banners
			Where BannerType = <cfqueryparam value="#arguments.BannerType#" cfsqltype="cf_sql_integer">
			Order by Rand()
		</cfquery>
		<cfreturn local.ad>
	</cffunction>
	
	<!---Polls--->
	<cffunction name="GetQuestions" access="public" returntype="any">
		<cfargument name="dsn" type="string" default="tm" />
		
		<cfscript>
			var local = StructNew();
		</cfscript>
		
		<cfquery name="local.Questions" datasource="#arguments.dsn#" maxrows="1">
			SELECT *
			FROM Polls
			Order by PollID Desc
		</cfquery>
		
		<cfreturn local.Questions>
	</cffunction>
	
	<cffunction name="GetAnswers" access="public" returntype="any">
		<cfargument name="dsn" type="string" default="tm" />
		<cfargument name="pollID" type="numeric" default="tm" />
		
		<cfscript>
			var local = StructNew();
		</cfscript>
		
		<cfquery name="local.answers" datasource="#arguments.dsn#">
			Select *
			From PollAnswers
			Where PollID = <cfqueryparam value="#arguments.PollID#" cfsqltype="cf_sql_integer">
			Order by AnswerID Asc
		</cfquery>
		
		<cfreturn local.answers>
	</cffunction>
	


</cfcomponent>	
