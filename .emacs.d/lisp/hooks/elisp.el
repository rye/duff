(defun hooks/elisp--add-prettify-symbols ()
  "Adds EmacsLisp-specific symbols to the `prettify-symbols-alist'."
  (push '(">=" . ?≥) prettify-symbols-alist)
  (push '("<=" . ?≤) prettify-symbols-alist))

(provide 'hooks/elisp)
