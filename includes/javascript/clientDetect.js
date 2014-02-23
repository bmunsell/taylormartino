/* Client list
"midp",
"240x320",
"blackberry",
"netfront",
"nokia",
"panasonic",
"portalmmm",
"sharp",
"sie-",
"sonyericsson",
"symbian",
"windows ce",
"benq",
"mda",
"mot-",
"opera mini",
"philips",
"pocket pc",
"sagem",
"samsung",
"sda",
"sgh-",
"vodafone",
"xda",
"iphone",
"android"
 */
var Client = {
	mobileClients : [
			"iphone",
			"blackberry",
			"android"
		],

	isMobileClient : function(userAgent) {
		userAgent=userAgent.toLowerCase();
			for (var i in this.mobileClients) {
				if (userAgent.indexOf(this.mobileClients[i]) != -1) {
					return this.mobileClients[i];
				}
			}
			return 'null';
	}
}