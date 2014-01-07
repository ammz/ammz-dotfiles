
(defvar vendor-dir (concat main-dir "vendor/")
  "This directory house Emacs Lisp packages that are not yet available in
ELPA (or Marmalade).")

(defvar personal-dir (concat main-dir "personal/")
  "Users of Emacs are encouraged to keep their personal configuration
changes in this directory. All Emacs Lisp files there are loaded automatically
by ammz.")

;; add directories to Emacs's `load-path'
(add-to-list 'load-path vendor-dir)
(add-to-list 'load-path personal-dir)

;; config changes made through the customize UI will be store here
;;(setq custom-file (concat ammz-personal-dir "custom.el"))

;; load the personal settings (this includes `custom-file')
;;(when (file-exists-p ammz-personal-dir)
;;  (mapc 'load (directory-files ammz-personal-dir nil "^[^#].*el$")))

(defun ammz-add-subfolders-to-load-path (parent-dir)
    "Adds all first level `parent-dir' subdirs to the
  Emacs load path."
    (dolist (f (directory-files parent-dir))
      (let ((name (concat parent-dir f)))
        (when (and (file-directory-p name)
                   (not (equal f ".."))
                   (not (equal f ".")))
          (add-to-list 'load-path name)))))

(ammz-add-subfolders-to-load-path vendor-dir)
