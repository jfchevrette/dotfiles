;;; Initialize package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;;; Install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

;;; Set personal information
(setq user-full-name "Jean-François Chevrette"
      user-mail-address "jfchevrette@gmail.com")

;;; UI stuff
(setq inhibit-splash-screen t)		;; Disable splash screen
(setq inhibit-startup-screen t)		;; Disable startup screen
(line-number-mode 1)			;; Show line number in modeline
(column-number-mode 1)			;; Show column number in modeline
(global-hl-line-mode 1)			;; Highlight the line where the cursor is
(defalias 'yes-or-no-p 'y-or-n-p)	;; Replace yes/no answers by y/n
(setq make-pointer-invisible t)		;; Hide the mouse when typing
(setq visible-bell nil)
(setq ring-bell-function 'my/visible-bell) ;; Flash modeline for a visible bell

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (push '("lambda" . ?λ) prettify-symbols-alist)))
(add-hook 'php-mode-hook
	  (lambda ()
	    (push '("function" . ?ƒ) prettify-symbols-alist)))
(global-prettify-symbols-mode +1)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Utility functions ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my/visible-bell ()
   "A friendlier visual bell effect."
   (invert-face 'mode-line)
   (run-with-timer 0.1 nil 'invert-face 'mode-line))

;;; Misc settings
(setq make-backup-files nil)	;; Don't make backup files
(setq delete-auto-save-files t) ;; Delete auto-save files
(delete-selection-mode 1)	;; Entered text replace selection if active
(setq require-final-newline t)	;; Ensure a file ends with a newline before saving


;;;;;;;;;;;;;;;;
;;; Packages ;;;
;;;;;;;;;;;;;;;;

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package relative-line-numbers
  :config
  (global-relative-line-numbers-mode))

(use-package php-mode)
(use-package yaml-mode)
(use-package ansible)

;;(load "~/.emacs.d/elisp/misc.el")

;;; Load misc functions
(load "~/.emacs.d/elisp/functions.el")
(load "~/.emacs.d/elisp/keybinds.el")

;;; UI (theme, font, ui)
(load "~/.emacs.d/elisp/ui.el")

;;; Packages
(load "~/.emacs.d/elisp/expand-region.el")
(load "~/.emacs.d/elisp/multiple-cursors.el")
(load "~/.emacs.d/elisp/eshell.el")
