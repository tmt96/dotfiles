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
        org-tags-column -90
        org-ellipsis " ▼"
        org-list-demote-modify-bullet
        '(("-" . "+") ("+" . "*") ("*" . "-") ("A." . "1.") ("1." . "a."))
        )
  (unsetq-hook! 'org-mode-hook (company-mode -1))
  )

(use-package! org-journal
  :custom
  ( org-journal-file-format "%Y/%m-%d.org")
  (org-journal-date-format "%A, %b %d")
  ( org-journal-dir org-directory)
  (org-journal-file-type 'weekly)
  (org-journal-file-header "#+TITLE: %m-%d Weekly Journal\n#+SETUPFILE: ~/org/master.org\n")
  (org-journal-enable-agenda-integration t)
  (org-journal-carryover-items "TODO=\"TODO\"|TODO=\"PROGRESS\"|TODO=\"BLOCKED\"")
  )

(use-package! org-super-agenda
  :after org-agenda
  :config
  (org-super-agenda-mode)
  :custom
  (org-super-agenda-groups
   '((:name "Schedule"
      :time-grid t)
     (:name "Blocked"
      :todo "BLOCKED" :order 1)
     (:name "Due"
      :deadline today)
     (:name "Overdue"
      :deadline past)
     (:name "Ongoing"
      :scheduled past)
     (:name "Important"
      :priority "A")
     (:name "Todo soon"
      :scheduled future :order 1)
     (:name "Due soon"
      :deadline future )
     (:name "Behind"
      :todo ("NOT_STARTED" "BEHIND") :order 1)
     (:name "Career"
      :tag "career_growth" :order 2)
     (:name "Misc"
      :todo ("TODO PROGRESS") :order 2)))
  (org-agenda-prefix-format
   (quote
    ((agenda . "%-24c%?-12t% s")
     (timeline . "% s")
     (todo . "%-12c")
     (tags . "%-12c")
     (search . "%-12c"))))
  )

(use-package! org-superstar
  :custom
  (org-superstar-item-bullet-alist
   '((?+ . ?•)
     (?* . ?▪)
     (?- . ?➤)))
  (org-superstar-todo-bullet-alist nil)
  )

(use-package! org-wild-notifier
  :after org
  :config
  (org-wild-notifier-mode)
  :custom
  (org-wild-notifier-keyword-whitelist '("TODO" "PROGRESS" "BLOCKED"))
  (alert-default-style 'osx-notifier)
  )
