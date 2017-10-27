(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line operate-on-number move-text magit projectile ov imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major dash crux browse-kill-ring beacon anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(prelude-require-packages '(smooth-scrolling
                            plantuml-mode
                            org-bullets
                            ))

;; Disable C-z (because it is annoying when running the gui
(global-unset-key "\C-z")

;; I fat finger C-x C-c too often...
(setq confirm-kill-emacs 'y-or-n-p)

;; No vertical scroll bar please.
(toggle-scroll-bar -1)

;; Smooth scrolling
(smooth-scrolling-mode 0)

;; Paste on click puts text at point, not at mouse cursor.
(setq mouse-yank-at-point t)

;; Ace window to use home row
(global-set-key (kbd "M-p") 'ace-window)
(require 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; Org mode setup
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; (setq org-log-done t)

(require 'org)
(setq org-agenda-files (list "~/Documents/Org/planner.org"))

(setq org-directory  "~/Documents/Org")

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
