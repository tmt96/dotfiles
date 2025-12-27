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

(after! org
  (setq
   ;; ui & ux fixes
   org-auto-align-tags nil
   org-tags-column 0
   org-ellipsis " ▼"
   org-list-demote-modify-bullet
   '(("-" . "+") ("+" . "*") ("*" . "-") ("A." . "1.") ("1." . "a."))
   org-id-link-to-org-use-id t
   org-blank-before-new-entry '((heading . t) (plain-list-item . auto))
   org-pretty-entities t
   org-hide-emphasis-markers t

   ;; todo settings
   org-todo-keywords
   '((sequence
      "TASK(t)"         ; A newly-filed task, have not been evaluated or scheduled yet
      "HOLD(h)"         ; A task that was decided to be put off for a later date
      "EVAL(e)"         ; A task that needs to be evaluated on feasibility & could potentially be done soon
      "NEXT(n!)"         ; A task that is ready to be done and should be done soon (<3 days)
      "LOOP(l!)"         ; A recurring task
      "WAIT(w@)"         ; A task that is hold off by other tasks, or by other people/external factors
      "PROG(p!)"         ; An in-progress task
      "MEET(m)"         ; A meeting/call
      "IDEA(i)"         ; an unconfirmed/unsubstantiated idea
      "|"
      "DONE(d!)"        ; Self-explanatory
      "PASS(>@)"         ; Another person will take over
      "DROP(x@)"         ; Task is dropped/decided against doing
    ))
   org-enforce-todo-dependencies t
   org-log-into-drawer "LOGBOOK"
   org-todo-repeat-to-state "LOOP"

   ;; org-agenda settings
   org-agenda-files (directory-files-recursively org-directory "\\.org$")
   org-agenda-skip-scheduled-if-deadline-is-shown t
   org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled
   org-agenda-tags-column 0
   org-agenda-prefix-format
    (quote
     ((agenda . "%-24c%?-12t% s")
      (timeline . "% s")
      (todo . "%-12c")
      (tags . "%-12c")
      (search . "%-12c")))
   )
  (when (modulep! :lang org +bigheadings)
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
  :defer
  :when (modulep! :lang org +journal)
  :defer 1
  :after org
  :init
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-carryover-items "TODO=\"TASK\"|TODO=\"HOLD\"|TODO=\"EVAL\"|TODO=\"MEET\"|TODO=\"NEXT\"|TODO=\"PROG\"|TODO=\"WAIT\"")
  :custom
  (org-journal-file-format "%Y/%m-%d.org")
  (org-journal-date-format "%A, %b %d")
  (org-journal-dir org-directory)
  (org-journal-file-type 'weekly)
  (org-journal-file-header "#+TITLE: %m-%d Weekly Journal\n#+SETUPFILE: ~/org/master.org\n")
  (org-journal-enable-agenda-integration t)
  )

;; agenda format
(use-package! org-super-agenda
  :when (modulep! :lang org +super-agenda)
  :after org-agenda
  :config
  (org-super-agenda-mode)
  :custom
  (org-super-agenda-groups
   `((:name "Schedule"
      :time-grid t)
     (:name "Habits"
      :habit t)
     (:name "Blocked"
      :todo "WAIT" :order 1)
     (:name "Due"
      :deadline today)
     (:name "Overdue"
      :deadline past)
     (:name "In-progress"
      :todo "PROG")
     (:name "Next"
      :todo "NEXT")
     (:name "Important"
      :priority "A")
     (:name "Meeting"
      :todo "MEET")
     (:name "Evaluating"
      :todo "EVAL")
     (:name "Coming up"
      :not (:category "career_growth"
            :scheduled future
            :deadline (after ,(org-read-date nil nil "+3d"))))
     (:name "Not yet filed"
      :todo "TASK")
     (:name "Unscheduled"
      :and (:scheduled nil :deadline nil
            :not (:category "career_growth")))
     (:name "Career Task Behind"
      :todo ("NOT_STARTED" "BEHIND") :order 1)
     (:name "Career"
      :tag "career_growth" :order 2)))
  )

;; bullet formatting
(use-package! org-superstar
  :when (modulep! :lang org +pretty)
  :after org
  :custom
  (org-superstar-item-bullet-alist
   '((?+ . ?•)
     (?* . ?❅)
     (?- . ?➤)))
  (org-superstar-todo-bullet-alist nil)
  )

(use-package! org-modern
  :when (modulep! :lang org +modern)
  :hook (org-mode . global-org-modern-mode)
  :custom
  (org-modern-priority
   `((?A . ,(propertize "⚑" 'face 'error))
     (?B . ,(propertize "⬆" 'face 'warning))
     (?C . ,(propertize "■" 'face 'success))))
  (org-modern-hide-stars nil)
  (org-modern-star 'replace)
  :custom-face (org-modern-label ((t :inherit default :height 1.0)))
  )

(use-package! org-modern-indent
  :when (modulep! :lang org +modern)
  :config ; add late to hook
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90)
  )

;; notification
(use-package! org-wild-notifier
  :when (and IS-MAC (modulep! :lang org +notify))
  :after org
  :config
  (org-wild-notifier-mode)
  :custom
  (org-wild-notifier-keyword-blacklist '("DONE" "PASS" "DROP"))
  (alert-default-style (cond (IS-MAC 'osx-notifier) (t 'notifications)))
  )

;; roam
(use-package! org-roam
  :when (modulep! :lang org +roam2)
  :after org
  :custom
  (org-roam-graph-executable (executable-find "neato"))
  (+org-roam-open-buffer-on-find-file nil)
  (org-roam-directory org-directory)
  )

(use-package! org-noter-pdftools
  :when (modulep! :lang org +noter)
  :after org-noter
  )

;; pomodoro
(use-package! org-pomodoro
  :when (modulep! :lang org +pomodoro)
  :after org
  :custom
  (org-pomodoro-manual-break t)
  )
