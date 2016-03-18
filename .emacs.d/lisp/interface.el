;; Enable custom themes that haven't been properly signed.
(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(defvar interface-theme-switcher--current-pair '())
(defvar interface-theme-switcher--alist '())

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

;; Customize the mode-line.
(setq-default mode-line-format
              '("%e"
                "<%*%+>"
                "%@"
                mode-line-frame-identification
                (#("%16b" 0 4 (local-map mode-line-highlight face mode-line-buffer-id)))
                " "
                (#("%[" 0 2 ()) "<" (:propertize ("" mode-name)) ("" mode-line-process) (:propertize ("" minor-mode-alist)) #("%n" 0 2 ()) ">" #("%]" 0 2 ()))
                " "
                "<%l,%c>"
                (vc-mode vc-mode)))

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


;; Get rid of the fringes.
(fringe-mode '(0 . 0))

(defun set-font-size (&optional size)
  "Sets the font size to the given size"

  (interactive "nNew size: ")

  (set-face-attribute 'default nil :height (floor (* 10 size))))

;; When finding files, don't ask the user whether to follow a symbolic
;; link or not; just do it, and do it always.
(setq find-file-visit-truename t)

;; Some magit configuration variables.
(setq magit-push-always-verify nil)
(setq magit-last-seen-setup-instructions "1.4.0")

(require 'whitespace)
