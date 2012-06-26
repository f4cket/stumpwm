(defcommand scrot () ()                                                                                                                               
   (run-shell-command "scrot"))  
(notifications-add "StumpWM: scrot, cheese!")
 (defcommand scrotnot () ()                                                                                                                            
						            (run-commands "notifications-show" "scrot"))
(define-key *top-map* (kbd "M-S") "scrotnot")
(define-key *top-map* (kbd "M-Home") "exec setxkbmap se")
(define-key *top-map* (kbd "M-End") "exec setxkbmap dvorak se")


;; Färger o så 
(set-focus-color "SteelBlue")
(set-unfocus-color "gray5")  
(set-fg-color "ForestGreen")

