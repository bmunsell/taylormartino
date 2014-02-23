<cfscript>
	// Allow unique URL or combination of URLs, we recommend both enabled
	setUniqueURLS(false);
	// Auto reload configuration, true in dev makes sense to reload the routes on every request
	//setAutoReload(false);
	// Sets automatic route extension detection and places the extension in the rc.format variable
	// setExtensionDetection(true);
	// The valid extensions this interceptor will detect
	// setValidExtensions('xml,json,jsont,rss,html,htm');
	// If enabled, the interceptor will throw a 406 exception that an invalid format was detected or just ignore it
	// setThrowOnInvalidExtension(true);

	// Base URL
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("http://#cgi.HTTP_HOST#/");
	}
	else{
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm");
	}

	
	
	// Your Application Routes
	addRoute(pattern="/attorneys/:SubPage.PageDir/", handler="Attorneys", action="attorney");
	addRoute(pattern="/attorneys/", handler="Attorneys", action="index");
	addRoute(pattern="/lawyers/:SubPage.PageDir/", handler="Attorneys", action="attorney");
	addRoute(pattern="/lawyers/", handler="Attorneys", action="index");
	
	addRoute(pattern="/cms/admin/:action", handler="CMS.Admin", action=":action");
	addRoute(pattern="/cms/page/:action", handler="CMS.Page", action=":action");
	addRoute(pattern="/cms/subpage/:action", handler="CMS.SubPage", action=":action");
	addRoute(pattern="/cms/:handler/:action", handler="CMS.:handler", action=":action");
	addRoute(pattern="/cms/", handler="CMS.Admin", action="index");
	
	addRoute(pattern="/contact/thankyou", handler="Contact", action="thankyou");
	addRoute(pattern="/contact/send", handler="Contact", action="send");
	addRoute(pattern="/contact/", handler="Contact", action="index");
	
	addRoute(pattern="/login/", handler="Login", action="index");	
	addRoute(pattern="/logout/", handler="General", action="Logout");	
	
	addRoute(pattern="/news/:year-numeric/:PageName", handler="News", action="article");
	addRoute(pattern="/news/:year-numeric", handler="News", action="year");
	addRoute(pattern="/news/", handler="News", action="index");
	addRoute(pattern="/injury-news/", handler="News", action="index");
	
	addRoute(pattern="/photos/:Gallery.Name", handler="Photos", action="gallery");
	addRoute(pattern="/photos/", handler="Photos", action="index");

	addRoute(pattern="/search/", handler="Search", action="results");
	
	addRoute(pattern="/videos/:id", handler="Videos", action="detail");
	addRoute(pattern="/videos/", handler="Videos", action="index");	
	
	addRoute(pattern="/:Page.PageDir/:SubPage.PageDir/", handler="Pages", action="subpage");
	addRoute(pattern="/:Page.PageDir/", handler="Pages", action="index");
	addRoute(pattern="/", handler="General", action="index");


	/** Developers can modify the CGI.PATH_INFO value in advance of the SES
		interceptor to do all sorts of manipulations in advance of route
		detection. If provided, this function will be called by the SES
		interceptor instead of referencing the value CGI.PATH_INFO.

		This is a great place to perform custom manipulations to fix systemic
		URL issues your Web site may have or simplify routes for i18n sites.

		@Event The ColdBox RequestContext Object
	**/
	function PathInfoProvider(Event){
		/* Example:
		var URI = CGI.PATH_INFO;
		if (URI eq "api/foo/bar")
		{
			Event.setProxyRequest(true);
			return "some/other/value/for/your/routes";
		}
		*/
		return CGI.PATH_INFO;
	}
</cfscript>
