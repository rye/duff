(defun hooks/editorconfig--set-language-specific-indent-tabs-mode (hash)
  "Ensures that any language-specific `indent-tabs-mode' variables are set."
  (cond ((eq major-mode 'ruby-mode)
         (message "In Ruby mode, setting `ruby-indent-tabs-mode' to `indent-tabs-mode' per EditorConfig.")
         (setq ruby-indent-tabs-mode indent-tabs-mode))))

(defun hooks/editorconfig--unify-indent-tabs-mode-and-smart-tabs-mode (hash)
  "Ensures that `smart-tabs-mode' is disabled if `indent-tabs-mode' is."
  (if (not indent-tabs-mode)
      (setq smart-tabs-mode nil)))

(provide 'hooks/editorconfig)
