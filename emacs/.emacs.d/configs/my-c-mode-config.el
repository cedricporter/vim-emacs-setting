;;; my-c-mode-config.el
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>

;; http://stackoverflow.com/questions/3801147/how-can-can-i-get-emacs-to-insert-closing-braces-automaticallye
(defun my-c-mode-insert-lcurly ()
  (interactive)
  (insert "{")
  (let ((pps (syntax-ppss)))
    (when (and (eolp) (not (or (nth 3 pps) (nth 4 pps)))) ;; EOL and not in string or comment
      (c-indent-line)
      (insert "\n\n}")
      (c-indent-line)
      (forward-line -1)
      (c-indent-line))))

(define-key c-mode-base-map "{" 'my-c-mode-insert-lcurly)

;;; my-c-mode-config.el ends here
