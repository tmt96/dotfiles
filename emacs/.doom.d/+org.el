;;; +org.el -*- lexical-binding: t; -*-

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")

(nconc org-modules
       '(org-capture
         org-checklist
         org-habit
         org-id
         org-inlinetask
         org-protocol))

(when (featurep! :lang org +roam)
  (setq org-roam-directory org-directory)
)

(after! org
  (setq
   ;; ui & ux fixes
   org-tags-column -90
   org-ellipsis " ▼"
   org-list-demote-modify-bullet
   '(("-" . "+") ("+" . "*") ("*" . "-") ("A." . "1.") ("1." . "a."))
   org-id-link-to-org-use-id t

   ;; todo settings
   org-todo-keywords
   '((sequence "TODO(t)" "PROGRESS(p!)" "BLOCKED(b@)" "|" "DONE(d!)" "DELEGATED(g@)" "NO-OP(n@)"))
   org-enforce-todo-dependencies t
   org-log-into-drawer "LOGBOOK"

   ;; org-agenda settings
   org-agenda-files (directory-files-recursively org-directory "\\.org$")
   org-agenda-skip-scheduled-if-deadline-is-shown t
   org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled
   org-agenda-prefix-format
    (quote
     ((agenda . "%-24c%?-12t% s")
      (timeline . "% s")
      (todo . "%-12c")
      (tags . "%-12c")
      (search . "%-12c")))
   )
  (when (featurep! :lang org +bigheadings)
    (custom-set-faces!
      '(org-document-title :height 1.3)
      '(org-level-1 :inherit outline-1 :height 1.2)
      '(org-level-2 :inherit outline-2 :height 1.1)
      '(org-level-3 :inherit outline-3 :height 1.05)
      ))
  (unsetq-hook! 'org-mode-hook (company-mode -1))
  )

;; journal
(use-package! org-journal
  :when (featurep! :lang org +journal)
  :init
  (setq org-journal-prefix-key "C-c j ")
  :custom
  (org-journal-file-format "%Y/%m-%d.org")
  (org-journal-date-format "%A, %b %d")
  (org-journal-dir org-directory)
  (org-journal-file-type 'weekly)
  (org-journal-file-header "#+TITLE: %m-%d Weekly Journal\n#+SETUPFILE: ~/org/master.org\n")
  (org-journal-enable-agenda-integration t)
  (org-journal-carryover-items "TODO=\"TODO\"|TODO=\"PROGRESS\"|TODO=\"BLOCKED\"")
  )

;; agenda format
(use-package! org-super-agenda
  :when (featurep! :lang org +super-agenda)
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
  )

;; bullet formatting
(use-package! org-superstar
  :when (featurep! :lang org +pretty)
  :custom
  (org-superstar-item-bullet-alist
   '((?+ . ?•)
     (?* . ?❅)
     (?- . ?➤)))
  (org-superstar-todo-bullet-alist nil)
  )

;; notification
(use-package! org-wild-notifier
  :when (featurep! :lang org +notify)
  :after org
  :config
  (org-wild-notifier-mode)
  :custom
  (org-wild-notifier-keyword-whitelist '("TODO" "PROGRESS" "BLOCKED"))
  (alert-default-style 'osx-notifier)
  )

(use-package! org-roam
  :when (featurep! :lang org +roam)
  :custom
  (org-roam-graph-executable (executable-find "neato"))
  )

(use-package! org-pomodoro
  :when (featurep! :lang org +pomodoro)
  :after org
  :custom
  (org-pomodoro-manual-break t)
  )
