<html>
<head>
   <title>CFFileUpload Example</title><script> 
  var foo = function(result){ 
   alert(ColdFusion.JSON.encode(result)); 
  } 
  
</script>
 </head>
<body>

<cffileupload url="cffileupload-uploader.cfm" onUploadComplete="foo" />

<cfparam name="foo" default="1">
<cfdump var="#foo#">
</body>
</html>