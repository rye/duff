(defun window-management--balance-windows ()
  (interactive)

  (balance-windows))

(defun window-management--maximize-window (&optional window)
  (interactive)
  (delete-other-windows window))

(defun window-management--delete-window (&optional window)
  (interactive)

  (delete-window window))

(defun window-management--split-window-above (&optional window)
  (interactive)

  (split-window window nil 'above))

(defun window-management--split-window-left (&optional window)
  (interactive)

  (split-window window nil 'left))

(defun window-management--split-window-below (&optional window)
  (interactive)

  (split-window window nil 'below))

(defun window-management--split-window-right (&optional window)
  (interactive)

  (split-window window nil 'right))

(defun window-management--split-window (&optional window)
  (interactive)

  (if (> (/ (window-total-width window) (window-total-height window)) 1.0)
      (window-management--split-window-right window)
    (window-management--split-window-below window)))

(defun window-management--split-window-3-above (&optional window)
  (interactive)

  (let ((current-window-width (window-total-width window)))
    (let ((new-window-width (/ current-window-width 3)))
      (let ((parent-window (split-window window nil 'above)))
        (split-window (split-window parent-window new-window-width 'left) new-window-width 'right)))))

(defun window-management--split-window-3-left (&optional window)
  (interactive)

  (let ((current-window-height (window-total-height window)))
    (let ((new-window-height (/ current-window-height 3)))
      (let ((parent-window (split-window window nil 'left)))
        (split-window (split-window parent-window new-window-height 'above) new-window-height 'below)))))

(defun window-management--split-window-3-below (&optional window)
  (interactive)

  (let ((current-window-width (window-total-width window)))
    (let ((new-window-width (/ current-window-width 3)))
      (let ((parent-window (split-window window nil 'below)))
        (split-window (split-window parent-window new-window-width 'left) new-window-width 'right)))))

(defun window-management--split-window-3-right (&optional window)
  (interactive)

  (let ((current-window-height (window-total-height window)))
    (let ((new-window-height (/ current-window-height 3)))
      (let ((parent-window (split-window window nil 'right)))
        (split-window (split-window parent-window new-window-height 'above) new-window-height 'below)))))

(defun window-management--make-frame (&optional alist)
  (interactive)

  (make-frame alist))

(global-set-key (kbd "C-x w m") 'window-management--maximize-window)
(global-set-key (kbd "C-x w d") 'window-management--delete-window)

(global-set-key (kbd "C-x w s a") 'window-management--split-window)

(global-set-key (kbd "C-x w s C-p") 'window-management--split-window-above)
(global-set-key (kbd "C-x w s C-b") 'window-management--split-window-left)
(global-set-key (kbd "C-x w s C-n") 'window-management--split-window-below)
(global-set-key (kbd "C-x w s C-f") 'window-management--split-window-right)

(global-set-key (kbd "C-x w s 3 C-p") 'window-management--split-window-3-above)
(global-set-key (kbd "C-x w s 3 C-b") 'window-management--split-window-3-left)
(global-set-key (kbd "C-x w s 3 C-n") 'window-management--split-window-3-below)
(global-set-key (kbd "C-x w s 3 C-f") 'window-management--split-window-3-right)

(global-set-key (kbd "C-x w C-p") 'windmove-up)
(global-set-key (kbd "C-x w C-b") 'windmove-left)
(global-set-key (kbd "C-x w C-n") 'windmove-down)
(global-set-key (kbd "C-x w C-f") 'windmove-right)

(global-set-key (kbd "C-x w p") 'windmove-up)
(global-set-key (kbd "C-x w b") 'windmove-left)
(global-set-key (kbd "C-x w n") 'windmove-down)
(global-set-key (kbd "C-x w f") 'windmove-right)

(global-unset-key (kbd "C-x f"))
(global-set-key (kbd "C-x f n") 'window-management--make-frame)
