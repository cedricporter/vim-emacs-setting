;; ==================== octopress ====================
(require 'octopress)
(setq octopress-workdir (expand-file-name "~/octopress"))
(global-set-key (kbd "C-c o n") 'octopress-new-post)
(global-set-key (kbd "C-c o p") 'octopress-new-page)
;; -------------------- octopress --------------------


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
  "Insert an image from clipboard and copy it to disired path"
  (interactive "P")
  (let ((url (concat octopress-image-url (copy-file-from-clipboard-to-path octopress-image-dir))))
    (if arg
	(insert "![](" url ")")
      (insert "{% img " url " %}"))))

(define-key markdown-mode-map (kbd "C-c C-s s") 'markdown-screenshot)
(define-key markdown-mode-map (kbd "C-c C-s i") 'markdown-insert-image-from-clipboard)

(provide 'my-octopress-settings)
