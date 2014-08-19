;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2014-08-19 21:52:25 Tuesday by Hua Liang>


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

    ;; For Linux
    ;; (call-process-shell-command "scrot" nil nil nil (concat "-s " "\"" full-file-name "\""))

    ;; For Mac OS X
    (call-process-shell-command "screencapture" nil nil nil (concat "-i " "\"" full-file-name "\""))
    (call-process-shell-command "convert" nil nil nil (concat "\"" full-file-name "\"" " -resize " "\" 800x> \"" "\"" full-file-name "\""))
    file-name
    ))

					;(global-set-key (kbd "s-s") 'my-screenshot)
;; -------------------- screenshot --------------------


;; base on http://emacswiki.org/emacs/CopyAndPaste
(defun get-clipboard-contents-as-string ()
    "Return the value of the clipboard contents as a string."
    (let ((x-select-enable-clipboard t))
      (or (if (fboundp 'x-cut-buffer-or-selection-value) (x-cut-buffer-or-selection-value))
          (if (fboundp 'x-last-selected-text-clipboard) x-last-selected-text-clipboard)
	  (if (fboundp 'pbcopy-selection-value) (pbcopy-selection-value))
          )
      ))


(defun copy-file-from-clipboard-to-path (dst-dir)
  "copy file to desired path from clipboard"
  (interactive)
  (message "[copy-file-from-clipboard-to-path]")
  (message dst-dir)
  (let* ((full-file-name) (file-name) (ext) (new-file-name))
    (setq full-file-name (get-clipboard-contents-as-string))
    ;; Copy QQ screenshot file for Mac OS X
    (when (string-equal system-type "darwin")
	(setq full-file-name (concat "~/Pictures/com.tencent.ScreenCapture/" full-file-name))
	(message full-file-name)
      )
    (when (eq (search "file://" full-file-name) 0)
	(setq full-file-name (substring full-file-name 7))
	(message full-file-name)
      )
    (if (or (eq (search "/" full-file-name) 0) (string-equal system-type "darwin"))
	(progn
	  (setq file-name (my-base-name full-file-name))
	  (setq ext (concat "." (file-name-extension file-name)))
	  (setq new-file-name
		(concat (make-temp-name
			 (concat (substring file-name 0
					    (search "." file-name :from-end t))
				 (format-time-string "_%Y%m%d_%H%M%S_"))) ext))
	  (setq new-full-file-name (concat dst-dir new-file-name))
	  (copy-file full-file-name new-full-file-name)
	  (message full-file-name new-full-file-name)
	  (message new-full-file-name)
	  (message "------")
	  (chmod new-full-file-name (file-modes-symbolic-to-number "u=rw,go=r"))
	  new-file-name
	  )
      )))

;; borrow from http://alpha-blog.wanglianghome.org/2010/08/26/emacs-startup-log/
(defmacro require-maybe (feature &optional file)
  "*Try to require FEATURE, but don't signal an error if `require' fails."
  `(let ((require-result (require ,feature ,file 'noerror)))
     (with-current-buffer (get-buffer-create "*Startup Log*")
       (let* ((startup-log-format-string-prefix "%-20s--------[")
              (startup-log-format-string-postfix "%s")
              (startup-status (if require-result "LOADED" "FAILED"))
              (startup-status-face `(face (:foreground
                                           ,(if require-result "green" "red")))))
         (insert (format startup-log-format-string-prefix ,feature))
         (let ((start-pos (point)))
           (insert (format startup-log-format-string-postfix startup-status))
           (add-text-properties start-pos (point) startup-status-face)
           (insert "]\n"))))
     require-result))

;; -------------------- My Functions --------------------


;; (provide 'my-functions)
