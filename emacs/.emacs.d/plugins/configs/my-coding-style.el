
;;自定义的代码风格
(defconst my-c-style
  '("stroustrup" ;;基于现有的代码风格进行修改。
    (c-offsets-alist . (;(access-label . -)
			(inclass . ++)
			(inline-open . 0)
			;(case-label . +)
			(statement-case-intro . +))))
  "My Programming Style")
;; 将自定义的代码风格加入到列表中
(c-add-style "my" my-c-style)

;; microsoft style
(c-add-style "microsoft"
	     '("stroustrup"
	       (c-offsets-alist
		(innamespace . -)
		(inline-open . 0)
		(inher-cont . c-lineup-multi-inher)
		(arglist-cont-nonempty . +)
		(template-args-cont . +))))
;(setq c-default-style "microsoft")

;定制C/C++缩进风格
(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "k&r")
	     (setq c-basic-offset 4)
	     (setq tab-width 4)
	     (setq-default indent-tabs-mode nil)
             ;(setq indent-tabs-mode nil)
	     ))
(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "microsoft")
	;	     (set (make-local-variable 'ac-auto-start) nil) ;; shut down ac-auto-start in c++-mode
	     ))



(setq tab-width 4)
;; 设置缩进字符数
(setq c-basic-offset 4)
;(setq-default indent-tabs-mode nil)


(provide 'my-coding-style)
