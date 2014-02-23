<div class="article">
	<h1>Taylor Martino Website Search Results</h1>		
	<cfif isDefined('prc.results.recordcount') AND prc.results.recordcount>
		<ul class="theNews">
		<cfoutput query="prc.results" maxrows="15" >
			<cfif prc.results.PageDir EQ prc.results.PageName>
				<cfset myLink = '/#prc.results.PageName#'>
			<cfelseif prc.results.PageName EQ 'home'>
				<cfset myLink = getSetting('websiteURL')>
			<cfelse>
				<cfset myLink = '#getSetting('websiteURL')#/#prc.results.PageDir#/#prc.results.PageName#'>
			</cfif>		
				<li><a href="#myLink#" title="#prc.results.PageTitle#">
					<cfif PageImage is not ''>
					<img src="/#getSetting('imageURL')#/th-#prc.results.PageImage#" alt="#prc.results.PageTitle#" title="#prc.results.PageTitle#">
					</cfif>
					<p><strong>#prc.results.PageTitle#</strong><br>
					<span class="myDate">#DateFormat(prc.results.PageDate, 'long' )#<br></span>
					#prc.results.PageDescription#</p></a></li>
		</cfoutput>
		</ul>
		<cfelse>
			<p>We're sorry we couldn't find any search results. Please <a href="#getSetting('websiteurl')#/contact">contact us</a> for more information.</p>
	</cfif>
</div>
