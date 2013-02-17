;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-02-08 12:07:33 Friday by Hua Liang>

;; ==================== octopress ====================
(require 'octopress)
(setq octopress-workdir (expand-file-name "~/octopress"))

(global-set-key (kbd "C-c o n") '(lambda (title) ;isolate new post for better preview
                                   (interactive "MTitle: ")
                                   (octopress-new-post title)
                                   (octopress-isolate)))
(global-set-key (kbd "C-c o p") 'octopress-new-page)
(global-set-key (kbd "C-c o i") 'octopress-isolate)
(global-set-key (kbd "C-c o d") '(lambda (arg) ; write diary
				   (interactive "P")
				   (find-file "~/diary/index.md")
				   (if arg
				       (message "just open diary")
				       (progn
					 (goto-char 0)
					 (search-forward "---")
					 (search-forward "---")
					 (insert (format-time-string
						  (concat "\n# %Y-%m-%d %T %A "
							  (if arg "" "姐家")
							  "\n\n\n\n-----\n")))
					 (backward-char 8)))
				   ))

;; -------------------- octopress --------------------


;; ==================== markdown-mode ====================
(defun add-strike-for-list ()
  (interactive)
  (beginning-of-line)
  (forward-char 3)
  (insert "<del>")
  (end-of-line)
  (insert "</del>")
  )

;; -------------------- markdown-mode --------------------


;; ==================== ac-source ====================
(defun mysource-octopress ()
  (let ((line-text (thing-at-point 'line)))
    (cond ((string-match "^\\(tags:\\|categories:\\)" line-text)
	   (split-string (shell-command-to-string (concat "~/bin/tags.py " "~/octopress/source"))))
	  ;; ((string-match "^categories:" line-text)
	  ;;  (directory-files "~/octopress/public/category")))
	  )
    ))

(defvar ac-source-octopress
  '((candidates . mysource-octopress)
    ))

(defun ac-octopress-setup ()
  (setq ac-sources '(ac-source-octopress)))

(add-hook 'markdown-mode-hook 'ac-octopress-setup)
;; -------------------- ac-source --------------------



;; ==================== orgmode-octopress ====================
;(require 'org-octopress)
;; -------------------- orgmode-octopress --------------------



(setq octopress-image-dir (expand-file-name "~/octopress/source/imgs/"))
(setq octopress-image-url "/imgs/")

;; Screenshot
(defun markdown-screenshot (arg)
  "Take a screenshot for Octopress"
  (interactive "P")
  (let* ((dir_path octopress-image-dir)
	 (url (concat octopress-image-url (my-screenshot dir_path))))
    (if arg
	(insert "![](" url ")")
      (insert "{% img " url " %}"))))

;; Insert Image From Clip Board
(defun markdown-insert-image-from-clipboard (arg)
  "Insert an image from clipboard and copy it to desired path"
  (interactive "P")
  (let ((url (concat octopress-image-url (copy-file-from-clipboard-to-path octopress-image-dir))))
    (if arg
	(insert "![](" url ")")
      (insert "{% img " url " %}"))))


(add-hook 'markdown-mode-hook
	  '(lambda ()
	     (define-key markdown-mode-map (kbd "C-c d") 'add-strike-for-list)
	     (define-key markdown-mode-map (kbd "C-c C-s s") 'markdown-screenshot)
	     (define-key markdown-mode-map (kbd "C-c C-s i") 'markdown-insert-image-from-clipboard)
	     ))

;; (provide 'my-octopress-settings)
