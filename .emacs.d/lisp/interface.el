;; Enable custom themes that haven't been properly signed.
(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(defvar interface-theme-switcher--current-pair '())
(defvar interface-theme-switcher--alist '())

(setq solarized-use-variable-pitch nil
      solarized-scale-org-headlines nil)

(defun interface-theme-switcher--preload (alist &optional no-confirm)
  (dolist (target alist)
    (progn
      (add-to-list 'interface-theme-switcher--alist target)
      (load-theme (cdr target) no-confirm t))))

(interface-theme-switcher--preload '((light . solarized-light)
                                     (dark . solarized-dark)
                                     (greyscale-dark . tao-yin)
                                     (greyscale-light . tao-yang)))

(defun interface-theme-switcher--customize ()
  (cond ((or (string= (cdr interface-theme-switcher--current-pair) 'solarized-dark)
             (string= (cdr interface-theme-switcher--current-pair) 'solarized-light))
         (progn
           (setq x-underline-at-descent-line t)))
        (t
         nil)))

(defun interface-theme-switcher--change-to (name)
  (interactive "SSwitch to: ")
  (dolist (target interface-theme-switcher--alist)
    (disable-theme (cdr target)))
  (let ((assoc (assoc name interface-theme-switcher--alist)))
    (setq interface-theme-switcher--current-pair assoc)
    (enable-theme (cdr assoc)))
  (interface-theme-switcher--customize))

(interface-theme-switcher--change-to 'dark)

;; Enable column numbering.
(line-number-mode 1)
(column-number-mode 1)

;; Mode line configuration.
(require 'mode-line)
(mode-line--set-format)
(mode-line--toggle-time-display)
(mode-line--toggle-battery-display)

;; Improve unique buffer name behavior.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward
      uniquify-separator ":")

(setq linum-format "\x2007%d\x2007")

(defun create-prog-mode-hook-linum-mode-enabler (&optional _)
  "Creates a prog-mode-hook that starts linum-mode"

  (progn
    (add-hook 'prog-mode-hook 'linum-mode)))

(add-hook 'window-setup-hook 'create-prog-mode-hook-linum-mode-enabler)
(add-to-list 'after-make-frame-functions #'create-prog-mode-hook-linum-mode-enabler)

(if (require 'whitespace nil 'no-error)
    (progn
      (setq whitespace-style '(face trailing lines-tail newline space-mark tab-mark newline-mark))
      (setq whitespace-display-mappings
            '((space-mark 32
                          [183]
                          [46])
              (space-mark 160
                          [164]
                          [95])
              (newline-mark 10
                            [172 10])
              (tab-mark 9
                        [8212 9]
                        [92 9])))

      (set-face-foreground 'whitespace-tab "#586e75")))

(if (require 'dired nil 'no-error)
    (progn
      (add-hook 'dired-mode-hook
                (lambda ()
                  (if (require 'whitespace nil 'no-error)
                      (setq-local whitespace-style (remove 'space-mark whitespace-style)))))))

;; Get rid of the fringes.
(fringe-mode '(0 . 0))

(defun set-font-size (&optional size)
  "Sets the font size to the given size"

  (interactive "nNew size: ")

  (set-face-attribute 'default nil :height (floor (* 10 size))))

;; Add configuration for fic-mode to allow the use of
;; fic-mode whenever in prog-mode
(if (require 'hl-todo nil 'no-error)
    (add-hook 'prog-mode-hook
              (lambda ()
                (hl-todo-mode t))))


;; When finding files, don't ask the user whether to follow a symbolic
;; link or not; just do it, and do it always.
(setq find-file-visit-truename t)

;; Some magit configuration variables.
(setq magit-push-always-verify nil)
(setq magit-last-seen-setup-instructions "1.4.0")

(require 'whitespace)

(global-prettify-symbols-mode +1)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
