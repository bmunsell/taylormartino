<cfoutput>
	<!---<cfif prc.currentpage.PageImage is not ''>
		<ul class="gallery">
			<li><a href="/inc/images/#prc.currentpage.PageImage#" rel="prettyPhoto" title="#prc.currentpage.PageTitle#"><img src="/inc/images/th-#prc.currentpage.PageImage#" class="shadow" alt="#prc.currentpage.PageTitle#" title="#prc.currentpage.PageTitle#" /></a></li>	
		</ul>			
	</cfif>--->
	<div class="article">#prc.currentpage.PageText#</div>
	<cfif isDefined('prc.subs') AND prc.subs.recordcount GT 0>
		<div class="article">
				<cfloop query="prc.subs">
					<div style="width: 35%;float:left;">
						<a href="/#prc.subs.PageDir#/#prc.subs.PageName#" title="#prc.subs.PageName#"><img src="/inc/images/th-#prc.subs.PageImage#" height="200" class="shadowNF" title="#prc.subs.PageName#" alt="#prc.subs.PageName#"></a></td>
					</div>	
					<div style="width: 59%;float:left;padding-left:3%;padding-right:3%;padding-top:1%">
						<h2><a href="/#prc.subs.PageDir#/#prc.subs.PageName#" title="#prc.subs.PageName#">#prc.subs.PageLink#</a></h2>#Left(prc.subs.PageDescription, 500)#...<br><a href="/#prc.subs.PageDir#/#prc.subs.PageName#" title="#prc.subs.PageName#">Click here for full Attorney profile.</a></td>
					</div>
					<br clear="all">
					<hr>				
				</cfloop>			
			<!---<h2 align="center">More #prc.currentpage.PageLink#</h2>--->
			<!---<ul class="sublist"><cfloop query="prc.subs">
				<li><a href="/#prc.subs.PageDir#/#prc.subs.PageName#" title="#prc.subs.PageName#"><img src="/inc/images/th-#prc.subs.PageImage#" class="shadowNF" title="#prc.subs.PageName#" alt=" title="#prc.subs.PageName#""><br clear="all"><p>#prc.subs.PageLink#</p></a></li></cfloop>
			</ul>--->
		</div>
	</cfif>
</cfoutput>