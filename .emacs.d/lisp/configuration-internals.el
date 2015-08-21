;; This is placeholder text.

(defun configuration-internals--term-program ()
  (getenv "TERM_PROGRAM"))

(defun configuration-internals--system-type ()
  (symbol-name system-type))

(defun configuration-internals--mac-os-x-fixup-path (&optional force)
  (interactive "*")
  (progn
    (if (or force
            (and (not (configuration-internals--term-program))
                 (string-equal "darwin" (configuration-internals--system-type))))
        (let ((path (shell-command-to-string
                     "$SHELL -cl \"printf %s \\\"\\\$PATH\\\"\"")))
          (setenv "PATH" path)
          (setq exec-path (split-string (getenv "PATH") ":"))))))
