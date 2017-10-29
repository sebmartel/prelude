(prelude-require-packages '(smooth-scrolling
                            plantuml-mode
                            org-bullets
                            ))

;; Set config `crux-find-user-init-file' to be this `custom.el'
(setq user-init-file "~/.emacs.d/personal/my-init.el")

;; Disable C-z (because it is annoying when running the gui
(global-unset-key "\C-z")

;; I fat finger C-x C-c too often...
(setq confirm-kill-emacs 'y-or-n-p)

;; No vertical scroll bar please.
(toggle-scroll-bar -1)

;; Smooth scrolling
(smooth-scrolling-mode nil)

;; Keep whitespace mode but prevent massive whitespace changes on save.
(setq prelude-clean-whitespace-on-save nil)

;; Paste on click puts text at point, not at mouse cursor.
(setq mouse-yank-at-point t)

;; Ace window to use home row
(global-set-key (kbd "M-P") 'ace-window)
(require 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; Avy use goto-char instead of goto-word-or-subword
(global-set-key (kbd "C-c j") 'avy-goto-char-2)

;; Org mode setup
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; (setq org-log-done t)

(require 'org)
(setq org-agenda-files (list "~/Documents/Org/planner.org"))

(setq org-directory "~/Documents/Org")


;; plantuml
(require 'plantuml-mode)
(setq plantuml-jar-path
      (expand-file-name "/usr/share/plantuml/plantuml.jar"))
;; (setq org-plantuml-jar-path plantuml-jar-path)

;; Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)
   (gnuplot . t)
   (plantuml . t)
   ))

;; Pretty bullets
(add-hook 'org-mode-hook
          (lambda () (org-bullets-mode 1)))

;; syntax color source blocks in org mode
(setq org-src-fontify-natively t)

;; org mode templates
(add-to-list 'org-structure-template-alist'
             ("dw" "#+BEGIN_SRC sql :exports both :engine postgresql :cmdline \"-U sebm -d dev -h slate#####.com -p 5439\" \n\n#+END_SRC"))

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
