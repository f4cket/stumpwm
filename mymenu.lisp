(define-stumpwm-command "mymenu" ()
      (labels ((pick (options)
                 (let ((selection (stumpwm::select-from-menu (current-screen) options "")))
                   (cond
                     ((null selection)
                      (throw 'stumpwm::error "Abort."))
                     ((stringp (second selection))
                      (second selection))
                     (t
                      (pick (cdr selection)))))))
        (let ((choice (pick *app-menu*)))
          (run-shell-command choice))))
    
    (defparameter *app-menu* '(("INTERNET"
                              ;; sub menu
	    		        ("Firefox" "firefox")
				("irssi" "urxvt -e tmux attach")
		    	        ("Midori" "midori"))
			       ("FUN"
			        ;; sub menu
    			        ("Emacs" "emacs")
	    		        ("Emacs NW" "urxvt -e emacs -nw"))
		    	       ("WORK"
			        ;;submenu
			        ("LibreOffice" "libreoffice"))
			       ("GRAPHICS"
			        ;;submenu
			        ("GIMP" "gimp"))
			        ("XFburn" "xfburn")))
			   
(define-key *top-map* (kbd "M-m") (mymenu))

