;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2014-03-16 10:08:30 Sunday by Hua Liang>

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; temp
(require 'undo-tree)
(global-undo-tree-mode)
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-flymake")
(load "~/.emacs.d/plugins/emacs-flymake/flymake.el")

(require 'el-get-status)

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.
(setq
 el-get-sources
 '(el-get				; el-get is self-hosting
   escreen            			; screen for emacs, C-\ C-h
   php-mode-improved			; if you're into php...
   switch-window			; takes over C-x o
   rainbow-mode				; show color
   rainbow-delimiters
   graphviz-dot-mode
   ;; nrepl
   slime
   coffee-mode
   htmlize
   ;; undo-tree
   ;; yascroll
   full-ack
   scss-mode
   ascii
   autopair
   eassist
   yaml-mode
   puppet-mode
   quickrun
   date-calc
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
   ;; diminish
   mmm-mode
   ;;python-magic
   dired-details
   dired-details+
   ;; ido-ubiquitous
   python-mode
   gtags
   json
   any-ini-mode
   apache-mode

   rope
   ropemacs
   ropemode
   pymacs

   go-mode

   (:name dash-at-point
          :after (progn
		   (global-set-key (kbd "C-c d") 'dash-at-point)
		   (global-set-key (kbd "C-c e") 'dash-at-point-with-docset)
		   ))

   (:name pbcopy
          :after (progn
                    ;; (turn-on-pbcopy)
                    ))

   showtip
   (:name sdcv
          :after (progn
                   (setq sdcv-dictionary-simple-list '("朗道英汉字典5.0"
   						       ;; "牛津现代英汉双解词典"
                                                       ;; "英汉双解计算机词典"
                                                       ;; "简明英汉词典"
                                                       ))
                   (global-set-key (kbd "C-c [") 'sdcv-search-pointer+)
                   (global-set-key (kbd "C-c ]") 'sdcv-search-input)))

   (:name eclim
          :after (progn
                   (global-eclim-mode)
                   (require 'eclimd)
                   (setq eclim-eclipse-dirs '("/Users/cedricporter/adt-bundle-mac-x86_64-20131030/eclipse/Eclipse.app/Contents/MacOS"))
                   ))

   (:name minimap
	  :after (progn
		   (defun minimap-toggle ()
		     "Toggle minimap for current buffer."
		     (interactive)
		     (if (not (boundp 'minimap-bufname))
		   	 (setf minimap-bufname nil))
		     (if (null minimap-bufname)
		   	 (progn (minimap-create)
		   		(set-frame-width (selected-frame) 100))
		       (progn (minimap-kill)
		   	      (set-frame-width (selected-frame) 80))))
		   (global-set-key (kbd "M-<f7>") 'minimap-toggle)
		   ))

   (:name flymake-easy
          :type elpa)

   ;; use builtin org-mode
   ;; (:name org-mode
   ;;  	  :prepare (progn
   ;;  		     (add-to-list 'load-path "~/.emacs.d/el-get/org-mode/lisp")
   ;;  		     ;; (add-to-list 'load-path "~/.emacs.d/el-get/org-mode/contrib/lisp")
   ;;  		     )
   ;;        :after (progn
   ;;  		   (setq load-path (remove "/home/cedricporter/my/share/emacs/24.2/lisp/org" load-path))
   ;;  		   (setq load-path (remove "/home/cedricporter/my/share/emacs/24.3.50/lisp/org" load-path))
   ;;  		   (require-maybe 'ox-odt)	; 如果这里不require一下，在导出那里就没有odt的选项。貌似没有自动加载...
   ;;  		   )
   ;;  	  )

   ;; use `M-x hc`
   (:name httpcode
          :website "https://github.com/rspivak/httpcode.el"
          :description "Explains the meaning of an HTTP status code in minibuffer."
          :type github
          :pkgname "rspivak/httpcode.el")

   ;; (:name emmet-mode
   ;; 	  :website "https://github.com/smihica/emmet-mode"
   ;; 	  :description "Unofficial emmet's support for emacs. http://www.emacswiki.org/emacs/ZenCoding"
   ;; 	  :type github
   ;; 	  :pkgname "smihica/emmet-mode"
   ;; 	  :after (progn
   ;; 		   (add-hook 'web-mode-hook 'emmet-mode)
   ;; 		   (setq emmet-indentation 2)
   ;; 		   (define-key emmet-mode-keymap (kbd "C-j") nil)
   ;; 		   (define-key emmet-mode-keymap (kbd "C-<return>") nil)
   ;; 		   (define-key emmet-mode-keymap (kbd "C-;") 'emmet-expand-line)
   ;; 		   (add-hook 'sgml-mode-hook 'emmet-mode)
   ;; 		   (add-hook 'css-mode-hook  'emmet-mode)
   ;; 		   ))

   ;; (:name sdcv-mode
   ;; 	  :website "https://github.com/gucong/emacs-sdcv"
   ;; 	  :description "forked version of sdcv.el or sdcv-mode.el"
   ;; 	  :type github
   ;; 	  :pkgname "gucong/emacs-sdcv"
   ;; 	  :after (progn
   ;; 		   (global-set-key (kbd "C-c [") 'sdcv-search)
   ;; 		   )
   ;; 	  )

   ;; (:name jedi
   ;;        :prepare (progn
   ;;      	     ;; (setq jedi:setup-keys t)
   ;;      	     )
   ;;        :after (progn
   ;;                 (setq jedi:setup-keys nil) ; use custom

   ;;      	   (autoload 'jedi:setup "jedi" nil t)
   ;;      	   (add-hook 'python-mode-hook 'jedi:setup)

   ;;      	   (require 'jedi)
   ;;      	   ;; I want to use my favorite Python executable.
   ;;      	   (setq jedi:server-command (list "/usr/bin/python" jedi:server-script))
   ;;      	   ))

   (:name web-mode
	  :after (progn
		   (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
		   (add-to-list 'auto-mode-alist '("\\.tmpl?\\'" . web-mode))
		   (add-to-list 'auto-mode-alist '("\\.pat?\\'" . web-mode))
                   (setq web-mode-engines-alist
                         '(("django"    . "\\.html\\'"))
                         )
		   (add-hook
		    'web-mode-hook
		    '(lambda ()
		       (local-set-key (kbd "<f7>")
				      '(lambda ()
					 (interactive)
					 (browse-url (buffer-file-name))))
		       (define-key web-mode-map (kbd "C-;") nil)
		       (local-set-key (kbd "C-c c") 'web-mode-comment-or-uncomment)
                       (setq web-mode-markup-indent-offset 4)
                       (setq web-mode-css-indent-offset 4)
                       (setq web-mode-code-indent-offset 4)
                       (setq web-mode-indent-style 4)
                       (setq tab-width 4)
		       ))
		   ))

   (:name zencoding-mode					; http://www.emacswiki.org/emacs/ZenCoding
   	  :after (progn
   		   (add-hook 'web-mode-hook 'zencoding-mode)
   		   (setq zencoding-indentation 2)
   		   (define-key zencoding-mode-keymap (kbd "C-j") nil)
   		   (define-key zencoding-mode-keymap (kbd "C-<return>") nil)
   		   (define-key zencoding-mode-keymap (kbd "C-;") 'zencoding-expand-line)
   		   ))

   (:name flymake-coffee
	  :after (progn
		   (add-hook 'coffee-mode-hook 'flymake-coffee-load)))

   (:name multiple-cursors
          :after (progn
                   (global-set-key (kbd "C->") 'mc/mark-next-like-this)
                   (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
                   (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
                   ))

   ;(:name ipython
   ;	  :after (progn
   ;		   (setq ipython-completion-command-string ;fix completion bug
   ;			 "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")))

   (:name expand-region
          :after (progn
		   (setq expand-region-guess-python-mode nil)
		   (setq expand-region-preferred-python-mode 'python-mode)
                   (global-set-key (kbd "C-=") 'er/expand-region)
		   ))

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

   (:name js3-mode
	  :after (progn
		   (add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
                   (add-hook 'js3-mode-hook '(lambda()
                                               (setq js3-indent-level 4)
                                               (setq tab-width 4)
                                               ))
                   ))

   ;; (:name js2-mode
   ;;        :after (progn
   ;;      	   (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))))

   ;; (:name evil-numbers
   ;;  	  :after (progn
   ;;  		   (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
   ;;  		   (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
   ;;  		   ))

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

   helm-ls-git
   (:name helm
	  :after (progn
		   (require 'helm-config)
		   (require 'helm-files)
                   (require 'helm-ls-git)
		   (setq helm-idle-delay 0.1)
		   (setq helm-input-idle-delay 0.1)
                   ;; (global-set-key (kbd "C-x b") 'helm-mini)
                   (global-set-key (kbd "C-x b") 'helm-for-files)
                   (global-set-key (kbd "C-x C-b") 'switch-to-buffer)
		   (global-set-key (kbd "C-c i") 'helm-imenu)
		   (loop for ext in '("\\.swf$" "\\.elc$" "\\.pyc$" "\\.odt$" "\\.pdf$")
			 do (add-to-list 'helm-c-boring-file-regexp-list ext))
		   ))


   (:name emacs-helm-gtags
          :website "https://github.com/syohex/emacs-helm-gtags.git"
          :type github
          :pkgname "syohex/emacs-helm-gtags"
          :features "helm-gtags"
          :compile "helm-gtags.el"
          :depends helm
          )

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
		   (global-set-key (kbd "C-x C-/") 'goto-last-change)))

   (:name session
	  :after (progn
                   (if (not (daemonp))
                       (progn
                         (add-hook 'after-init-hook 'session-initialize)
                         (load "desktop")
                         (setq history-length 250)
                         (desktop-save-mode 1)
                         ;; Specifying Files Not to be Opened
                         (setq desktop-buffers-not-to-save
                               (concat "\\("
                                       "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
                                       "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
                                       "\\)$"))
                         (add-to-list 'desktop-modes-not-to-save 'dired-mode)
                         (add-to-list 'desktop-modes-not-to-save 'Info-mode)
                         (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
                         (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)
                         (global-set-key (kbd "C-x g d") 'desktop-change-dir)

			 (setq session-key-dir-map '(("c" "~/git/vipbar-b2c")
						     ("u" "~/git/ugame")
						     ("m" "~/git/mg-channel")
						     ("b" "~/svn/vipbar")
						     ("n" "~/git/vip-bar-b2b")
						     ("w" "~/cedricporter@gmail.com/weekly")
						     ("o" "~/octopress")
						     ))
			 (while session-key-dir-map
			   (lexical-let* ((item (car session-key-dir-map))
				  (key (car item))
				  (path (car (cdr item))))
			     (global-set-key (kbd (concat "C-x g g " key))
					     #'(lambda () (interactive) (desktop-change-dir path)))
			     (setq session-key-dir-map (cdr session-key-dir-map)))
			   )

                         ))))

   )


   ;; (:name highlight-indentation
   ;;        after: (progn
   ;;                 (add-hook 'python-mode-hook 'highlight-indentation)))

 )

;; 完全同步，初始化的顺序严格按照el-get-sources中的顺序完成
(el-get 'sync (mapcar 'el-get-source-name el-get-sources))


;; 这些貌似没有正常加载，所以手动加载它们
(load-library "sdcv")
(load-library "python-mode")
