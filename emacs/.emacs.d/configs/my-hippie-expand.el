;;; my-hippie-expand.el
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>


;; From http://www.emacswiki.org/cgi-bin/wiki/MicheleBini
(defun my-try-complete-with-calc-result (arg)
  (and
   (not arg) (eolp)
   (save-excursion
     (beginning-of-line)
     (when (and (boundp 'comment-start)
		comment-start)
       (when (looking-at
	      (concat
	       "[ \n\t]*"
	       (regexp-quote comment-start)))
	 (goto-char (match-end 0))
	 (when (looking-at "[^\n\t ]+")
	   (goto-char (match-end 0)))))
     (looking-at ".* \\(\\([;=]\\) +$\\)"))
   (save-match-data
     (require 'calc-ext nil t))
   ;;(require 'calc-aent)
   (let ((start (match-beginning 0))
	 (op (match-string-no-properties 2)))
     (save-excursion
       (goto-char (match-beginning 1))
       (if (re-search-backward (concat "[\n" op "]") start t)
	   (goto-char (match-end 0)) (goto-char start))
       (looking-at (concat " *\\(.*[^ ]\\) +" op "\\( +\\)$"))
       (goto-char (match-end 2))
       (let* ((b (match-beginning 2))
	      (e (match-end 2))
	      (a (match-string-no-properties 1))
	      (r (calc-do-calc-eval a nil nil)))
	 (when (string-equal a r)
	   (let ((b (save-excursion
		      (and (search-backward "\n\n" nil t)
			   (match-end 0))))
		 (p (current-buffer))
		 (pos start)
		 (s nil))
	     (setq r
		   (calc-do-calc-eval
		    (with-temp-buffer
		      (insert a)
		      (goto-char (point-min))
		      (while (re-search-forward
			      "[^0-9():!^ \t-][^():!^ \t]*" nil t)
			(setq s (match-string-no-properties 0))
			(let ((r
			       (save-match-data
				 (save-excursion
				   (set-buffer p)
				   (goto-char pos)
				   (and
				    ;; TODO: support for line
				    ;; indentation
				    (re-search-backward
				     (concat "^" (regexp-quote s)
					     " =")
				     b t)
				    (progn
				      (end-of-line)
				      (search-backward "=" nil t)
				      (and (looking-at "=\\(.*\\)$")
					   (match-string-no-properties 1))))))))
			  (if r (replace-match (concat "(" r ")") t t))))
		      (buffer-substring (point-min) (point-max)))
		    nil nil))))
	 (and
	  r
	  (progn
	    (he-init-string b e)
	    (he-substitute-string (concat " " r))
	    t)))))))

(setq hippie-expand-try-functions-list
      (cons
       'my-try-complete-with-calc-result
       (delq 'my-try-complete-with-calc-result
	     hippie-expand-try-functions-list)))


;; (setq hippie-expand-try-functions-list
;;       '(try-expand-dabbrev                 ; 搜索当前 buffer
;;         try-expand-dabbrev-visible         ; 搜索当前可见窗口
;;         try-expand-dabbrev-all-buffers     ; 搜索所有 buffer
;;         try-expand-dabbrev-from-kill       ; 从 kill-ring 中搜索
;;         try-complete-file-name-partially   ; 文件名部分匹配
;;         try-complete-file-name             ; 文件名匹配
;;         try-expand-all-abbrevs             ; 匹配所有缩写词
;;         try-expand-list                    ; 补全一个列表
;;         try-expand-line                    ; 补全当前行
;;         try-complete-lisp-symbol-partially ; 部分补全 elisp symbol
;;         try-complete-lisp-symbol))         ; 补全 lisp symbol

(global-set-key (kbd "M-/") 'hippie-expand)

;;; my-hippie-expand.el ends here
