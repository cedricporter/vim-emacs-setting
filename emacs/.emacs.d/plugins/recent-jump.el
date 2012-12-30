;; -*- Emacs-Lisp -*-

;; Time-stamp: <2009-11-27 00:41:09 Friday by ahei>

;; 使用
;; (setq rj-ring-length 10000)
;; (require 'recent-jump)
;; (global-set-key (kbd "M-,") 'recent-jump-backward)
;; (global-set-key (kbd "M-.") 'recent-jump-forward)

(require 'desktop)

(defvar rj-line-threshold 5 "*The line threshold of a big-jump")
(defvar rj-column-threshold 20 "*The column threshold of a big-jump")
(defvar rj-ring-length 10000 "*The length of `rj-ring'")

(defvar rj-ring (make-ring rj-ring-length) "存放光标所经过的位置的环")
(defvar rj-index 0 "`recent-jump-backward'的时候当前位置在`rj-ring'中的序号")
(defvar rj-position-before nil "以前光标所在的位置")
(defvar rj-position-pre-command nil "命令执行前光标所在的位置")
(defvar rj-command-ignore
  '(recent-jump-backward
    recent-jump-forward
    recent-jump-small-backward
    recent-jump-small-forward))

(defvar rj-mode-line-format " RJ" "*Mode line format of `recent-jump-mode'.")

(defun column-number-at-pos (&optional pos)
  "得到位置POS的列号"
  (save-excursion
    (if pos (goto-char pos))
    (current-column)))

(defun rj-insert-point (ring position)
  "将位置POSITION插入ring RING中去."
    (when (or (ring-empty-p ring)
              (let ((latest (ring-ref ring 0)))
                (not (and (equal (nth 0 position) (nth 0 latest)) (equal (nth 2 position) (nth 2 latest))))))
      (ring-insert ring position)))

(defun rj-insert-big-jump-point (ring line column position-before position-after &optional position)
  "位置POSITION-BEFORE和POSITION-AFTER是否是一个big-jump.
如果是的话返回t, 将位置POSITION插入到ring RING中, 否则返回nil"
  (let* (is-big-jump
         (buffer-before (nth 1 position-before))
         (point-before (nth 2 position-before))
         (point-after (nth 2 position-after)))
    (if (and (buffer-live-p buffer-before) (equal buffer-before (nth 1 position-after)))
        (setq is-big-jump
              (or
               (> (count-lines (min point-before (point-max)) (min point-after (point-max))) line)
               (> (abs (- (column-number-at-pos point-before) (column-number-at-pos point-after))) column)))
      (setq is-big-jump t))
    (when is-big-jump
      (rj-insert-point ring (if position position position-after))
      t)))

(defun rj-pre-command ()
  "每个命令执行前执行这个函数"
  (unless (or (active-minibuffer-window) isearch-mode)
    (unless (memq this-command rj-command-ignore)
      (let ((position (list (buffer-file-name) (current-buffer) (point))))
        (unless rj-position-before
          (setq rj-position-before position))
        (setq rj-position-pre-command position))
      (if (memq last-command '(recent-jump-backward recent-jump-forward))
          (progn
            (let ((index (1- rj-index)) (list nil))
              (while (> index 0)
                (push (ring-ref rj-ring index) list)
                (setq index (1- index)))
              (while list
                (ring-insert rj-ring (car list))
                (pop list))))))))

(defun rj-post-command ()
  "每个命令执行后执行这个函数"
  (let ((position (list (buffer-file-name) (current-buffer) (point))))
    (if (or (and rj-position-pre-command
                 (rj-insert-big-jump-point rj-ring rj-line-threshold rj-column-threshold rj-position-pre-command position rj-position-pre-command))
            (and rj-position-before
                 (rj-insert-big-jump-point rj-ring rj-line-threshold rj-column-threshold rj-position-before position rj-position-before)))
        (setq rj-position-before nil)))
  (setq rj-position-pre-command nil))

(defun recent-jump-backward (arg)
  "跳到命令执行前的位置"
  (interactive "p")
  (let ((index rj-index)
        (last-is-rj (memq last-command '(recent-jump-backward recent-jump-forward))))
    (if (ring-empty-p rj-ring)
        (message (if (> arg 0) "Can't backward, ring is empty" "Can't forward, ring is empty"))
      (if last-is-rj
          (setq index (+ index arg))
        (setq index arg)
        (let ((position (list (buffer-file-name) (current-buffer) (point))))
          (setq rj-position-before nil)
          (unless (rj-insert-big-jump-point rj-ring rj-line-threshold rj-column-threshold (ring-ref rj-ring 0) position)
            (ring-remove rj-ring 0)
            (ring-insert rj-ring position))))
      (if (>= index (ring-length rj-ring))
          (message "Can't backward, reach bottom of ring")
        (if (<= index -1)
            (message "Can't forward, reach top of ring")
          (let* ((position (ring-ref rj-ring index))
                (file (nth 0 position))
                (buffer (nth 1 position)))
            (if (not (or file (buffer-live-p buffer)))
                (progn
                  (ring-remove rj-ring index)
                  (message "要跳转的位置所在的buffer为无文件关联buffer, 但该buffer已被删除"))
              (if file
                  (find-file (nth 0 position))
                (assert (buffer-live-p buffer))
                (switch-to-buffer (nth 1 position)))
              (goto-char (nth 2 position))
              (setq rj-index index))))))))

(defun recent-jump-forward (arg)
  "重新跳到刚才的位置"
  (interactive "p")
  (recent-jump-backward (* -1 arg)))

(defun rj-clean ()
  "清除相关变量"
  (interactive)
  (setq rj-index 0)
  (setq rj-position-pre-command nil)
  (setq rj-position-before nil)
  (while (not (ring-empty-p rj-ring))
    (ring-remove rj-ring)))

(define-minor-mode recent-jump-mode
  "Toggle recent-jump mode."
  :lighter rj-mode-line-format
  :global t
  (let ((hook-action (if recent-jump-mode 'add-hook 'remove-hook)))
    (funcall hook-action 'pre-command-hook 'rj-pre-command)
    (funcall hook-action 'post-command-hook 'rj-post-command)))

(dolist (var (list 'rj-ring 'rj-index 'rj-position-before))
  (add-to-list 'desktop-globals-to-save var))

(provide 'recent-jump)
