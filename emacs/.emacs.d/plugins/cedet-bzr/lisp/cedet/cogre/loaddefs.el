;;; loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (cogre-export-ascii) "cogre/ascii" "ascii.el" "af06d47ff041318d21bcbe5f8f1bc4c0")
;;; Generated autoloads from ascii.el

(autoload 'cogre-export-ascii "cogre/ascii" "\
Export the current diagram into an ASCII buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads (cogre-export-dot-postscript-print cogre-export-dot-png
;;;;;;  cogre-export-dot) "cogre/convert" "convert.el" "f9ee5cf1991f06c6647712d86a078aff")
;;; Generated autoloads from convert.el

(autoload 'cogre-export-dot "cogre/convert" "\
Export the current COGRE graph to DOT notation.
DOT is a part of GraphViz.

\(fn)" t nil)

(autoload 'cogre-export-dot-png "cogre/convert" "\
Export the current COGRE graph to DOT, then convert that to PNG.
The png file is then displayed in an Emacs buffer.
DOT is a part of GraphVis.

\(fn)" t nil)

(autoload 'cogre-export-dot-postscript-print "cogre/convert" "\
Print the current graph.
This is done by exporting the current COGRE graph to DOT, then
convert that to Postscript before printing.
DOT is a part of GraphVis.

\(fn)" t nil)

;;;***

;;;### (autoloads (cogre-dot-mode) "cogre/dot-mode" "dot-mode.el"
;;;;;;  "e2fe2e0bb579079063fc27f18740448c")
;;; Generated autoloads from dot-mode.el

(autoload 'cogre-dot-mode "cogre/dot-mode" "\
Major mode for the dot language.
This is a mini-mode that will first attempt to load and install
`graphviz-dot-mode' in this buffer.  If that fails, it installs
the syntax table, and runs a hook needed to get Semantic working
as a parsing engine.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.dot\\'" . cogre-dot-mode))

;;;***

;;;### (autoloads (cogre-layout) "cogre/layout" "layout.el" "28bc557f48a2b784acfc76b519eebb72")
;;; Generated autoloads from layout.el

(autoload 'cogre-layout "cogre/layout" "\
Layout the current graph.
This function depends on graphviz `dot' program.

\(fn)" t nil)

;;;***

;;;### (autoloads (cogre-mode) "cogre/mode" "mode.el" "d24115507ffaddeabaec83259e461579")
;;; Generated autoloads from mode.el

(autoload 'cogre-mode "cogre/mode" "\
Connected Graph Editor Mode.
\\{cogre-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist (cons "\\.cgr\\'" 'cogre-mode))

;;;***

;;;### (autoloads (cogre-periodic) "cogre/periodic" "periodic.el"
;;;;;;  "83d4c1c2c364ca9cb1d8c7ddf4a7b381")
;;; Generated autoloads from periodic.el

(autoload 'cogre-periodic "cogre/periodic" "\
Create a periodic table of COGRE objects.

\(fn)" t nil)

;;;***

;;;### (autoloads (cogre-picture-insert-rectangle) "cogre/picture-hack"
;;;;;;  "picture-hack.el" "223fcd18e2f4f6641818adf4afc7b6cb")
;;; Generated autoloads from picture-hack.el

(autoload 'cogre-picture-insert-rectangle "cogre/picture-hack" "\
Overlay RECTANGLE with upper left corner at point.
Leaves the region surrounding the rectangle.

\(fn RECTANGLE)" nil nil)

;;;***

;;;### (autoloads (cogre-uml-quick-class cogre-export-code cogre-semantic-tag-to-node)
;;;;;;  "cogre/semantic" "semantic.el" "ea16f9d9b22bb07dff581235247eb8ac")
;;; Generated autoloads from semantic.el

(autoload 'cogre-semantic-tag-to-node "cogre/semantic" "\
Convert the Semantic tag TAG into a COGRE node.
Only handles data types nodes.
To convert function/variables into methods or attributes in
an existing COGRE node, see @TODO - do that.

\(fn TAG)" nil nil)

(autoload 'cogre-export-code "cogre/semantic" "\
Export the current graph into source-code in FILE.
Uses `cogre-export-semantic' to convert into Semantic tags.
Uses `cogre-srecode-setup' to setup SRecode for code generation.

\(fn FILE)" t nil)

(autoload 'cogre-uml-quick-class "cogre/semantic" "\
Create a new UML diagram based on CLASS showing only immediate lineage.
The parent to CLASS, CLASS, and all of CLASSes children will be shown.

\(fn CLASS)" t nil)

;;;***

;;;### (autoloads (srecode-semantic-handle-:dot srecode-semantic-handle-:cogre
;;;;;;  cogre-srecode-setup) "cogre/srecode" "srecode.el" "0979981f919ca32452786239c110daa5")
;;; Generated autoloads from srecode.el

(autoload 'cogre-srecode-setup "cogre/srecode" "\
Update various paths to get SRecode to identify COGRE macros.

\(fn)" nil nil)

(autoload 'srecode-semantic-handle-:cogre "cogre/srecode" "\
Add macros to dictionary DICT based on COGRE data.

\(fn DICT)" nil nil)

(eval-after-load "srecode-map" '(cogre-srecode-setup))

(autoload 'srecode-semantic-handle-:dot "cogre/srecode" "\
Add macros to dictionary DICT based on the current DOT buffer.

\(fn DICT)" nil nil)

;;;***

;;;### (autoloads (cogre-uml-sort-for-lineage cogre-uml-enable-unicode)
;;;;;;  "cogre/uml" "uml.el" "a11fdbab240c43a17c5dac6e84ba4ea5")
;;; Generated autoloads from uml.el

(autoload 'cogre-uml-enable-unicode "cogre/uml" "\
Enable use of UNICODE symbols to create COGRE graphs.
Inheritance uses math triangle on page 25a0.
Aggregation uses math square on edge 25a0.
Line-drawing uses line-drawing codes on page 2500.
See http://unicode.org/charts/symbols.html.

The unicode symbols can be differing widths.  This will make the
cogre chart a little screwy somteims.  Your mileage may vary.

\(fn)" t nil)

(autoload 'cogre-uml-sort-for-lineage "cogre/uml" "\
Sort the current graph G for determining inheritance lineage.
Return it as a list of lists.  Each entry is of the form:
  ( NODE PARENT1 PARENT2 ... PARENTN)

\(fn G)" t nil)

;;;***

;;;### (autoloads (wisent-dot-setup-parser) "cogre/wisent-dot" "wisent-dot.el"
;;;;;;  "098827214c96f8d6c2a618118e3377d9")
;;; Generated autoloads from wisent-dot.el

(autoload 'wisent-dot-setup-parser "cogre/wisent-dot" "\
Setup buffer for parse.

\(fn)" nil nil)

(add-hook 'graphviz-dot-mode-hook 'wisent-dot-setup-parser)

(add-hook 'cogre-dot-mode-hook 'wisent-dot-setup-parser)

;;;***

;;;### (autoloads nil nil ("wisent-dot-wy.el") (20679 27067 658908))

;;;***

(provide 'loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; loaddefs.el ends here
