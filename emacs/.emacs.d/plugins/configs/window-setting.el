;; Setting By:  Hua Liang [ Stupid ET ]
;; email:       et@everet.org
;; website:     http://EverET.org
;; This is about auto setting window style. 
;; You can read the diagram.

;;==================== window ====================

(eval-when-compile (require 'cl))

(winner-mode 1)

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

(global-set-key (kbd "C-x 4 c") 'change-split-type-auto)


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

(provide 'window-setting)

