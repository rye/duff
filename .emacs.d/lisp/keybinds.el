(global-unset-key (kbd "C-x m"))
(global-set-key (kbd "C-x m s") 'magit-status)

(global-set-key (kbd "M-%") 'query-replace-regexp)

(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-x t s") 'interface-theme-switcher--change-to)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; (defun duff/frame-settings (frame)
;;   "Changes the settings for a given frame."
;;   (with-selected-frame frame
;;     (progn
;;       (if (display-graphic-p)
;;           (progn
;;             (message "Running frame settings hook for graphical frame.")
;;             (let ((command-modifier 'meta)
;;                   (option-modifier 'super))
;;               (setq mac-command-modifier command-modifier)
;;               (setq mac-option-modifier option-modifier)))
;;         (progn
;;           (message "Running frame settings hook for non-graphical frame.")
;;           (let ((command-modifier 'super)
;;                 (option-modifier 'meta))
;;             (setq mac-command-modifier command-modifier)
;;             (setq mac-option-modifier option-modifier))))
;;       (make-variable-frame-local mac-command-modifier)
;;       (make-variable-frame-local mac-option-modifier)))
