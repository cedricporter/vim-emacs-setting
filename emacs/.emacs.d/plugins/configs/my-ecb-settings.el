;; ==================== ecb ====================
(add-to-list 'load-path "~/.emacs.d/plugins/ecb-2.40")
(require 'ecb)
(setq-default ecb-tip-of-the-day nil)

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

(setq ecb-layout-name "my-cscope-layout")

(setq ecb-history-make-buckets 'never)

;; --------------------  ecb --------------------


(provide 'my-ecb-settings)
