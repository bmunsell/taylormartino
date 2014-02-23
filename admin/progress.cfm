<html>
<head>
<script type="text/javascript">
startProgress = function(){
	ColdFusion.ProgressBar.start('testbar');
}
stopProgress = function(){
	ColdFusion.ProgressBar.stop('testbar');
}
</script>
</head>
<body>
<cfprogressbar name="testbar" bind="cfc:StatusCheck.getStatus()" interval="500" />
<a href="javascript:startProgress()">Start Progress</a> | <a href="javascript:stopProgress()">Stop Progress</a>
</body>
</html>
