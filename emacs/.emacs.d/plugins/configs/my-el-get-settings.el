;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-01-25 20:13:58 Friday by Hua Liang>

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
   yasnippet
   markdown-mode
   auto-complete
   auto-complete-emacs-lisp
   auto-complete-latex
   auto-complete-css
   auto-complete-etags
   nrepl
   slime
   js2-mode
   coffee-mode
   htmlize
   undo-tree
   full-ack
   edit-server

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
		   (add-hook 'python-mode-hook '(lambda ()
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

   (:name goto-last-change		; move pointer back to last change
	  :after (progn
		   ;; when using AZERTY keyboard, consider C-x C-_
		   (global-set-key (kbd "C-x C-/") 'goto-last-change)))))

(el-get 'sync)				; 完全同步，初始化的顺序严格按照el-get-sources中的顺序完成
