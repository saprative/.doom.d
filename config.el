;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; ;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "c://Users/SaprativeJana/org/")

(setq org-directory (expand-file-name "org" (getenv "USERPROFILE")))

;; (setq org-directory (expand-file-name "org" (getenv "USERPROFILE")))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (setq org-directory "c://Users/SaprativeJana/org/")
;; (setq default-directory "c://Users/SaprativeJana/org/")

  ;; Define your org directory dynamically
  ;; (setq org-directory (expand-file-name "org/" (getenv "USERPROFILE")))
;; works on Windows
  ;; (setq org-directory (expand-file-name "org/" (getenv "HOME")))
;; works on Linux/macOS
;; Also set default directory so Dired, Org, and capture start here

(setq default-directory org-directory)

(after! org
  ;; Default notes file → inbox.org
  (setq org-default-notes-file (expand-file-name "inbox.org" org-directory))

  ;; Capture templates
  (setq org-capture-templates
        '(
          ;; 1. TODO goes under a headline
          ("t" "Todo" entry
           (file+headline (expand-file-name "inbox.org" org-directory) "Tasks")
           "* TODO %?\n  %U\n  %a")

          ;; 2. Note goes under a headline
          ("n" "Note" entry
           (file+headline (expand-file-name "inbox.org" org-directory) "Notes")
           "* %?\n  %U\n  %a")

          ;; 3. Journal goes into a date tree
          ("j" "Journal" entry
           (file+datetree (expand-file-name "journal.org" org-directory))
           "* %U %?\n")

          ;; 4. Quick scratch note → just goes at end of file
          ("s" "Scratch" entry
           (file (expand-file-name "scratch.org" org-directory))
           "* %U %?\n")
        )))

(defun my-dashboard-banner ()
  (let* ((banner '("|--------------------------------------------------|"
                   "|   ╔═╗┌─┐┌─┐┌─┐┬ ┬┌─┐  ╔╗╔┌─┐┌┬┐┌─┐┌┐ ┌─┐┌─┐┬┌─   |"
                   "|   ╚═╗├─┤├─┘├─┘└┬┘└─┐  ║║║│ │ │ ├┤ ├┴┐│ ││ │├┴┐   |"
                   "|   ╚═╝┴ ┴┴  ┴   ┴ └─┘  ╝╚╝└─┘ ┴ └─┘└─┘└─┘└─┘┴ ┴   |"
                   "|--------------------------------------------------|"
                   "                                                    "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 42)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'my-dashboard-banner)
