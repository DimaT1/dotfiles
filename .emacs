;;; package -- Summary
;;; Commentary:
;;; Code:

; Undo tree
(add-to-list 'load-path "~/.emacs.d/undo-tree")
(require 'undo-tree)

; Evil mode
(setq evil-want-C-u-scroll t) ; C-u for scroll up
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "C-n") nil)
  (define-key evil-normal-state-map (kbd "C-p") nil))

; Evil mode window motions
(define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)

; Show parhenthesis pairs
(show-paren-mode 1)
(setq show-paren-delay 0)

; Highlight current line
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray90")

(setq-default show-trailing-whitespace t)

; Packages
(require 'package)
(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(package-install 'use-package)
(require 'use-package)

; vim-like surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

; Linter
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

; Autocompletion
;; == irony-mode ==
(use-package irony
  :ensure t
  :defer t
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  :config
  ;; replace the `completion-at-point' and `complete-symbol' bindings in
  ;; irony-mode's buffers by irony-mode's function
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )

(use-package company
  :ensure t
  :defer t
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (use-package company-irony :ensure t :defer t)
  (setq company-idle-delay          0
	company-minimum-prefix-length   1
	company-show-numbers            t
	company-tooltip-limit           20
	company-dabbrev-downcase        nil
	company-backends                '((company-irony company-gtags))
	)
  ; :bind ("C-n" . company-complete-common)
  )
(company-tng-configure-default)

; NeoTree
(require 'neotree)
(global-unset-key "\C-n")
(global-set-key (kbd "\C-n") 'neotree-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "\C-n") 'neotree-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

; Convert tab to 4 spaces
(setq-default c-basic-offset 4
              tab-width 4
              c-default-style "linux"
              indent-tabs-mode nil)

; Appearance
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-line-numbers (quote relative))
 '(package-selected-packages (quote (neotree irony flycheck use-package)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; call a shell command
(shell-command "notify-send 'Welcome Back to Emacs! ' --icon='/usr/share/icons/hicolor/32x32/apps/emacs.png'")

(provide '.emacs)
;;; .emacs ends here
