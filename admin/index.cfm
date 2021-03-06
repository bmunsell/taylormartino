<cfquery name="GetPages">
SELECT PageID
FROM Pages
</cfquery>
<cfquery name="GetSubPages">
SELECT SubPageID
FROM SubPages
</cfquery>
<cfset pcount = #GetPages.RecordCount# + #GetSubPages.RecordCount#>
<cfquery name="GetPosts">
SELECT PostID
FROM Posts
</cfquery>
<!---<cfquery name="GetNewsletters">
SELECT NewsletterID
FROM Newsletters
</cfquery>
<cfquery name="GetMinutes">
SELECT MinutesID
FROM Minutes
</cfquery>
<cfquery name="GetBoardMinutes">
SELECT BoardMinutesID
FROM BoardMinutes
</cfquery>--->
<cfquery name="GetGalleries">
SELECT GalleryID
FROM Galleries
</cfquery>
<cfquery name="GetPhotos">
SELECT PhotoID
FROM Photos
</cfquery>
<cfquery name="GetUsers">
SELECT UserID
FROM Users
</cfquery>
<!---<cfquery name="GetAds">
SELECT BannerID
FROM Banners
</cfquery>--->
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Taylor Martino Website Admin</title>
<link href="/admin/admin.css" rel="stylesheet" type="text/css"><!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="/includes/javascript/SpryMenuBar.js" type="text/javascript"></script>

</head>
<body>
	<cfinclude template="header.cfm">
    
	<div class="container">
<table width="600" border="0" cellspacing="5" cellpadding="5" align="center">
  <tr>
    <td bgcolor="#CCCCCC"><cfoutput><strong>Website Pages:</strong> #pcount# total</cfoutput></td>
    <td bgcolor="#CCCCCC"><cfoutput><strong>Website Posts:</strong> #GetPosts.RecordCount# total </cfoutput></td>
  </tr>
  <tr>
    <td width="300">
      <cfoutput>
      <!---<p><a href="subpage-add.cfm"><img src="/admin/images/page_add.png" width="16" height="16">Add New Page</a></p>--->
<p><a href="page-list.cfm"><img src="/admin/images/page_edit.png" width="16" height="16"> Edit Website Pages</a></p>
      </cfoutput>
      </td>
    <td width="300">
      <cfoutput>
      <p><a href="post-add.cfm"><img src="/admin/images/comment_add.png" width="16" height="16">Add New Post</a></p>
<p><a href="posts.cfm"><img src="/admin/images/comment_edit.png" width="16" height="16">Edit Posts</a></p>
      </cfoutput>
    </td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC"><strong>Photo Galleries:</strong><cfoutput>#GetGalleries.RecordCount# total </cfoutput></td>
    <td bgcolor="#CCCCCC"><p><cfoutput><strong>Photos:</strong> #GetPhotos.RecordCount# total </cfoutput></p></td>
  </tr>
  <tr>
    <td>
    <!---<cfoutput>
      <p><strong>Board Minutes:</strong>
      #GetBoardMinutes.RecordCount# total </p>
      <p><a href="board-minutes-add.cfm"><img src="/admin/images/note_add.png" width="16" height="16">Add Board Minutes</a></p>
      <p><a href="board-minutes.cfm"><img src="/admin/images/note.png" width="16" height="16">Edit Board Minutes</a></p>
    </cfoutput>--->
    <a href="galleries.cfm"><img src="/admin/images/photos.png" width="16" height="16">Add New Gallery</a></td>
    <td>
    <cfif GetPhotos.RecordCount GT 0>
     <a href="photos.cfm"><img src="/admin/images/photo_add.png" width="16" height="16">Add New Photo</a>
     <cfelse>
     <a href="galleries.cfm"><img src="/admin/images/photos.png" width="16" height="16">Add New Gallery</a>
      </cfif>
    </td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC"><cfoutput>
      <p><strong>Users:</strong> #GetUsers.RecordCount# total </p>
    </cfoutput></td>
   <!--- <td bgcolor="#CCCCCC"><cfoutput><strong>Ads:</strong> #GetAds.RecordCount# total </cfoutput></td>--->
  </tr>
  <tr>
    <td>
     <cfoutput>
       <p><a href="user-add.cfm"><img src="/admin/images/user_add.png" width="16" height="16">Add New User</a></p>
<p><a href="users.cfm"><img src="/admin/images/group_edit.png" width="16" height="16">Edit Users</a></p>
      </cfoutput>
    </td>
    <!---<td><p><a href="banner-add.cfm"><img src="/admin/images/book_go.png" alt="" width="16" height="16">Add New Ad</a></p>
      <p><a href="banners.cfm"><img src="/admin/images/book_edit.png" alt="" width="16" height="16">Edit Ads</a></p></td>--->
  </tr>
</table>

    </div>
</body>
</html>
<!---<cflayoutarea name="header" position="top" style="border:0px;border-style:none;"collapsible="false" splitter="true" overflow="hidden">
	
</cflayoutarea>--->
<!---<cflayoutarea name="rightColumn" position="right" title="NEW" style="background-color:##FFF" collapsible="true" splitter="true" size="300" source="nav.cfm" />
		<cflayoutarea name="footer" position="bottom" style="border:0px;border-style:none;" source="footer.cfm" overflow="hidden" splitter="no" />--->