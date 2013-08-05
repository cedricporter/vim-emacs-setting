;;; my-themes.el ---
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>
;; Time-stamp: <2013-08-02 15:48:35 Friday by Hua Liang>


;;==================== color theme ====================
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0/")
(require 'color-theme)
(load-file "~/.emacs.d/plugins/color-theme-6.6.0/themes/color-theme-library.el")

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/zenburn-emacs")

;; change font key bindings
(defun change-my-theme (theme-num)
  (save-excursion
    (progn
      (let ((origin-buffer (current-buffer)))
      (find-file "~/.emacs.d/configs/my-themes.el")
      (goto-char 0)
      (while (search-forward-regexp "^(set-theme [0-9]+)" nil t)
        (save-restriction
          (narrow-to-region (match-beginning 0) (match-end 0))
          (replace-match (format "(set-theme %d)" theme-num))
          (eval-region (region-beginning) (region-end))
          )
        )
      (save-buffer)
      (switch-to-buffer origin-buffer)
      ))))

(setq my-theme-list '((1 . color-theme-taylor-et)
                      (2 . (lambda () (load-theme 'tango t)))
                      (3 . (lambda () (load-theme 'zenburn t)))
                      (4 . (lambda () (load-theme 'Amelie t)))
                      ))

(dolist (item my-theme-list)
  (let ((theme-num (car item)))
    (global-set-key (kbd (format "C-c , t %d" theme-num))
                    `(lambda ()
                       (interactive)
                       (change-my-theme ,theme-num)))))

(defun set-theme (what-theme)
  (funcall (cdr (assoc what-theme my-theme-list))))

;; set theme according to theme number
(set-theme 3)
;; end

;; solarized
;(add-to-list 'load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
;(require 'color-theme-solarized)
;(load-theme 'solarized-light t)

;;-------------------- color theme --------------------





;;; my-themes.el ends here
