;; For configuration of various network functions

(if (require 'tramp nil 'no-error)
    (progn
      (add-to-list 'tramp-remote-process-environment "TERM=dumb")
      (setq tramp-histfile-override "/dev/null")))
