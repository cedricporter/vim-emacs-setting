;; Setting By:  Hua Liang [ Stupid ET ]
;; email:       et@everet.org
;; website:     http://EverET.org
;; This is about auto setting window style. 
;; You can read the diagram.
;; Time-stamp: <2013-01-08 11:21:15 Tuesday by Hua Liang>

(eval-when-compile (require 'cl))

(winner-mode 1)


;;use meta and direction key to go to the window
(windmove-default-keybindings 'meta)


;; 实现全屏效果，快捷键为f11
(global-set-key [(control f11)] 'my-fullscreen) 
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
  )
;; 最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  )
;; 启动emacs时窗口最大化
(when window-system
  (my-maximized)) 


;; ==================== Transposing Two Buffers ====================
(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))
;; -------------------- Transposing Two Buffers --------------------


;;==================== window ====================


; +----------+-----------+
; |          |           |
; |          |           |
; +----------+-----------+
; |          |           |
; |          |           |
; +----------+-----------+

(defun split-window-4() 
  "Splite window into 4 sub-window"
  (interactive) 
  (if (= 1 (length (window-list))) 
      (progn (split-window-vertically) 
	     (split-window-horizontally) 
	     (other-window 2) 
	     (split-window-horizontally) 
	     ) 
    ) 
  ) 

(global-set-key (kbd "C-x 4 4") 'split-window-4)

; +----------------+
; |                |
; +----------------+
; |                |
; +----------------+
(defun split-window-up-down()
  "Splite window into 2 up and down window"
  (interactive)
  (if (= 1 (length (window-list)))
      (progn (split-window-vertically -10)
	     (other-window 1)
	     (eshell) 
	     )
    ))
(global-set-key (kbd "C-x 4 2") 'split-window-up-down)

; +----------+-----------+
; |          |           |
; |          |           |
; +          +-----------+
; |          |           |
; |          |           |
; +----------+-----------+
(defun split-window-3() 
  "Splite window into 3 sub-window"
  (interactive) 
  (if (= 1 (length (window-list))) 
      (progn (split-window-horizontally)         ;split to left and right
	     (enlarge-window-horizontally 15)	 ;make the main window bigger
	     (other-window 1)		         ;go to the right window
	     (split-window-vertically)	         ;split the right window to two window
	     (eshell)			         ;open shell at left top window
	     (other-window 2) 		         ;go back to origin window
	     ) 
    ) 
  ) 

(global-set-key (kbd "C-x 4 3") 'split-window-3)
			
;  +----------------------+                 +------------+-----------+
;  |                      |           \     |            |           |
;  |                      |   +-------+\    |            |           |
;  +----------+-----------+   +-------+/    |            +-----------+
;  |          |           |           /     |            |           |
;  |          |           |                 |            |           |
;  +----------+-----------+                 +------------+-----------+
(defun split-v-3 () 
  "Change 3 window style from horizontal to vertical"
  (interactive) 
  (select-window (get-largest-window)) 
  (if (= 3 (length (window-list))) 
      (let ((winList (window-list))) 
	(let ((1stBuf (window-buffer (car winList))) 
	      (2ndBuf (window-buffer (car (cdr winList)))) 
	      (3rdBuf (window-buffer (car (cdr (cdr winList)))))) 
	  (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf) 
	  (delete-other-windows) 
	  (split-window-horizontally) 
	  (set-window-buffer nil 1stBuf) 
	  (other-window 1) 
	  (set-window-buffer nil 2ndBuf) 
	  (split-window-vertically) 
	  (set-window-buffer (next-window) 3rdBuf) 
	  (select-window (get-largest-window)) 
	  )))) 

		
				
;  +------------+-----------+                  +----------------------+
;  |            |           |            \     |                      |
;  |            |           |    +-------+\    |                      |
;  |            +-----------+    +-------+/    +----------+-----------+
;  |            |           |            /     |          |           |
;  |            |           |                  |          |           |
;  +------------+-----------+                  +----------+-----------+


(defun split-h-3 () 
  "Change 3 window style from vertical to horizontal"
  (interactive) 

  (select-window (get-largest-window)) 
  (if (= 3 (length (window-list))) 
      (let ((winList (window-list))) 
	(let ((1stBuf (window-buffer (car winList))) 
	      (2ndBuf (window-buffer (car (cdr winList)))) 
	      (3rdBuf (window-buffer (car (cdr (cdr winList)))))) 
	  (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf) 

	  (delete-other-windows) 
	  (split-window-vertically) 
	  (set-window-buffer nil 1stBuf) 
	  (other-window 1) 
	  (set-window-buffer nil 2ndBuf) 
	  (split-window-horizontally) 
	  (set-window-buffer (next-window) 3rdBuf) 
	  (select-window (get-largest-window)) 
	  )))) 

				
;  +------------+-----------+                 +------------+-----------+
;  |            |           |            \    |            |           |
;  |            |           |    +-------+\   |            |           |
;  +------------+-----------+    +-------+/   +------------+           |
;  |                        |            /    |            |           |
;  |                        |                 |            |           |
;  +------------+-----------+                 +------------+-----------+
;  +------------+-----------+                 +------------+-----------+
;  |            |           |            \    |            |           |
;  |            |           |    +-------+\   |            |           |
;  |            +-----------+    +-------+/   +------------+-----------+
;  |            |           |            /    |                        |
;  |            |           |                 |                        |
;  +------------+-----------+                 +------------+-----------+

(defun change-split-type-3 (&optional arg) 
  "Change 3 window style from horizontal to vertical and vice-versa"
  (interactive) 

  (select-window (get-largest-window)) 
  (if (= 3 (length (window-list))) 
      (let ((winList (window-list))) 
	(let ((1stBuf (window-buffer (car winList))) 
	      (2ndBuf (window-buffer (car (cdr winList)))) 
	      (3rdBuf (window-buffer (car (cdr (cdr winList))))) 

	      (split-3 
	       (lambda(1stBuf 2ndBuf 3rdBuf split-1 split-2) 
		 "change 3 window from horizontal to vertical and vice-versa"
		 (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf) 

		 (delete-other-windows) 
		 (funcall split-1) 
		 (set-window-buffer nil 2ndBuf) 
		 (funcall split-2) 
		 (set-window-buffer (next-window) 3rdBuf) 
		 (other-window 2) 
		 (set-window-buffer nil 1stBuf)))         

	      (split-type-1 nil) 
	      (split-type-2 nil) 
	      ) 
	  (if (= (window-width) (frame-width)) 
	      (setq split-type-1 'split-window-horizontally 
		    split-type-2 'split-window-vertically) 
	    (setq split-type-1 'split-window-vertically  
		  split-type-2 'split-window-horizontally)) 
	  (funcall split-3 1stBuf 2ndBuf 3rdBuf split-type-1 split-type-2) 

	  )))) 


;; (defun change-split-type-2 ()
;;   "change between horizonal and vertical"
;;   (interactive)
;;   (if (= 2 (length (window-list)))
;;       (let ((next-buffer (window-buffer (next-window))))
;;         (delete-other-windows)
;;         (split-window-right)
;;         (other-window 0)
;;         (set-window-buffer (next-window) next-buffer)
;;         (other-window 0)
;;         )
;;     )
;;   )

;; ==================== change-split-type ====================
(defun change-split-type (split-fn &optional arg)
  "Change 3 window style from horizontal to vertical and vice-versa"
  (let ((bufList (mapcar 'window-buffer (window-list))))
    (select-window (get-largest-window))
    (funcall split-fn arg)
    (mapcar* 'set-window-buffer (window-list) bufList)))
;; -------------------- change-split-type --------------------


;  +----------------------+                +---------- +----------+
;  |                      |          \     |           |          |
;  |                      |  +-------+\    |           |          |
;  +----------------------+  +-------+/    |           |          |
;  |                      |          /     |           |          |
;  |                      |                |           |          |
;  +----------------------+                +---------- +----------+
;
;  +--------- +-----------+                +----------------------+
;  |          |           |          \     |                      |
;  |          |           |  +-------+\    |                      |
;  |          |           |  +-------+/    +----------------------+
;  |          |           |          /     |                      |
;  |          |           |                |                      |
;  +--------- +-----------+                +----------------------+

(defun change-split-type-2 (&optional arg)
  "Changes splitting from vertical to horizontal and vice-versa"
  (interactive "P")
  (let ((split-type (lambda (&optional arg)
                      (delete-other-windows-internal)
                      (if arg (split-window-vertically)
                        (split-window-horizontally)))))
    (change-split-type split-type arg)))

(defun change-split-type-auto (&optional arg)
  "Changes splitting auto"
  (interactive "P")
  (let ((window-list-length (length (window-list))))
    (cond ((= window-list-length 2) (change-split-type-2 arg))
          ((= window-list-length 3) (change-split-type-3 arg)))
    ))



;;==================== buffer =====================
				
;  +------------+-----------+                   +------------+-----------+
;  |            |     C     |            \      |            |     A     |
;  |            |           |    +-------+\     |            |           |
;  |     A      |-----------|    +-------+/     |     B      |-----------|
;  |            |     B     |            /      |            |     C     |
;  |            |           |                   |            |           |
;  +------------+-----------+                   +------------+-----------+
;
;  +------------------------+                   +------------------------+
;  |           A            |           \       |           B            |
;  |                        |   +-------+\      |                        |
;  +------------+-----------+   +-------+/      +------------+-----------+
;  |     B      |     C     |           /       |     C      |     A     |
;  |            |           |                   |            |           |
;  +------------+-----------+                   +------------+-----------+


(defun roll-v-3 (&optional arg) 
  "Rolling 3 window buffers (anti-)clockwise"
  (interactive "P") 
  (select-window (get-largest-window)) 
  (if (= 3 (length (window-list))) 
      (let ((winList (window-list))) 
	(let ((1stWin (car winList)) 
	      (2ndWin (car (cdr winList))) 
	      (3rdWin (car (last winList)))) 
	  (let ((1stBuf (window-buffer 1stWin)) 
		(2ndBuf (window-buffer 2ndWin)) 
		(3rdBuf (window-buffer 3rdWin))) 
	    (if arg (progn                                
					; anti-clockwise
		      (set-window-buffer 1stWin 3rdBuf) 
		      (set-window-buffer 2ndWin 1stBuf) 
		      (set-window-buffer 3rdWin 2ndBuf)) 
	      (progn                                      ; clockwise
		(set-window-buffer 1stWin 2ndBuf) 
		(set-window-buffer 2ndWin 3rdBuf) 
		(set-window-buffer 3rdWin 1stBuf)) 
	      )))))) 

(global-set-key (kbd "C-x 4 r")  (quote roll-v-3)) 
;;-------------------- window -------------------


;; ==================== key bindings ====================
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-0") 'delete-window)

;; (global-unset-key (kbd "C-x 1"))
;; (global-unset-key (kbd "C-x 2"))
;; (global-unset-key (kbd "C-x 3"))
;; (global-unset-key (kbd "C-x 0"))

(global-set-key (kbd "M-4") 'winner-undo)
(global-set-key (kbd "M-5") 'winner-redo)

(global-set-key (kbd "M-6") 'change-split-type-auto)

(global-set-key (kbd "M-9") 'transpose-buffers)

(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-h") 'windmove-left)
(global-set-key (kbd "C-S-l") 'windmove-right)

;; -------------------- key bindings --------------------


;; (provide 'window-setting)

