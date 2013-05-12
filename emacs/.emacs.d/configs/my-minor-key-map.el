;;; my-minor-key-map.el
;;
;; Time-stamp: <2013-05-10 21:31:40 Friday by Hua Liang>

;; Took from http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

;; tabbar
(define-key my-keys-minor-mode-map (kbd "M-j") 'tabbar-backward)
(define-key my-keys-minor-mode-map (kbd "M-k") 'tabbar-forward)
(define-key my-keys-minor-mode-map (kbd "C-M-j") 'tabbar-backward-group)
(define-key my-keys-minor-mode-map (kbd "C-M-k") 'tabbar-forward-group)

;; open new line
(define-key my-keys-minor-mode-map (kbd "<C-return>") 'open-line-below)
(define-key my-keys-minor-mode-map (kbd "<C-S-return>") 'open-line-above)

(define-key my-keys-minor-mode-map (kbd "C->") 'mc/mark-next-like-this)


;; ==================== tab ====================
(define-key my-keys-minor-mode-map (kbd "<C-M-tab>") (lambda ()
                                                     (interactive)
                                                     (insert "\t")))
;; -------------------- tab --------------------



(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)


(defun disable-my-keys-minor-mode ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'disable-my-keys-minor-mode)
(add-hook 'org-mode-hook 'disable-my-keys-minor-mode)

;;; my-minor-key-map.el ends here
