;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq org-hide-emphasis-markers t)
(setq org-src-tab-acts-natively t)

(setq org-roam-directory "~/Dropbox/org/roam/")
(add-hook 'after-init-hook 'org-roam-mode)
(setq org-roam-dailies-directory (concat org-roam-directory "daily/"))

;; (setq org-roam-dailies-capture-templates
;;       '(("d" "default" entry
;;          #'org-roam-capture--get-point
;;          "* %?"
;;          :file-name "daily/%<%Y-%m-%d>"
;;          :head "#+title: %<%Y-%m-%d>\n\n")))

;; Agenda configuration
(setq org-agenda-directory (concat org-directory "gtd/"))
(require 'find-lisp)
(setq org-deadline-warning-days 1)
(setq org-agenda-start-with-log-mode t)
;; (setq org-agenda-files
;;         (find-lisp-find-files org-agenda-directory "\.org$"))
;; '((concat org-directory "Birthdats.org")))
(setq org-agenda-files
      '("~/Dropbox/org/gtd/Birthdays.org"
        "~/Dropbox/org/gtd/Projects.org"
        "~/Dropbox/org/gtd/inbox.org"))

(setq org-agenda-ke)


;; setting first calendar day on Monday
(setq calendar-week-start-day 1)
;; Keybindings
(define-key global-map "\C-h" 'delete-backward-char)
; (define-key org-mode-map "\C-h" 'delete-backward-char)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(after! org-roam
        (map! :leader
            :prefix "r"
            :desc "org-roam-dailies-today" "t" #'org-roam-dailies-today
            :desc "org-roam-dailies-tomorrow" "m" #'org-roam-dailies-tomorrow
                :desc "org-roam-dailies-yesterday" "y" #'org-roam-dailies-yesterday))
(after! org
  (setq org-capture-templates
      `(("i" "inbox" entry (file ,(concat org-agenda-directory "inbox.org"))
         ,"* TODO %?")
        ("j" "Journal" entry (file+datetree  ,(concat org-agenda-directory "journal.org"))
         "* %?\nEntered on %U\n  %i\n")
        ("e" "email" entry (file+headline ,(concat org-agenda-directory "emails.org") "Emails")
         "* TODO [#A] Reply: %a :@home:@school:" :immediate-finish t)
        ("l" "link" entry (file ,(concat org-agenda-directory "inbox.org"))
         "* TODO %(org-cliplink-capture)" :immediate-finish t)
        ("c" "org-protocol-capture" entry (file ,(concat org-agenda-directory "inbox.org"))
         "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)
        )
))
;; (setq org-agenda-custom-commands `((" " "Agenda"
;;                                       ((agenda ""
;;                                                ((org-agenda-span 'day)
;;                                                 (org-deadline-warning-days 365)))
;;                                        ))))
;; org-capture templates
;; (after! org
;;         (add-to-list 'org-capture-templates
;;                 `(("i" "inbox" entry (file ,(concat org-agenda-directory "inbox.org"))
;;                         "* TODO %?")
;;                 ("j" "Journal" entry (file+datetree  ,(concat org-agenda-directory "journal.org"))
;;                 "* %?\nEntered on %U\n  %i\n")
;;         )))
;; (setq org-capture-templates
;; (after! org
;; (add-to-list 'org-capture-templates
;;       '(("i" "inbox" entry (file (concat org-agenda-directory "inbox.org"))
;;          ,"* TODO %?")
;;         ;; ("j" "Journal" entry (file+datetree  ,(concat org-agenda-directory "journal.org"))
;;         ;;  "* %?\nEntered on %U\n  %i\n")
;;         ;; ("o" "Org-Notes" entry (file+headline ,(concat org-directory "/projects/org-notes.org") "Notes")
;;         ;; "* %a: %?\nEntered on %U\n")
;;         ;; ("e" "email" entry (file+headline ,(concat org-agenda-directory "emails.org") "Emails")
;;         ;;  "* TODO [#A] Reply: %a :@home:@school:" :immediate-finish t)
;;         ;; ("l" "link" entry (file ,(concat org-agenda-directory "inbox.org"))
;;         ;;  "* TODO %(org-cliplink-capture)" :immediate-finish t)
;;         ;; ("c" "org-protocol-capture" entry (file ,(concat org-agenda-directory "inbox.org"))
;;         ;;  "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)
;;         )
;; ))
;; (setq org-image-actual-width nil)
;; (defun my-org-screenshot ()
;;   "Take a screenshot into a time stamped unique-named file in the
;; same directory as the org-buffer and insert a link to this file."
;;   (interactive)
;;   (setq filename
;;         (concat
;;          (make-temp-name
;;           (concat (buffer-file-name)
;;                   "_"
;;                   (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
;;   (call-process "screencapture" nil nil nil "-i" filename)
;;   (insert (concat "[[" filename "]]"))
;;   (org-display-inline-images))
(defvar ll/org/insert-screenshot/redisplay-images t
  "Redisplay images after inserting a screenshot with
`ll/org/insert-screenshot'?")

(defun ll/org/capture-screenshot (&optional arg)
  "Capture a screenshot and insert a link to it in the current
buffer. If `ll/org/insert-screenshot/redisplay-images' is non-nil,
redisplay images in the current buffer.

By default saves images to ./screenshots/screen_%Y%m%d_%H%M%S.png,
creating the screenshots directory if necessary.

With a prefix arg (C-u) prompt for a filename instead of using the default.

Depends upon `import` from ImageMagick."
  (interactive)
  (unless (or arg
              (file-directory-p "./screenshots"))
    (make-directory "screenshots"))
  (let* ((default-dest
           (format-time-string "./screenshots/screen_%Y%m%d_%H%M%S.png"))
         (dest (if arg
                   (helm-read-string "Save to: " default-dest)
                 default-dest)))
    ;; (start-process "import" nil "/usr/local/bin/import" dest)
    (call-process "screencapture" nil nil nil "-i" dest)
    ;; (read-char "Taking screenshot... Press any key when done.")
    (insert (format "#+ATTR_HTML: :width 350\n"))
    (org-insert-link t (concat "file:" dest) "")
    (when ll/org/insert-screenshot/redisplay-images
      (org-remove-inline-images)
      (org-display-inline-images))))

(defun ll/org/resize-image-at-point ()
  (interactive)
  (let ((percent (read-number "new pixels width? ")))
    (beginning-of-line)
    (insert (format "#+ATTR_HTML: :width %s\n" percent))
    (when ll/org/insert-screenshot/redisplay-images
      (org-remove-inline-images)
      (org-display-inline-images))))

(defvar ll/org/edit-image/redisplay-images t
  "Redisplay images after editing an image with `ll/org/edit-image'?")

(defun ll/org/edit-image ()
  "Edit the image linked at point. If
`ll/org/insert-screenshot/redisplay-images' is non-nil, redisplay
images in the current buffer."
  (interactive)
  (let ((img (ll/org/link-file-path-at-point)))
    (start-process "gimp" nil "/Applications/GIMP-2.10.app/Contents/MacOS/gimp" img)
    (read-char "Editing image... Press any key when done.")
    (when ll/org/edit-image/redisplay-images
      (org-remove-inline-images)
      (org-display-inline-images))))

(defun ll/org/link-file-path-at-point ()
  "Get the path of the file referred to by the link at point."
  (let* ((org-element (org-element-context))
         (is-subscript-p (equal (org-element-type org-element) 'subscript))
         (is-link-p (equal (org-element-type org-element) 'link))
         (is-file-p (equal (org-element-property :type org-element) "file")))
    (when is-subscript-p
      (user-error "Org thinks you're in a subscript. Move the point and try again."))
    (unless (and is-link-p is-file-p)
      (user-error "Not on file link"))
    (expand-file-name (org-element-property :path org-element))))

(defun get-newest-file-from-dir  (path)
      "Get latest file (including directory) in PATH."
      (car (directory-files path 'full nil #'file-newer-than-file-p)))

(defun ll/org/insert-screenshot ()
  "Moves image from ~/Pictures/Screenshoots folder to ./screenshots, inserting org-mode link"
  (interactive)
  (let* ((indir (expand-file-name "/Users/arturo/Pictures/Screenshots"))
         (infile (get-newest-file-from-dir indir))
         (outdir (concat (file-name-directory (buffer-file-name)) "/screenshots"))
         (outfile (expand-file-name (file-name-nondirectory infile) outdir)))
    (unless (file-directory-p outdir)
      (make-directory outdir t))
    (rename-file infile outfile)
    (insert (concat (concat "[[./screenshots/" (file-name-nondirectory outfile)) "]]")))
    (when ll/org/edit-image/redisplay-images
      (org-remove-inline-images)
      (org-display-inline-images))
)

(map! :leader
      :desc "org-insert-screenshot"
      "a p" #'ll/org/insert-screenshot)
(map! :leader
      :desc "org-resize-image"
      "a r" #'ll/org/resize-image-at-point)
(map! :leader
      :desc "org-roam-buffer-toggle-display"
      "n r t" #'org-roam-buffer-toggle-display)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
