<cfoutput>	
	<h2 class="sideTitle"><a href="#prc.settings.TheURL#/personal-injury" title="Personal Injury">Taylor Martino<br>Practice Areas</a></h2>
	<!---<img src="#prc.settings.TheURL#/includes/images/personal-injury-practice-areas.png" alt="Personal Injury Practice Areas" title="Personal Injury Practice Areas" style="magin-top: -3px;">--->
	<ul class="sidenav">
		<cfloop query="prc.PI"><li><a href="#prc.settings.theUrl#/#prc.PI.pagedir#/#prc.PI.pagename#">#prc.PI.pageLink#</a></li></cfloop>
	</ul>
	<h2 class="sideTitle"><a href="#prc.settings.TheURL#/cases" title="Personal Injury Lawsuits">Taylor Martino<br>Specialty Cases</a></h2>
	<ul class="sidenav">
		<cfloop query="prc.cases"><li><a href="#prc.settings.theUrl#/#prc.cases.pagedir#/#prc.cases.pagename#">#prc.cases.pageLink#</a></li></cfloop>
	</ul>
	<br>
	<a href="#prc.settings.TheURL#/about-injury-claims"><img src="/includes/images/about-injury-claims.jpg" alt="About Personal Injury claims" class="sideshadow"></a>
	<!---<br>
	<a href="##"><img src="/includes/images/recall-alerts.jpg" alt="Defective Product Recall Alerts" class="sideshadow"></a>--->
	<br>
	<!-- Start Of NGage -->
		<div id="nGageLH" style="visibility:hidden; display: block; padding: 0; z-index: 5000;"></div>
		<script type="text/javascript" src="https://messenger.ngageics.com/ilnksrvr.aspx?websiteid=15-208-29-101-75-158-159-174"></script>
	<!-- End Of NGage -->

</cfoutput>