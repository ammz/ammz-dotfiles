(when (require 'lusty-explorer nil 'noerror)
  ;; overrride the normal file-opening, buffer switching
  (global-set-key (kbd "C-x C-f") 'lusty-file-explorer)
  (global-set-key (kbd "C-x d") 'lusty-file-explorer)
  ;;(global-set-key (kbd "C-m") 'lusty-buffer-explorer)
  (global-set-key (kbd "C-x b") 'lusty-buffer-explorer))

(add-hook 'lusty-setup-hook 'my-lusty-hook)

(defun my-lusty-hook ()
  (define-key lusty-mode-map "\C-l" 'lusty-highlight-next)
  (define-key lusty-mode-map "\C-k" 'lusty-highlight-previous))
