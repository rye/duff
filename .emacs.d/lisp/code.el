;; Use a tab size of 2
(setq global-tab-width 2)
(setq-default tab-width global-tab-width)
(setq-default smie-indent-basic global-tab-width)

(setq-default indent-tabs-mode nil)
(setq-default backward-delete-char-untabify-method nil)

(if (require 'smart-tabs-mode nil 'no-error)
    (progn
      (smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python 'nxml)

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

            (add-hook 'sh-mode-hook
                      (lambda () (setq indent-tabs-mode t)))))

      (if (require 'java-mode nil 'no-error)
          (progn
            (add-hook 'java-mode-hook
                      (lambda () (setq indent-tabs-mode t)))))

      (if (require 'ruby-mode nil 'no-error)
          (progn
            (setq-default ruby-indent-level 2)
            ;; (smart-tabs-advice ruby-indent-line ruby-indent-level)

            (setq ruby-indent-tabs-mode nil)
            (setq ruby-use-smie nil)

            (add-hook 'ruby-mode-hook 'robe-mode)
            (add-hook 'ruby-mode-hook 'auto-complete-mode)
            (add-hook 'ruby-mode-hook
                      (lambda ()
                        (setq-local indent-line-function 'ruby-indent-line)))

            (add-hook 'ruby-mode-hook
                      (lambda ()
                        (setq prettify-symbols-alist '())
                        (push '(">=" . ?≥) prettify-symbols-alist)
                        (push '("<=" . ?≤) prettify-symbols-alist)
                        (push '("<<" . ?«) prettify-symbols-alist)
                        (push '("=>" . ?⇒) prettify-symbols-alist)))))

      (if (require 'elisp-mode nil 'no-error)
          (progn
            (add-hook 'emacs-lisp-mode-hook
                      (lambda ()
                        (setq indent-tabs-mode nil)

                        (add-hook 'emacs-lisp-mode-hook
                                  (lambda ()
                                    (push '(">=" . ?≥) prettify-symbols-alist)
                                    (push '("<=" . ?≤) prettify-symbols-alist)))

                        (if (require 'whitespace nil 'no-error)
                            (setq-local whitespace-style (remove 'space-mark whitespace-style)))))

            (font-lock-add-keywords 'emacs-lisp-mode
                                    '(("setq" . font-lock-builtin-face)
                                      ("setq-default" . font-lock-builtin-face)
                                      ("load-theme" . font-lock-builtin-face)
                                      ("add-hook" . font-lock-builtin-face)
                                      ("add-to-list" . font-lock-builtin-face)))))

      (if (require 'lisp-mode nil 'no-error)
          (progn
            (add-hook 'lisp-mode-hook
                      (lambda ()
                        (setq indent-tabs-mode nil)
                        (if (require 'whitespace nil 'no-error)
                            (setq-local whitespace-style (remove 'space-mark whitespace-style)))))

            (font-lock-add-keywords 'emacs-lisp-mode
                                    '(("setq" . font-lock-builtin-face)
                                      ("setq-default" . font-lock-builtin-face)
                                      ("load-theme" . font-lock-builtin-face)
                                      ("add-hook" . font-lock-builtin-face)
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

            (add-hook 'web-mode-hook
                      (lambda () (setq indent-tabs-mode t)))))))

(if (require 'hl-line nil 'no-error)
    (progn
      (add-hook 'prog-mode-hook
                (lambda ()
                  (hl-line-mode t)))))

(if (require 'doc-view nil 'no-error)
    (progn
      (add-hook 'doc-view-mode-hook 'auto-revert-mode)))

(if (require 'robe nil 'no-error)
    (progn
      (add-hook 'robe-mode-hook 'ac-robe-setup)))

;; Delete annoying trailing whitespace.
(add-hook 'before-save-hook
          '(lambda ()
             (delete-trailing-whitespace)))

;; Require final newline
(setq-default require-final-newline t)

;; Set the default maximum Git commit summary length.
(setq git-commit-summary-max-length 50)
