;; drupal-mode.el --- major mode for Drupal coding

(require 'prelude-programming)
(prelude-require-packages '(php-mode))

(defun drupal-search ()
  "Search Drupal API with a query or region if any."
  (interactive)
  (prelude-search "http://drupalcontrib.org/api/search/7/" "Search Drupal API: "))

(defun php-search ()
  (interactive)
  (prelude-search "http://se1.php.net/manual-lookup.php?scope=quickref&pattern=" "Search php.net: "))


;;;###autoload
(define-derived-mode drupal-mode php-mode "Drupal"
  "Major mode for Drupal coding.\n\n\\{drupal-mode-map}"
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (setq fill-column 78)
  (setq show-trailing-whitespace t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (c-set-offset 'case-label '+)
  (c-set-offset 'arglist-close 0)
  (c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
  (c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values
  (run-mode-hooks 'drupal-mode-hook)
  )
(provide 'drupal-mode)
