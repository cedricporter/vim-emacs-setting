;;; my-coffee-script.el ---

;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>
;; Time-stamp: <2013-01-25 22:24:11 Friday by Hua Liang>

;; ==================== coffee-script ====================
(defun my-coffee-script-setup ()
  (define-key coffee-mode-map (kbd "<f7>")
    '(lambda ()
       (interactive)
       (delete-other-windows)
       (split-window-horizontally)
       (coffee-compile-file)
       (find-file-other-window (coffee-compiled-file-name))
       (other-window 1)))
  (define-key coffee-mode-map (kbd "C-j")
    'coffee-newline-and-indent)
  )

(defun revert-compiled-coffee-buffer ()
  (interactive)
  (coffee-compile-file)
  (let ((js-buffer-name (concat (file-name-sans-extension (buffer-name (current-buffer))) ".js")))
    (if (not (get-buffer js-buffer-name))
	my-coffee-script-setup)
    (with-current-buffer js-buffer-name
      (revert-buffer nil t))))

(add-hook 'coffee-mode-hook
	  '(lambda ()
	     (my-coffee-script-setup)
	     (add-hook 'after-save-hook
		       'revert-compiled-coffee-buffer
		       nil t)))

;; -------------------- coffee-script --------------------



;;; my-coffee-script.el ends here
