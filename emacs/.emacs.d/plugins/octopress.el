;; Octopress路径
(setq octopress-workdir (expand-file-name "~/octopress"))


(defun octopress-rake (command)
  "run rake commands"
  (let ((command-str (format "bash -l -c 'cd %s && rake %s'" octopress-workdir command))) ;; RVM变量设置
    (shell-command-to-string command-str)))


(defun octopress-new (class title)
  (let* ((command-str (format "new_%s[\"%s\"]" class title))
         (command-result (octopress-rake command-str))
         (regexp-str (format "Creating new %s: " class))
         (filename))
    (progn
      (setq filename (concat octopress-workdir "/"
                             (replace-regexp-in-string regexp-str ""
                                                       (car (cdr (reverse (split-string command-result "\n")))))))
      (find-file filename))))


(defun octopress-new-post (title)
  "begin a new post in source/_posts"
  (interactive "MTitle: ")
  (octopress-new "post" title))


(defun octopress-new-page (title)
  "create a new page in source/(filename)/index.markdown"
  (interactive "MTitle: ")
  (octopress-new "page" title))


(defun octopress-generate ()
  "generate jekyll site"
  (interactive)
  (octopress-rake "generate")
  (message "Generate site OK"))


(defun octopress-deploy ()
  "default deploy task"
  (interactive)
  (octopress-rake "deploy")
  (message "Deploy site OK"))

(defun octopress-rsync ()
  "deploy website via rsync"
  (octopress-rake "rsync")
  (message "Rsync site OK"))

(defun octopress-gen-deploy ()
  "generate website and deploy"
  (interactive)
  (octopress-rake "gen_deploy")
  (message "Generate and Deploy OK"))


(defun octopress-preview ()
  "preview the site in a web browser"
  (interactive)
  (octopress-rake "preview"))

(provide 'octopress)
