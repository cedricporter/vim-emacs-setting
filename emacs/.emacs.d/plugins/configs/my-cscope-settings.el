;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2012-12-31 16:32:01 by Hua Liang>

;; ==================== cscope ====================
;; +----------+--------------------------------------------------+
;; |C-c s a   |设定初始化的目录，一般是你代码的根目录            |
;; +----------+--------------------------------------------------+
;; |C-s s I   |对目录中的相关文件建立列表并进行索引              |
;; +----------+--------------------------------------------------+
;; |C-c s s   |序找符号                                          |
;; +----------+--------------------------------------------------+
;; |C-c s g   |寻找全局的定义                                    |
;; +----------+--------------------------------------------------+
;; |C-c s c   |看看指定函数被哪些函数所调用                      |
;; +----------+--------------------------------------------------+
;; |C-c s C   |看看指定函数调用了哪些函数                        |
;; +----------+--------------------------------------------------+
;; |C-c s e   |寻找正则表达式                                    |
;; +----------+--------------------------------------------------+
;; |C-c s f   |寻找文件                                          |
;; +----------+--------------------------------------------------+
;; |C-c s i   |看看指定的文件被哪些文件include                   |
;; +----------+--------------------------------------------------+

(add-to-list 'load-path "~/.emacs.d/plugins/cscope-15.8a/contrib/xcscope/")
(add-hook 'c-mode-common-hook
          '(lambda ()
             (require 'xcscope)
             (define-key c-mode-base-map (kbd "<f12>") 'cscope-find-global-definition-no-prompting)
             (define-key c-mode-base-map (kbd "<C-f12>") 'cscope-find-this-symbol)
             (define-key c-mode-base-map (kbd "S-<f12>") 'cscope-pop-mark)
             (define-key cscope-list-entry-keymap (kbd "<f12>") 'cscope-select-entry-other-window)
             (define-key cscope-list-entry-keymap (kbd "S-<f12>") 'cscope-pop-mark)
             ))

;; -------------------- cscope --------------------



(provide 'my-cscope-settings)















