(defun hooks/nginx--set-indent-line-function ()
  "Sets `indent-line-function' to `nginx-indent-line' locally."
  (if (eq major-mode 'nginx-mode)
      (setq-local indent-line-function 'nginx-indent-line)))

(provide 'hooks/nginx)
