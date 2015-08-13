(deftheme eturna "A modern, sensible theme.")

(require 'color)

(defun rgbl-to-rgbs (rgbl-list)
  (let ((r (nth 0 rgbl-list))
        (g (nth 1 rgbl-list))
        (b (nth 2 rgbl-list)))
    (format "#%02x%02x%02x" (* 255 r) (* 255 g) (* 255 b))))

(defun mix-hsl (h s l)
  (rgbl-to-rgbs (color-hsl-to-rgb (/ h 360.0) s l)))

(let ((region (mix-hsl 240 0.4 0.3)))
  (let ((background (mix-hsl 0 0 0.1))
        (background-hl (mix-hsl 0 0 0.15))
        (foreground (mix-hsl 0 0 0.9))
        (line-number (mix-hsl 0 0 0.6))
        (comment (mix-hsl 0 0 0.5))
        (string (mix-hsl 40 0.7 0.7))
        (function (mix-hsl 240 0.7 0.8))
        (variable (mix-hsl 120 0.6 0.8))
        (type (mix-hsl 30 0.7 0.6))
        (keyword (mix-hsl 200 0.9 0.8))
        (prompt (mix-hsl 240 0.9 0.8))
        (partial-success (mix-hsl 120 0.9 0.8))
        (mode-line-background (mix-hsl 0 0 0.8))
        (mode-line-foreground (mix-hsl 0 0 0.2))
        (success (mix-hsl 120 0.9 0.5))
        (html-tag (mix-hsl 220 0.7 0.7))
        (html-attr-name (mix-hsl 220 0.7 0.7))
        (html-attr-value (mix-hsl 60 0.7 0.7))
        )

    (custom-theme-set-faces
     `eturna
     `(default ((t (:foreground ,foreground :background ,background))))
     `(cursor ((t (:foreground ,background :background ,foreground))))
     `(region ((t (:foreground ,foreground :background ,region))))
     `(linum ((t (:foreground ,line-number :background ,background :italic nil :bold t :underline nil))))

     ;; Customizations for the colors on the editor.
     ;;
     ;; These customizations are, if correctly used, global to all languages with these
     ;; primitives.
     `(font-lock-string-face ((t (:foreground ,string :bold t))))
     `(font-lock-comment-face ((t (:foreground ,comment :italic t))))
     `(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :italic nil))))
     `(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
     `(font-lock-variable-name-face ((t (:inherit default :foreground ,variable))))
     `(font-lock-type-face ((t (:inherit default :foreground ,type :bold t))))
     `(font-lock-function-name-face ((t (:inherit default :foreground ,function))))
     `(font-lock-keyword-face ((t (:inherit default :foreground ,keyword :bold t))))
     `(font-lock-builtin-face ((t (:inherit font-lock-keyword-face))))

     ;; Change the line highlighting face, use instead the
     ;; background-hl color for the background.
     `(hl-line ((t (:background ,background-hl))))

     ;; Certain customizations for the ido and other minibuffer faces.
     ;;
     ;; Subdirectories are emboldened when displayed in the completion list.
     ;;
     ;; When there are multiple matches for the current pattern, a pale green
     ;; is used as the foreground color (,partial-success variable). When there
     ;; exists solely one match, a more bold green (,success variable) is used.
     `(ido-subdir ((t (:inherit default :bold t))))
     `(ido-first-match ((t (:inherit default :bold t :foreground ,partial-success))))
     `(ido-only-match ((t (:inherit default :bold t :foreground ,success))))
     `(minibuffer-prompt ((t (:foreground ,prompt :background nil :bold t))))

     ;; Set up the mode-line.
     ;;
     ;; For now, inactive mode-line just swaps the foreground and background
     ;; colors. Thus, the foreground and background colors are slightly closer
     ;; to the mean of the regular foreground and background colors. Also, the
     ;; colors are inverted from their regular counterparts; the mode-line has
     ;; a light background when active and a dark one when inactive.
     `(mode-line
       ((t
         (:foreground ,mode-line-foreground
          :background ,mode-line-background
          :box (:line-width 4
                :color ,mode-line-background)))))
     `(mode-line-inactive
       ((t
         (:foreground ,mode-line-background
          :background ,mode-line-foreground
          :box (:line-width 4
                :color ,mode-line-foreground)))))

     ;; I'm not entirely sure why dired only has a face
     ;; for the write permissions, so for now I have
     ;; just set it up so that all of the perms look
     ;; identical.
     `(dired-perm-write ((t (:inherit default))))

     `(web-mode-html-tag-face ((t (:foreground ,html-tag :bold t))))
     `(web-mode-html-attr-name-face ((t (:foreground ,html-attr-name :italic t))))
     `(web-mode-html-attr-equal-face ((t (:inherit default))))
     `(web-mode-html-attr-value-face ((t (:foreground ,html-attr-value :italic t))))

     `(web-mode-string-face ((t (:inherit font-lock-string-face))))
     `(web-mode-variable-name-face ((t (:inherit font-lock-variable-name-face))))
     `(web-mode-type-face ((t (:inherit font-lock-type-face))))
     `(web-mode-function-name-face ((t (:inherit font-lock-function-name-face))))
     `(web-mode-keyword-face ((t (:inherit font-lock-keyword-face))))
     `(web-mode-builtin-face ((t (:inherit font-lock-builtin-face))))
     )))

(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(defun eturna-theme ()
  "Apply the eterna-theme."
  (interactive)
  (load-theme 'eturna t))

(provide-theme 'eturna)
