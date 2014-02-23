<cfoutput>
	<div class="article">
		<div class="vtitle2"><h1>#prc.article.PageTitle#</h1></div>
		<cfif len(prc.article.PageImage) and prc.article.showImage>
			<ul class="gallery">
				<li><a href="/inc/images/#prc.article.PageImage#" rel="prettyPhoto" title="#prc.article.PageTitle#"><img src="/inc/images/th-#prc.article.PageImage#" class="shadow" alt="#prc.article.PageTitle#" title="#prc.article.PageTitle#" /></a></li>	
			</ul>
		</cfif>
		#prc.article.PageText#
	</div>
</cfoutput>