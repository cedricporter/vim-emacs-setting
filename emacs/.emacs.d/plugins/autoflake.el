;;; auto-remove.el --- Auto remove unused functions in python

;;; Commentary:
;; Uses external tool autoflake to remove unused imports from a Python file.

;;; Code:

(defcustom python-autoflake-path (executable-find "autoflake")
  "Autoflake executable path.
Allows working with a virtualenv without actually adding support
for it."
  :group 'python
  :type 'string)

(defun python-remove-unused-imports ()
  "Use Autoflake to remove unused function.
$ autoflake --remove-all-unused-imports -i unused_imports.py"
  (interactive)
  (when (eq major-mode 'python-mode)
    (shell-command (format "%s --remove-all-unused-imports -i %s"
			   python-autoflake-path
			   (shell-quote-argument (buffer-file-name))))
    (revert-buffer t t t))
  nil)

(eval-after-load 'python
  '(if python-autoflake-path
       (add-hook 'after-save-hook 'python-remove-unused-imports)
     (message "Unable to find autoflake. Configure `python-autoflake-path`")))

(provide 'auto-remove)

;;; auto-remove.el ends here
