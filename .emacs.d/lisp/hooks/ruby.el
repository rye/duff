(defun hooks/ruby--set-indent-line-function ()
  "Sets `indent-line-function' to `ruby-indent-line' locally."
  (if (eq major-mode 'ruby-mode)
      (setq-local indent-line-function 'ruby-indent-line)))

(defun hooks/ruby--add-prettify-symbols ()
  "Adds Ruby-specific symbols to the `prettify-symbols-alist'."
  (let (alist '())
    (push '(">=" . ?≥) alist)
    (push '("<=" . ?≤) alist)
    (push '("<<" . ?«) alist)
    (push '("=>" . ?⇒) alist)
    (setq prettify-symbols-alist alist)))

(provide 'hooks/ruby)
