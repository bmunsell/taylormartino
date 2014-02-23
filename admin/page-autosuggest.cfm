<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<cfform name="PageSearch">
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
    <td>
    <cfselect enabled="No" name="SearchType" multiple="no">
    <option value="PageLink">Name</option>
    <option value="PageTitle">Title</option>
    <option value="PageText">Text</option>
    </cfselect>
    </td>
  </tr>
  <tr>
    <td>Search:</td>
    <td><cfinput name="PageTitle" type="text" autosuggestminlength="2" autosuggest="cfc:Taylor Martino.autoPages({cfautosuggestvalue}, {PageSearch:SearchType@change})" bind="cfc:Taylor Martino.autoPages({PageSearch:SearchType@change})" /></td>
  </tr>
</table> 
</cfform>

</body>
</html>