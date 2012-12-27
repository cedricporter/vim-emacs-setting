
;; ==================== My Functions ====================


(defun my-base-name (file-name)
  (car (last (split-string file-name "\\/"))))

;; ==================== screenshot ====================
;; based on [http://dreamrunner.org/wiki/public_html/Emacs/org-mode.html, http://lists.gnu.org/archive/html/emacs-orgmode/2011-07/msg01292.html]

(defun my-screenshot (dir_path)
  "Take a screenshot and save it to dir_path path.
Return image filename without path so that you can concat with your
opinion. "
  (interactive)
  (let* ((full-file-name
	  (concat (make-temp-name (concat dir_path (buffer-name) "_" (format-time-string "%Y%m%d_%H%M%S_"))) ".png"))
	 (file-name (my-base-name full-file-name))
	 )
    (call-process-shell-command "scrot" nil nil nil (concat "-s " "\"" full-file-name "\""))
    file-name
    ))

					;(global-set-key (kbd "s-s") 'my-screenshot)
;; -------------------- screenshot --------------------


;; base on http://emacswiki.org/emacs/CopyAndPaste
(defun get-clipboard-contents-as-string ()
    "Return the value of the clipboard contents as a string."
    (let ((x-select-enable-clipboard t))
      (or (x-cut-buffer-or-selection-value)
          x-last-selected-text-clipboard)))


(defun copy-file-from-clipboard-to-path (dst-dir)
  "copy file to desired path from clipboard"
  (interactive)
  (let* ((full-file-name) (file-name) (ext) (new-file-name))
    (setq full-file-name (get-clipboard-contents-as-string))
    (if (eq (search "file://" full-file-name) 0)
	(progn
	  (setq full-file-name (substring full-file-name 7))
	  (setq file-name (my-base-name full-file-name))
	  (setq ext (concat "." (file-name-extension file-name)))
	  (setq new-file-name
		(concat (make-temp-name
			 (concat (substring file-name 0
					    (search "." file-name :from-end t))
				 (format-time-string "_%Y%m%d_%H%M%S_"))) ext))
	  (setq new-full-file-name (concat dst-dir new-file-name))
	  (copy-file full-file-name new-full-file-name)
	  new-file-name
	  )
      )))
;; -------------------- My Functions --------------------


(provide 'my-functions)
