;; load and fire
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(require 'org-mu4e)
(require 'smtpmail)

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
;; (setq mu4e-sent-messages-behavior 'delete)

;; general settings
(setq mail-user-agent 'mu4e-user-agent                   ; mu4e as default mail agent
      mu4e-attachment-dir "/Volumes/data/Downloads"                  ; put attachements in download dir
      mu4e-get-mail-command "getmail --rcfile junta"     ; fetch email with offlineimap
;;       mu4e-confirm-quit nil                              ; don't ask me to quit
;;       mu4e-headers-date-format "%d %b, %Y at %H:%M"      ; date format
;;       message-signature "Petar Radosevic | @wunki"       ; signature
      message-kill-buffer-on-exit t                      ; don't keep message buffers around
;;       mu4e-headers-leave-behavior 'apply                 ; apply all marks at quit
;;       mu4e-html2text-command "html2text -utf8 -width 72" ; html to text
;;       smtpmail-queue-mail nil                            ; start in non queue mode
      ;; smtpmail-auth-credentials (expand-file-name "~/.authinfo")
)

;; my e-mail addresses
(setq mu4e-user-mail-address-regexp
      "antonio\.moreno\.m@juntadeandalucia\.es")
(setq user-mail-address "antonio.moreno.m@juntadeandalucia.es")
(setq user-full-name "Antonio Moreno")

;; maildir locations
(setq mu4e-maildir "~/Maildir/junta"
      mu4e-sent-folder "/sent"
      mu4e-drafts-folder "/draft"
      mu4e-trash-folder "/trash"
      mu4e-refile-folder "/archive")


;; sending mail
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'ssl
      smtpmail-default-smtp-server "mail.juntadeandalucia.es"
      smtpmail-smtp-server "mail.juntadeandalucia.es"
      smtpmail-smtp-service 465)

;; multiple accounts
;; (setq ammz-mu4e-account-alist
;;       '(("deversorius"
;;          (user-mail-address "ammz@deversorius.net")
;;          (mu4e-sent-folder "/junta/sent")
;;          (mu4e-drafts-folder "/junta/drafts")
;;          (mu4e-refile-folder "/junta/archive")
;;          (mu4e-trash-folder  "/junta/trash")
;;          (smtpmail-smtp-server "mail.gmail.com")
;;          (smtpmail-smtp-user "amorenomartinez@gmail.com"))
;;         ("junta"
;;          (user-mail-address "antonio.moreno.m@juntadeandalucia.es")
;;          (mu4e-sent-folder "/ammz/[Gmail].Enviados")
;;          (mu4e-drafts-folder "/ammz/[Gmail].Borradores")
;;          (mu4e-trash-folder "/ammz/[Gmail].Papelera")
;;          (smtpmail-smtp-server "smtp.juntadeandalucia.es")
;;          (smtpmail-smtp-user "antonio.moreno.m"))))

;; (defun ammz-mu4e-set-account ()
;;   "Set the account for composing a message by looking at the maildir"
;;   (let* ((account
;;           (if mu4e-compose-parent-message
;;               (let ((maildir (mu4e-msg-field mu4e-compose-parent-message :maildir)))
;;                 (string-match "/\\(.*?\\)/" maildir)
;;                 (match-string 1 maildir))
;;             (completing-read (format "Compose with account: (%s) "
;;                                      (mapconcat #'(lambda (var) (car var)) ammz-mu4e-account-alist "/"))
;;                              (mapcar #'(lambda (var) (car var)) ammz-mu4e-account-alist)
;;                              nil t nil nil (caar ammz-mu4e-account-alist))))
;;          (account-vars (cdr (assoc account ammz-mu4e-account-alist))))
;;     (if account-vars
;;         (mapc #'(lambda (var)
;;                   (set (car var) (cadr var)))
;;               account-vars))))
;; (add-hook 'mu4e-compose-pre-hook 'ammz-mu4e-set-account)

;; Use Unicode characters
(setq mu4e-use-fancy-chars nil)


;; org-mode integration
(setq mu4e-org-contacts-file "/Users/ammz/Dropbox/org/contactos.org")
(add-to-list 'mu4e-headers-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)

;; headers
(setq mu4e-headers-fields
      '((:date          .  12)
        (:flags         .   6)
        (:from-or-to    .  24)
        (:maildir       .  10)        
        (:subject       .  nil)))

;; set bookmarks
(setq mu4e-bookmarks 
  '(
;;     ("flag:new maildir:/wunki/inbox"              "New Personal"         ?p)
;;     ("flag:new maildir:/bread-and-pepper/inbox"   "New Bread & Pepper"   ?b)
;;     ("flag:unread maildir:/wunki/inbox OR maildir:/bread-and-pepper/inbox"  "All unread messages"  ?u)
    ("date:today..now"                            "Today's messages"     ?t)
    ("date:7d..now"                               "Last 7 days"          ?w)
    ("date:3m..now NOT maildir:/junta/trash"      "Last 3 moths"         ?m)
;;     ("mime:image/*"                               "Messages with images" ?i)
;;     ("flag:flagged"                               "Flagged messages"     ?f)
    ))

;; shortcuts
(setq mu4e-maildir-shortcuts
;;        '(("/INBOX"              . ?i)
;;          ("/[Gmail].Enviados"   . ?e)
;;          ("/[Gmail].Papelera"   . ?p)
;;          ("/[Gmail].Borradores" . ?b)
;;          ("/[Gmail].Todos"      . ?t)
      '(("/"          . ?i)
        ("/sent"      . ?e)
        ("/trash"     . ?p)
        ("/archive"   . ?a)))


(setq mu4e-html2text-command
 "textutil -stdin -format html -convert txt -stdout")
