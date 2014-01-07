; org-mode
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c b") 'org-iswitchb)
(define-key global-map (kbd "<f12>") 'org-cycle-agenda-files)
(define-key global-map (kbd "<f11>") 'org-agenda)

; load org-protocol for external calls
(require 'org-protocol)

; Avoid conflicts between cua-mode and org-mode
;; (require 'org-cua-dwim)
;; (org-cua-dwim-activate)

; archive method
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

; org-files
(setq org-agenda-files
      (list 
       (concat dropbox-directory "/org")
       ;; (concat dropbox-directory "/org/eca2020")
       ))

(setq org-default-notes-file (concat dropbox-directory "/org/inbox.org"))

; always use indent-mode
(setq org-startup-indented t)

; log the time
(setq org-log-done 'time)

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; refile items two levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))

; targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)

; org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (C . t)
   (sh . t)
   (ditaa . t)
   (ruby . t)
   (python . t)
   (js . t)
   (haskell . t)
   (clojure . t)))

(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")

; capture templates
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline (concat dropbox-directory "/org/inbox.org") "Tareas")
         "* TODO %?\n %i")
        ("T" "Todo limite" entry
         (file+headline (concat dropbox-directory "/org/inbox.org") "Tareas")
         "* TODO %?\nDEADLINE: %t\n %i")
        ("r" "Reunion" entry
         (file (concat dropbox-directory "/org/inbox.org") "Reuniones")
         "* TODO %? :Reunion:\n %T")
        ("c" "Cursos que sigo")
        ("cp" "Actividad de Physics 1" entry
         (file+olp (concat dropbox-directory "/org/estudios.org") "Physics 1" "tareas")
         "* TODO %? :physics1:\n%^t")
        ("cm" "Actividad de Classical Mechanics" entry
         (file+olp (concat dropbox-directory "/org/estudios.org") "Classical Mechanics" "tareas")
         "* TODO %? :MIT801x:\n%^t")
        ("cc" "Actividad Calculus One" entry
         (file+olp (concat dropbox-directory "/org/estudios.org") "Calculus One" "tareas")
         "* TODO %? :Calculus1:\n%^t")
        ("n" "Nota" entry
         (file (concat dropbox-directory "/org/notas.org"))
         "* NOTA %?\n%a")
        ("f" "Llamada telefonica" entry
         (file+headline (concat dropbox-directory "/org/oficina.org") "Llamadas recibidas")
;         "%U %? :TELEFONO:\n")))
         "* %? :TELEFONO:")))

; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@work" . ?w)
                            ("@home" . ?h)
                            (:endgroup)
                            ("mail" . ?m)
                            ("phone" . ?c)
                            ("waiting" . ?.)
                            ("hold" . ?h)
                            ("code" . ?c)
                            ("note" . ?n)
                            ("cancelled" . ?a)
                            ("flagged" . ??))))

; allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; LaTeX export
(require 'org-latex)
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-export-backends '(latex icalendar html ascii odt md pandoc))
