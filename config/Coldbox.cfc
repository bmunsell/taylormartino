<cfcomponent output="false" hint="My App Configuration">
<cfscript>
/**
structures/arrays to create for configuration

- coldbox (struct)
- settings (struct)
- conventions (struct)
- environments (struct)
- ioc (struct)
- models (struct) DEPRECATED use Wirebox instead
- wirebox (struct)
- debugger (struct)
- mailSettings (struct)
- i18n (struct)
- bugTracers (struct)
- webservices (struct)
- datasources (struct)
- layoutSettings (struct)
- layouts (array of structs)
- cacheBox (struct)
- interceptorSettings (struct)
- interceptors (array of structs)
- modules (struct)
- logBox (struct)

Available objects in variable scope
- controller
- logBoxConfig
- appMapping (auto calculated by ColdBox)

Required Methods
- configure() : The method ColdBox calls to configure the application.
Optional Methods
- detectEnvironment() : If declared the framework will call it and it must return the name of the environment you are on.
- {environment}() : The name of the environment found and called by the framework.

*/
	
	// Configure ColdBox Application
	function configure(){
	
		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "www.taylormartino.com",
			eventName 				= "event",
			
			//Development Settings
			debugMode				= false,
			debugPassword			= "360",
			reinitPassword			= "360",
			handlersIndexAutoReload = false,
			configAutoReload		= false,
			
			//Implicit Events
			defaultEvent			= "General.index",
			requestStartHandler		= "Main.onRequestStart",
			requestEndHandler		= "Main.onRequestEnd",
			applicationStartHandler = "Main.onApplicationStart",
			applicationEndHandler	= "Main.onApplicationEnd",
			sessionStartHandler 	= "Main.onSessionStart",
			sessionEndHandler		= "Main.onSessionEnd",
			missingTemplateHandler	= "Main.onMissingTemplate",
			
			//Extension Points
			UDFLibraryFile 				= "includes/helpers/ApplicationHelper.cfm",
			coldboxExtensionsLocation 	= "",
			modulesExternalLocation		= [],
			pluginsExternalLocation 	= "",
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			
			//Error/Exception Handling
			//exceptionHandler		= "Main.onException",
			//onInvalidEvent			= "Main.onInvalidEvent",
			customErrorTemplate		= "views/404.cfm",
				
			//Application Aspects
			handlerCaching 			= true,
			eventCaching			= true,
			proxyReturnCollection 	= false,
			flashURLPersistScope	= "session"	
		};
	
		// custom settings
		// Default setting are for production
	settings = {
		datasource = "tm",
		websiteUrl = "http://www.taylormartino.com",
		imageUrl = "inc/images",
		imagepath = "/var/www/taylormartino.com/html/inc/images",
		thumbpath = "/var/www/taylormartino.com/html/inc/images",
		thumbWidth = "320",
		companyName = "Taylor Martino",
		emailList = "suely@taylormartino.com;bill@360webpath.com",
		defaultImage = "includes/images/Taylor-Martino-Mobile-Alabama.png"
	};
		
		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
		staging = "360webpath.com",
		development = ".*local"
	};
		
		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = false,
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = [] 
		};
		
		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				coldboxTracer = { class="coldbox.system.logging.appenders.ColdboxTracerAppender" }
			},
			// Root Logger
			root = { levelmax="INFO", appenders="*" },
			// Implicit Level Categories
			info = [ "coldbox.system" ] 
		};
		
		//Layout Settings
		layoutSettings = {
			defaultLayout = "Layout.Main.cfm"
		};
		
		//WireBox Integration
		wireBox = { 
			enabled = true,
			//binder="config.WireBox", 
			singletonReload=false 
		};
		
		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = false,
			customInterceptionPoints = ""
		};
		
		//Register interceptors as an array, we need order
		interceptors = [
			//Autowire
			{class="coldbox.system.interceptors.Autowire",
			 properties={}
			},
			//SES
			{class="coldbox.system.interceptors.SES",
			 properties={}
			}, 
			{ class="interceptors.SimpleSecurity" }
		];
		
		ioc = {
	    framework = "coldspring",
	    reload     = true,
	    objectCaching = false,
	    definitionFile  = "config/coldspring.xml.cfm"
    }; 
		
		/*
			
		//Conventions
		conventions = {
			handlersLocation = "handlers",
			pluginsLocation  = "plugins",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modelsLocation 	 = "model",
			modulesExternalLocation  = "",
			eventAction 	 = "index"
		};
		
		//Debugger Settings
		debugger = {
			enableDumpVar = false,
			persistentRequestProfilers = true,
			maxPersistentRequestProfilers = 10,
			maxRCPanelQueryRows = 50,
			//Panels
			showTracerPanel = true,
			expandedTracerPanel = true,
			showInfoPanel = true,
			expandedInfoPanel = true,
			showCachePanel = true,
			expandedCachePanel = true,
			showRCPanel = true,
			expandedRCPanel = true,
			showModulesPanel = true,
			expandedModulesPanel = false
		};
		
		//Mailsettings
		mailSettings = {
			server = "",
			username = "",
			password = "",
			port = 25
		};
		
		//i18n & Localization
		i18n = {
			defaultResourceBundle = "includes/i18n/main",
			defaultLocale = "en_US",
			localeStorage = "session",
			unknownTranslation = "**NOT FOUND**"		
		};
		
		//bug tracers
		bugTracers = {
			enabled = false,
			bugEmails = "",
			mailFrom = "",
			customEmailBugReport = ""
		};
		
		//webservices
		webservices = {
			testWS = "http://www.test.com/test.cfc?wsdl",
			AnotherTestWS = "http://www.coldbox.org/distribution/updatews.cfc?wsdl"	
		};
		
		//Datasources
		datasources = {
			mysite   = {name="mySite", dbType="mysql", username="root", password="pass"},
			blog_dsn = {name="myBlog", dbType="oracle", username="root", password="pass"}
		};
		*/

	}

//Executed whenever the environments are detected
function staging(){
	// Override coldbox directives
	coldbox.debugMode = false;
	coldbox.handlerCaching = false;
	coldbox.eventCaching = false;	
	//coldbox.handlersIndexAutoReload = false;
	coldbox.exceptionHandler		= "";
	coldbox.onInvalidEvent			= "";
	coldbox.customErrorTemplate		= "";
	settings.datasource = "tm";
	settings.websiteUrl = "http://tm.360webpath.com";
	settings.imagepath = "/var/www/taylormartino.com/html/inc/images";
	settings.thumbpath = "/var/www/taylormartino.com/html/inc/images";
	
}

//Executed whenever the environments are detected
function development(){
	// Override coldbox directives
	coldbox.debugMode = true;
	coldbox.handlerCaching = false;
	coldbox.eventCaching = false;	
	//coldbox.handlersIndexAutoReload = false;
	coldbox.exceptionHandler		= "";
	coldbox.onInvalidEvent			= "";
	coldbox.customErrorTemplate		= "";
	settings.datasource = "tm";
	settings.websiteUrl = "http://www.tm.local";
	settings.imagepath = "b:\inetpub\wwwroot\taylormartino.com\inc\images";
	settings.thumbpath = "b:\inetpub\wwwroot\taylormartino.com\inc\images";
}

</cfscript>
</cfcomponent>