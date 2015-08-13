(require 'package)

;; Add Milkypostman's Emacs Lisp Package Archive to the list of
;; archives.
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq -dependency-list- '(smart-tabs-mode smex magit gitignore-mode web-mode solarized-theme frame-fns coffee-mode haskell-mode markdown-mode jazz-theme ample-theme smartparens))
(setq -recommendation-list- '(multi-term))

;; Installs the dependencies.
(defun -install-dependencies- (&optional all)
  "Installs the dependencies for this Emacs configuration.

If ALL is non-nil or a package in the dependency list is not
installed, the package gets installed."

  (interactive "*")

  (-install--package-list- -dependency-list- all))

(defun -update-packages- (&optional all)
  "Updates all packages currently installed on the system."

  (interactive "*")

  (progn
    (package-list-packages)
    (package-menu-mark-upgrades)
    (package-menu-execute (yes-or-no-p "Execute package update without querying? "))))

(defun -install--package-list- (package-list &optional all)
  "Installs a list of packages."

  (mapc (lambda (package)
          (progn
            (if (or all
                    (not (package-installed-p package)))
                (package-install package)))) package-list)

  t)

(defun -install-recommended-packages- (&optional all)
  "Installs the recommended packages for this Emacs configuration."

  (interactive "*")

  (-install--package-list- -recommendation-list- all))
