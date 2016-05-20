(defvar my/package-contents-refreshed nil)

(defun my/package-refresh-contents ()
  (when (not my/package-contents-refreshed)
    (package-refresh-contents)
    (setq my/package-contents-refreshed t)))

(defun my/require (package)
  (unless (package-installed-p package)
    (my/package-refresh-contents)
    (package-install package)))

(defun my/duplicate-line ()
  "Duplicate line leaving cursor at the current position."
  (interactive)
  (save-excursion
    (let ((kill-read-only-ok t) deactivate-mark)
      (toggle-read-only 1)
      (kill-whole-line)
      (toggle-read-only 0)
      (yank))))
(global-set-key (kbd "C-d") 'my/duplicate-line)

(defun my/delete-single-window (&optional window)
  "Remove WINDOW from the display.  Default is `selected-window'.
If WINDOW is the only one in its frame, then `delete-frame' too."
  (interactive)
  (save-current-buffer
    (setq window (or window (selected-window)))
    (select-window window)
    (kill-buffer)
    (if (one-window-p t)
        (delete-frame)
        (delete-window (selected-window)))))
