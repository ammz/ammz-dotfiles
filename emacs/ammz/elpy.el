(package-initialize)
(elpy-enable)
;(elpy-use-ipython)
(elpy-clean-modeline)
;(setq elpy-rpc-backend "jedi")

;; (eval-after-load 'elpy
;;   '(progn
;;      (define-key elpy-mode-map (kbd "M-,") 'pop-tag-mark)
;;      ; disable some elpy's keybindings
;;      (define-key elpy-mode-map (kbd "M-n") nil)
;;      (define-key elpy-mode-map (kbd "M-p") nil)
;;      (define-key elpy-mode-map (kbd "M-a") nil)
;;      (define-key elpy-mode-map (kbd "M-e") nil)
;;      (define-key elpy-mode-map (kbd "C-c C-j") nil)
;;      ))
