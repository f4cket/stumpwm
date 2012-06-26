    (defvar *my-emms-bindings*
      '(("n" "emms-next")
        ("p" "emms-previous")
        ("s" "emms-stop")
        ("P" "emms-pause")))
    (stumpwm:define-key stumpwm:*root-map* (stumpwm:kbd "m")
      (let ((m (stumpwm:make-sparse-keymap)))
        (map nil #'(lambda (x)
                     (stumpwm:define-key m (stumpwm:kbd (car x))
                       (concat "exec emacsclient -e '(" (cadr x) ")'")))
             *my-emms-bindings*)
        m))
    
