;; Allow arrow navigation.
(setq prelude-guru nil)

;; Add some packages
(prelude-require-packages '(monokai-theme))
(prelude-require-packages '(jade-mode))

;; Let's use the monokai theme
(load-theme 'monokai t)

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

;; Don't use smart parens'
; (turn-off-smartparens-mode)

;; Javascript indent level
(setq js-indent-level 2)
