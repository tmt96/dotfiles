;;; +bindings.el -*- lexical-binding: t; -*-

(map!
 ;; Fix silly Mac-specific keybindings
 (:when IS-MAC
  "s-x"                #'kill-region
  )
 ;; swiper is love swiper is life
 (:when (featurep! :completion ivy)
  "C-s"         #'swiper
  "C-r"         #'swiper-backward
  )
 (:after org
  (:map org-mode-map
   ;;Reset default behavior overriden by doom
   "C-c a"              #'org-agenda
   "M-<right>"          #'org-do-demote
   "M-<left>"           #'org-do-promote
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
 )
