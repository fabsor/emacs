;; Allow arrow navigation.
(setq prelude-guru nil)

;; Add some packages
(prelude-require-packages '(seti-theme))
(prelude-require-packages '(jade-mode))

;; Let's use the monokai theme
(load-theme 'seti t)

;; No scroll bars
(custom-set-variables
 '(scroll-bar-mode nil))

(custom-set-variables '(coffee-tab-width 2))

;; Map some files to drupal mode.

(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.test$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.profile$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))


(defun find-jshintrc ()
  (expand-file-name ".jsxhintrc"
                    (locate-dominating-file
                     (or (buffer-file-name) default-directory) ".jsxhintrc")))


(flycheck-define-checker jsxhint-checker
  "A JSX syntax and style checker based on JSXHint."

  :command ("jsxhint" (config-file "--config=" jshint-configuration-path) source)
  :error-patterns
  ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
  :modes (web-mode))

(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              ;; enable flycheck
              (flycheck-select-checker 'jsxhint-checker)
              (flycheck-mode))))

(defun my-web-mode-hook ()
  (setq-local jshint-configuration-path (find-jshintrc))
  "Hooks for Web mode."
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

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
 )

(setq split-height-threshold nil
      split-width-threshold nil)

(server-start)

(require 'virtualenvwrapper)
(setq venv-location "/Users/fabsor/.virtualenvs")
