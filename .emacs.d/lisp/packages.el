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
        ;; Handy tools
        magit
        smex
        smartparens
        editorconfig
        robe
        multi-term

        ;; Themes (solarized is primary, but we have some other options)
        solarized-theme
        tao-theme
        ample-theme
        jazz-theme

        ;; RSpec mode
        rspec-mode

        ;; Configuration file modes
        yaml-mode
        nginx-mode
        gitignore-mode
        dockerfile-mode

        ;; Text file modes
        markdown-mode

        ;; Special/Enhanced language modes
        web-mode
        coffee-mode
        haskell-mode

        ;; Smart Tabs
        smart-tabs-mode

        ;; Highlighted Delimiters
        rainbow-delimiters

        ;; Highlight words like TODO, FIXME, HACK, KLUDGE, HOLD, ???
        hl-todo

        ;; Docker interaction
        docker
        docker-api
        docker-tramp

        ;; Code completion
        auto-complete
        auto-complete-nxml
        auto-complete-c-headers
        auto-complete-exuberant-ctags
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
