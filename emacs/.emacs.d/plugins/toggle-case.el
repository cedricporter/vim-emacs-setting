;;; **************************************************************************
;; @(#) toggle-case.el -- toggles case at point like ~ in vi
;; @(#) $Id: toggle-case.el,v 1.5 2008/11/20 23:40:53 joe Exp $

;; This file is not part of Emacs

;; Copyright (C) 2001 by Joseph L. Casadonte Jr.
;; Author:          Joe Casadonte (emacs@northbound-train.com)
;; Maintainer:      Joe Casadonte (emacs@northbound-train.com)
;; Created:         January 03, 2001
;; Latest Version:  http://www.northbound-train.com/emacs.html

;; COPYRIGHT NOTICE

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.
;;; **************************************************************************

;;; Description:
;;
;;  This packages provides a sophisticated (over-engineered?) set of
;;  functions to toggle the case of the character under point, with
;;  which you can emulate vi's ~ function, which I found useful and
;;  miss.  Basically, the vi command (and my version of it) toggles
;;  the case of the current character and then advances to the next
;;  character, allowing successive invocations to progress down the
;;  line.

;;; Installation:
;;
;;  Put this file on your Emacs-Lisp load path and add the following to your
;;  ~/.emacs startup file
;;
;;     (require 'toggle-case)
;;
;;  See below for key-binding suggestions.

;;; Usage:
;;
;;  M-x `toggle-case'
;;     Toggles the case of the character under point.  If called with
;;     a prefix argument, it toggles that many characters (see
;;     toggle-case-stop-at-eol).  If the prefix is negative, the
;;     case of the character before point is toggled, and if called
;;     with a prefix argument, N characters before point will have
;;     their case toggled (see also toggle-case-backwards).
;;
;;  M-x `toggle-case-backwards'
;;     Convenience function to toggle case of character preceeding
;;     point.  This is the same as calling toggle-case with a
;;     negative prefix (and is in fact implemented that way).
;;
;;  M-x `toggle-case-by-word'
;;     Similar to toggle-case except that the count (supplied by
;;     the prefix argument) is of the number of words, not letters, to
;;     be toggled.  It will start from point and move to the end of
;;     the first word at a minimum, and then take whole words from
;;     there.  If called with a negative prefix, then from point to
;;     beginning of current word will have their case toggled, going
;;     backwards for N words (see also
;;     toggle-case-by-word-backwards).  Note that the
;;     toggle-case-stop-at-eol setting will be honored.
;;
;;  M-x `toggle-case-by-word-backwards'
;;     Convenience function to toggle case by word, backwards.  This
;;     is the same as calling toggle-case-by-word with a
;;     negative prefix (and is in fact implemented that way).
;;
;;  M-x `toggle-case-by-word-backwards'
;;     Toggles the case of all characters in the current region.

;;; Customization:
;;
;;  M-x `toggle-case-customize' to customize all package options.
;;
;;  The following variables can be customized:
;;
;;  o `toggle-case-stop-at-eol'
;;        Boolean used to determine whether or not the toggle
;;        advancement stops at the end of a line.  Set to `t' it will
;;        stop at the end of the line, set to `nil' it will not (it
;;        will continue on to the next line).  If direction of toggle
;;        is reversed, the semantics of this are reveresed as well
;;        (i.e. does it stop at the beginning of the line).

;;; Keybinding examples:
;;
;;  This is what I have -- use it or not as you like.
;;
;;       (global-set-key [(control \`)] 'toggle-case)
;;       (global-set-key [(control ~)] 'toggle-case-backwards)
;;
;;       (global-set-key [(control meta \`)] 'toggle-case-by-word)
;;       (global-set-key [(control meta ~)] 'toggle-case-by-word-backwards)

;;; To Do:
;;
;;  o Nothing, at the moment.

;;; Comments:
;;
;;  Any comments, suggestions, bug reports or upgrade requests are welcome.
;;  Please send them to Joe Casadonte (emacs@northbound-train.com).
;;
;;  This version of toggle-case was developed and tested with NTEmacs
;;  2.7 under Windows NT 4.0 SP6 and Emacs 20.7.1 under Linux (RH7).
;;  Please, let me know if it works with other OS and versions of Emacs.

;;; **************************************************************************
;;; **************************************************************************
;;; **************************************************************************
;;; **************************************************************************
;;; **************************************************************************
;;; Code:

;;; **************************************************************************
;;; ***** customization routines
;;; **************************************************************************
(defgroup toggle-case nil
  "toggle-case package customization"
  :group 'tools)

;; ---------------------------------------------------------------------------
(defun toggle-case-customize ()
  "Customization of the group toggle-case."
  (interactive)
  (customize-group "toggle-case"))

;; ---------------------------------------------------------------------------
(defcustom toggle-case-stop-at-eol nil
  "Boolean used to determine whether or not the toggle
advancement stops at the end of a line.  Set to `t' it will
stop at the end of the line, set to `nil' it will not (it
will continue on to the next line).  If direction of toggle
is reversed, the semantics of this are reveresed as well
(i.e. does it stop at the beginning of the line)."
  :group 'toggle-case
  :type 'boolean)

;;; **************************************************************************
;;; ***** version related routines
;;; **************************************************************************
(defconst toggle-case-version
  "$Revision: 1.5 $"
  "toggle-case version number.")

;; ---------------------------------------------------------------------------
(defun toggle-case-version-number ()
  "Returns toggle-case version number."
  (string-match "[0123456789.]+" toggle-case-version)
  (match-string 0 toggle-case-version))

;; ---------------------------------------------------------------------------
(defun toggle-case-display-version ()
  "Displays toggle-case version."
  (interactive)
  (message "toggle-case version <%s>." (toggle-case-version-number)))

;;; **************************************************************************
;;; ***** interactive functions
;;; **************************************************************************
(defun toggle-case (prefix)
  "Toggles the case of the character under point.  If called with
a prefix argument, it toggles that many characters (see
toggle-case-stop-at-eol).  If the prefix is negative, the
case of the character before point is toggled, and if called
with a prefix argument, N characters before point will have
their case toggled (see also toggle-case-backwards)."

  (interactive "*p")

  ;; loop thru N times
  (let ((forward-flag (> prefix 0))
		(count (abs prefix))
		(lcv 0))
	(while (< lcv count)
	  (joc-internal-toggle-case forward-flag)
	  (setq lcv (1+ lcv))

	  ;; make sure we're not at [be]ol
	  (if (and toggle-case-stop-at-eol
			   (or (and forward-flag (eolp))
				   (and (not forward-flag) (bolp))))
		  ;; set it high to exit
		  (setq lcv count))

	  ;; make sure we're not at the [be]ob
	  (if (or (bobp) (eobp))
		  ;; set it high to exit
		  (setq lcv count)))))

;; ---------------------------------------------------------------------------
(defun toggle-case-backwards (prefix)
  "Convenience function to toggle case of character preceeding
point.  This is the same as calling toggle-case with a
negative prefix (and is in fact implemented that way)."
  (interactive "*p")
  (toggle-case (- prefix)))

;; ---------------------------------------------------------------------------
(defun toggle-case-by-word (prefix)
  "Similar to toggle-case except that the count (supplied by
the prefix argument) is of the number of words, not letters, to
be toggled.  It will start from point and move to the end of
the first word at a minimum, and then take whole words from
there.  If called with a negative prefix, then from point to
beginning of current word will have their case toggled, going
backwards for N words (see also
toggle-case-by-word-backwards).  Note that the
toggle-case-stop-at-eol setting will be honored."

  (interactive "*p")

  ;; just look n words out, leave it to the lower level
  ;; functions to determine if a boundary's been reached
  (let ((start (point)) (end))
	(save-excursion
	  ;; this leaves us at the end (or beginning) of the word
	  (forward-word prefix)
	  (setq end (point)))
	(toggle-case (- end start))))

;; ---------------------------------------------------------------------------
(defun toggle-case-by-word-backwards (prefix)
  "Convenience function to toggle case by word, backwards.  This
is the same as calling toggle-case-by-word with a
negative prefix (and is in fact implemented that way)."
  (interactive "*p")
  (toggle-case-by-word (- prefix)))

;; ---------------------------------------------------------------------------
(defun toggle-case-by-region (start end)
  "Toggles the case of all characters in the current region."
  (interactive "*r")
  (save-excursion
	(let ((deactivate-mark nil))
	  (goto-char start)
	  (toggle-case (- end start))
	  (forward-char 2))))

;;; **************************************************************************
;;; ***** non-interactive functions
;;; **************************************************************************
(defun joc-internal-toggle-case (forward-flag)
  "Internal workhorse for toggle-case functions."

  (let ((backward-flag (not forward-flag)))
	;; if we're to stop at [be]ol and we're already there, check that first
	(if (and toggle-case-stop-at-eol
			 (or (and backward-flag (bolp))
				 (and forward-flag (eolp))))
		;; note an error
		(ding)

	  ;; backup first if going backward, as we always delete forward
	  (if backward-flag
		  (backward-char))

	  ;; actually delete and replace the character
	  (let ((c (following-char)))
		(if (eq c (upcase c))
			(insert-char (downcase c) 1 t)
		  (insert-char (upcase c) 1 t))
		(delete-char 1 nil)

		;; again, backup if we're backing up
		(if backward-flag
			(backward-char))

		;; point is where it's supposed to be unless at [be]ol
		;; maybe move point to next position

		;; stop && backwards && BOL
		(if (and toggle-case-stop-at-eol
				 backward-flag
				 (bolp))
			;; warn the user
			(ding)
		  ;; stop && forwards && EOL
		  (if (and toggle-case-stop-at-eol
				   forward-flag
				   (eolp))
			  ;; warn the user
			  (ding)
			;; no-stop && backwards && BOL
			(if (and backward-flag (bolp))
				(backward-char 1)
			  ;; no-stop && forwards && EOL
			  (if (and forward-flag (eolp))
				  (forward-char 1)))))
		))))

;;; **************************************************************************
;;; ***** we're done
;;; **************************************************************************
(provide 'toggle-case)

;; toggle-case.el ends here!
;;; **************************************************************************
;;;; *****  EOF  *****  EOF  *****  EOF  *****  EOF  *****  EOF  *************
