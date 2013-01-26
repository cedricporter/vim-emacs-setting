;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-01-26 11:32:16 Saturday by Hua Liang>

;; ====================      line number      ====================
;; 调用linum.el(line number)来显示行号：
(require 'linum)
(global-linum-mode t)
;;(require 'hlinum)

(line-number-mode -1)
;; --------------------      End         --------------------


;; ==================== fast-jump-back ====================
;(require 'fast-jump-back)
;; -------------------- fast-jump-back --------------------


;; ==================== ahei's recent-jump ====================
(setq rj-ring-length 10000)
(require 'recent-jump)
(global-set-key (kbd "C-o") 'recent-jump-backward)
(global-set-key (kbd "M-o") 'recent-jump-forward)
;; -------------------- ahei's recent-jump --------------------


;; ==================== moinmoin-mode ====================
(require 'screen-lines)
(require 'moinmoin-mode)
;; -------------------- moinmoin-mode --------------------


;(require 'ibus)
;(add-hook 'after-init-hook 'ibus-mode-on)


;; ==================== browse-kill-ring ====================
;; 方便的在 kill-ring 里寻找需要的东西。
(require 'browse-kill-ring)
(require 'second-sel)
(require 'browse-kill-ring+)
(browse-kill-ring-default-keybindings)
(global-set-key "\C-c\C-k" 'browse-kill-ring)
;; -------------------- browse-kill-ring --------------------


;; ==================== ido ====================
;; take the place of C-x C-f
;; 当你输入了一些字符后，系统会自动帮你补全；
;; C-s(next)或是C-r(previous)用来在列表中循环；
;; 按[Tab]键会自动列出可能的补全方法；
;; 用C-x C-d直接打开当前目录的Dired浏览模式；
(require 'ido)
(ido-mode t)
;(ffap-bindings)
;(global-set-key "\C-x\C-f" 'ido-dired)
(global-set-key "\C-c\C-f" 'find-file-at-point)
;; -------------------- ido --------------------


;; ;; ==================== session ====================
;; ;; session
;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)
;; (load "desktop")
;; (desktop-save-mode)
;; ;; -------------------- session --------------------


;; ==================== saveplace ====================
;; back to last position when we close the file
(require 'saveplace)
(setq-default save-place t)
;; -------------------- saveplace --------------------




;; ;; ==================== org2blog ====================
;; (add-to-list 'load-path "~/.emacs.d/plugins/org2blog")
;; (require 'org2blog-autoloads)

;; (setq org2blog/wp-blog-alist
;;       '(("EverET.org"
;;          :url "http://EverET.org/xmlrpc.php"
;;          :username "cedricporter"
;;          :default-title "无题")))
;; ;; -------------------- org2blog --------------------


;; ==================== find-func in emacs lisp ====================
(require 'find-func)
(define-key emacs-lisp-mode-map (kbd "C-.") 'find-function)
(define-key emacs-lisp-mode-map (kbd "<f12>") 'find-function)
(define-key emacs-lisp-mode-map (kbd "C-c v") 'find-variable)
;; -------------------- find-func in emacs lisp --------------------


;; ==================== moinmoin2markdown ====================
(setq moinmoin2markdown-reg-pat
      '(; header
        ("^= \\(.*?\\) =" . "# \\1")
        ("^== \\(.*?\\) ==" . "## \\1")
        ("^=== \\(.*?\\) ===" . "### \\1")
        ("^==== \\(.*?\\) ====" . "#### \\1")
        ("^===== \\(.*?\\) =====" . "##### \\1")
                                        ; code block
        ("^{{{ *?\n\\([[:ascii:][:nonascii:]]*?\\)}}}"
         . "```\n\\1\n```")
        ("^{{{#!highlight \\(.*?\\)\n\\([[:ascii:][:nonascii:]]*?\\)}}}"
         . "``` \\1\n\\2\n```")
                                        ; link
        ("\\[\\[\\(.*?\\)|\\(.*?\\)\\]\\]" . "[\\2](\\1)")
        ("\\[\\[\\(.*?\\)\\]\\]" . "[](\\1)")
        ("{{\\(.*?\\)}}" . "![](\\1)")
        ("\\([^(\\[]\\)http://\\(.*?\\)\\([^[:digit:][:word:]-./%&?@]\\)" . "\\1<http://\\2>\\3")
                                        ; emphasis
        ("'''\\(.*?\\)'''" . "**\\1**")
        ))

(defun moinmoin2markdown ()
  "Convert moinmoin syntax to markdown syntax"
  (interactive)
  (let ((origin-pos (point)))
    (dolist (pattern moinmoin2markdown-reg-pat)
      (replace-regexp (car pattern) (cdr pattern))
      (goto-char 0))
    (goto-char origin-pos))
  (markdown-mode)
  )
;; -------------------- moinmoin2markdown --------------------


;; ==================== toggle-case ====================
(require 'toggle-case)
(global-set-key (kbd "M-u") 'toggle-case)
;; -------------------- toggle-case --------------------


;; ==================== ws ====================
;; (require 'ws)
;; -------------------- ws --------------------


;; ==================== full-ack ====================
;(add-to-list 'load-path "~/.emacs.d/plugins/full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
;; -------------------- full-ack --------------------


;; ==================== reload chrome ====================
(add-to-list 'load-path "~/.emacs.d/plugins/gc-refresh-mode")
(require 'gc-refresh-mode)
;; -------------------- reload chrome --------------------


;; (provide 'my-small-tools)
