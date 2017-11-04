;; drupal-mode.el --- major mode for Drupal coding

(require 'prelude-programming)
(prelude-require-packages '(php-mode))
(prelude-require-packages '(geben))
(setq c-basic-offset 2)
(c-set-offset 'case-label '+)
(c-set-offset 'arglist-close 0)
(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
(c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values


(defun drupal-search ()
  "Search Drupal API with a query or region if any."
  (interactive)
  (prelude-search "http://drupalcontrib.org/api/search/7/" "Search Drupal API: "))

(defun php-search ()
  (interactive)
  (prelude-search "http://se1.php.net/manual-lookup.php?scope=quickref&pattern=" "Search php.net: "))
