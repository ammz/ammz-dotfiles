(global-set-key (kbd "M-7") 'comment-or-uncomment-region)
(global-set-key (kbd "C-<return>") 'ammz-newline-down)
(global-set-key (kbd "C-S-<up>") 'ammz-move-line-up)
(global-set-key (kbd "C-S-<down>") 'ammz-move-line-down)
;;(global-set-key (kbd "C-ñ") 'other-window)
(global-set-key (kbd "C-.") 'repeat)
(global-set-key (kbd "<f9>") 'mu4e)
;;(global-set-key (kbd "M-ñ") 'join-line)
(global-set-key (kbd "C-º") 'toggle-frame-fullscreen)

(global-set-key (kbd "C-ñ") 'other-window)
;; kill word and avoid using the backspace
;; (global-set-key (kbd "C-w") 'kill-region-or-backward-word)

;; resize windows
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<down>") 'shrink-window)

;; Use fn+arrow_keys to move among split panes
;(windmove-default-keybindings 'hyper)

;; keyboard binding for Deft
(global-set-key [f8] 'deft)

;; Markdown preview with marked
(global-set-key "\C-cm" 'markdown-preview-file)
