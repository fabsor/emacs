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
(add-to-list 'auto-mode-alist '("\\.php$" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.module$" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.test$" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.profile$" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . drupal-mode))

;; Don't use smart parens'
; (turn-off-smartparens-mode)

;; Javascript indent level
(setq js-indent-level 2)
