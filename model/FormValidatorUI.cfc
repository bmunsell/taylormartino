<cfcomponent name="FormValidatorUI" extends="com.gf.form.FormValidator" output="false">
	<cfproperty name="resourceBundle" inject="coldbox:plugin:resourceBundle">
	<cffunction name="init" returntype="FormValidatorUI" access="public" output="false">
		<cfargument name="javascriptRoot" type="string" default="/includes/javascript"
						hint="The root URL for all javascript files. Used for including prototype, scriptaculous, and the Validation javascript." />

		<cfset super.init() />
		<cfset Variables.instance.javascriptRoot = Arguments.javascriptRoot />

		<cfreturn this />
	</cffunction>

	<cffunction name="getErrorFieldIdList" returntype="string" access="private" output="false">
		<cfset var errors = false />
		<cfset var fieldIdList = "" />
		<cfset var lcv = 0 />

		<cfif hasErrors()>
			<cfset errors = getErrors() />
			<cfloop from="1" to="#ArrayLen(errors)#" index="lcv">
				<cfset fieldIdList = ListAppend(fieldIdList, "#errors[lcv].fieldId#") />
			</cfloop>
		</cfif>

		<cfreturn fieldIdList />
	</cffunction>

	<cffunction name="getDisplayHtml" returntype="string" access="public" output="false">
		<cfargument name="formId" type="string" required="true"
						hint="The ID of the form element to validate. Used to attach validation event functions to the form.">
		<cfset var errors = false />
		<cfset var html = "" />
		<cfset var lcv = 0 />

		<cfsavecontent variable="html">
<div id="<cfoutput>FormValidation-#Arguments.formId#</cfoutput>" class="formValidationArea"<cfif NOT hasErrors()> style="display: none;"</cfif>>
	<cfoutput>
	<div class="formValidationHeader">#resourceBundle.getResource('Submission_Problems')#</div>
	<p>
		#resourceBundle.getResource('The_following_problems_were_found_when_processing_your_submission')#:
	</p>
	<div id="FormValidation-#Arguments.formId#-Errors">
	<cfif hasErrors()>
		<cfset errors = getErrors() />
		<ul>
			<cfloop index="lcv" from="1" to="#ArrayLen(errors)#">
			<li>#errors[lcv].errorMessage#</li>
			</cfloop>
		</ul>
	</cfif>
	</div>
	<p>
		#resourceBundle.getResource('Please_scroll_down_to_correct_the_problems_and_submit_the_form_again')#
	</p>
	</cfoutput>
</div>
		</cfsavecontent>

		<cfreturn html />
	</cffunction>

	<cffunction name="getJavascript" returntype="string" access="public" output="false">
		<cfargument name="jsValidatorName" type="variableName" required="false" default="validator" />
		<cfargument name="formId" type="string" required="true"
						hint="The ID of the form element to validate. Used to attach validation event functions to the form.">
			<cfset var rules = getRules() />
			<cfset var js = "" />
			<cfset var lcv = 0 />
			<cfset var errors = false />

<!--- Begin Javascript Output --->
<cfoutput>
<cfsavecontent variable="js">
<!--- <script type="text/javascript" src="#Variables.instance.javascriptRoot#/scriptaculous/lib/prototype.js"></script>
<script type="text/javascript" src="#Variables.instance.javascriptRoot#/scriptaculous/scriptaculous.js"></script> --->
<script type="text/javascript" src="#Variables.instance.javascriptRoot#/Validation.js"></script>
<script type="text/javascript">
// Initialize Validator
var #Arguments.jsValidatorname# = new Validation("#Arguments.formID#");
// Add Form event listener
Event.observe("#Arguments.formID#", "submit", function(event) {
	if (! #Arguments.jsValidatorname#.validate()) {
		Event.stop(event);
	}
});
// Add Rules
</cfsavecontent>
</cfoutput>
<cfscript>
for (lcv = 1; lcv LTE ArrayLen(rules); lcv = lcv + 1) {
	if (rules[lcv].checkType EQ "custom") {
		js = js.concat('#Arguments.jsValidatorName#.addRule("#rules[lcv].fieldId#", #rules[lcv].isRequired#, "custom", "#JSStringFormat(rules[lcv].errorMessage)#", function (value) { #rules[lcv].isValidJavascript# });#chr(10)#');
	} else {
		js = js.concat('#Arguments.jsValidatorName#.addRule("#rules[lcv].fieldId#", #rules[lcv].isRequired#, "#rules[lcv].checkType#", "#JSStringFormat(rules[lcv].errorMessage)#");#chr(10)#');
	}
}
js = js.concat('</script>');
</cfscript>

		<cfreturn js />
	</cffunction>

</cfcomponent>