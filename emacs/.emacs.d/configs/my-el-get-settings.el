;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-02-02 23:50:50 Saturday by Hua Liang>

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(require 'el-get-status)

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.
(setq
 el-get-sources
 '(el-get				; el-get is self-hosting
   escreen            			; screen for emacs, C-\ C-h
   php-mode-improved			; if you're into php...
   switch-window			; takes over C-x o
   zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
   rainbow-mode				; show color
   org-mode
   graphviz-dot-mode
   ;; nrepl
   slime
   coffee-mode
   htmlize
   undo-tree
   full-ack
   scss-mode
   ascii
   autopair
   eassist
   yaml-mode
   highlight-parentheses
   flymake-cursor
   browse-kill-ring
   browse-kill-ring+
   xml-rpc
   second-sel
   xcscope
   xcscope+
   tabbar
   google-c-style
   diminish
   web-mode
   mmm-mode
   python-magic

   (:name multiple-cursors
          :after (progn
                   (global-set-key (kbd "C->") 'mc/mark-next-like-this)
                   (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
                   (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
                   ))

   (:name ipython
   	  :after (progn
   		   (setq ipython-completion-command-string ;fix completion bug
   			 "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")))

   (:name expand-region
          :after (progn
                   (global-set-key (kbd "C-=") 'er/expand-region)))

   (:name auto-complete
	  :after (load "~/.emacs.d/configs/my-autocomplete-settings.el"))

   auto-complete-emacs-lisp
   auto-complete-latex
   auto-complete-css
   auto-complete-etags

   (:name yasnippet
	  :after (progn
		   (load "~/.emacs.d/configs/my-yasnippet-settings.el")))

   (:name markdown-mode
	  :after (progn
		   (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
		   (add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))))

   (:name edit-server
	  :after (progn
		   (when (and (require 'edit-server nil t) (not (daemonp)))
		     (edit-server-start)
		     (setq edit-server-url-major-mode-alist
			   '(("github\\.com" . markdown-mode)
			     ("i\\.everet\\.org" . moinmoin-mode))))))

   (:name js2-mode
	  :after (progn
		   (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))))

   (:name evil-numbers
	  :after (progn
		   (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
		   (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
		   ))

   (:name session
	  :after (progn
		   (add-hook 'after-init-hook 'session-initialize)
		   (load "desktop")
		   (desktop-save-mode)))

   (:name nginx-mode
	  :after (progn
		   (add-hook
		    'find-file-hook
		    '(lambda ()
		       (when (string-match
			      "^\\(/etc/nginx\\|/home/cedricporter/my\\).*?\\.\\(com\\|org\\|net\\|conf\\)$"
			      (buffer-file-name))
			 (nginx-mode)
			 )))))

   (:name ace-jump-mode
	  :after (progn
		   (setq ace-jump-mode-case-fold t)
		   (setq ace-jump-mode-scope 'window)      ; limit scope to current buffer(window)
		   (setq ace-jump-mode-submode-list
			 '(ace-jump-word-mode              ; C-c SPC
			   ace-jump-line-mode              ; C-u C-c SPC
			   ace-jump-char-mode))            ; C-u C-u C-c SPC
		   ;; you can select the key you prefer to
		   (global-set-key (kbd "M-l") 'ace-jump-mode)
		   ))

   (:name helm
	  :after (progn
		   (require 'helm-config)
		   (global-set-key (kbd "C-x b") 'helm-mini)))

   (:name jedi
	  :after (progn
		   (setq jedi:setup-keys t)
		   (autoload 'jedi:setup "jedi" nil t)
		   (add-hook 'python-mode-hook
			     '(lambda ()
				(define-key python-mode-map (kbd "C-c r") 'helm-jedi-related-names)
				(jedi:setup)))))

   (:name buffer-move			; have to add your own keys
	  :after (progn
		   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
		   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
		   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
		   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

   (:name smex				; a better (ido like) M-x
	  :after (progn
		   (setq smex-save-file "~/.emacs.d/.smex-items")
		   (global-set-key (kbd "M-x") 'smex)
		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

   (:name magit				; git meet emacs, and a binding
	  :after (progn
		   (global-set-key (kbd "C-x g s") 'magit-status)))

    ))

(el-get 'sync (mapcar 'el-get-source-name el-get-sources))				; 完全同步，初始化的顺序严格按照el-get-sources中的顺序完成
