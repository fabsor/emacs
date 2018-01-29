;; Allow arrow navigation.
(setq prelude-guru nil)

(setq prelude-flyspell nil)

(setq ido-use-filename-at-point 'disabled)
;; Add some packages
(prelude-require-packages '(solarized-theme))
(prelude-require-packages '(dracula-theme))

(prelude-require-packages '(geben))
;; Set the font
;; You have to install the ubuntu mono font to use this.
;; (add-to-list 'default-frame-alist '(font . "Ubuntu Mono 16" ))
;; (set-face-attribute 'default t :font "Ubuntu Mono 16" )
;; (set-frame-font "Ubuntu Mono 16" nil t)

(load-theme 'dracula t)

;; No scroll bars
(custom-set-variables
 '(scroll-bar-mode nil))

(custom-set-variables '(coffee-tab-width 2))


;; Map some files to php mode.

(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.test$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.profile$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

(defun light ()
  "Light look"
  (interactive)
  (load-theme 'solarized-light t)
  )

(defun dark ()
  "Dark look"
  (interactive)
  (load-theme 'dracula t)
  )

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))


(defun find-jshintrc ()
  (expand-file-name ".jsxhintrc"
                    (locate-dominating-file
                     (or (buffer-file-name) default-directory) ".jsxhintrc")))

;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(json-jsonlist)))

(add-to-list 'load-path "/Users/fabsor/apps/tern/emacs/")
(add-to-list 'load-path ".")

(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-auto-quoting nil)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

(setq geben-path-mappings '(("/srv/projects/crm/web" "/var/www")))
(setq geben-dbgp-default-port 9001)

(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

;; Don't use smart parens'
; (turn-off-smartparens-mode)

;; Javascript indent level
(setq js-indent-level 2)

(custom-set-variables
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(js-switch-indent-offset 2)
 )
;; (setq python-lsp-pyls-path "/home/fabsor/.virtualenvs/mailhead/bin/pyls")


(setq split-height-threshold nil
      split-width-threshold nil)


(setq elfeed-feeds
      '("https://news.ycombinator.com/rss"
        "https://www.kntnt.com/feed/"))

(server-start)
