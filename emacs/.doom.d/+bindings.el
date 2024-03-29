;;; +bindings.el -*- lexical-binding: t; -*-


;; (use-package! counsel
;;   :init
;;   (define-key! [remap org-set-tags-command] nil))

(map!
 ;; Fix silly Mac-specific keybindings
 (:when IS-MAC
  "s-x"                #'kill-region
  )

 ;; swiper is love swiper is life
 (:when (modulep! :completion ivy)
  "C-s"         #'swiper
  "C-r"         #'swiper-backward
  )

 ;; Reset some org-mode keybind
 (:after org
  (:map org-mode-map
   ;;Reset default behavior overriden by doom
   "C-c a"              #'org-agenda
   ;; Make structural editing smart with blank space
   "C-RET"              #'+org/smart-org-insert-heading-respect-content-dwim
   [C-return]           #'+org/smart-org-insert-heading-respect-content-dwim
   "C-S-RET"            #'+org/smart-org-insert-todo-heading-respect-content-dwim
   [C-S-return]         #'+org/smart-org-insert-todo-heading-respect-content-dwim
   "M-RET"              #'+org/smart-org-meta-return-dwim
   [M-return]           #'+org/smart-org-meta-return-dwim
   "M-S-RET"            #'+org/smart-org-insert-todo-heading-dwim
   [M-S-return]         #'+org/smart-org-insert-todo-heading-dwim
   "C-M-S-RET"          #'+org/smart-org-insert-todo-subheading-dwim
   [C-M-S-return]       #'+org/smart-org-insert-todo-subheading-dwim
   "C-M-RET"            #'+org/smart-org-insert-subheading-dwim
   [C-M-return]         #'+org/smart-org-insert-subheading-dwim
   (:when IS-MAC
    [s-return]          #'+org/smart-org-insert-item-below-dwim
    [s-M-return]        #'+org/smart-org-insert-subheading-dwim)
   ))

 (:after smartparens
  (:map smartparens-mode-map
   ;; Reset some keybindings to free up space for org
   "M-<left>"          nil
   "M-<right>"         nil
   "C-M-<left>"        #'sp-backward-barf-sexp
   "C-M-<right>"       #'sp-forward-barf-sexp
   ))

 :leader
 ;; for "notes", i.e org-mode
 (:prefix "n"
  (:when (modulep! :lang org +journal)
   (:prefix "j"
    :desc "Current journal file"        "c"     #'org-journal-open-current-journal-file
    :desc "Previous journal entry"      "b"     #'org-journal-previous-entry
    :desc "Next journal entry"          "f"     #'org-journal-next-entry
    ))
  (:when (modulep! :lang org +pomodoro)
   (:prefix ("p" . "pomodoro")
    "p"         #'org-pomodoro
    "e"         #'org-pomodoro-extend-last-clock))
  (:when (modulep! :lang org +sidebar)
   (:prefix ("b" . "sidebar")
    :desc "Toggle sidebar"              "s"     #'org-sidebar-toggle
    :desc "Toggle sidebar tree"         "t"     #'org-sidebar-tree-toggle
    :desc "Toggle agenda sidebar"       "a"     #'+org-sidebar-toggle-agenda))
  )

 :localleader
 (:map org-mode-map
  (:prefix "r"
   "R"          #'org-refile-copy))
 )
