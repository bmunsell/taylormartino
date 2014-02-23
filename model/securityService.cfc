component accessors="true" singleton{
	
	// Dependencies
	property name="sessionStorage" 	inject="coldbox:plugin:SessionStorage";
	property name="siteService" inject="model:siteService" type="model" scope="variables";
	
	/**
	* Constructor
	*/
	public SecurityService function init(){
		
		/*variables.username = "luis";
		variables.password = "coldbox";*/
		
		return this;
	}
	
	/**
	* Authorize with basic auth
	*/
	function authorize(username,password){
		var local = StructNew();
		local.username = arguments.username;
		local.password = arguments.password;
		local.login=siteService.adminSecure(username=local.username,password=local.password,admin='admin');
		
		// Validate Credentials, we can do better here
		if( isDefined('local.login.recordcount') AND local.login.recordcount ){
			// Set simple validation
			sessionStorage.setVar("userAuthorized",  true );
			return true;
		}
		
		return false;
	}
	
	/**
	* Checks if user already logged in or not.
	*/
	function isLoggedIn(){
		if( sessionStorage.getVar("userAuthorized","false") ){
			//writeDump(session);abort;
			return true;
		}
		return false;
	}

}