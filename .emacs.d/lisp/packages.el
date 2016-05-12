(require 'package)

;; Add Milkypostman's Emacs Lisp Package Archive to the list of
;; archives.
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq packages--dependency-list
      '(
        solarized-theme
        ))

(setq packages--recommendation-list
      '(
        nyan-mode
        rspec-mode
        yaml-mode
        multi-term
        smartparens
        ample-theme
        jazz-theme
        markdown-mode
        haskell-mode
        coffee-mode
        frame-fns
        solarized-theme
        web-mode
        gitignore-mode
        magit
        smex
        smart-tabs-mode
        tao-theme
        robe
        fic-mode
        ))

;; Installs the dependencies.
(defun packages-install-dependencies (&optional all)
  "Installs the dependencies for this Emacs configuration.

If ALL is non-nil or a package in the dependency list is not
installed, the package gets installed."

  (interactive "*")

  (packages--install-package-list packages--dependency-list all))

(defun packages-upgrade (&optional all)
  "Updates all packages currently installed on the system."

  (interactive "*")

  (progn
    (package-list-packages)
    (package-menu-mark-upgrades)
    (package-menu-execute (yes-or-no-p "Execute package update without querying? "))))

(defun packages--install-package-list (package-list &optional all)
  "Installs a list of packages."

  (package-refresh-contents)

  (mapc (lambda (package)
          (progn
            (if (or all
                    (not (package-installed-p package)))
                (package-install package)))) package-list)

  t)

(defun packages-install-recommendations (&optional all)
  "Installs the recommended packages for this Emacs configuration."

  (interactive "*")

  (packages--install-package-list packages--recommendation-list all))
