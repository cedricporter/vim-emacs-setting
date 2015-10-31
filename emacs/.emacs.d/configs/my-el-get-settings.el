;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2015-10-31 10:55:02 星期六 by Hua Liang>

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     ;; (end-of-buffer)
     (goto-char (point-max))
     (eval-print-last-sexp))))

;; temp
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-flymake")
(load "~/.emacs.d/plugins/emacs-flymake/flymake.el")

(require 'el-get-status)

;; set local recipes, el-get-sources should only accept PLIST element

(setq
 el-get-sources
 '(
   (:name exec-path-from-shell
    :after (progn
	     (when (memq window-system '(mac ns))
	       (exec-path-from-shell-initialize))
	     )
    )
   ;; `C-c p C-h` to get all key binding
   (:name projectile
	  :after (progn
		   (projectile-global-mode)
		   ;; (setq projectile-enable-caching t)

		   (persp-mode)
		   (require 'persp-projectile)

		   ;; (define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)

		   (global-set-key (kbd "C-c h") 'projectile-find-file)

		   (setq projectile-globally-ignored-directories (append
		   						  '(".ropeproject/")
		   						  projectile-globally-ignored-directories))
		   (setq projectile-globally-ignored-files (append
							    '("*.svn-base" "*.o" "*.pyc" ".DS_Store"
							      "*.swp" "GPATH" "GRTAGS" "GTAGS"
							      ".emacs.desktop" ".emacs.desktop.lock"
							      )
							    projectile-globally-ignored-files))

		   ))

   (:name flx
	  :after (progn
		   (require 'flx-ido)
		   (ido-mode 1)
		   (ido-everywhere 1)
		   (flx-ido-mode 1)
		   ;; disable ido faces to see flx highlights.
		   (setq ido-enable-flex-matching t)
		   (setq ido-use-faces nil)
		   ))

   (:name guide-key
	  :after (progn
		   (guide-key-mode 1)  ; Enable guide-key-mode
		   ;; (setq guide-key/idle-delay 0.1)

		   (defun guide-key/my-hook-function-for-python-mode ()
		     (guide-key/add-local-guide-key-sequence "C-c")
		     (guide-key/add-local-guide-key-sequence "C-x")
		     (guide-key/add-local-highlight-command-regexp "rope-")
		     (guide-key/add-local-highlight-command-regexp "py-")
		     (guide-key/add-local-highlight-command-regexp "python-"))
		   (add-hook 'python-mode-hook 'guide-key/my-hook-function-for-python-mode)

		   (defun guide-key/my-hook-function-for-org-mode ()
		     (guide-key/add-local-guide-key-sequence "C-c")
		     (guide-key/add-local-guide-key-sequence "C-x")
		     (guide-key/add-local-guide-key-sequence "C-c C-x")
		     (guide-key/add-local-highlight-command-regexp "org-"))
		   (add-hook 'org-mode-hook 'guide-key/my-hook-function-for-org-mode)

		   (setq guide-key/guide-key-sequence
			 '("C-x r" "C-x 4" "C-x 5" "C-c p"
			   (org-mode "C-c C-x")
			   (outline-minor-mode "C-c @")
			   (markdown-mode "C-c C-a")
			   ))
		   (setq guide-key/recursive-key-sequence-flag t)
		   ))

   (:name undo-tree
	  :after (progn
		   (global-undo-tree-mode)
		   ))

   (:name lua-mode
	  :after (progn
		   (setq lua-indent-level 4)
		   (define-key lua-mode-map (kbd "C-.") 'ag)
		   ))

   ;; dash emacs integrate
   (:name dash-at-point
          :after (progn
		   (global-set-key (kbd "C-c d") 'dash-at-point)
		   (global-set-key (kbd "C-c e") 'dash-at-point-with-docset)
		   ))

   (:name switch-window			; takes over C-x o
	  :after (progn
		   (global-set-key (kbd "C-x o") 'switch-window)
		   ))


   (:name pbcopy
          :after (progn
                    ;; (turn-on-pbcopy)
                    ))

   (:name sdcv
          :after (progn
                   (setq sdcv-dictionary-simple-list '("朗道英汉字典5.0"
   						       ;; "牛津现代英汉双解词典"
                                                       ;; "英汉双解计算机词典"
                                                       ;; "简明英汉词典"
                                                       ))
                   (global-set-key (kbd "C-c [") 'sdcv-search-pointer+)
                   (global-set-key (kbd "C-c ]") 'sdcv-search-input)))

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

   ;; ;; not use builtin org-mode
   ;; (:name org-mode
   ;; 	  ;; :build ("make clean" "make" "make doc"
   ;; 	  ;; 	  "make INSTALL_INFO=ginstall-info infodir=~/.emacs.d/info/org install-info")
   ;;  	  :prepare (progn
   ;;  		     (add-to-list 'load-path "~/.emacs.d/el-get/org-mode/lisp")
   ;;  		     ;; (add-to-list 'load-path "~/.emacs.d/el-get/org-mode/contrib/lisp")
   ;;  		     )
   ;;        :after (progn
   ;;  		   (setq load-path (remove "/home/cedricporter/my/share/emacs/24.2/lisp/org" load-path))
   ;;  		   (setq load-path (remove "/home/cedricporter/my/share/emacs/24.3.50/lisp/org" load-path))
   ;;  		   (setq load-path (remove "/usr/local/share/emacs/24.3/lisp/org" load-path))

   ;;  		   ;; (require-maybe 'ox-odt)	; 如果这里不require一下，在导出那里就没有odt的选项。貌似没有自动加载...
   ;;  		   )
   ;;  	  )

   ;; use `M-x hc`
   (:name httpcode
          :website "https://github.com/rspivak/httpcode.el"
          :description "Explains the meaning of an HTTP status code in minibuffer."
          :type github
          :pkgname "rspivak/httpcode.el")

   (:name vimrc-mode
          :website "https://github.com/mcandre/vimrc-mode"
          :description "Enables syntax highlighting for .vimrc/_vimrc files"
          :type github
          :pkgname "mcandre/vimrc-mode"
	  :after (progn
		   (add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))
		   (add-to-list 'auto-mode-alist '(".pentadactylrc$" . vimrc-mode))
		   (add-to-list 'auto-mode-alist '(".Vromerc$" . vimrc-mode))
		   )
	  )

   (:name vlf
	  :website "https://github.com/m00natic/vlfi"
	  :description "View Large Files in Emacs"
	  :type github
	  :pkgname "m00natic/vlfi"
	  :after (progn
		   (require 'vlf-integrate)
		   (eval-after-load "vlf"
		     '(define-key vlf-prefix-map "\C-cv" vlf-mode-map))
		   )
	  )


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
   		   ;; (define-key zencoding-mode-keymap (kbd "C-j") nil)
   		   ;; (define-key zencoding-mode-keymap (kbd "C-<return>") nil)
   		   ;; (define-key zencoding-mode-keymap (kbd "C-;") 'zencoding-expand-line)
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

   (:name yasnippet
	  :after (progn
		   (load "~/.emacs.d/configs/my-yasnippet-settings.el")))

   (:name eclim
          :after (progn
                   (global-eclim-mode)
                   (require 'eclimd)
                   (setq eclim-eclipse-dirs '("/Users/cedricporter/adt-bundle-mac-x86_64-20140624/eclipse/Eclipse.app/Contents/MacOS"))
		   (require 'ac-emacs-eclim-source)
		   (ac-emacs-eclim-config)

		   ;; (setq help-at-pt-display-when-idle t)
		   ;; (setq help-at-pt-timer-delay 0.1)
		   ;; (help-at-pt-set-timer)

                   ))

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

   ;; (:name js3-mode
   ;; 	  :after (progn
   ;; 		   (add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
   ;;                 (add-hook 'js3-mode-hook '(lambda()
   ;;                                             (setq js3-indent-level 4)
   ;;                                             (setq tab-width 4)
   ;;                                             ))
   ;;                 ))

   (:name js2-mode
          :after (progn
        	   (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
		   ))

   ;; (:name evil-numbers
   ;;  	  :after (progn
   ;;  		   (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
   ;;  		   (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
   ;;  		   ))

   (:name nginx-mode
	  :after (progn
		   (add-to-list 'auto-mode-alist '("/etc/nginx/sites-available/.*" . nginx-mode))
		   (add-to-list 'auto-mode-alist '("/etc/nginx/.*\.conf$" . nginx-mode))
		   ;; (add-hook
		   ;;  'find-file-hook
		   ;;  '(lambda ()
		   ;;     (when (string-match
		   ;; 	      "^\\(/etc/nginx\\|/home/cedricporter/my\\).*?\\.\\(com\\|org\\|net\\|conf\\)$"
		   ;; 	      (buffer-file-name))
		   ;; 	 (nginx-mode)
		   ;; 	 )))
		   ))

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
		   (require 'helm-files)
                   ;(require 'helm-ls-git)
		   (setq helm-idle-delay 0.1)
		   (setq helm-input-idle-delay 0.1)
                   ;; (global-set-key (kbd "C-x b") 'helm-mini)
                   (global-set-key (kbd "C-x b") 'helm-projectile)
                   (global-set-key (kbd "C-x C-b") 'switch-to-buffer)
		   (global-set-key (kbd "C-c i") 'helm-imenu)
		   (loop for ext in '("\\.swf$" "\\.elc$" "\\.pyc$" "\\.odt$" "\\.pdf$")
			 do (add-to-list 'helm-c-boring-file-regexp-list ext))
		   ))

   ;; helm-ls-git  ;; this is replaced by projectile

   (:name helm-ag
	  :after (progn
		   (global-set-key (kbd "M-g .") 'helm-ag)
		   (global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
		   (setq helm-ag-insert-at-point 'symbol)
		   ))

   helm-gtags
   ;; (:name emacs-helm-gtags
   ;;        :website "https://github.com/syohex/emacs-helm-gtags.git"
   ;;        :type github
   ;;        :pkgname "syohex/emacs-helm-gtags"
   ;;        :features "helm-gtags"
   ;;        :compile "helm-gtags.el"
   ;;        :depends helm
   ;;        )

   ;; List match lines to another buffer.
   ;; https://github.com/ShingoFukuyama/helm-swoop
   (:name helm-swoop
	  :after (progn
		   (global-set-key (kbd "M-i") 'helm-swoop)
		   (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
		   ))

   (:name buffer-move			; have to add your own keys
	  :after (progn
		   (global-set-key (kbd "<C-s-up>")     'buf-move-up)
		   (global-set-key (kbd "<C-s-down>")   'buf-move-down)
		   (global-set-key (kbd "<C-s-left>")   'buf-move-left)
		   (global-set-key (kbd "<C-s-right>")  'buf-move-right)
		   ))

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

						     ("l" "~/projects/learn-lua/")
						     ("e" "~/games/everlost")

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

   ;; (:name highlight-indentation
   ;;        after: (progn
   ;;                 (add-hook 'python-mode-hook 'highlight-indentation)))

   ;; A minor mode which displays current match and total matches information
   ;; in the mode-line in various search mode.
   ;; https://github.com/syohex/emacs-anzu
   (:name anzu
	  :after (progn
		   (global-anzu-mode +1)
		   (global-set-key (kbd "M-%") 'anzu-query-replace)
		   (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)
		   (defun my/anzu-update-func (here total)
		     (propertize (format "<%d/%d> " here total)
				 'face '((:foreground "chocolate1" :weight bold))))
		   (setq anzu-mode-line-update-function 'my/anzu-update-func)
		   ))

   ;; https://github.com/syohex/emacs-git-gutter
   (:name git-gutter
   	  :after (progn
   		   ;; If you enable global minor mode
   		   (global-git-gutter-mode t)

   		   ;; If you would like to use git-gutter.el and linum-mode
   		   (git-gutter:linum-setup)

   		   (add-to-list 'git-gutter:update-hooks 'focus-in-hook)
   		   (add-to-list 'git-gutter:update-commands 'other-window)
   		   (add-to-list 'git-gutter:update-commands 'switch-window)
   		   (add-to-list 'git-gutter:update-commands 'tabbar-backward)
   		   (add-to-list 'git-gutter:update-commands 'tabbar-forward)

   		   (set-face-background 'git-gutter:modified "purple") ;; background color
   		   (set-face-foreground 'git-gutter:added "yellow")
   		   (set-face-foreground 'git-gutter:deleted "red")

   		   ;; ;; If you enable git-gutter-mode for some modes
   		   ;; (add-hook 'emacs-lisp-mode-hook 'git-gutter-mode)
   		   ;; (add-hook 'ruby-mode-hook 'git-gutter-mode)
   		   ;; (add-hook 'python-mode-hook 'git-gutter-mode)

   		   (global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
   		   ;; (global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

   		   ;; Jump to next/previous hunk
   		   (global-set-key (kbd "C-x g p") 'git-gutter:previous-hunk)
   		   (global-set-key (kbd "C-x g n") 'git-gutter:next-hunk)

   		   ;; ;; Stage current hunk
   		   ;; (global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

   		   ;; ;; Revert current hunk
   		   ;; (global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)
   		   ))

   ;; Minor mode for editing parentheses. Strict parenthesis auto-pairing and easy depth adjustment.
   ;; Compatible with Lisp/Scheme/Clojure.
   (:name paredit
	  :after (progn
		   (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
		   (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
		   (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
		   (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
		   (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
		   (add-hook 'scheme-mode-hook           #'enable-paredit-mode)

                   ;; (add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
                   ;; ;; Stop SLIME's REPL from grabbing DEL,
                   ;; ;; which is annoying when backspacing over a '('
                   ;; (defun override-slime-repl-bindings-with-paredit ()
                   ;;   (define-key slime-repl-mode-map
                   ;;     (read-kbd-macro paredit-backward-delete-key) nil))
                   ;; (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

		   ))

   (:name color-theme-solarized
          :after (progn
                   (load "~/.emacs.d/configs/my-themes.el")
                   )
          )

   (:name slime
          :after (progn
                   (load "~/.emacs.d/configs/my-lisp-settings.el")
                   ))

   ))

;; now set our own packages
(setq
 my:el-get-packages
 '(el-get				; el-get is self-hosting
   ;; diminish
   ;; ido-ubiquitous
   ;; nrepl
   ;; yascroll

   showtip
   git-timemachine
   perspective
   auto-complete-emacs-lisp
   auto-complete-latex
   auto-complete-css
   auto-complete-etags
   ag
   ;; any-ini-mode
   apache-mode
   ascii
   auto-complete			; complete as you type with overlays
   autopair
   browse-kill-ring
   browse-kill-ring+
   coffee-mode
   csharp-mode
   date-calc
   dired-details
   dired-details+
   eassist
   ein
   escreen            			; screen for emacs, C-\ C-h
   flymake-cursor
   full-ack
   go-mode
   google-c-style
   graphviz-dot-mode
   gtags
   highlight-parentheses
   htmlize
   json
   mmm-mode
   php-mode-improved			; if you're into php...
   puppet-mode
   pymacs
   python-mode
   quickrun
   ibuffer-vc
   rainbow-delimiters
   rainbow-mode				; show color
   rope
   ropemacs
   ropemode
   scss-mode
   second-sel
   switch-window			; takes over C-x o
   tabbar
   xcscope
   xcscope+
   xml-rpc
   yaml-mode
   ;; zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
))

(setq my:el-get-packages
      (append my:el-get-packages
              (mapcar #'el-get-source-name el-get-sources)))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)

;; 这些貌似没有正常加载，所以手动加载它们
(load-library "python-mode")
