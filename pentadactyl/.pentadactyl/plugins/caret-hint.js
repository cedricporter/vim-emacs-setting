/* NEW BSD LICENSE {{{
Copyright (c) 2009-2011, anekos.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
    3. The names of the authors may not be used to endorse or promote products
       derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.


###################################################################################
# http://sourceforge.jp/projects/opensource/wiki/licenses%2Fnew_BSD_license       #
# に参考になる日本語訳がありますが、有効なのは上記英文となります。                #
###################################################################################

}}} */

// Cf. also:
// http://github.com/grassofhust/dotfiles/blob/master/.pentadactyl/archives/caret-hint.js

group.options.add(["carethint", "ch"],
    "Keys used by the caret-hint plugin",
    "stringmap",
    "movebeg:mb,moveend:me,selectbeg:Mb,selectend:Me",
    {
        completer: function (context, extra) {
            if (extra.value == null)
                return [
                    ["movebeg", "Go to the beginning of an element (extended hint mode)"],
                    ["moveend", "Go to the end of an element (extended hint mode)"],
                    ["selectbeg", "Go to the beginning of an element and select it (extended hint mode)"],
                    ["selectend", "Go to the end of an element and select it (extended hint mode)"]
                ].filter(function (e) !Set.has(extra.values, e[0]));
            // return;
        },
        setter: function (val) {
            let old = this.value;
            for (let m in hintSpecs) {
                if (val[m] !== old[m]) {
                    delete hints.modes[old[m]];
                    defineHintMode(m, val[m]);
                }
            }
            return val;
        },
        validator: function (val) {
            let def = this.defaultValue;
            return Object.keys(val).every(function (k) k in def);
        }
    });


let hintSpecs = {
    "movebeg": [true,  false],
    "moveend": [false, false],
    "selectbeg": [true,  true],
    "selectend": [false, true]
}

function defineHintMode(mode, key) {
    let key = key || options["carethint"][mode];
    if (!key)
        return;
    let spec = hintSpecs[mode];
    hints.addMode(
        key,
        "Move caret to the " + (spec[0] ? "beginning" : "end") +
            " of element" + (spec[1] ? " and select it" : ""),
        function (elem, loc, count) moveCaret(elem, spec[0], spec[1]),
        function (elem) (elem.textContent.trim().length > 0),
        ["a", "blockquote", "dd", "div", "dt", "em", "p", "pre", "td", "th"]
    );
}

for (let m in hintSpecs) {
    defineHintMode(m);
}

let curWin = null;

function moveCaret (elem, head, select) {
    let doc = elem.ownerDocument;
    doc.defaultView.focus();
    curWin = doc.defaultView;
    let sel = curWin.getSelection();
    let r = doc.createRange();

    sel.removeAllRanges();
    r.selectNodeContents(elem);

    if (select) {
        mappings.builtin.get(modes.NORMAL, "i").action();
        mappings.builtin.get(modes.CARET, "v").action();
    } else {
        if (head) {
            r.setEnd(r.startContainer, r.startOffset);
        } else {
            r.setStart(r.endContainer, r.endOffset);
        }
        mappings.builtin.get(modes.NORMAL, "i").action();
    }

    sel.addRange(r);

    if (select && head)
        mappings.builtin.get(modes.VISUAL, "o").action();
}

var INFO =
    ["plugin", {name: "caret-hint", 
    			version: "1.6.0", 
            	href: "https://gist.github.com/1225428",
            	summary: "Move caret position or select text by hinting",
            	lang: "en-US",
            	xmlns: "dactyl"}, 
        ["author", {email: "anekos@snca.net"}, "anekos"],
    	["author", {email: "stepnem@gmail.com"}, "Štěpán Němec"],
        ["license", {href: "http://opensource.org/licenses/bsd-license.php"}, "BSD"],
        ["project", {name: "Pentadactyl", minVersion: "1.0"}],
        ["p", {}, 
            "Provides hint modes for moving the caret and optionally selecting ",
            "hintable elements."],
        ["item", {},
            ["tags", {}, 'ch, carethint'],
            ["spec", {}, 'carethint, ch'],
            ["type", {}, options.get("carethint").type],
            ["default", {}, options.get("carethint").stringDefaultValue],
            ["description", {}, 
                ["p", {}, "Keys used by the caret-hint plugin:"], 
                ["dl", {}, 
                    template.map(options.get("carethint").completer(null, { values: {} }),
                    function ([k, v]) {
                    	return [["dt", {}, k], ["dd", {}, v]]
                    })
                ]
			]
		]
    ];
