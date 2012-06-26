(load "/usr/share/emacs/site-lisp/slime/swank-loader.lisp")
(swank-loader:init)
(defcommand swank () ()
  (setf stumpwm:*top-level-error-action* :break)
  (swank:create-server :port 4005
                       :style swank:*communication-style*
                       :dont-close t)
  (echo-string (current-screen)
               "Starting swank. M-x slime-connect RET RET, then (in-package stumpwm)."))
;;(swank)

