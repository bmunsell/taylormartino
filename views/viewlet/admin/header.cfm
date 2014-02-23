<cfset DTS = #DateAdd('h', 1, now())#>
<cfset DTS = #CreateODBCDateTime(DTS)#>
<header>
<div class="logo">
<h2><img src="/includes/images/Taylor-Martino-Mobile-Alabama.png" alt="Taylor Martino Website Admin" height="100" align="absmiddle" style="padding: 5px;" /></h2>
<div class="dts">
<cfoutput>
#DateFormat(DTS, 'full')#<br />
#TimeFormat(DTS, 'medium')#
</cfoutput>
</div>
</div>
<div class="menuholder">
<ul id="MenuBar1" class="MenuBarHorizontal">
  <li><a class="MenuBarItemSubmenu" href="/admin/index.cfm"><img src="/admin/images/page_gear.png" width="16" height="16"> HOME&nbsp;</a>
    <ul>
      <!---<li><a href="/admin/teams.cfm"><img src="/admin/images/sport_football.png" width="16" height="16"> Teams</a></li>--->
      <li><a href="/admin/categories.cfm"><img src="/admin/images/page_add.png" width="16" height="16"> Categories</a></li>
      <li><a href="/admin/backgrounds.cfm"><img src="/admin/images/photo.png" width="16" height="16"> Backgrounds</a></li>
      <!---<li><a href="/admin/polls.cfm"><img src="/admin/images/chart_bar.png" width="16" height="16">Polls</a></li>--->
    </ul>
  <li><a class="MenuBarItemSubmenu" href="/cms/page/list/"><img src="/admin/images/page.png" width="16" height="16"> PAGES&nbsp;</a>
    <ul>
      <li><a href="/cms/page/list/"><img src="/admin/images/page_edit.png" width="16" height="16"> EDIT Pages</a></li>
      <li><a href="/cms/subpage/list"><img src="/admin/images/page_edit.png" width="16" height="16"> EDIT SubPages</a></li>
      <li><a href="/cms/page/add"><img src="/admin/images/page_add.png" width="16" height="16"> NEW Page</a></li>
      <li><a href="/cms/subpage/add"><img src="/admin/images/page_add.png" width="16" height="16"> NEW Sub-Page</a></li>
    </ul>
  </li>
  <li><a class="MenuBarItemSubmenu" href="posts.cfm"><img src="/admin/images/newspaper.png" width="16" height="16"> NEWS&nbsp;</a>
    <ul>
      <li><a href="post-add.cfm"><img src="/admin/images/newspaper_add.png" width="16" height="16"> ADD News</a></li>
      <li><a href="posts.cfm"><img src="/admin/images/newspaper_go.png" width="16" height="16"> EDIT News</a></li>
    </ul>
  </li>
  <!---<li><a class="MenuBarItemSubmenu" href="videos.cfm"><img src="/admin/images/film.png" width="16" height="16"> VIDEOS&nbsp;</a>
    <ul>
      <li><a href="video-add.cfm"><img src="/admin/images/film_add.png" width="16" height="16"> ADD Video</a></li>
      <li><a href="videos.cfm"><img src="/admin/images/film_edit.png" width="16" height="16"> EDIT Videos</a></li>
    </ul>
  </li>
  <li><a class="MenuBarItemSubmenu" href="audio.cfm"><img src="/admin/images/sound.png" width="16" height="16"> AUDIO&nbsp;</a>
    <ul>
      <li><a href="audio-add.cfm"><img src="/admin/images/sound_add.png" width="16" height="16"> ADD Audio</a></li>
      <li><a href="audio.cfm"><img src="/admin/images/sound.png" width="16" height="16"> EDIT Audio</a></li>
    </ul>
  </li>--->
  <!---<li><a class="MenuBarItemSubmenu" href="scores.cfm"><img src="/admin/images/sport_football.png" width="16" height="16"> SCORES&nbsp;</a>
    <ul>
      <li><a href="manage.cfm"><img src="/admin/images/sport_football.png" width="16" height="16"> ADD Score</a></li>
      <li><a href="scores.cfm"><img src="/admin/images/sport_football.png" width="16" height="16"> EDIT Scores</a></li>
    </ul>
  </li>
  <li><a class="MenuBarItemSubmenu" href="banners.cfm"><img src="/admin/images/picture_edit.png" width="16" height="16"> BANNERS&nbsp;</a>
    <ul>
      <li><a href="banner-ad.cfm"><img src="/admin/images/picture_add.png" width="16" height="16"> ADD Banner</a></li>
      <li><a href="banners.cfm"><img src="/admin/images/picture_edit.png" width="16" height="16"> EDIT Banners</a></li>
    </ul>
  </li>
  <li><a class="MenuBarItemSubmenu" href="polls.cfm"><img src="/admin/images/chart_bar_edit.png" width="16" height="16"> POLLS&nbsp;</a>
    <ul>
      <li><a href="poll-ad.cfm"><img src="/admin/images/chart_bar_edit.png" width="16" height="16"> ADD Poll</a></li>
      <li><a href="polls.cfm"><img src="/admin/images/chart_bar_edit.png" width="16" height="16"> EDIT Poll</a></li>
    </ul>
  </li>--->
  <li><a class="MenuBarItemSubmenu" href="/admin/index.cfm"><img src="/admin/images/book.png" width="16" height="16"> MEDIA&nbsp;</a>
     <ul>
      <li><a href="/admin/galleries.cfm"><img src="/admin/images/photos.png" width="16" height="16">Photo Galleries</a></li>
      <!---<li><a href="/admin/polls.cfm"><img src="/admin/images/chart_bar.png" width="16" height="16">Polls</a></li>--->
      <li><a href="/admin/files.cfm"><img src="/admin/images/page_excel.png" width="16" height="16">Site Files</a></li>
      <li><a href="/admin/images.cfm"><img src="/admin/images/pictures.png" width="16" height="16">Site Images</a></li>
      <!---<li><a href="/admin/backgrounds.cfm"><img src="/admin/images/photo.png" width="16" height="16">Backgrounds</a></li>--->
    </ul>
  </li>
  <li><a class="MenuBarItemSubmenu" href="/admin/users.cfm"><img src="/admin/images/user.png" width="16" height="16"> USERS&nbsp;</a>
     <ul>
      <li><a href="users.cfm"><img src="/admin/images/Search.png" width="16" height="16"> SEARCH</a></li>
      <li><a href="user-add.cfm"><img src="/admin/images/user_add.png" width="16" height="16"> ADD User</a></li>
      <!---<li><cfoutput><a href="user-edit.cfm?uid=#session.UserID#"><img src="/admin/images/user_comment.png" width="16" height="16"> Edit #session.firstname# #session.lastname#</a></cfoutput></li>--->
    </ul>
  </li>
  <!---<li><a class="MenuBarItemSubmenu" href="/admin/banners.cfm"><img src="/admin/images/book.png" width="16" height="16"> Ads&nbsp;</a>
     <ul>
      <li><a href="banner-add.cfm"><img src="/admin/images/book_go.png" width="16" height="16">ADD Banner</a></li>
      <li><a href="banners.cfm"><img src="/admin/images/book_edit.png" width="16" height="16">Edit Banners</a></li>
    </ul>
  </li>--->
  <li><a href="/login/index.cfm?logout=1"><img src="/admin/images/disconnect.png" width="16" height="16"> LOGOUT</a></li>
</ul>
</div>

<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"SpryMenuBarDownHover.gif", imgRight:"SpryMenuBarRightHover.gif"});
</script></header>