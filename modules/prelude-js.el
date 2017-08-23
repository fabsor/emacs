;;; prelude-js.el --- Emacs Prelude: js-mode configuration.
;;
;; Copyright © 2011-2017 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Some basic configuration for js-mode.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(require 'prelude-programming)
(prelude-require-packages '(js2-mode json-mode))

(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'"    . js2-mode))
(add-to-list 'auto-mode-alist '("\\.pac\\'"   . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(eval-after-load 'js2-mode
  '(progn
     (defun prelude-js-mode-defaults ()
       ;; electric-layout-mode doesn't play nice with smartparens
       (setq-local electric-layout-rules '((?\; . after)))
       (setq mode-name "JS2")
       (js2-imenu-extras-mode +1))

     (setq prelude-js-mode-hook 'prelude-js-mode-defaults)
     (add-hook 'js2-mode-hook (lambda () (run-hooks 'prelude-js-mode-hook)))))


(eval-after-load 'js2-mode
  '(progn

     ;; Cosmetics
     (font-lock-add-keywords
      'js2-mode `(("\\(function *\\)("
                   (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                             "ƒ")
                             nil)))))

     (font-lock-add-keywords
      'js2-mode
      '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
         1 font-lock-warning-face t)))

     (defun js-lambda () (interactive) (insert "function () {\n}")
       (backward-char 5))

     (add-hook 'js2-mode-hook 'coding-hook)

     (define-key js2-mode-map (kbd "C-c l") 'js-lambda)
     (define-key js2-mode-map "\C-\M-h" 'backward-kill-word)

     ;; Fix js2's crazy indentation
     (define-key js2-mode-map (kbd "TAB") (lambda () (interactive)
                                            (indent-for-tab-command)
                                            (back-to-indentation)))

     (setq js2-bounce-indent-flag nil
           js2-indent-on-enter-key t)

     (defun js-continued-var-decl-list-p ()
       "Return non-nil if point is inside a continued variable declaration list."
       (interactive)
       (let ((start (save-excursion (js-re-search-backward "\\<var\\>" nil t))))
         (and start
              (save-excursion (re-search-backward "\n" start t))
              (not (save-excursion
                     (js-re-search-backward
                      ";\\|[^, \t][ \t]*\\(/[/*]\\|$\\)" start t))))))

     (defun js-proper-indentation (parse-status)
       "Return the proper indentation for the current line."
       (save-excursion
         (back-to-indentation)
         (let ((ctrl-stmt-indent (js-ctrl-statement-indentation))
               (same-indent-p (looking-at "[]})]\\|\\<case\\>\\|\\<default\\>"))
               (continued-expr-p (js-continued-expression-p)))
           (cond (ctrl-stmt-indent)
                 ((js-continued-var-decl-list-p)
                  (js-re-search-backward "\\<var\\>" nil t)
                  (+ (current-indentation) js2-basic-offset))
                 ((nth 1 parse-status)
                  (goto-char (nth 1 parse-status))
                  (if (looking-at "[({[][ \t]*\\(/[/*]\\|$\\)")
                      (progn
                        (skip-syntax-backward " ")
                        (when (= (char-before) ?\)) (backward-list))
                        (back-to-indentation)
                        (cond (same-indent-p
                               (current-column))
                              (continued-expr-p
                               (+ (current-column) (* 2 js2-basic-offset)))
                              (t
                               (+ (current-column) js2-basic-offset))))
                    (unless same-indent-p
                      (forward-char)
                      (skip-chars-forward " \t"))
                    (current-column)))
                 (continued-expr-p js2-basic-offset)
                 (t 0)))))))

(provide 'prelude-js)

;;; prelude-js.el ends here
