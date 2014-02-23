<cfsilent>


<cfif rc.showCalendar>
	<cfparam name="Request.js.isCalendarJsLoaded" default="false" />
	<cfparam name="Request.js.calendarCount" default="1" />
	<cfif rc.calendarName neq "">
		<cfset calName = rc.calendarName />
	<cfelse>
		<cfset calName = "calendar#Request.js.calendarCount#" />
	</cfif>
	<cfset calContainer = "#calName#Container" />

	<!--- Increment JS calendar counter ---> 
	<cfset Request.js.calendarCount = Request.js.calendarCount + 1 />

	<cfif NOT Request.js.isCalendarJsLoaded>
		<cfoutput>
		<cfsavecontent variable="Variables.js">
			<link type="text/css" rel="stylesheet" href="/includes/javascript/yui/build/calendar/assets/calendar.css" />

			<script type="text/javascript" src="/includes/javascript/yui/build/yahoo/yahoo.js"></script>
			<script type="text/javascript" src="/includes/javascript/yui/build/event/event.js" ></script>
			<script type="text/javascript" src="/includes/javascript/yui/build/dom/dom.js" ></script>
			<script type="text/javascript" src="/includes/javascript/yui/build/calendar/calendar.js"></script>
			<script type="text/javascript" src="/includes/javascript/dhtmlShim.js"></script>
			<script type="text/javascript">
			YahooCalendarConfig = {
				title: '#JSStringFormat("Select A Date")#',
				MONTHS_LONG : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
				LOCALE_WEEKDAYS : "1char",
				WEEKDAYS_1CHAR : ['#Left("Sunday", 1)#', '#Left("Monday", 1)#', '#Left("Tuesday", 1)#', '#Left("Wednesday", 1)#', '#Left("Thursday", 1)#', '#Left("Friday", 1)#', '#Left("Saturday", 1)#'],
				WEEKDAYS_LONG : ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
				close: true
			}
			</script>

			<!--- Keep from loading calendar JS again --->
			<cfset Request.js.isCalendarJsLoaded = true />
		</cfsavecontent>
		</cfoutput>
		<cfhtmlhead text="#Variables.js#" />
	</cfif>
</cfif>
</cfsilent>
<cfoutput>
	
<style type="text/css">
	.yui-calendar .calheader {font-size:1em;}
	.yui-calcontainer .title {font-size:11px;} 
	table###calName# td.calcell {
		padding:.4em .5em;
		border:1px solid ##E0E0E0;
		text-align:center;
	}
</style>


<table cellspacing="0" cellpadding="0"<cfif rc.class neq ""> class="#rc.class#"</cfif>>
<tr>
	<td>
	<select id="#rc.FieldNamePreFix#month#rc.FieldNamePostFix#" name="#rc.FieldNamePreFix#month#rc.FieldNamePostFix#">
		<option value='1' <cfif rc.selectedMonth eq 1>selected="selected"</cfif>>Jan</option>
		<option value='2' <cfif rc.selectedMonth eq 2>selected="selected"</cfif>>Feb</option>
		<option value='3' <cfif rc.selectedMonth eq 3>selected="selected"</cfif>>Mar</option>
		<option value='4' <cfif rc.selectedMonth eq 4>selected="selected"</cfif>>Apr</option>
		<option value='5' <cfif rc.selectedMonth eq 5>selected="selected"</cfif>>May</option>
		<option value='6' <cfif rc.selectedMonth eq 6>selected="selected"</cfif>>Jun</option>
		<option value='7' <cfif rc.selectedMonth eq 7>selected="selected"</cfif>>Jul</option>
		<option value='8' <cfif rc.selectedMonth eq 8>selected="selected"</cfif>>Aug</option>
		<option value='9' <cfif rc.selectedMonth eq 9>selected="selected"</cfif>>Sep</option>
		<option value='10' <cfif rc.selectedMonth eq 10>selected="selected"</cfif>>Oct</option>
		<option value='11' <cfif rc.selectedMonth eq 11>selected="selected"</cfif>>Nov</option>
		<option value='12' <cfif rc.selectedMonth eq 12>selected="selected"</cfif>>Dec</option>
	</select>
	</td>
	<td>
	<select id="#rc.FieldNamePreFix#day#rc.FieldNamePostFix#" name="#rc.FieldNamePreFix#day#rc.FieldNamePostFix#">
		<cfloop from="1" to="31" index="d">
			<option <cfif rc.selectedDay eq d>selected="selected"</cfif>>#d#</option>
		</cfloop>
	</select>
	</td>
	<td>
	<select id="#rc.FieldNamePreFix#year#rc.FieldNamePostFix#" name="#rc.FieldNamePreFix#year#rc.FieldNamePostFix#">
		<cfloop from="#year(now())#" to="#year(now())+10#" index="y">
			<option <cfif rc.selectedYear eq y>selected="selected"</cfif>>#y#</option>
		</cfloop>
	</select>
	</td>
	<cfif rc.showCalendar>
	<td style="vertical-align:middle;">
		<div id="#calContainer#" style="display:none; position:absolute;width:210px;padding-right:5px;z-index:600;"></div>
		<img id="#rc.FieldNamePreFix#calImage#rc.FieldNamePostFix#" src="/includes/images/website/icon_calendar.png" alt="" border="0" style="cursor: pointer;">
	</td>
	</cfif>
