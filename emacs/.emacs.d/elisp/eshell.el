(defun my/setup-eshell ()
  (interactive)
  ;; turn off semantic-mode in eshell buffers
  (semantic-mode -1)
  ;; turn off hl-line-mode1
  (hl-line-mode -1)
  (setq-local show-trailing-whitespace nil))


(require 'esh-opt)
(require 'em-cmpl)
(require 'em-prompt)
(require 'em-term)

(setq eshell-cmpl-cycle-completions nil
      ;; auto truncate after 12k lines
      eshell-buffer-maximum-lines 12000
      ;; history size
      eshell-history-size 500
      ;; buffer shorthand -> echo foo > #'buffer
      eshell-buffer-shorthand t
      ;; my prompt is easy enough to see
      eshell-highlight-prompt nil
      ;; treat 'echo' like shell echo
      eshell-plain-echo-behavior t)

(setq eshell-visual-commands '("vi" "screen" "top" "less" "more" "lynx"
                               "ncftp" "pine" "tin" "trn" "elm" "vim"
                               "nmtui" "alsamixer" "htop" "el" "elinks"
                               ))
(setq eshell-visual-subcommands '(("git" "log" "diff" "show")))

(add-hook 'eshell-mode-hook #'my/setup-eshell)

(defun eshell-here ()
  "Opens up a new shell in the directory associated with the current buffer's file."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (name (car (last (split-string parent "/" t)))))
    (split-window-vertically)
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'my/eshell-here)

(defun eshell/x (&rest args)
  (delete-single-window))

