;; Utilities
(defun seb/halve-other-window-height ()
  "Expand current window to use half of the other window's lines."
  (interactive)
  (enlarge-window (/ (window-height (next-window)) 2)))

;; use 2 spaces for tabs
(defun seb/die-tabs ()
  "Remove all tabs and replace with spaces at indent 2"
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;; Insert the date function
(defun seb/insert-current-date () (interactive)
       (insert (shell-command-to-string "echo -n $(date +'%a %B %e, %Y')")))

(defun seb/close-all-buffers ()
  "Close all open buffers"
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun seb/open-line-above ()
  "Inserts a line above the current line and put point to the beginning of the line."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(provide 'seb-utils)
