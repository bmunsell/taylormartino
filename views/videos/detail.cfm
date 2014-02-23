<cfoutput>
<div class="content">
<div class="article">
	<div class="vtitle2"><h1 align="center">#prc.video.title#</h1></div>
	<div style="margin-left: 15px;">
	<iframe class="youtube-player" type="text/html" width="640" height="442" src="http://www.youtube.com/embed/#rc.id#?autoplay=1&fs=1&hl=en_US&feature=player_embedded&version=3&rel=0" frameborder="0">
	</iframe>
	</div>
	<p>#prc.video.content#</p>
</div>
<div class="article">
	<ul id="ytcarousel" class="jcarousel-skin-yt" style="list-style-type: none; margin-left: 10px;">
		<cfloop query="prc.user" startrow="1" endrow="#prc.user.recordcount#">
		<cfoutput>
			<cfset v = Right(prc.user.id, 11)>
			<li class="ytThumb">
				<a href="/videos/#v#">
				<img src="#prc.user.thumbnail_url#" width="122" border="0" /><br />
				#prc.user.TITLE#
				</a>
			</li>
		</cfoutput>
		</cfloop>
	</ul>
</div>
</div>
</cfoutput>