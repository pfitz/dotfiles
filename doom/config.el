(setq doom-font (font-spec :family "Fira Code" :size 18)
     doom-variable-pitch-font (font-spec :family "Fira Sans" :size 18))
;; (setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'regular)
;;       doom-variable-pitch-font (font-spec :family "Fira Sans" :size 18))

(setq doom-theme 'catppuccin)

(setq display-line-numbers-type 'relative)

(after! org

(setq org-directory "~/Documents/org/")
(setq org-agenda-files (quote ("~/Documents/org" "~/Documents/org/daily")))

;; config for my todo system
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Documents/org/"))
  (org-roam-capture-templates
   '(
     ("d" "default" plain
      (file "~/Documents/org/templates/default.org")
        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date:%U")
      :unnarrowed t)
     ("M" "monthly" plain
      (file "~/Documents/org/templates/monthly.org")
        :if-new (file+head "%<%Y%m%d%H%M%S>-%<%Y-%m>-monthly.org" "")
      :unnarrowed t)
     ("D" "Scrum daily" plain
      (file "~/Documents/org/templates/daily.org")
      :if-new (file+head "./scrum/%<%Y>/%<%Y%m%d%H%M%S>-daily.org" "")
      :unnarrowed t)
     ("r" "scrum refinement" plain
      (file "~/Documents/org/templates/refinement.org")
      :if-new (file+head "./scrum/%<%Y>/%<%Y%m%d%H%M%S>-refinement.org" "")
      :unnarrowed t)
     ("R" "Scrum retro" plain
      (file "~/Documents/org/templates/retro.org")
      :if-new (file+head "./scrum/%<%Y>/%<%Y%m%d%H%M%S>-retro.org" "#+title: ${title}\n#+date:%U")
      :unnarrowed t)
     ("m" "meeting" plain
      (file "~/Documents/org/templates/meeting.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-meeting-${slug}.org" "")
      :unnarrowed t)
     ("p" "phone call" plain
      (file "~/Documents/org/templates/phone_call.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-phone-${slug}.org" "#+title: ${title}\n#+date:%U")
      :unnarrowed t)
     ("P" "Project" plain
      (file "~/Documents/org/templates/project.org")
      :if-new (file+head "./projects/%<%Y%m%d%H%M%S>${slug}.org" "#+title: ${title}\n#+date:%U")
      :unnarrowed t)
     ("c" "Collection" plain
      (file "~/Documents/org/templates/collection.org")
      :if-new (file+head "./collection/%<%Y%m%d%H%M%S>${slug}.org" "#+title: ${title}\n#+date:%U")
      :unnarrowed t)
     ))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  )
)

(defvar-local my/flycheck-local-cache nil)
(defun my/flycheck-checker-get (fn checker property)
  (or (alist-get property (alist-get checker my/flycheck-local-cache))
      (funcall fn checker property)))
(advice-add 'flycheck-checker-get :around 'my/flycheck-checker-get)
(add-hook 'lsp-managed-mode-hook
          (lambda ()
            (when (derived-mode-p 'elixir-mode)
              (setq my/flycheck-local-cache '((lsp . ((next-checkers . (elixir-credo)))))))
            ))

(setq lsp-elixir-fetch-deps nil)
(setq lsp-elixir-suggest-specs t)
(setq lsp-elixir-signature-after-complete t)
(setq lsp-elixir-enable-test-lenses t)

(set-popup-rule! "^\\*Alchemist-IEx" :quit nil :size 0.3)

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(setq evil-snipe-scope 'buffer)

(setq-default gac-automatically-push-p t)
(setq-default gac-automatically-add-new-files-p t)
(setq-default gac-debounce-interval 300)
