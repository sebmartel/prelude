(deftheme zenburn-seb
  "Created 2017-11-03. With a more contrasting region color.")

(custom-theme-set-variables
 'zenburn-seb
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector ["#454545" "#cd5542" "#6aaf50" "#baba36" "#5180b3" "#ab75c3" "#68a5e9" "#bdbdb3"])
 '(beacon-color "#cc6666")
 '(compilation-message-face (quote default))
 '(custom-safe-themes (quote ("6de7c03d614033c0403657409313d5f01202361e35490a3404e33e46663c2596" "938d8c186c4cb9ec4a8d8bc159285e0d0f07bad46edf20aa469a89d0d2a586ea" "ed317c0a3387be628a48c4bbdb316b4fa645a414838149069210b66dd521733f" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "cdfc5c44f19211cfff5994221078d7d5549eeb9feda4f595a2fd8ca40467776c" default)))
 '(nrepl-message-colors (quote ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-babel-clojure-backend (quote cider))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages (quote (fancy-narrow ample-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized solarized-theme material-theme hydra markdown-mode smex org clojure-snippets org-bullets plantuml-mode smooth-scrolling zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line operate-on-number move-text magit projectile ov imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major dash crux browse-kill-ring beacon anzu ace-window)))
 '(safe-local-variable-values (quote ((flycheck-disabled-checkers emacs-lisp-checkdoc))))
 '(smartrep-mode-line-active-bg "#204934"))

(custom-theme-set-faces
 'zenburn-seb
 '(region ((t (:background "tan4")))))

(provide-theme 'zenburn-seb)
