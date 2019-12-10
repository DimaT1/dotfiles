(add-to-list 'load-path "~/.emacs.d/undo-tree")
(require 'undo-tree)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)


(show-paren-mode 1)
(setq show-paren-delay 0)

(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray90")


(require 'package)
; (package-refresh-contents)
(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(package-install 'use-package)
(require 'use-package)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))




(setq-default c-basic-offset 4
              tab-width 4
              c-default-style "linux"
              indent-tabs-mode nil)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-battery-mode t)
 '(display-line-numbers (quote relative))
 '(package-selected-packages (quote (flycheck use-package)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width 1 :style released-button))))))
