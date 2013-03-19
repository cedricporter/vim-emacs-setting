;;; my-gtags-config.el
;;
;; Time-stamp: <2013-03-19 13:48:28 Tuesday by Hua Liang>
;;
;; took from http://emacswiki.org/emacs/GnuGlobal


;; == GNU GLOBAL incremental update ==
;;
(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun gtags-update ()
  "Make GTAGS incremental update"
  (call-process "global" nil nil nil "-u"))

(defun gtags-update-hook ()
  (when (gtags-root-dir)
    (gtags-update)))

(add-hook 'after-save-hook #'gtags-update-hook)


;;; my-gtags-config.el ends here
