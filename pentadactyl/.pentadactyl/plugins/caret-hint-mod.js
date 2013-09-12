var INFO =
<plugin name="Caret-Hint" version="1.4.0"
	href="https://github.com/vimpr/vimperator-plugins/blob/master/caret-hint.js"
	summary="Move caret position by hint"
	xmlns="http://vimperator.org/namespaces/liberator">
    <author email="anekos@snca.net">anekos</author>
    <license>New BSD License</license>
    <project name="Pentadactyl" min-version="1.0"/>
    <p>
        This plugin provides a means to move caret by hitting hints.
    </p>
    <item>
	<tags>;m</tags>
	<spec>;m</spec>
	<description>
	    <p>
		Move caret position to the head of selected element.
	    </p>
	</description>
    </item>
    <item>
	<tags>;M</tags>
	<spec>;M</spec>
	<description>
	    <p>
		Move caret position to the tail of selected element.
	    </p>
	</description>
    </item>
    <item>
	<tags>;e</tags>
	<spec>;e</spec>
	<description>
	    <p>
		Move caret position to the tail of selected element and select it.
	    </p>
	</description>
    </item>
</plugin>;

let headMode = 'm';
let tailMode = 'M';
let selectTailMode = 'e';

[
[[true,  false], headMode],
[[false, false], tailMode],
[[false, true ], selectTailMode],
].forEach(function ([[h, s], m]) {
    hints.addMode(
	m,
	'Move caret position to ' + (h ? 'head' : 'tail') + (s ? ' and select' : ''),
	function (elem) {
	    moveCaret(elem, h, s);
	}
    );
});

dactyl.execute("se eht+=[mMe]:*");

function moveCaret(elem, head, select) {
    let doc = elem.ownerDocument;
    let win = new XPCNativeWrapper(window.content.window);
    let sel =  win.getSelection();
    let r = doc.createRange();

    sel.removeAllRanges();
    r.selectNodeContents(elem);
    sel.addRange(r);

    if (select) {
	modes.push(modes.VISUAL);
    } else {
	if (head) {
	    r.setEnd(r.startContainer, r.startOffset);
	} else {
	    r.setStart(r.endContainer, r.endOffset);
	}
	modes.push(modes.CARET);
    }
}
