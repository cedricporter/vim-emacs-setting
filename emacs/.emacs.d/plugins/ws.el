;;; ws.el --- 

;; Copyright (C) 2009 Free Software Foundation, Inc.
;;
;; Author: Ye Wenbin <wenbinye@gmail.com>
;; Maintainer: Ye Wenbin <wenbinye@gmail.com>
;;             poppyer <poppyer@gmail.com>
;; Created: 31 Aug 2009
;; Version: 0.02
;; Keywords

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; 

;; (1) Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'ws)
;; Use M-x ws-mode to enable M-f (forward-word) and M-b (backward-word).

;; (2) Put the hanconvert.el into your load-path and the following into your ~/.emacs:
;;   (require 'hanconvert)
;; such that it will automatically deal with traditional chinese

;; (3) Run M-x ws-sync-rword manually each time when you change words.txt file
;;     Note: words.txt should be pre-sorted in alphabetical order

;;; ChangeLogs:

;; 0.02 : poppyer, Sep 2, 2009
;; (1) change some implementation to improve speed
;; (2) add traditional chinese support if hanconvert.el is loaded
;;     i.e. (require 'hanconvert)
;; (3) add ws-sync-rword

;;; Code:

(eval-when-compile
  (require 'cl))

(defvar ws-initialized nil)
(defvar ws-words-buffer nil)
(defvar ws-reverse-words-buffer nil)

(defvar ws-words-file "~/.emacs.d/ws/words.txt")
(defvar ws-reverse-words-file "~/.emacs.d/ws/rwords.txt")

(defun ws-init ()
  (unless ws-initialized
    (save-excursion
      (set-buffer (generate-new-buffer " ws-words"))
      (insert-file-contents ws-words-file)
      (setq ws-words-buffer (current-buffer))
      (set-buffer (generate-new-buffer " ws-rwords"))
      (insert-file-contents ws-reverse-words-file)
      (setq ws-reverse-words-buffer (current-buffer))
      (setq ws-initialized t))))

(defun ws-bisearch-word (prefix start end)
  (if (= start end)
	  (let (line count)
		(beginning-of-line)
		(setq line (buffer-substring-no-properties (point) (line-end-position)))
		(setq count (compare-strings line 0 (length line) prefix 0 (length prefix)))
		(> count (length prefix))
		)
	(let ((mid (/ (+ start end) 2))
		  line)
	  (goto-char mid)
	  (beginning-of-line)
	  (setq line (buffer-substring-no-properties (point) (line-end-position)))
	  (if (string= line prefix)
		  line
		(if (string< line prefix)
			(if (= start mid)
				(and (forward-line 1)
					 (ws-bisearch-word prefix end end))
			  (ws-bisearch-word prefix mid end)
			  )
		  (ws-bisearch-word prefix start mid))))
	))

(defun ws-get-word (prefix &optional reverse)
  (ws-init)
  (if reverse
	  (setq prefix (ws-reverse-string prefix)))
  (with-current-buffer (if reverse ws-reverse-words-buffer ws-words-buffer)
	(goto-char (point-min))
	(let ((len (length prefix))
		  (i 1)
		  (curword t)
		  (word nil))
	  (while (and (<= i len)
				  (let ((subprefix (substring prefix 0 i)))
					(setq curword (ws-bisearch-word subprefix (point) (point-max)))))
		(unless (booleanp curword) 
		  (setq word curword))
		(setq i (1+ i)))
	  word)))


(defun ws-forward-word ()
  (interactive)
  (if (looking-at "\\cC")
      (let* ((prefix (buffer-substring-no-properties (point) (line-end-position)))
			(word1 (ws-get-word prefix))
			(word2 (and (fboundp 'hanconvert-string) (ws-get-word (hanconvert-string prefix))))
			(word (if (> (length word2) (length word1)) word2 word1)))
        (if word 
			(forward-char (length word))
		  (forward-char 1)))
    (let (pos)
      (save-excursion
        (if (re-search-forward "\\cC" nil t)
            (setq pos (- (point) 1))))
      (if pos
          (goto-char (min pos (save-excursion (forward-word) (point))))
        (forward-word)))))

(defun ws-reverse-string (str)
  (concat (reverse (append str nil))))

(defun ws-backward-word ()
  (interactive)
  (if (looking-back "\\cC")
      (let* ((prefix (buffer-substring-no-properties (line-beginning-position) (point)))
			(word1 (ws-get-word prefix t))
			(word2 (and (fboundp 'hanconvert-string) (ws-get-word (hanconvert-string prefix) t)))
			(word (if (> (length word2) (length word1)) word2 word1)))
        (if word 
			(backward-char (length word))
		  (backward-char 1)))
    (let (pos)
      (save-excursion
        (if (re-search-backward "\\cC" nil t)
            (setq pos (+ (point) 1))))
      (if pos
          (goto-char (max pos (save-excursion (backward-word) (point))))
        (backward-word)))))

(defun ws-sync-rword ()
  (interactive)
  (ws-init)
  (with-current-buffer ws-reverse-words-buffer
	(delete-region (point-min) (point-max)))
  (with-current-buffer ws-words-buffer
	(goto-char (point-min))
	(let (line)
	  (while (not (eobp))
		(setq line (buffer-substring-no-properties (point) (line-end-position)))
		(with-current-buffer ws-reverse-words-buffer
		  (insert (ws-reverse-string line))
		  (insert ?\n)
		  )
		(forward-line 1))
	  ))
  (with-current-buffer ws-reverse-words-buffer
	(sort-lines nil (point-min) (point-max))
	(write-region (point-min) (point-max) ws-reverse-words-file)))

(define-minor-mode ws-mode
  "Buffer-local minor mode to move word by chinese word."
  :group 'ws
  :global t
  :lighter " WS"
  :keymap
  `((,(kbd "M-f") . ws-forward-word)
    (,(kbd "M-b") . ws-backward-word))
  )

(provide 'ws)
;;; ws.el ends here
