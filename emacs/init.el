;; ------------------------------------
;; load-path
;; ------------------------------------
(defvar main-dir (file-name-directory load-file-name)
 "The root dir of the Emacs ammz distribution.")

(add-to-list 'load-path main-dir)



;; ------------------------------------
;; Initiating emacs server
;; ------------------------------------
(server-start)


;; ------------------------------------
;; Language environment - required by mu4e
;; ------------------------------------
(setq set-language-environment "UTF-8")


;; ------------------------------------
;; Packages
;; ------------------------------------
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("org" . "http://orgmode.org/elpa/")))

(package-initialize)

(dolist (p '(;; fundamentales
             auto-complete powerline autopair s magit
             auctex dash deft dired+ elpy epl fuzzy
             highlight-indentation idomenu iedit
             lorem-ipsum magit nose org-pandoc pkg-info 
             virtualenv yasnippet find-file-in-project

             ;; modes
             org-plus-contrib pandoc-mode markdown-mode
             haskell-mode php-mode git-commit-mode
             git-rebase-mode lua-mode web-mode mmm-mode

             ;; themes
             zenburn-theme
             ))
  (when (not (package-installed-p p))
    (package-install p)))



;; ------------------------------------
;; Lisp
;; ------------------------------------
(load "ammz/routes")

;; place to save customizations
(setq custom-file "~/.emacs.d/ammz/custom.el")

;; load main configuration
(when (file-exists-p custom-file)
  (load custom-file))

(load "ammz/org")           ; org-mode
(load "ammz/defuns")        ; handy functions
(load "ammz/os")            ; settings for specific operating systems
(load "ammz/dired")         ; expand dired
;; (load "ammz/ergoemacs")     ; ergoemacs
;; (load "ammz/lusty")         ; lusty mode
(load "ammz/modes")         ; settings for specific modes
(load "ammz/theme")         ; set the theme and font
(load "ammz/temp_files")    ; temporary files
(load "ammz/auctex")        ; AUCTeX
(load "ammz/haskell")       ; haskell
(load "ammz/bindings")      ; keybindings
(load "ammz/global")        ; global config
(load "ammz/mu4e")          ; mu4e config
(load "ammz/slime")         ; slime config
(load "ammz/elpy")          ; elpy config
(load "ammz/yasnippet")     ; yasnippet config
(load "ammz/mmm")           ; mmm-mode config
(load "lorem-ipsum")

(put 'downcase-region 'disabled nil)

