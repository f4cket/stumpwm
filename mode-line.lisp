(in-package :stumpwm)

(load-module "cpu")
(load-module "disk")
;; (load-module "mpd")
(load-module "mem")
(load-module "maildir")
(load-module "net")
;; (load-module "battery-portable")
;;(load-module "notifications")
(load "/home/simon/stumpwm/gmail.lisp")
(load-module "wifi")
(dolist (i '("ml-wifi.sh" "ml-weather.sh"
	     ;; "ml-email.sh"
             ;; "ml-volume.sh" "ml-dropbox.sh" "ml-sensors.sh"
             ;; "ml-clock.sh"
             "ml-trash.sh" "ml-quotes.sh" ))
  (run-shell-command i))

(defun read-ml-file (s)
  (read-file (str "/dev/shm/" s)))

(defun color-ping (s)
  (if (equal s "")
      ""
      (let* ((words (cl-ppcre:split "\\s+" s))
             (ping (nth 5 words))
             (color (bar-zone-color (read-from-string ping)
                                    300 700 1000))
             (colored-ping (format nil "^[~A~3D^]" color ping)))
        (cl-ppcre:regex-replace ping s colored-ping))))

;; Solarized theme vs defektz theme = Love 
(defun colour (key)
  (let ((colours '(:base03 #x002b36
                   :base02 #x073642
                   :base01 #x586e75
                   :base00 #x657b83
                   :base0 #x839496
                   :base1 #x93a1a1
                   :base2 #xeee8d5
                   :base3 #xfdf6e3
                   :yellow #x99ad6a
                   :orange #xcb4b16
                   :red #xdc322f
                   :magenta #xd33682
                   :violet #x6c71c4
                   :blue #x268bd2
                   :cyan #x87ceeb
		   :dfx #x14db49
		   :pnevma #x000000
                   :green #x8ae234)))
    (getf colours key)))

;; Update colors
(setf *bright-colors* nil
      *colors* (mapcar #'colour '(:base02 :red :green :yellow :blue :magenta
:cyan :base2 :base03 :orange))
			*mode-line-background-color* (colour :pnevma)
      *mode-line-foreground-color* (colour :violet)
      *mode-line-border-color* (colour :pnevma))
(mapcar #'update-color-map *screen-list*)

(set-focus-color (colour :base02))
(set-unfocus-color (colour :base03))
(set-border-color (colour :base03))
(set-bg-color (colour :pnevma))
(set-fg-color (colour :base02))

(setf *time-modeline-string* "%a %m-%d ^5*^B%l:%M^b^n")

(setq stumpwm:*mode-line-position* :top)
(setf stumpwm:*screen-mode-line-format*
      (list
       "^B[^b%n^B]^b "
	"^4*^B%W^b^n "
       ;;'(:eval (string-right-trim '(#\Newline) (run-shell-command
	;;"date +'%m-%d ^5*^B%R^b^n %p'" t)))
      ;; "[^B%n^b] " ; group num
      ;; '(:eval (color-ping (read-ml-file ".ml-wifi")))
       ;; "%B" ; battery
      ;; "[%h] "
;;	"[^B%g^b] " ;groups
       ;; "^B%w^b" ; window list
       ;; voicemail, sms, email
       ;; "^4*^B%D^b^n"
;;	'(:eval (read-ml-file ".ml-email"))
       ;; quotes
;;       '(:eval (read-ml-file ".ml-quotes"))
       ;; notifications
;;       "%Z "
       ;; FIXME add weather forecast
       ;; TODO add google reader unread
       ;; TODO add linphone status/incoming calls
       ;; TODO add irc alert
       ;; TOOD add current todo (from emacs/org, clocked in item)
       ;; " DRP: " '(:eval (read-ml-file ".ml-dropbox"))
       "^>" ; right align
			 '(:eval (format-gmail nil))
			 " ^4[^6*^B%g^b^4]^n < "
       ;; pomodoro
       "^B««^b"
       " %h "
       "^B««^b "
       ;;"^B[^b"
       ;;"%m"
       ;;"^B]^b "
       ;;'(:eval (read-ml-file ".ml-pomodoro-msg")) " "
       ;;'(:eval (read-ml-file ".ml-pomodoro-time")) " "
       ;;'(:eval (read-ml-file ".ml-weather")) "F " ;; "°F "
       ;; ;; volume
       ;; '(:eval (read-file ".mode-line-volume")) " "
       "^B «« ^b"
       "^4*^BÆ^b^n %c" ; cpu
       ;;"^B « ^b "
       ;; '(:eval (read-ml-file ".ml-sensors")) " "
       ;; "%N "   ; mem
       "^B «« ^b"
       "%l" ; net
       "^B «« ^b "
       "^4*^Bµ^b^n "
       "^B «« ^b"
       "%D" ; disk
       "^B «« ^b "
       ;; "Trash: " '(:eval (read-ml-file ".ml-trash")) " "
       ;; "^> %M %c" ;; I like %c but not working last time I tries it's cpu.lisp
       ;; "%d"  ;; crappy default date
       ;; "%d"
       '(:eval (string-right-trim '(#\Newline) (run-shell-command
       ;;                                          ;; "date +'%a %m-%d ^6*^B%l:%M^b^n %p'|tr -d '\\n'"
       ;;                                          ;; uses date command so time can be bold
                 "date +'^B%m-%d ^4*«« ^6*%R ^4*««^n^b'" t)))
       ))

(defcommand uaml () ()
  ""
  (update-all-mode-lines))

(dolist (head
          (list (first (screen-heads (current-screen)))) ; first
         ;; (screen-heads (current-screen)) ; all
         )
  (enable-mode-line (current-screen) head 
							t *screen-mode-line-format*))
