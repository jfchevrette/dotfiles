;;; Theme
(my/require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-night t)

;;; Font
(defvar my/font-name "Hack")
(defvar my/font-height 150)
(set-frame-font my/font-name)
(set-face-attribute 'default nil :font my/font-name :height my/font-height)
(set-face-font 'default my/font-name)

;;; UI
(when (functionp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (functionp 'set-scroll-bar-mode)
  (set-scroll-bar-mode 'nil))
(when (functionp 'mouse-wheel-mode)
  (mouse-wheel-mode -1))
(when (functionp 'tooltip-mode)
  (tooltip-mode -1))
(when (functionp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (functionp 'blink-cursor-mode)
  (blink-cursor-mode -1))

;;; Modeline
(setq display-time-mail-function (lambda () nil)
      display-time-24hr-format t
      display-time-interval 15)
(display-time-mode 1)
