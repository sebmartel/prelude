(prelude-require-packages '(smooth-scrolling
                            plantuml-mode
                            org-bullets
                            clojure-snippets
                            hydra))

(require 'seb-utils (concat prelude-personal-dir "/seb-utils"))

;; Scratch (from wasamasa)
(setq initial-scratch-message "")          ;; remove scratch default
                                           ;; message
(setq initial-major-mode 'emacs-lisp-mode) ;; Scratch should be ing
                                           ;; elisp mode (because
                                           ;; emacs puts it in
                                           ;; fundamental mode by
                                           ;; default for some reason)
;; Searching tweaks
;; https://www.emacswiki.org/emacs/IncrementalSearch#toc4
;; Reliably put the point at the end of the match
(add-hook 'isearch-mode-end-hook 'my-goto-match-end)
(defun my-goto-match-end ()
  (when (and (not isearch-forward) isearch-other-end)
    (goto-char isearch-other-end)))

;; I like a true insert line above.
(global-set-key (kbd "C-S-o") 'seb/open-line-above)

;; Set config `crux-find-user-init-file' to be this `custom.el'
(setq user-init-file "~/.emacs.d/personal/my-init.el")

;; I disable C-z because I fat finger that area quite often and
;; definitely do not like emacs to be minimized when that happens.
(global-unset-key "\C-z")

;; I fat finger C-x C-c too often as well. Too bad this doesn't help
;; when running emacsclient.
(setq confirm-kill-emacs 'y-or-n-p)

;; No vertical scroll bar please.
(scroll-bar-mode -1)

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

;; org-mode clojure
(setq org-babel-clojure-backend 'cider)
(require 'cider)

;; Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)
   (gnuplot . t)
   (plantuml . t)
   (clojure . t)
   (shell . t)
   ))

;; Pretty bullets
(add-hook 'org-mode-hook
          (lambda () (org-bullets-mode 1)))

;; syntax color source blocks in org mode
(setq org-src-fontify-natively t)

;; org mode templates
(add-to-list 'org-structure-template-alist'
             ("dw" "#+BEGIN_SRC sql :exports both :engine postgresql :cmdline \"-U sebm -d dev -h slate#####.com -p 5439\" \n?\n#+END_SRC"))
(add-to-list 'org-structure-template-alist'
             ("clj" "#+BEGIN_SRC clojure\n?\n#+END_SRC"))

;; smart-parqens missing bindings
(define-key smartparens-mode-map (kbd "M-J") 'sp-join-sexp)
(define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)

;; hydra

(defhydra hydra-nav-errors (global-map "M-g")
  "Navigate error buffers easily"
  ("a" first-error "first-error")
  ("n" next-error "next-error")
  ("p" previous-error "previous-error")
  ("e" (condition-case err
           (while t
             (next-error))
         (user-error nil)) "last-error")
  ("q" nil "quit"))

(which-key-add-key-based-replacements
  "M-g n" "next-error"
  "M-g p" "previous-error"
  "M-g a" "first-error"
  "M-g e" "last-error")

(defhydra hydra-move-text ()
  "Move text"
  ("p" move-text-up "up")
  ("n" move-text-down "down")
  ("q" nil "quit"))

(defhydra hydra-learn-sp (:hint nil)
  "
      _f_ forward-symbol     _b_ backward-symbol     _n_ next-sexp      _p_ backwards-sexp
      _C-f_ forward-sexp     _C-b_ previous-sexp     _C-n_ forward-down _C-p_ backward-up
      _M-f_ forward-up       _M-b_ backward-down       _e_ end-of-sexp    _a_ beginning-of-sexp
      ----------------------------------------------------------------------------------------
    "

  ("f" sp-forward-symbol)
  ("b" sp-backward-symbol )

  ("n" sp-next-sexp )
  ("p" sp-backward-sexp ) ;; C-M-b

  ("C-n" sp-down-sexp)        ;; C-M-d
  ("C-p" sp-backward-up-sexp) ;; C-M-u

  ("M-f" sp-up-sexp)            ;; C-M-n
  ("M-b" sp-backward-down-sexp) ;; C-M-p

  ("C-f" sp-forward-sexp)    ;; C-M-f
  ("C-b" sp-previous-sexp)   ;;

  ;;
  ("a" sp-beginning-of-sexp)
  ("e" sp-end-of-sexp)

  ;;
  ("t" sp-transpose-sexp)
  ;;
  ("x" sp-delete-char)
  ("dw" sp-kill-word)
  ;;("ds" sp-kill-symbol ) ;; Prefer kill-sexp
  ("dd" sp-kill-sexp)
  ;;("yy" sp-copy-sexp ) ;; Don't like it. Pref visual selection
  ;;
  ("S" sp-unwrap-sexp) ;; Strip!
  ;;("wh" sp-backward-unwrap-sexp ) ;; Too similar to above
  ;;
  ("C-)" sp-forward-slurp-sexp)
  ("M-)" sp-forward-barf-sexp)
  ("C-(" sp-backward-slurp-sexp)
  ("M-(" sp-backward-barf-sexp)

  ;;
  ;;("C-[" (bind (sp-wrap-with-pair "[")) ) ;;FIXME
  ;;("C-(" (bind (sp-wrap-with-pair "(")))
  ;;

  ("s" sp-splice-sexp)
  ("df" sp-splice-sexp-killing-forward)
  ("db" sp-splice-sexp-killing-backward)
  ("da" sp-splice-sexp-killing-around)
  ;;
  ("C-S-s" sp-select-next-thing-exchange)
  ("C-S-p" sp-select-previous-thing)
  ("C-S-n" sp-select-next-thing)
  ;;
  ;;
  ;;("C-t" sp-prefix-tag-object)
  ;;("H-p" sp-prefix-pair-object)
  ("c" sp-convolute-sexp)
  ("g" sp-absorb-sexp)
  ("q" sp-emit-sexp)
  ;;
  (",b" sp-extract-before-sexp)
  (",a" sp-extract-after-sexp)
  ;;
  ("AP" sp-add-to-previous-sexp)   ;; Difference to slurp?
  ("AN" sp-add-to-next-sexp)
  ;;
  ("_" sp-join-sexp) ;;Good
  ("|" sp-split-sexp))
