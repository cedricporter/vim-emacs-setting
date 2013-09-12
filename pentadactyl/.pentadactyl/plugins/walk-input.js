(function () {

    var xpath = '//input[@type="text" or @type="password" or @type="search" or not(@type)] | //textarea';

    var walkinput = function (forward) {
        var focused = document.commandDispatcher.focusedElement;
        var current = null;
        var next = null;
        var prev = null;
        var list = [];

        (function (frame) {
            var doc = frame.document;
            if (doc.body.localName.toLowerCase() == 'body') {
                let r = doc.evaluate(xpath, doc, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
                for (let i = 0, l = r.snapshotLength; i < l; ++i) {
                    let e = r.snapshotItem(i);
                    if (/^none$/i.test(getComputedStyle(e, '').display))
            continue;
        let ef = {element: e, frame: frame};
        list.push(ef);
        if (e == focused) {
            current = ef;
        } else if (current && !next) {
            next = ef;
        } else if (!current) {
            prev = ef;
        }
                }
            }
            for (let i = 0; i < frame.frames.length; i++)
            arguments.callee(frame.frames[i]);
        })(content);

        if (list.length <= 0)
            return;

        var elem = forward ? (next || list[0])
            : (prev || list[list.length - 1]);

        if (!current || current.frame != elem.frame)
            elem.frame.focus();
        elem.element.focus();
    };

    group.mappings.add([modes.NORMAL, modes.INSERT], ['<M-i>', '<A-i>'],
            'Walk Input Fields (Forward)', function () walkinput(true));
    group.mappings.add([modes.NORMAL, modes.INSERT], ['<M-S-i>', '<A-S-i>'],
            'Walk Input Fields (Backward)', function () walkinput(false));

})();
