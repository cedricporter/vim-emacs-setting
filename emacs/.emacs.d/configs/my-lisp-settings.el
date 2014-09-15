;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2014-09-04 00:13:47 Thursday by Hua Liang>

;; ==================== lisp ====================
(require 'slime)
(require 'slime-autoloads)


(add-to-list 'load-path "/usr/local/lib/node_modules/swank-js")
(slime-setup '(slime-js slime-repl slime-fancy))

;; (slime-setup '(slime-fancy))
(setq slime-contribs '(slime-fancy))

;; From http://d.hatena.ne.jp/tsz/20091222/1261492959
(defvar ac-slime-modes
  '(lisp-mode))

(defun ac-slime-candidates ()
  "Complete candidates of the symbol at point."
  (if (memq major-mode ac-slime-modes)
      (let* ((end (point))
	     (beg (slime-symbol-start-pos))
	     (prefix (buffer-substring-no-properties beg end))
	     (result (slime-simple-completions prefix)))
	(destructuring-bind (completions partial) result
	  completions))))

(defvar ac-source-slime
  '((candidates . ac-slime-candidates)
    (requires-num . 3)))

(add-hook 'lisp-mode-hook (lambda ()
			    (slime-mode t)
			    (push 'ac-source-slime ac-sources)
			    (auto-complete-mode)))

(setq inferior-lisp-program "sbcl")


(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))
(add-hook 'js3-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))
(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))
;; -------------------- lisp --------------------


;; (provide 'my-lisp-settings)
