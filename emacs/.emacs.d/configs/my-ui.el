;;; my-ui.el ---
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>
;; Time-stamp: <2013-01-26 17:41:36 Saturday by Hua Liang>

;;====================== time setting =====================
;;启用时间显示设置，在minibuffer上面的那个杠上（忘了叫什么来着）
(display-time-mode 1)

;;时间使用24小时制
(setq display-time-24hr-format t)
(setq display-time-format "%02H:%02M:%02S %Y-%02m-%02d %3a")

;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)

;;时间栏旁边启用邮件设置
					;(setq display-time-use-mail-icon t)

;;时间的变化频率
(setq display-time-interval 1)

;;显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
;;----------------------    END    time setting    ---------------------


;; ==================== UI setting ====================

;; Font Setting

(setq my-font "Monaco-11")

(add-to-list 'default-frame-alist
             '(font . my-font))

;(set-frame-font "Ubuntu Mono-12")
(defun frame-setting ()
  (set-frame-font my-font)
  (set-fontset-font "fontset-default"
		    'chinese-gbk "WenQuanYi Micro Hei Mono 11"))

;; ;; 解决汉字表格对齐问题，也就是设置等宽汉字
;; (if (and (fboundp 'daemonp) (daemonp))
;;     (add-hook 'after-make-frame-functions
;;               (lambda (frame)
;;                 (with-selected-frame frame
;; 		  (frame-setting))))
;;   (frame-setting))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (frame-setting))))
(if (not (and (fboundp 'daemonp) (daemonp)))
    (frame-setting))

(setq-default fill-column 81)
(setq default-fill-column 80)


;; 启动窗口大小
(setq default-frame-alist
      '((height . 35) (width . 125) (menu-bar-lines . 20) (tool-bar-lines . 0)))

;; 去掉滚动栏
(scroll-bar-mode -1)

;;去掉菜单栏，将F10绑定为显示菜单栏，需要菜单栏了可以摁F10调出，再摁F10就去掉菜单
;; 如果总是不显示工具栏，将下面代码加到.emacs中
;; 参考： http://www.emacswiki.org/emacs/ToolBar
;; 注意：在menu-bar不显示的情况下，按ctrl+鼠标右键还是能调出菜单选项的
(tool-bar-mode -1)
;; 如果总是不显示菜单，将下面代码加到.emacs中
;;参考： http://www.emacswiki.org/emacs/MenuBar
(menu-bar-mode -1)


;; -------------------- UI setting --------------------

;;; my-ui.el ends here
