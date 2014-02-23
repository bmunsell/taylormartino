<cfoutput>
<div class="article">
	<div class="vtitle2"><h1>#prc.current.PageTitle#</h1></div>
	#prc.current.PageText#
</div>
<div class="article">
	<ul class="theNews">
	<cfloop query="prc.news" >			
			<li><a href="/news/#Year(prc.news.PageDate)#/#prc.news.PageName#" title="#prc.news.PageTitle#">
				<cfif PageImage is not ''>
				<img src="/inc/images/th-#prc.news.PageImage#" alt="#prc.news.PageTitle#" title="#prc.news.PageTitle#">
				<cfelse>
					<img src="/includes/images/Taylor-Martino-Mobile-Alabama.png" alt="#prc.news.PageTitle#" title="#prc.news.PageTitle#">
				</cfif>
				<p><strong>#prc.news.PageTitle#</strong><br>
				<span class="myDate">#DateFormat(prc.news.PageDate, 'long' )#<br></span>
				#prc.news.PageDescription#</p></a></li>
	</cfloop>
	</ul>
	<div class="breadcrumbs">
		<a href="<cfoutput>#getSetting("websiteUrl")#/news/</cfoutput>">Taylor Martino News</a> Archive: 
		<cfloop query="prc.years"><cfif theYear neq Year(Now())>
				<cfif theYear eq rc.year>
					 #theYear# |
				<cfelse>
					<a href="#getSetting("websiteUrl")#/news/#theYear#" title="Taylor Martino #theYear# News"> #theYear#</a> | 
				</cfif>
			</cfif>
		</cfloop>
	</div>
</div>
<!---<cfloop array="prc.myPosts" index="i">#prc.myPosts.postID[i]#<br></cfloop>--->
</cfoutput>