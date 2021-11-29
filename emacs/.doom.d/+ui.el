;;; +ui.el -*- lexical-binding: t; -*-

;; I like my scrollbar. Fight me!
(scroll-bar-mode)


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-acario-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq +word-wrap-extra-indent 2)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq +ui/font-face (cond (IS-WINDOWS "Cascadia Code")
                          (IS-MAC "Menlo for Powerline")
                          (t "monospace")))
(setq doom-font (font-spec :family  +ui/font-face :size 14 :weight 'light))
(setq line-spacing 0.5)

;; Nice icons in modeline
(use-package! doom-modeline
  :custom
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-major-mode-icon t))

;; Icons in treemacs
(use-package! treemacs-all-the-icons
  :when (featurep! :ui treemacs +icons)
  :defer t
  :config
  (treemacs-load-theme '"all-the-icons"))
