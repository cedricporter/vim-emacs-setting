var INFO =

<plugin name="Mouse-Hover" version="2.0"

href="https://g.mozest.com/viewthread.php?tid=38908&amp;page=3#pid261071"

summary="mouse hover : add hints to trigger mouse over/move/out event"

xmlns={NS}>

<info lang="zh-CN" summary="增加鼠标hint模式：触发鼠标移入移出事件"/>

<author>weide</author>

<license href="http://opensource.org/licenses/mit-license.php">MIT</license>

<project name="Pentadactyl" min-version="1.0"/>

<p lang="en-US">

Add two extended hint modes:

<item><spec>;h</spec><description>dispatch mouse over event to popup menu</description></item>

<item><spec>;r</spec><description>dispatch mouse out  event to remove popup menu</description></item>

<item><spec>:setmouseout</spec><description>run this command to set the ;h mode's last mouse over elem to mouse out,you may:<example>map so -ex :setmouseout</example></description></item>

<note>setmousemout is not always work as you like.</note>

</p>

<p lang="zh-CN">

添加两个扩展的hint模式：

<item><spec>;h</spec><description>触发鼠标移入事件打开弹出对象</description></item>

<item><spec>;r</spec><description>触发鼠标移出事件关闭弹出对象</description></item>

<item><spec>:setmouseout</spec><description>执行此命令触发 ;h 模式下鼠标移入对象的移出事件，也可以映射为快捷键执行:<example>map so -ex :setmouseout</example></description></item>

<note>setmouseout不是每次都能象想象的那么工作</note>

</p>

</plugin>;



dactyl.modules.hints.getFilter = function getFilter(events){

    return function(elem){

        var els = Cc["@mozilla.org/eventlistenerservice;1"].getService(Ci.nsIEventListenerService);

        var infos = els.getListenerInfoFor(elem, {});

        for(var i=0;i<infos.length;i++){

            if(events.indexOf(infos[i].type)>=0) {

                return true;

            }

        };

        return false;

    }

}



dactyl.modules.hints.dispatchEvents = function dispatchEvent(elem,events){

    events.forEach(function(event){

        var evt = document.createEvent("MouseEvents");

        evt.initEvent(event, true, true);

        elem.dispatchEvent(evt);

    });

}





dactyl.modules.hints.LastMouseOverElem=null;



dactyl.modules.hints.addMode(

        "h" , 

        "Mouse over the hint" , 

        function(elem) {

            dactyl.modules.hints.dispatchEvents(elem,['mouseover','mousemove']);                                        

            dactyl.modules.hints.LastMouseOverElem = elem;

        },

        dactyl.modules.hints.getFilter(['mouseover','mousemove']),

        ["*"]

        );



dactyl.modules.hints.addMode(

        "r" , 

        "Mouse out the hint",

        function(elem) dactyl.modules.hints.dispatchEvents(elem,['mouseout']),

        dactyl.modules.hints.getFilter(['mouseout']),

        ["*"]

        );



group.commands.add(

        ['setmouseout'],

        '',

        function (){

            if(dactyl.modules.hints.LastMouseOverElem)

    dactyl.modules.hints.dispatchEvents(dactyl.modules.hints.LastMouseOverElem,['mouseout']);

        }

        );
