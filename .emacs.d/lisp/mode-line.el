(defun mode-line--set-format ()
  "Sets `mode-line-format' to the value that it should be set to."

  (progn
    (setq-default mode-line-format
                  '("%e"
                    mode-line-mule-info
                    mode-line-client
                    "<%*%+>"
                    "%@"
                    mode-line-frame-identification
                    (#("%16b" 0 4 (local-map mode-line-highlight face mode-line-buffer-id)))
                    " "
                    "(%l,%c)"
                    " "
                    (vc-mode vc-mode)
                    " "
                    mode-line-misc-info))
    (setq-default battery-mode-line-format " |%b%p%%, %t| ")
    (setq display-time-format " %Y-%m-%d, %H:%M ")
    (setq display-time-default-load-average nil)))

(defun mode-line--toggle-time-display ()
  "Toggles `display-time-mode'"

  (display-time-mode))

(defun mode-line--toggle-battery-display ()
  "Toggles `display-battery-mode'"

  (display-battery-mode))

(provide 'mode-line)
