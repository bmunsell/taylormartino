<cfoutput>
<div class="article">
	<cfif len(prc.subpage.PageImage) and prc.subpage.showImage>
		<ul class="gallery">
			<li><a href="/inc/images/#prc.subpage.PageImage#" rel="prettyPhoto" title="#prc.subpage.PageTitle#"><img src="/inc/images/th-#prc.subpage.PageImage#" class="shadow" alt="#prc.subpage.PageTitle#" title="#prc.subpage.PageTitle#" /></a></li>	
		</ul>					
	</cfif>
	#prc.subpage.PageText#
</div><!---End Article--->
</cfoutput>