(package-initialize)

;; Get rid of annoying stuff immediately.
(menu-bar-mode -1)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'set-horizontal-scroll-bar-mode) (set-horizontal-scrollbar-mode nil))

(setq inhibit-startup-message t
      initial-scratch-message ";; This is a scratch buffer.
;;
;; Use it for work, for play, or don't use it.  It's pretty lonely,
;; being a scratch buffer.

"
      echo-keystrokes 0.1
      vc-follow-symlinks t
      ring-bell-function 'ignore)

;; Add some directories to the load-path.
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/etc/")
(add-to-list 'load-path "~/Emacs Lisp/")
(add-to-list 'load-path "~/elisp/")
(add-to-list 'load-path "~/.emacs-local/")

;; Shorthand for loading files using symbols.
(defun l (file-or-symbol &optional noerror nomessage nosuffix must-suffix)
  "If `file-or-symbol' is a symbol, calls (load (symbol-name `file-or-symbol')).
Otherwise, simply calls (load `file-or-symbol').

In either case, passes remaining arguments to load."
  (if (symbolp file-or-symbol)
      (load (symbol-name file-or-symbol) noerror nomessage nosuffix must-suffix)
    (load file-or-symbol noerror nomessage nosuffix must-suffix)))

;; Set up our custom file, so we don't have to deal with stupid customize.
(setq custom-file "~/.custom.el")
(l custom-file 'noerror 'nomessage)

;; Load the internals of the configuration.
(l 'configuration-internals)
(l 'packages)
(l 'interface)
(l 'keybinds)
(l 'window-management)
(l 'autosave)
(l 'completion)
(l 'code)
(l 'duff-local 'noerror 'nomessage)

;; Load the LilyPond Emacs mode.
(l 'lilypond-init t)
