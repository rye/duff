(defun hooks/lisp--remove-space-from-whitespace-style ()
  "Removes `space-mark' from `whitespace-style'."
  (if (require 'whitespace nil 'no-error)
      (setq-local whitespace-style (remove 'space-mark whitespace-style))))

(provide 'hooks/lisp)
