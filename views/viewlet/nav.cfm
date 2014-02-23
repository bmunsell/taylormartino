<!---<div class="menuHolder">
	<ul id="MenuBar1" class="MenuBarHorizontal">
		<cfloop query="prc.cats">
			<cfquery name="subcats" datasource="#getSetting('datasource')#">
				SELECT PageDir,PageLink,PageID,PageName,DOrder,SubPageID
				FROM SubPages
				Where PageID = <cfqueryparam value="#prc.cats.PageID#" cfsqltype="cf_sql_integer" >
				AND isActive = 1
				ORDER BY DOrder
			</cfquery><cfoutput><cfprocessingdirective suppresswhitespace="true" >
			<cfif subcats.RecordCount GT 0><li><a class="MenuBarItemSubmenu" href="#prc.settings.theUrl#/#prc.cats.PageDir#">#prc.cats.PageLink#</a>
        			<ul><cfloop query="subcats">
         				<li><a href="#prc.settings.theUrl#/#subcats.PageDir#/#subcats.PageName#">#subcats.PageLink#</a></li></cfloop>
        			</ul>
				</li>
				<cfelse><li><a href="#prc.settings.theUrl#/#prc.cats.PageDir#">#prc.cats.PageLink#</a></li></cfif></cfprocessingdirective></cfoutput></cfloop>
		<li style="margin-left: 100px;padding-top: 10px;color: white;">Toll Free: 1-800-256-7728</li>
    </ul>
    <br clear="all">
</div>--->
<cfoutput>
<ul>
	<cfloop query="prc.cats">
	<cfquery name="subcats" datasource="#getSetting('datasource')#">
		SELECT PageDir,PageLink,PageID,PageName,DOrder,SubPageID
		FROM SubPages
		Where PageID = <cfqueryparam value="#prc.cats.PageID#" cfsqltype="cf_sql_integer" >
		AND isActive = 1
		ORDER BY DOrder
	</cfquery>
<cfif subcats.RecordCount GT 0>
	<li class="has-sub"><a href="#prc.settings.theUrl#/#prc.cats.PageDir#"><span>#prc.cats.PageLink#</span></a>
		<ul><cfset mySubcount = 1>
		<cfloop query="subcats">
			<li<cfif subcats.recordcount EQ mySubcount> class="last"</cfif>><a href="#prc.settings.theUrl#/#subcats.PageDir#/#subcats.PageName#"><span>#subcats.PageLink#</span></a></li>
		<cfset mySubcount = mySubcount + 1></cfloop>
		</ul>
	</li>
<cfelse>
   <li><a href="#prc.settings.theUrl#/#prc.cats.PageDir#"><span>#prc.cats.PageLink#</span></a></li>
</cfif>
	</cfloop>
   <li class="last" style="float: right;margin-right: 1%;"><a href='tel:18002567728'><span>Toll Free: 1-800-256-7728</span></a></li>
</ul>
</cfoutput>