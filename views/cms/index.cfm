<table width="600" border="0" cellspacing="5" cellpadding="5" align="center">
  <tr>
    <td bgcolor="#CCCCCC"><cfoutput><strong>Website Pages:</strong> #prc.pcount# total</cfoutput></td>
    <td bgcolor="#CCCCCC"><cfoutput><strong>Website Posts:</strong> #prc.GetPosts.RecordCount# total </cfoutput></td>
  </tr>
  <tr>
    <td width="300">
      <cfoutput>
      <!---<p><a href="subpage-add.cfm"><img src="/admin/images/page_add.png" width="16" height="16">Add New Page</a></p>--->
<p><a href="/cms/page/list"><img src="/admin/images/page_edit.png" width="16" height="16"> Edit Website Pages</a></p>
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
    <td bgcolor="#CCCCCC"><strong>Photo Galleries:</strong><cfoutput>#prc.GetGalleries.RecordCount# total </cfoutput></td>
    <td bgcolor="#CCCCCC"><p><cfoutput><strong>Photos:</strong> #prc.GetPhotos.RecordCount# total </cfoutput></p></td>
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
    <cfif prc.GetPhotos.RecordCount GT 0>
     <a href="photos.cfm"><img src="/admin/images/photo_add.png" width="16" height="16">Add New Photo</a>
     <cfelse>
     <a href="galleries.cfm"><img src="/admin/images/photos.png" width="16" height="16">Add New Gallery</a>
      </cfif>
    </td>
  </tr>
  <tr>
    <td bgcolor="#CCCCCC"><cfoutput>
      <p><strong>Users:</strong> #prc.GetUsers.RecordCount# total </p>
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