(defun hooks/global--disable-indent-tabs-mode ()
  "Sets `indent-tabs-mode' to nil."
  (indent--set-indent-tabs-mode nil))

(defun hooks/global--enable-indent-tabs-mode ()
  "Sets `indent-tabs-mode' to t."
  (indent--set-indent-tabs-mode t))

(defun hooks/global--delete-trailing-whitespace ()
  "Deletes trailing whitespace."
  (delete-trailing-whitespace))

(provide 'hooks/global)
