(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))

(setq doom-font (font-spec :family "Fira Code" :size 18)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 18))
;; (setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'regular)
;;       doom-variable-pitch-font (font-spec :family "Fira Sans" :size 18))

(setq doom-theme 'catppuccin)

(setq display-line-numbers-type 'relative)

(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

(after! org

(setq org-directory "~/Documents/org/")
(setq org-agenda-files '("~/Documents/org/inbox.org"
                          "~/Documents/org/gtd.org"
                          "~/Documents/org/someday.org"))
(setq org-log-done 'time)
(setq org-log-into-drawer t)

;; TODO keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))

(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
        ("NEXT" :foreground "blue" :weight bold)
        ("DONE" :foreground "forest green" :weight bold)
        ("WAITING" :foreground "orange" :weight bold)
        ("HOLD" :foreground "magenta" :weight bold)
        ("CANCELLED" :foreground "forest green" :weight bold)))

;; Capture templates
(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/Documents/org/inbox.org" "Inbox")
         "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n" :empty-lines 1)
        ("n" "Note" entry (file+headline "~/Documents/org/inbox.org" "Inbox")
         "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%a" :empty-lines 1)))

;; Refile targets
(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)

;; Agenda settings
(setq org-agenda-todo-ignore-scheduled 'future)
(setq org-agenda-start-with-log-mode t)
)

;; org-super-agenda for grouped agenda views
(use-package! org-super-agenda
  :after org-agenda
  :config
  (org-super-agenda-mode))

;; Custom dashboard view: SPC o A then d
(after! org-agenda
  (setq org-agenda-custom-commands
        `(("d" "Dashboard"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '((:name "Overdue" :deadline past)
                           (:name "Due today" :deadline today)
                           (:name "Scheduled today" :scheduled today)
                           (:discard (:anything t))))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "Inbox" :file-path "inbox.org")
                            (:name "Next Actions" :todo "NEXT")
                            (:name "Waiting" :todo "WAITING")
                            (:name "On Hold" :todo "HOLD")
                            (:name "Projects" :file-path "gtd.org" :todo "TODO")
                            (:discard (:anything t))))))))
          ("r" "Review"
           ((alltodo "" ((org-agenda-overriding-header "Review")
                         (org-super-agenda-groups
                          '((:name "Inbox (unprocessed)" :file-path "inbox.org")
                            (:name "Stuck (no NEXT action)" :todo "TODO")
                            (:name "Waiting on others" :todo "WAITING")
                            (:name "Someday / Maybe" :file-path "someday.org")
                            (:name "On Hold" :todo "HOLD")
                            (:discard (:anything t))))))))
          ("n" "Next Actions"
           ((alltodo "" ((org-agenda-overriding-header "Next Actions")
                         (org-super-agenda-groups
                          '((:name "Next Actions" :todo "NEXT")
                            (:discard (:anything t)))))))))))



;; Remember to check the doc strings of those variables.
(setq denote-directory (expand-file-name "~/Documents/org/"))
(setq denote-known-keywords '("emacs" "philosophy" "politics" "economics"))
(setq denote-prompts '(title keywords))
(setq denote-excluded-directories-regexp nil)
(setq denote-excluded-keywords-regexp nil)

;; Pick dates, where relevant, with Org's advanced interface:
(setq denote-date-prompt-use-org-read-date t)


;; Read this manual for how to specify `denote-templates'.  We do not
;; include an example here to avoid potential confusion.


(setq denote-date-format nil) ; read doc string

;; By default, we do not show the context of links.  We just display
;; file names.  This provides a more informative view.
(setq denote-backlinks-show-context t)

;; Also see `denote-link-backlinks-display-buffer-action' which is a bit
;; advanced.

;; If you use Markdown or plain text files (Org renders links as buttons
;; right away)
(add-hook 'find-file-hook #'denote-fontify-links-mode)

;; We use different ways to specify a path for demo purposes.
;; (setq denote-dired-directories
;;       (list denote-directory
;;             (thread-last denote-directory (expand-file-name "attachments"))
;;             (expand-file-name "~/Documents/books")))

;; Generic (great if you rename files Denote-style in lots of places):
;; (add-hook 'dired-mode-hook #'denote-dired-mode)
;;
;; OR if only want it in `denote-dired-directories':
(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)


;; Automatically rename Denote buffers using the `denote-rename-buffer-format'.
(denote-rename-buffer-mode 1)

;; Denote DOES NOT define any key bindings.  This is for the user to
;; decide.  For example:
(let ((map global-map))
  (define-key map (kbd "C-c n n") #'denote)
  (define-key map (kbd "C-c n c") #'denote-region) ; "contents" mnemonic
  (define-key map (kbd "C-c n N") #'denote-type)
  (define-key map (kbd "C-c n d") #'denote-date)
  (define-key map (kbd "C-c n z") #'denote-signature) ; "zettelkasten" mnemonic
  (define-key map (kbd "C-c n s") #'denote-subdirectory)
  (define-key map (kbd "C-c n t") #'denote-template)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  (define-key map (kbd "C-c n i") #'denote-link) ; "insert" mnemonic
  (define-key map (kbd "C-c n I") #'denote-add-links)
  (define-key map (kbd "C-c n b") #'denote-backlinks)
  (define-key map (kbd "C-c n f f") #'denote-find-link)
  (define-key map (kbd "C-c n f b") #'denote-find-backlink)
  ;; Note that `denote-rename-file' can work from any context, not just
  ;; Dired bufffers.  That is why we bind it here to the `global-map'.
  (define-key map (kbd "C-c n r") #'denote-rename-file)
  (define-key map (kbd "C-c n R") #'denote-rename-file-using-front-matter))

;; Key bindings specifically for Dired.
(let ((map dired-mode-map))
  (define-key map (kbd "C-c C-d C-i") #'denote-link-dired-marked-notes)
  (define-key map (kbd "C-c C-d C-r") #'denote-dired-rename-files)
  (define-key map (kbd "C-c C-d C-k") #'denote-dired-rename-marked-files-with-keywords)
  (define-key map (kbd "C-c C-d C-R") #'denote-dired-rename-marked-files-using-front-matter))

(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))

;; Also check the commands `denote-link-after-creating',
;; `denote-link-or-create'.  You may want to bind them to keys as well.


;; If you want to have Denote commands available via a right click
;; context menu, use the following and then enable
;; `context-menu-mode'.
(add-hook 'context-menu-functions #'denote-context-menu)

;; Claude Code configuration
(use-package! claude-code
  :config
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))
