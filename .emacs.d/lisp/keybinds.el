(global-unset-key (kbd "C-x m"))
(global-set-key (kbd "C-x m s") 'magit-status)

(global-set-key (kbd "M-%") 'query-replace-regexp)

(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-x t s") 'interface-theme-switcher--change-to)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