</tr>
</table>
<script type="text/javascript">
YAHOO.util.Event.addListener(window, "load",
	function () {
		#calName# = new YAHOO.widget.Calendar("#calName#","#calContainer#", YahooCalendarConfig );
		#calName#.render();
		
		// Listener to show the 1-up Calendar when the button is clicked
		YAHOO.util.Event.addListener("#rc.FieldNamePreFix#calImage#rc.FieldNamePostFix#", "click", #calName#.show, #calName#, true);
		
		// Listener to select appropriate pull-down choices
		#calName#.selectEvent.subscribe(
			function (type, args, obj) {
				var dates = args[0];
				var date = dates[0];
				var year = date[0], month = date[1], day = date[2];

				var selMonth = document.getElementById("#rc.FieldNamePreFix#month#rc.FieldNamePostFix#");
				var selDay = document.getElementById("#rc.FieldNamePreFix#day#rc.FieldNamePostFix#");
				var selYear = document.getElementById("#rc.FieldNamePreFix#year#rc.FieldNamePostFix#");
				
				selMonth.selectedIndex = month - 1;
				selDay.selectedIndex = day - 1;

				for (var y=0; y < selYear.options.length; y++) {
					if (selYear.options[y].text == year) {
						selYear.selectedIndex = y;
						break;
					}
				}
				
				updateUniform();
				
				#calName#.hide();
			},
			#calName#,
			true
		);

		// Listener to update the calendar when a pull-down is used
		YAHOO.util.Event.addListener([
				"#rc.FieldNamePreFix#month#rc.FieldNamePostFix#",
				"#rc.FieldNamePreFix#day#rc.FieldNamePostFix#",
				"#rc.FieldNamePreFix#year#rc.FieldNamePostFix#"
			],
			"change",
			function () {
				var selMonth = document.getElementById("#rc.FieldNamePreFix#month#rc.FieldNamePostFix#");
				var selDay = document.getElementById("#rc.FieldNamePreFix#day#rc.FieldNamePostFix#");
				var selYear = document.getElementById("#rc.FieldNamePreFix#year#rc.FieldNamePostFix#");

				var month = parseInt(selMonth.options[selMonth.selectedIndex].value);
				var day = parseInt(selDay.options[selDay.selectedIndex].value);
				var year = parseInt(selYear.options[selYear.selectedIndex].value);

				if (! isNaN(month) && ! isNaN(day) && ! isNaN(year)) { 
					var date = month + "/" + day + "/" + year;

					#calName#.select(date);
					#calName#.cfg.setProperty("pagedate", month + "/" + year);
					#calName#.render();
				}

			}
		);
		
		
		
		function setCal() {
				var selMonth = document.getElementById("#rc.FieldNamePreFix#month#rc.FieldNamePostFix#");
				var selDay = document.getElementById("#rc.FieldNamePreFix#day#rc.FieldNamePostFix#");
				var selYear = document.getElementById("#rc.FieldNamePreFix#year#rc.FieldNamePostFix#");

				var month = parseInt(selMonth.options[selMonth.selectedIndex].value);
				var day = parseInt(selDay.options[selDay.selectedIndex].value);
				var year = parseInt(selYear.options[selYear.selectedIndex].value);

				if (! isNaN(month) && ! isNaN(day) && ! isNaN(year)) { 
					var date = month + "/" + day + "/" + year;

					#calName#.select(date);
					#calName#.cfg.setProperty("pagedate", month + "/" + year);
					#calName#.render();
				}
		}

		<!--- Syncronize calendar date with another calendar. --->
		<!--- <cfif rc.syncWithCalendar neq "">
		YAHOO.util.Dom.get('#rc.syncWithCalendar#').selectEvent.subscribe(
			function (type, args, obj) {
				var selected = args[0][0];
				var year = selected[0];
				var month = selected[1];
				var day = selected[2];

				#calName#.select(month + "/" + day + "/" + year);
				#calName#.cfg.setProperty("pagedate", month + "/" + year);
				#calName#.render();
			},
			YAHOO.util.Dom.get('#rc.syncWithCalendar#'),
			true
		);
		var x = YAHOO.util.Dom.get(#rc.syncWithCalendar#);
		
		</cfif> --->

		<cfif not (rc.selectedMonth and rc.selectedDay and rc.selectedYear)>
			#calName#.select(new Date(#Year(rc.selectedDate)#, #Month(rc.selectedDate)-1#, #Day(rc.selectedDate)#));
			//#calName#.render();
		</cfif>
		
		setCal();
		
	}
);
</script>
</cfoutput>