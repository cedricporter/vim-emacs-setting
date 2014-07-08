;;; my-csharp-mode-config.el
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>

(defun my-csharp-mode-fn ()
  "function that runs when csharp-mode is initialized for a buffer."
  (setq default-tab-width 4)
)
(add-hook  'csharp-mode-hook 'my-csharp-mode-fn t)

;;; my-csharp-mode-config.el ends here
