(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

;; Cambia la asignación de la combinación de teclas
(when (require 'slime nil 'noerror)
(define-key slime-repl-mode-map "\M-s" 'move-cursor-next-pane))
