var INFO =
<plugin name="smooziee" version="0.3"
        href="http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/_smooziee.js"
        summary="At j,k key scrolling to be smooth."
        xmlns={NS}>
    <author email="snaka.gml@gmail.com">snake</author>
    <license href="http://opensource.org/licenses/mit-license.php">MIT</license>
    <project name="Pentadactyl" min-version="1.0"/>
    <p>
    j,k key scrolling to be smoothly.
    </p>
    <item>
        <tags>'ssa' 'smooziee_scroll_amount'</tags>
        <spec>'smooziee_scroll_amount'</spec>
        <type>number</type>
        <default>400</default>
        <description>
            <p>Scrolling amount(unit:px). Default value is 400px.</p>
        </description>
    </item>
    <item>
        <tags>'ssi' 'smooziee_scroll_interval'</tags>
        <spec>'smooziee_scroll_interval'</spec>
        <type>number</type>
        <default>20</default>
        <description>
            <p>Scrolling interval(unit:ms). Default value is 20ms.</p>
        </description>
    </item>
</plugin>;

group.options.add(["smooziee_scroll_interval", "ssi"],
    "Scrolling interval(unit:ms).",
    "number", 20);
group.options.add(["smooziee_scroll_amount", "ssa"],
    "Scrolling amount(unit:px).",
    "number", 400);

let self = dactyl.plugins.smooziee = (function(){

  group.mappings.add(
    [modes.NORMAL],
    ["j"],
    "Smooth scroll down",
    function(args){
      self.smoothScrollBy(getScrollAmount() * (args.count||1));
    },
    {
      count : true
    }
  );
  group.mappings.add(
    [modes.NORMAL],
    ["k"],
    "Smooth scroll up",
    function(args){
      self.smoothScrollBy(getScrollAmount() * -(args.count || 1));
    },
    {
      count : true
    }
  );

  var PUBLICS = {
    smoothScrollBy: function(moment) {
      win = buffer.findScrollableWindow();
      interval = window.eval(options.smooziee_scroll_interval) || 20;
      destY = win.scrollY + moment;
      clearTimeout(next);
      smoothScroll(moment);
    }
  }

  var next;
  var destY;
  var win;
  var interval;

  function getScrollAmount() window.eval(options.smooziee_scroll_amount) || 400;

  function smoothScroll(moment) {
    if (moment > 0)
      moment = Math.floor(moment / 2);
    else
      moment = Math.ceil(moment / 2);

    win.scrollBy(0, moment);

    if (Math.abs(moment) < 1) {
      setTimeout(makeScrollTo(win.scrollX, destY), interval);
      destY = null;
      return;
    }
    next = setTimeout(function() smoothScroll(moment), interval);
  }

  function makeScrollTo(x, y) function() win.scrollTo(x, y);
  return PUBLICS;
})();
