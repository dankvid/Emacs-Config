(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; Completion
(straight-use-package 'corfu)
(setq corfu-auto t)
(corfu-global-mode 1)

(straight-use-package 'vertico)
(setq-default vertico-cycle t)
(vertico-mode 1)

(straight-use-package 'consult)
(global-set-key (kbd "C-s") 'consult-line)
(define-key minibuffer-local-map (kbd "C-r") 'consult-history)

(setq completion-in-region-function #'consult-completion-in-region)

(straight-use-package 'orderless)

;; Set up Orderless for better fuzzy matching
(require 'orderless)
(customize-set-variable 'completion-styles '(orderless))
(setq-default completion-category-overrides '((file (styles . (partial-completion)))))
(setq completion-category-defaults nil)

(straight-use-package 'marginalia)
(setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
(marginalia-mode 1)

(straight-use-package 'embark)
(global-set-key [remap describe-bindings] #'embark-bindings)
(global-set-key (kbd "C-.") 'embark-act)

;; Use Embark to show bindings in a key prefix with `C-h`
(setq prefix-help-command #'embark-prefix-help-command)

;; Programming Stuff
(electric-pair-mode 1)
(straight-use-package 'eglot)
;; Hook up language modes with eglot
(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'eglot-ensure)

;; Setup for Golang
(straight-use-package 'go-mode)
;; Make project work nice together with go.mod files
(require 'project)
(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

(straight-use-package 'slime)
(straight-use-package 'haskell-mode)
(straight-use-package 'magit)

;; Visuals
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(global-display-line-numbers-mode 1)

(straight-use-package 'zenburn-theme)
(load-theme 'zenburn t)

(straight-use-package 'doom-modeline)
(doom-modeline-mode)

(straight-use-package 'all-the-icons)

;; Keys
(global-set-key (kbd "M-o") 'other-window)

;; Improve GC time by lower threshold
(setq gc-cons-threshold (* 2 1000 1000))
(setq find-file-visit-truename t)
