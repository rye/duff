;; Prepare ido.
(if (require 'ido nil 'no-error)
    (progn
      (ido-mode t)
      (setq ido-enable-flex-matching t)))

;; Prepare smex.
(if (require 'smex nil 'no-error)
    (progn
      (smex-initialize)
      (global-set-key [(meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(meta x)] 'smex)
                                   (smex)))

      (global-set-key [(shift meta x)] (lambda ()
                                         (interactive)
                                         (or (boundp 'smex-cache)
                                             (smex-initialize))
                                         (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                         (smex-major-mode-commands)))))
