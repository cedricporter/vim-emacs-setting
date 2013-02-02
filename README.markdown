# 我的各种配置文件

## Vim
I have a long time no using vim.

## Visual Studio
The most powerful IDE in Windows.

## Install of my config
[Dangerous] Just run install.sh, it will link `~/{.emacs,.emacs.d,.vim,.vimrc}` to the according config.

## Emacs
Emacs is the most powerful tool for me.

I love my Emacs very much.

### 定制的按键绑定 ###

1. (define-key my-keys-minor-mode-map (kbd "M-j") 'tabbar-backward)
1. (define-key my-keys-minor-mode-map (kbd "M-k") 'tabbar-forward)
1. (define-key my-keys-minor-mode-map (kbd "C-M-j") 'tabbar-backward-group)
1. (define-key my-keys-minor-mode-map (kbd "C-M-k") 'tabbar-forward-group)
1. (define-key my-keys-minor-mode-map (kbd "<C-return>") 'open-line-below)
1. (define-key my-keys-minor-mode-map (kbd "<C-S-return>") 'open-line-above)
1. ;;(global-set-key [(kdb "C-u")] 'evil-scroll-up)
1. (define-key evil-normal-state-map ",i" 'ibuffer)
1. (define-key evil-normal-state-map ",bs" 'ido-switch-buffer)
1. (define-key evil-normal-state-map ",bd" 'kill-this-buffer)
1. ;(define-key evil-normal-state-map ",m" 'magit-status)
1. (define-key evil-normal-state-map ",w" 'save-buffer)
1. (define-key evil-normal-state-map ",ee" 'open-setting-file)
1. (define-key evil-normal-state-map "ZZ" (kbd "C-c C-c"))
1. (define-key evil-normal-state-map ",a" 'org-agenda)
1. (define-key evil-normal-state-map ",hv" 'describe-variable)
1. (define-key evil-normal-state-map ",hk" 'describe-key)
1. (define-key evil-normal-state-map ",hf" 'describe-function)
1. (define-key evil-normal-state-map ",hm" 'describe-mode)
1. (define-key evil-normal-state-map ",0" 'delete-window)         ;delete this window, same as C-x 0 
1. (define-key evil-normal-state-map ",1" 'delete-other-windows)  ;delete other windows
1. (define-key evil-normal-state-map ",2" 'split-window-up-down)  ;split the window to up and down windows, which the upper one is bigger
1. (define-key evil-normal-state-map ",3" 'split-window-3)        ;split the window to 3 window, left big
1. (define-key evil-normal-state-map ",4" 'split-window-4)        ;split the window into 4 equal size window
1. (define-key evil-normal-state-map ",q" 'winner-undo)	       ;undo, in other word, restore to previous window style
1. (define-key evil-normal-state-map ",Q" 'winner-redo)	       ;redo window style change
1. (global-set-key (kbd (format "C-c , t %d" theme-num))
1. (global-set-key [(control f11)] 'my-fullscreen)
1. (global-set-key (kbd "C-x 4 4") 'split-window-4)
1. (global-set-key (kbd "C-x 4 2") 'split-window-up-down)
1. (global-set-key (kbd "C-x 4 3") 'split-window-3)
1. (global-set-key (kbd "C-x 4 r")  (quote roll-v-3))
1. (global-set-key (kbd "M-1") 'delete-other-windows)
1. (global-set-key (kbd "M-2") 'split-window-below)
1. (global-set-key (kbd "M-3") 'split-window-right)
1. (global-set-key (kbd "M-0") 'delete-window)
1. (global-set-key (kbd "M-4") 'winner-undo)
1. (global-set-key (kbd "M-5") 'winner-redo)
1. (global-set-key (kbd "M-6") 'change-split-type-auto) ; 左旋或者右旋
1. (global-set-key (kbd "M-9") 'transpose-buffers)
1. (global-set-key (kbd "C-S-j") 'windmove-down)
1. (global-set-key (kbd "C-S-k") 'windmove-up)
1. (global-set-key (kbd "C-S-h") 'windmove-left)
1. (global-set-key (kbd "C-S-l") 'windmove-right)
1. (global-set-key (kbd "C-c , e") 'open-setting-file)
1. (global-set-key [(control s)] 'isearch-forward-regexp)
1. (global-set-key [(control meta s)] 'isearch-forward)
1. (global-set-key [(control r)] 'isearch-backward-regexp)
1. (global-set-key [(control meta r)] 'isearch-backward)
1. (global-set-key (kbd "C-x C-b") 'ibuffer)
1. (global-set-key (kbd "M-SPC") 'set-mark-command)
1. ;; (global-set-key "\C-m" 'newline-and-indent)
1. ;(global-set-key (kbd "RET") 'newline-and-indent)
1. (global-set-key (kbd "M-<return>") 'newline)
1. ;; (global-set-key "\M-f" 'forward-same-syntax)
1. ;; (global-set-key "\M-b" (lambda () (interactive) (forward-same-syntax -1)))
1. ;; (global-set-key "\M-d" 'kill-syntax)
1. ;; (global-set-key [(meta backspace)] (lambda() (interactive) (kill-syntax -1) ) )
1. (global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
1. (global-set-key (kbd "C-c b") 'comment-box)
1. (global-set-key (kbd "C-c k") 'comment-kill)
1. (global-set-key [(f5)] 'speedbar)
1. (global-set-key (kbd "C-c o s") 'sudo-reopen-file)
1. (global-set-key (kbd "C-t") 'my-go-to-char)
1. (global-set-key (kbd "C-`") 'switch-to-previous-buffer)
1. (global-set-key (kbd "M-Z") 'zap-up-to-char)
1. (global-set-key (kbd "C-x C-S-c") 'kill-emacs)
1. (global-set-key (kbd "M-7") 'previous-buffer)
1. (global-set-key (kbd "M-8") 'next-buffer)
1. (global-set-key (kbd "<C-return>") 'open-line-below) ; conflict with semantic, set in my minor
1. (global-set-key (kbd "<C-S-return>") 'open-line-above)
1. (define-key coffee-mode-map (kbd "<f7>")
1. (define-key coffee-mode-map (kbd "C-j")
1. (global-set-key [(meta j)] 'tabbar-backward)
1. (global-set-key [(meta k)] 'tabbar-forward)
1. (global-set-key [(control meta j)] 'tabbar-backward-group)
1. (global-set-key [(control meta k)] 'tabbar-forward-group)
1. (global-set-key (kbd "<C-f1>") 'my-ecb-active-or-deactive)
1. (define-key ecb-mode-map (kbd "<C-f2>") 'ecb-toggle-ecb-windows)
1. `(define-key ecb-mode-map ,key
1. (global-set-key (kbd "C-M-1") 'ecb-goto-window-methods)
1. (global-set-key (kbd "C-M-2") 'ecb-goto-window-edit1)
1. (global-set-key (kbd "C-M-3") 'ecb-goto-window-edit2)
1. (global-set-key (kbd "C-M-4") 'ecb-goto-window-sources)
1. (global-set-key (kbd "C-M-5") 'ecb-goto-window-history)
1. (define-key markdown-mode-map
1. (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
1. (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
1. (local-set-key "\C-c>" 'semantic-comsemantic-ia-complete-symbolplete-analyze-inline)
1. (local-set-key "\C-c=" 'semantic-decoration-include-visit)
1. (local-set-key (kbd "C-.") 'semantic-ia-fast-jump)
1. (local-set-key (kbd "C->")  ;; go back
1. (local-set-key "\C-cq" 'semantic-ia-show-doc)
1. ;  (local-set-key "\C-cs" 'semantic-ia-show-summary)
1. (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
1. ;;  (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
1. ;;  (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)
1. ;; (local-set-key "." 'semantic-complete-self-insert)
1. ;; (local-set-key ">" 'semantic-complete-self-insert)
1. (local-set-key "\C-ct" 'eassist-switch-h-cpp)
1. (local-set-key "\C-xt" 'eassist-switch-h-cpp)
1. (local-set-key "\C-ce" 'eassist-list-methods)
1. (local-set-key "\C-c\C-r" 'semantic-symref)
1. (global-set-key [f7] 'alexott/compile)
1. (global-set-key [f4] 'eshell)
1. (global-set-key [S-f4] 'term)
1. ;(global-set-key (kbd "s-s") 'my-screenshot)
1. (global-set-key "\C-c\C-ep" 'flymake-goto-prev-error)
1. (global-set-key "\C-c\C-en" 'flymake-goto-next-error)
1. (global-set-key (kbd "C-=") 'er/expand-region)))
1. (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
1. (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
1. (global-set-key (kbd "M-l") 'ace-jump-mode)
1. (global-set-key (kbd "C-x b") 'helm-mini)))
1. (define-key python-mode-map (kbd "C-c r") 'helm-jedi-related-names)
1. (global-set-key (kbd "<C-S-up>")     'buf-move-up)
1. (global-set-key (kbd "<C-S-down>")   'buf-move-down)
1. (global-set-key (kbd "<C-S-left>")   'buf-move-left)
1. (global-set-key (kbd "<C-S-right>")  'buf-move-right)))
1. (global-set-key (kbd "M-x") 'smex)
1. (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
1. (global-set-key (kbd "C-x g s") 'magit-status)))
1. (define-key ac-mode-map [(control tab)] 'auto-complete)
1. (define-key emacs-lisp-mode-map (kbd "C-x C-r") 'eval-region)
1. (define-key lisp-interaction-mode-map (kbd "C-x C-r") 'eval-region)
1. (define-key c-mode-base-map [(f11)] 'gud-step) ; step in
1. (define-key c-mode-base-map [(f10)] 'gud-next) ; step out
1. (define-key c-mode-base-map [(f5)] 'gud-go)
1. (define-key c-mode-base-map [(shift f5)] 'gud-cont)
1. (define-key c-mode-base-map [(control f5)] 'gud-until) ; run to here
1. (define-key c-mode-base-map [(f9)] 'gud-break) ; set break point
1. (define-key c-mode-base-map [(control f9)] 'gud-remove) ; remove break point
1. (define-key c-mode-base-map [(shift f11)] 'gud-finish) ; jump out of the function
1. (define-key gud-mode-map [(f11)] 'gud-step)
1. (define-key gud-mode-map [(f10)] 'gud-next)
1. (define-key gud-mode-map [(f9)] 'gud-cont)
1. (define-key gud-mode-map [(shift f11)] 'gud-finish)
1. (define-key c-mode-base-map (kbd "<f12>") 'cscope-find-global-definition-no-prompting)
1. (define-key c-mode-base-map (kbd "<C-f12>") 'cscope-find-this-symbol)
1. (define-key c-mode-base-map (kbd "S-<f12>") 'cscope-pop-mark)
1. (define-key cscope-list-entry-keymap (kbd "<f12>") 'cscope-select-entry-other-window)
1. (define-key cscope-list-entry-keymap (kbd "S-<f12>") 'cscope-pop-mark)
1. (global-set-key (kbd "C-o") 'recent-jump-backward)
1. (global-set-key (kbd "M-o") 'recent-jump-forward)
1. (global-set-key "\C-c\C-k" 'browse-kill-ring)
1. ;(global-set-key "\C-x\C-f" 'ido-dired)
1. (global-set-key "\C-c\C-f" 'find-file-at-point)
1. (define-key dired-mode-map
1. (define-key dired-mode-map
1. (define-key emacs-lisp-mode-map (kbd "C-.") 'find-function)
1. (define-key emacs-lisp-mode-map (kbd "<f12>") 'find-function)
1. (define-key emacs-lisp-mode-map (kbd "C-c v") 'find-variable)
1. (global-set-key (kbd "M-u") 'toggle-case)
1. (define-key org-mode-map (kbd "C-<tab>") 'pcomplete)
1. (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))
1. (define-key yas/keymap [tab] 'yas/next-field)))
1. (global-set-key (kbd "C-c o n") '(lambda (title) ;isolate new post for better preview
1. (global-set-key (kbd "C-c o p") 'octopress-new-page)
1. (global-set-key (kbd "C-c o i") 'octopress-isolate)
1. (global-set-key (kbd "C-c o d") '(lambda (arg) ; write diary
1. (define-key markdown-mode-map (kbd "C-c d") 'add-strike-for-list)
1. (define-key markdown-mode-map (kbd "C-c C-s s") 'markdown-screenshot)
1. (define-key markdown-mode-map (kbd "C-c C-s i") 'markdown-insert-image-from-clipboard)
