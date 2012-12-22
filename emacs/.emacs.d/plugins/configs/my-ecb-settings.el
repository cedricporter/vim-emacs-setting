;; ==================== ecb ====================
(add-to-list 'load-path "~/.emacs.d/plugins/ecb-2.40")
(require 'ecb)
(setq-default ecb-tip-of-the-day nil)

(defun my-ecb-active-or-deactive ()
  (interactive)
  (if ecb-minor-mode
      (ecb-deactivate)
    (ecb-activate)))
(global-set-key (kbd "<C-f1>") 'my-ecb-active-or-deactive)
(define-key ecb-mode-map (kbd "<C-f2>") 'ecb-toggle-ecb-windows)

(ecb-layout-define "my-cscope-layout" left nil
                   (ecb-set-methods-buffer)
                   (ecb-split-ver 0.5 t)
                   (other-window 1)
                   (ecb-set-sources-buffer) ; (ecb-set-history-buffer)
                   (ecb-split-ver 0.25 t)
                   (other-window 1)
                   (ecb-set-cscope-buffer))

(defecb-window-dedicator-to-ecb-buffer ecb-set-cscope-buffer
    " *ECB cscope-buf*" nil
  "docstring of cscope buffer"
  (switch-to-buffer "*cscope*"))

(defmacro set-key-for-ecb-layout (key layout-name)
  `(define-key ecb-mode-map ,key
    '(lambda ()
       (interactive)
       (ecb-layout-switch ,layout-name))))

(set-key-for-ecb-layout (kbd "C-c . 1") "my-cscope-layout")
(set-key-for-ecb-layout (kbd "C-c . 2") "left10")
(set-key-for-ecb-layout (kbd "C-c . 3") "left-dir-plus-speedbar")

;; --------------------  ecb --------------------

(provide 'my-ecb-settings)
