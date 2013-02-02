;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-02-02 17:37:09 Saturday by Hua Liang>

(define-key emacs-lisp-mode-map (kbd "C-x C-r") 'eval-region)
(define-key lisp-interaction-mode-map (kbd "C-x C-r") 'eval-region)

;; ;; parenthese
;; (add-hook 'emacs-lisp-mode-hook
;;           '(lambda ()
;;              (highlight-parentheses-mode)
;;              (setq autopair-handle-action-fns
;;                    (list 'autopair-default-handle-action
;;                          '(lambda (action pair pos-before)
;;                             (hl-paren-color-update))
;; 			 ))))

;; (provide 'my-emacs-lisp-settings)
