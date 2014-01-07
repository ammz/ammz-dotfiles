(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(load "mmm-mako.el")

(add-to-list 'auto-mode-alist '("\\.mako\\'" . html-mode))
(mmm-add-mode-ext-class 'html-mode "\\.php\\'" 'html-php)
(mmm-add-mode-ext-class 'html-mode "\\.mako\\'" 'mako)


