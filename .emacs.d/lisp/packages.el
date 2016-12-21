(require 'package)

;; Add Milkypostman's Emacs Lisp Package Archive to the list of
;; archives.
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq packages--dependency-list
      '(
        solarized-theme
        tao-theme
        frame-fns
        ))

(setq packages--recommendation-list
      '(
        ;; make Emacs great again
        magit
        smex
        smartparens
        editorconfig
        robe

        ;; themes
        solarized-theme
        tao-theme
        ample-theme
        jazz-theme

        ;; editing modes for various files
        rspec-mode
        yaml-mode
        multi-term
        markdown-mode
        haskell-mode
        coffee-mode
        web-mode
        gitignore-mode
        smart-tabs-mode

        ;; bullshit
        nyan-mode

        ;; highlighted delimiters to make editing a bit easier
        rainbow-delimiters

        ;; for displaying TODO, FIXIT, etc. keywords
        fic-mode

        ;; for editing Docker-related files
        docker
        docker-api
        docker-tramp
        dockerfile-mode
        ))

;; Initialize the package repositories
(package-initialize)

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
