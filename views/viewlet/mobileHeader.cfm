<div id="spinner"></div>

<cfoutput>
<header>	
<div class="logodiv"><a href="#getSetting('websiteUrl')#"><img src="/includes/images/logo.png" alt="" id="logo"/></a></div>	
</header>

<a href="#prc.mLink#" id="BackBtn" class="btn">#prc.mName#</a>

<div id="MenuBtn" class="btn" >Menu</div>

<ul id="MainNav">
	<cfloop query="prc.cats" >
	<li><a href="#getSetting('websiteUrl')#/#prc.cats.PageDir#">#prc.cats.PageLink#</a></li>
	</cfloop>
	
</ul>
</cfoutput>