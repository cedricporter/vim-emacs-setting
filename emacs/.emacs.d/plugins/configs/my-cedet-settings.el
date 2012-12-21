;; ==================== bzr cedet ====================
;(load-file "~/.emacs.d/plugins/cedet-bzr/cedet-devel-load.el")
(require 'cedet)                        ; can't use bzr at 24.3 now

(semantic-mode 1)

;(require 'semantic/ia) ; bzr
(require 'semantic/bovine/c)
;(require 'semantic/bovine/clang) ; bzr
(require 'semantic/bovine/gcc)

(global-semantic-mru-bookmark-mode 1)

;; loading contrib...
(require 'eassist)

;; customisation of modes
(defun alexott/cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;;
  (local-set-key "\C-c>" 'semantic-comsemantic-ia-complete-symbolplete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cJ"  ;; go back
                 (lambda ()
                   (interactive)
                   (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                       (error "Semantic Bookmark ring is currently empty!!!"))
                   (let* ((ring (oref semantic-mru-bookmark-ring ring))
                          (alist (semantic-mrub-ring-to-assoc-list ring))
                          (first (cdr (car alist))))
                     (if (semantic-equivalent-tag-p (oref first tag)
                                                    (semantic-current-tag))
                         (setq first (cdr (car (cdr alist)))))
                     ;; (message "%s-%s" alist first)
                     (semantic-mrub-switch-tags first))))
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
;  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;;  (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
  ;;  (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)

  (add-to-list 'ac-sources 'ac-source-semantic)
  )

(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)
(add-hook 'lisp-mode-hook 'alexott/cedet-hook)
(add-hook 'scheme-mode-hook 'alexott/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'alexott/cedet-hook)
(add-hook 'erlang-mode-hook 'alexott/cedet-hook)

(defun alexott/c-mode-cedet-hook ()
  ;; (local-set-key "." 'semantic-complete-self-insert)
  ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)

  (add-to-list 'ac-sources 'ac-source-gtags)
  )
(add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)


;; ==================== make 24.3 hang ====================
;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode t)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode t))

;; (when (cedet-ectag-version-check t)
;;   (semantic-load-enable-primary-ectags-support))
;; -------------------- make 24.3 hang --------------------


;; SRecode
;(global-srecode-minor-mode 1)

;; EDE
(global-ede-mode 1)
(ede-enable-generic-projects)

;; helper for boost setup...
(defun recur-list-files (dir re)
  "Returns list of files in directory matching to given regex"
  (when (file-accessible-directory-p dir)
    (let ((files (directory-files dir t))
          matched)
      (dolist (file files matched)
        (let ((fname (file-name-nondirectory file)))
          (cond
           ((or (string= fname ".")
                (string= fname "..")) nil)
           ((and (file-regular-p file)
                 (string-match re fname))
            (setq matched (cons file matched)))
           ((file-directory-p file)
            (let ((tfiles (recur-list-files file re)))
              (when tfiles (setq matched (append matched tfiles)))))))))))

(defun c++-setup-boost (boost-root)
  (when (file-accessible-directory-p boost-root)
    (let ((cfiles (recur-list-files boost-root "\\(config\\|user\\)\\.hpp")))
      (dolist (file cfiles)
        (add-to-list 'semantic-lex-c-preprocessor-symbol-file file)))))

;; my functions for EDE
(defun alexott/ede-get-local-var (fname var)
  "fetch given variable var from :local-variables of project of file fname"
  (let* ((current-dir (file-name-directory fname))
         (prj (ede-current-project current-dir)))
    (when prj
      (let* ((ov (oref prj local-variables))
	     (lst (assoc var ov)))
        (when lst
          (cdr lst))))))

;; setup compile package
(require 'compile)
(setq compilation-disable-input nil)
(setq compilation-scroll-output t)
(setq mode-compile-always-save-buffer-p t)

(defun alexott/compile ()
  "Saves all unsaved buffers, and runs 'compile'."
  (interactive)
  (save-some-buffers t)
  (let* ((r (alexott/ede-get-local-var
             (or (buffer-file-name (current-buffer)) default-directory)
             'compile-command))
         (cmd (if (functionp r) (funcall r) r)))
    (set (make-local-variable 'compile-command) (or cmd compile-command))
    (compile compile-command)))

(global-set-key [f7] 'alexott/compile)
;; -------------------- bzr cedet --------------------


(provide 'my-cedet-settings)
