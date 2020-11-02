;;; +org.el -*- lexical-binding: t; -*-

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")

(nconc org-modules
       '(org-capture
         org-checklist
         org-habit-alert-faceorg-id
         org-protocol))

(after! org
  (setq org-agenda-files (directory-files-recursively org-directory "\\.org$")
        org-agenda-skip-scheduled-if-deadline-is-shown t
        org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled
        org-todo-keywords
        '((sequence "TODO(t)" "PROGRESS(p!)" "BLOCKED(b@)" "|" "DONE(d!)" "DELEGATED(g@)" "NO-OP(n@)"))
        org-enforce-todo-dependencies t
        org-log-into-drawer "LOGBOOK"
        org-tags-column -100
        org-ellipsis " ▼"
        org-list-demote-modify-bullet
        '(("-" . "+") ("+" . "*") ("*" . "-") ("A." . "1.") ("1." . "a."))
        )
  )

(use-package! org-super-agenda
  :after org-agenda
  :config
  (org-super-agenda-mode)
  )

(use-package! org-superstar
  :config
  (setq org-superstar-item-bullet-alist
        '((?+ . ?•)
          (?* . ?▪)
          (?- . ?➤))
        org-superstar-todo-bullet-alist nil
        )
  )
