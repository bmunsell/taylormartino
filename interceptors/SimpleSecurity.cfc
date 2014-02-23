/**
* Intercepts with HTTP Basic Authentication
*/
component {
	
	// Security Service

	
	
	void function configure(){
	}
	
	void function preProcess(event,struct interceptData) eventPattern="^CMS\."{
		
		
		// Verify Incoming Headers to see if we are authorizing already or we are already Authorized
		if( !getModel('securityService').isLoggedIn() ){
			
			// Verify incoming authorization
			var credentials = event.getCollection();
			if(isDefined('credentials.username') AND isDefined('credentials.password')) {
			if( getModel('securityService').authorize(credentials.username, credentials.password) ){
				// we are secured woot woot!
				return;
			};
			}
			// Not secure!
			location(url="/login/?error=1",addToken='no');
			//event.setHTTPHeader(name="WWW-Authenticate",value="basic realm=""Please enter your username and password""");
			
			// secured content data and skip event execution
			//event.renderData(data="<h1>Unathorized Access<p>Content Requires Authentication</p>",statusCode="401",statusText="Unauthorized")
			//	.noExecution();
		}	
			
	}
	
	/*void function preProcess(event,struct interceptData) eventPattern="^CMS\."{
		
		// Verify Incoming Headers to see if we are authorizing already or we are already Authorized
		if( !getModel('securityService').isLoggedIn() ){
			
			// Verify incoming authorization
			var credentials = event.getHTTPBasicCredentials();
			if( getModel('securityService').authorize(credentials.username, credentials.password) ){
				// we are secured woot woot!
				return;
			};
			
			// Not secure!
			event.setHTTPHeader(name="WWW-Authenticate",value="basic realm=""Please enter your username and password""");
			
			// secured content data and skip event execution
			event.renderData(data="<h1>Unathorized Access<p>Content Requires Authentication</p>",statusCode="401",statusText="Unauthorized")
				.noExecution();
		}	
			
	}*/	
	
}