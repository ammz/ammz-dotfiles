;; projectile for project management
;; (projectile-global-mode)


;; ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)


;; recentf
(recentf-mode 1)
(setq recentf-max-saved-items 30)
(add-to-list 'recentf-exclude "\\/tmp\\'")


;; auto completion
(require 'auto-complete-config)
(ac-config-default)
;; (setq ac-auto-start nil)    ; don't automatically trigger auto-complete
(ac-set-trigger-key "TAB")  ; only trigger auto-completion on TAB


;; autopair
(require 'autopair)
(autopair-global-mode t)    ; activa autopair en todos los buffers
(setq autopair-autowrap t)  ; envuelve la selección con paréntesis, comillas, ...


; auto-fill
(add-hook 'html-mode-hook 'turn-off-auto-fill)
;(add-hook 'clojure-mode-hook 'turn-on-auto-fill)
(add-hook 'python-mode-hook 'turn-on-auto-fill)
;(setq comment-auto-fill-only-comments t)


;; markdown
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.txt" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook 'turn-on-pandoc)
(setq markdown-command "pandoc --smart -f markdown -t html")

(defun marked-markdown-preview ()
  "run Marked on the current file if Marked is installed;
otherwise fallback to markdown-preview"
  (interactive)
  (let ((marked-app "/Applications/Marked.app"))
    (if (file-exists-p marked-app)
        (shell-command
         (format (concat "open -a " marked-app " %s")
                 (shell-quote-argument (buffer-file-name))))
      (markdown-preview))
    ))

(eval-after-load 'markdown-mode
  '(progn
     (define-key markdown-mode-map (kbd "C-c C-v") 'marked-markdown-preview)
     ))

;; ssh and sudo -> multi-hop filenames
;; /sudo:ssh-host:file-on-ssh-host 
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;; use ~.ssh/config with tramp
;; /su:gandalf:/
;; (tramp-set-completion-function "ssh"
;;                               '((tramp-parse-sconfig "~/.ssh/config")))

;; deft
(require 'deft)
(setq deft-extension "txt")
(setq deft-directory "~/Dropbox/notas")
(setq deft-text-mode 'markdown-mode)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'". web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'". web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'". web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'". web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'". web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'". web-mode))
(add-to-list 'auto-mode-alist '("\\.pt\\'". web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'". web-mode))
