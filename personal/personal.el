;; Allow arrow navigation.
(setq prelude-guru nil)

(setq prelude-flyspell nil)

(setq ido-use-filename-at-point 'disabled)

;; Add some packages
(prelude-require-packages '(solarized-theme))
(prelude-require-packages '(dracula-theme))
(prelude-require-packages '(material-theme))
(prelude-require-packages '(geben))
(prelude-require-packages '(tide))
(prelude-require-packages '(typescript-mode))
(prelude-require-packages '(web-narrow-mode))

;; Set the font
;; You have to install the ubuntu mono font to use this.
;; (add-to-list 'default-frame-alist '(font . "Ubuntu Mono 16" ))
;; (set-face-attribute 'default t :font "Ubuntu Mono 16" )
;; (set-frame-font "Ubuntu Mono 16" nil t)

(load-theme 'dracula t)

(setq max-specpdl-size 100000
      max-lisp-eval-depth 20000)

;; No scroll bars
(custom-set-variables
 '(scroll-bar-mode nil))

(custom-set-variables '(coffee-tab-width 2))

(custom-set-variables '(typescript-indent-level 2))

(custom-set-faces (if (not window-system) '(default ((t (:background "nil"))))))

(setq warning-minimum-level :emergency)

;; Map some files to php mode.

(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.test$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.profile$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))

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

(setq geben-path-mappings '(("/home/fabsor/projects/leanlab-docker/web" "/srv/www/leanlab/web")))
(setq geben-dbgp-default-port 9001)
(setq geben-pause-at-entry-line nil)
(setq geben-show-redirect-buffers nil)

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

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(require 'web-mode)
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)
(require 'web-narrow-mode)
(add-hook 'web-mode-hook 'web-narrow-mode)

(setq-default c-basic-offset 2)
(setq-default tab-width 2)

(add-hook 'php-mode-hook 'php-enable-drupal-coding-style)

(c-set-offset 'case-label '+)
(c-set-offset 'arglist-close 0)
(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
(c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))


;; (add-to-list 'eglot-server-programs '(php-mode . ("php-language-server")))
(server-start)
