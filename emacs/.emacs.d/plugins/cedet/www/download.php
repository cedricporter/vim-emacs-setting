<!-- -*-html-*- -->
<br clear="all">
<p>
<table width="100%" class="BAR"><tr><td>
<h2>Downloading CEDET</h2>
</td></tr></table>

<p>All the <b>CEDET</b> tools are available from a single distribution file.</p>

<p><b>CEDET 1.0</b> is finally available!
Send in bug reports on the build process, or anything
else to the <a href="http://lists.sourceforge.net/lists/listinfo/cedet-devel">mailing list</a>.

<p>Try out
<a href="https://sourceforge.net/projects/cedet/files/cedet/cedet-1.0.tar.gz/download">
cedet-1.0.tar.gz</a>.

<p>After building <b>CEDET</b>, consider posting to
the <a href="http://lists.sourceforge.net/lists/listinfo/cedet-devel">mailing
list</a> to let us know how it went!

<p><b>Please Note:</b>

<p>If you encounter build problems with a CEDET release, those issues
  may have already been fixed in CVS!  CEDET has an active community
  of users that help identify and fix these issues quickly.  You can check the
  <a href="https://sourceforge.net/mailarchive/forum.php?forum_name=cedet-devel">
  mailing list archives</a> or just try the
  <a href="https://sourceforge.net/scm/?type=cvs&group_id=17886">
  CVS version</a> directly.

<p><b>Emacs Version Support:</b>

<p>CEDET 1.0 has two automated build processes.  These have been
  tested on Linux with Emacs 22 and 23.1.  CEDET will also build and
  work for Emacs 23.2, though the version of CEDET that comes with
  Emacs 23.2 has been reported to conflict for some.

<p>Neither build process works with XEmacs 21.4.  It is possible to
  build parts of it by hand it so it works however.  If anyone knows
  how to fix the build, please let us know.

<p>In Emacs 21, CEDET's test suite will fail, but most parts still
  work.

<p>On windows, you will likely need to use the <tt>cedet-build.el</tt>
  script to build CEDET.
