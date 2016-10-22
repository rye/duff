;; For configuration of various network functions

(if (require 'tramp nil 'no-error)
    (add-to-list 'tramp-remote-process-environment "TERM=dumb"))
