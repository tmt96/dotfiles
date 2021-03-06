;;; autoload.el -*- lexical-binding: t; -*-

;;; Smarter org blank space behaviors

;;;###autoload
(defun +org/call-rebinding-org-blank-behaviour (fn)
  (let ((org-blank-before-new-entry
         (copy-tree org-blank-before-new-entry)))
    (when (org-at-heading-p)
      (rplacd (assoc 'heading org-blank-before-new-entry) nil))
    (call-interactively fn)))

;;;###autoload
(defun +org/smart-org-meta-return-dwim ()
  "org-meta-return with smart spacing"
  (interactive)
  (+org/call-rebinding-org-blank-behaviour 'org-meta-return))

;;;###autoload
(defun +org/smart-org-insert-todo-heading-dwim ()
  "insert todo heading with smart spacing"
  (interactive)
  (+org/call-rebinding-org-blank-behaviour 'org-insert-todo-heading))

;;;###autoload
(defun +org/smart-org-insert-heading-respect-content-dwim ()
  "insert heading at end of subtree with smart spacing"
  (interactive)
  (+org/call-rebinding-org-blank-behaviour 'org-insert-heading-respect-content))

;;;###autoload
(defun +org/smart-org-insert-todo-heading-respect-content-dwim ()
  "insert todo heading at end of subtree with smart spacing"
  (interactive)
  (+org/call-rebinding-org-blank-behaviour 'org-insert-todo-heading-respect-content))

;;;###autoload
(defun +org/smart-org-insert-subheading-dwim ()
  "insert subheading with smart spacing"
  (interactive)
  (+org/call-rebinding-org-blank-behaviour 'org-insert-subheading))

;;;###autoload
(defun +org/smart-org-insert-todo-subheading-dwim ()
  "insert todo subheading with smart spacing"
  (interactive)
  (+org/call-rebinding-org-blank-behaviour 'org-insert-todo-subheading))

;;;###autoload
(defun +org/smart-org-insert-item-below-dwim ()
  "insert item below with smart spacing"
  (interactive)
  (+org/call-rebinding-org-blank-behaviour '+org/insert-item-below))
