
(setq initial-buffer-choice t) ; Scratch al arrancar

;; fix vidual error in os x 
(setq linum-format " %d ")

;; default tab-width is two spaces
(setq-default tab-width 2
              indent-tabs-mode nil)

;; email
(setq user-full-name "Antonio Moreno")
(setq user-mail-address "ammz@deversorius.net")

;; unicode
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; warnings
(setq visible-bell t)
(setq ring-bell-function (lambda nil (message "")))

;; follow symlinks and don't ask questions
(setq vc-follow-symlinks t) 

;; always show the region
(setq transient-mark-mode t)

;; format the title-bar to always include the buffer name
(setq frame-title-format " %b (%m)")

;; autoselect window with mouse
(setq mouse-autoselect-window t)

;; dont show the GNU splash screen
(setq inhibit-startup-message t)

;; dont ask for yes or no, just use y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; auto-fill
(setq-default fill-column 78)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (add-hook 'org-mode-mode-hook 'turn-off-auto-fill)

;; truncate long lines
(setq-default truncate-lines nil)

;; activar por defecto visual-line-mode
(setq global-visual-line-mode t)

;; european dates
(setq calendar-date-style 'european)

;; spelling
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")

;; call me crazy but I only want lowercase on my linux system
(setq dropbox-directory (expand-file-name "~/Dropbox"))

;; disable scrollbars and menu bar on the mac
;; disable it with .Xdefaults in linux
(when (string-equal system-type "darwin")
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (when (fboundp 'tool-bar-mode) (tool-bar-mode -1)))

;; make buffer name unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; ibuffer always active
(defalias 'list-buffers 'ibuffer)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-list (quote (("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("Context MkIV" "context %t" TeX-run-TeX nil (context-mode)) ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-safe-themes (quote ("9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" "d070fa185078bf753dcfd873ec63be19fa36a55a0c97dc66848a6d20c5fffdad" "f715f948867d85fa384b6c20d793dfd126d71996afd62f9d003705c960929977" "8eef22cd6c122530722104b7c82bc8cdbb690a4ccdd95c5ceec4f3efa5d654f5" "31d3463ee893541ad572c590eb46dcf87103117504099d362eeed1f3347ab18f" "b1e54397de2c207e550dc3a090844c4b52d1a2c4a48a17163cce577b09c28236" "f3d2144fed1adb27794a45e61166e98820ab0bbf3cc7ea708e4bf4b57447ee27" "18d91d95e20450b0cdab4d7eed600e80c22cc7a4153a87989daa5a1c5aff3b83" "a2c537c981b4419aa3decac8e565868217fc2995b74e1685c5ff8c6d77b198d6" "d015a08b8d5850304e5a4bcaf20a80f20595e813e95bf7b66e480a36e240b8ab" "5dfacaf380068d9ed06e0872a066a305ab6a1217f25c3457b640e76c98ae20e6" "09820052b8d8261fb71cb537ac63fdad1def22af777029911e52654f724d9884" "8bb1e9a22e9e9d405ca9bdf20b91301eba12c0b9778413ba7600e48d2d3ad1fb" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bf7ed640479049f1d74319ed004a9821072c1d9331bc1147e01d22748c18ebdf" default)))
 '(doc-view-continuous t)
 '(doc-view-ghostscript-program "gs-noX11")
 '(ergoemacs-mode-used "5.8.0")
 '(ergoemacs-theme nil)
 '(haskell-notify-p t)
 '(haskell-process-type (quote cabal-dev))
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(pandoc-binary "~/.cabal/bin/pandoc"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :foreground "keyboardFocusIndicatorColor"))) t)
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :foreground "dark cyan"))) t)
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :foreground "PaleTurquoise4"))) t)
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :foreground "DarkOliveGreen4"))) t)
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :foreground "LightGoldenrod4"))) t)
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :foreground "light slate gray"))) t))
