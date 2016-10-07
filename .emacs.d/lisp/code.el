;; Use a tab size of 2
(setq global-tab-width 2)
(setq-default tab-width global-tab-width)
(setq-default smie-indent-basic global-tab-width)

(setq-default indent-tabs-mode nil)
(setq-default backward-delete-char-untabify-method nil)

(require 'indent)
(require 'hooks)

(if (require 'smart-tabs-mode nil 'no-error)
    (progn
      (smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'ruby 'python 'nxml)

      (if (require 'coffee-mode nil 'no-error)
          (progn
            (setq coffee-indent-tabs-mode t)
            (smart-tabs-add-language-support coffee coffee-mode-hook
              ((coffee-indent-line . global-tab-width)
               (coffee-indent-region . global-tab-width)))

            (smart-tabs-insinuate 'coffee)))

      (if (require 'sh-script nil 'no-error)
          (progn
            (setq-default sh-basic-offset 2)
            (setq-default sh-indentation 2)
            (setq-default sh-indent-for-case-label 0)
            (setq-default sh-indent-for-case-alt '+)

            (smart-tabs-add-language-support sh-script sh-mode-hook
              ((sh-indent-line . sh-basic-offset)))

            (smart-tabs-insinuate 'sh-script)

            (add-hook 'sh-mode-hook 'hooks/global--enable-indent-tabs-mode)))

      (if (require 'java-mode nil 'no-error)
          (progn
            (add-hook 'java-mode-hook 'hooks/global--enable-indent-tabs-mode)))

      (if (require 'nginx-mode nil 'no-error)
          (progn
            (setq-default nginx-indent-level 2)
            (smart-tabs-advice nginx-indent-line nginx-indent-level)

            (setq nginx-indent-tabs-mode t)

            (add-hook 'nginx-mode-hook 'hooks/nginx--set-indent-line-function)))

      (if (require 'ruby-mode nil 'no-error)
          (progn
            (setq-default ruby-indent-level 2)
            (smart-tabs-advice ruby-indent-line ruby-indent-level)

            (setq ruby-indent-tabs-mode t)
            (setq ruby-use-smie nil)

            (add-to-list 'auto-mode-alist '("\\.god\\'" . ruby-mode))

            (add-hook 'ruby-mode-hook 'robe-mode)
            (add-hook 'ruby-mode-hook 'auto-complete-mode)
            (add-hook 'ruby-mode-hook 'hooks/ruby--set-indent-line-function)
            (add-hook 'ruby-mode-hook 'hooks/ruby--add-prettify-symbols)))

      (if (require 'elisp-mode nil 'no-error)
          (progn
            (add-hook 'emacs-lisp-mode-hook
                      'hooks/global--disable-indent-tabs-mode)
            (add-hook 'emacs-lisp-mode-hook
                      'hooks/elisp--add-prettify-symbols)
            (add-hook 'emacs-lisp-mode-hook
                      'hooks/lisp--remove-space-from-whitespace-style)

            (font-lock-add-keywords 'emacs-lisp-mode
                                    '(("setq" . font-lock-builtin-face)
                                      ("setq-default" . font-lock-builtin-face)
                                      ("load-theme" . font-lock-builtin-face)
                                      ("add-hook" . font-lock-builtin-face)
                                      ("add-to-list" . font-lock-builtin-face)))))

      (if (require 'lisp-mode nil 'no-error)
          (progn
            (add-hook 'lisp-mode-hook
                      'hooks/global--disable-indent-tabs-mode)
            (add-hook 'lisp-mode-hook
                      'hooks/lisp--remove-space-from-whitespace-style)

            (font-lock-add-keywords 'lisp-mode
                                    '(("setq" . font-lock-builtin-face)
                                      ("setq-default" . font-lock-builtin-face)
                                      ("load-theme" . font-lock-builtin-face)
                                      ("add-to-list" . font-lock-builtin-face)))))

      ;; (if (require 'python-mode nil 'no-error)
      ;;     (progn
      ;;       (add-hook 'python-mode-hook
      ;;                 (lambda ()
      ;;                   (setq python-smart-indentation nil)
      ;;                   (setq python-indent-offset tab-width)
      ;;                   (setq indent-tabs-mode t)))))

      (if (require 'web-mode nil 'no-error)
          (progn
            (add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.sass\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.jsonp?\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

            ;; Don't indent Meta-HTML control blocks, and don't
            ;; apply any padding to <script> tags in HTML.
            (setq web-mode-enable-control-block-indentation nil)
            (setq web-mode-script-padding 0)

            (setq web-mode-markup-indent-offset global-tab-width)
            (setq web-mode-css-indent-offset global-tab-width)
            (setq web-mode-code-indent-offset global-tab-width)

            (add-hook 'web-mode-hook 'hooks/global--enable-indent-tabs-mode)))))

(if (require 'hl-line nil 'no-error)
    (progn
      (add-hook 'prog-mode-hook 'hooks/hl-line--enable)))

(if (require 'doc-view nil 'no-error)
    (progn
      (add-hook 'doc-view-mode-hook 'auto-revert-mode)))

(if (require 'robe nil 'no-error)
    (progn
      (add-hook 'robe-mode-hook 'ac-robe-setup)))

(if (require 'editorconfig nil 'no-error)
    (progn
      (editorconfig-mode 1)

      (add-hook 'editorconfig-custom-hooks
                (lambda (hash)
                  (hooks/editorconfig--set-language-specific-indent-tabs-mode hash)))
      (add-hook 'editorconfig-custom-hooks
                (lambda (hash)
                  (hooks/editorconfig--unify-indent-tabs-mode-and-smart-tabs-mode hash)))

      (add-to-list 'editorconfig-indentation-alist
                   '(ruby-mode ruby-indent-level))))

;; Delete annoying trailing whitespace.
(add-hook 'before-save-hook 'hooks/global--delete-trailing-whitespace)

;; Require final newline
(setq-default require-final-newline t)

;; Set the default maximum Git commit summary length.
(setq git-commit-summary-max-length 50)
