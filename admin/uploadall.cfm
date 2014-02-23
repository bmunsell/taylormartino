<cfif StructKeyExists(FORM, "fieldnames")>
	<cffile action="uploadall" destination="#ExpandPath(".")#" result="UploadResult" nameconflict="overwrite" />
	<cfdump var="#UploadResult#">
</cfif>
<cfform enctype="multipart/form-data">
	<cfinput type="file" name="field1" /><br />
	<cfinput type="file" name="field2" /><br />
	<cfinput type="submit" name="Upload" value="Upload" />
</cfform>
