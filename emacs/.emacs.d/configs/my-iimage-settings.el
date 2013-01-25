;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-01-14 01:35:03 Monday by Hua Liang>

(require 'iimage)

(add-hook 'info-mode-hook 'iimage-mode)
(add-hook 'markdown-mode-hook '(lambda()
				 (define-key markdown-mode-map
				   (kbd "<f12>") 'turn-on-iimage-mode)))

(setq iimage-mode-image-search-path '(list "." ".."))

;; for octopress
(add-to-list 'iimage-mode-image-regex-alist ; match: {% img xxx %}
	     (cons (concat "{% img /?\\("
			   iimage-mode-image-filename-regex
			   "\\) %}") 1))
(add-to-list 'iimage-mode-image-regex-alist ; match: ![xxx](/xxx)
	     (cons (concat "!\\[.*?\\](/\\("
			   iimage-mode-image-filename-regex
			   "\\))") 1))
;; 兼容以前在wordpress添加的图片
(add-to-list 'iimage-mode-image-regex-alist ; match: ![xxx](http://everet.org/xxx)
	     (cons (concat "!\\[.*?\\](http://everet.org/\\(wp-content/"
			   iimage-mode-image-filename-regex
			   "\\))") 1))
 

;; (provide 'my-iimage-settings)
