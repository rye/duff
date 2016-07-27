(defun l (file-or-symbol &optional noerror nomessage nosuffix must-suffix)
  "If `file-or-symbol' is a symbol, calls (load (symbol-name `file-or-symbol')).
Otherwise, simply calls (load `file-or-symbol').

In either case, passes remaining arguments to load."
  (if (symbolp file-or-symbol)
      (load (symbol-name file-or-symbol) noerror nomessage nosuffix must-suffix)
    (load file-or-symbol noerror nomessage nosuffix must-suffix)))

(provide 'l)
