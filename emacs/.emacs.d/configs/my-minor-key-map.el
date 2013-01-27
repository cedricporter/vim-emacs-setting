;;; my-minor-key-map.el
;;
;; Time-stamp: <2013-01-27 20:56:58 Sunday by Hua Liang>

;; Took from http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "M-j") 'tabbar-backward)
(define-key my-keys-minor-mode-map (kbd "M-k") 'tabbar-forward)
(define-key my-keys-minor-mode-map (kbd "C-M-j") 'tabbar-backward-group)
(define-key my-keys-minor-mode-map (kbd "C-M-k") 'tabbar-forward-group)


(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)


(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)


;;; my-minor-key-map.el ends here
