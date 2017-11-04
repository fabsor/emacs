;;; lsp-python.el --- Python support for lsp-mode

;; Copyright (C) 2017 Vibhav Pant <vibhavp@gmail.com>

;; Author: Vibhav Pant <vibhavp@gmail.com>
;; Version: 1.0
;; Package-Requires: ((lsp-mode "2.0"))
;; Keywords: python
;; URL: https://github.com/emacs-lsp/lsp-python

(require 'lsp-mode)
(require 'lsp-common)
(require 'python)

(defcustom python-lsp-pyls-path "pyls"
  "Pyls path"
  :group 'python-lsp
  :type 'string)

(lsp-define-stdio-client 'python-mode "python" 'stdio
                         (lsp-make-traverser #'(lambda (dir)
                                                 (directory-files
                                                  dir
                                                  nil
                                                  "\\(__init__\\|setup\\)\\.py")))
                         "Python Language Server"
                         (symbol-value 'python-lsp-pyls-path))

(provide 'lsp-python)
;;; lsp-python.el ends here
