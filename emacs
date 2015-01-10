(auto-fill-mode -1)
(global-auto-revert-mode t)
(global-smart-spacing-mode nil)
(global-visual-line-mode nil)
(remove-hook 'html-mode-hook #'visual-line-mode)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)
(setq-default indent-tabs-mode nil)

;; Split my windows vertically, not horizontally
;; See the function `split-window-sensibly' in window.el
(setq split-width-threshold nil)
