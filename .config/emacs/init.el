
(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)
;(set-face-attribute 'default nil :font "MartianMono Nerd Font")
;(set-face-attribute 'default nil :font "Mononoki Nerd Font")
;(set-frame-font "Iosevka Extended 12" nil t)
;(set-frame-font "IosevkaTermSlab Nerd Font" nil t)
(set-frame-font "IosevkaTerm Nerd Font" nil t)
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-type 'visual)
(global-display-line-numbers-mode t)
;(load-theme 'wombat)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; avoid to emacs to write in this file, instead it should writes in custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setq tab-bar-new-tab-choice "*scratch*")

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))


;(setq package-check-signature nil) ; Only uncomment first time for download gnu-elpa-keyring-update

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(unless (package-installed-p 'gnu-elpa-keyring-update)
   (package-install 'gnu-elpa-keyring-update))

(require 'use-package)
(setq use-package-always-ensure t)

;; ================= Packages

(use-package command-log-mode)

;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts

(use-package all-the-icons)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-sourcerer t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package vim-tab-bar
  :ensure t
  :commands vim-tab-bar-mode
  :config
  (setq tab-bar-show 1)
  :hook
  (after-init . vim-tab-bar-mode))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-set-undo-system 'undo-redo)
  (evil-mode 1))

(use-package drag-stuff
  :config
  (drag-stuff-mode t)
  (drag-stuff-global-mode 1)
  (global-set-key (kbd "M-j") 'drag-stuff-down)
  (global-set-key (kbd "M-k") 'drag-stuff-up)
  )

(with-eval-after-load 'evil
  (define-key evil-window-map (kbd "C-h") nil)
  (define-key evil-window-map (kbd "C-j") nil)
  (define-key evil-window-map (kbd "C-k") nil)
  (define-key evil-window-map (kbd "C-l") nil)
  (define-key evil-normal-state-map (kbd "C-,") 'open-init-file)
  (define-key evil-normal-state-map (kbd "<tab>") 'tab-next)
  (define-key evil-normal-state-map (kbd "<backtab>") 'tab-previous)
  (define-key evil-normal-state-map (kbd "C-S-h") 'windmove-left)   ;; Moverse a la ventana izquierda
  (define-key evil-normal-state-map (kbd "C-S-l") 'windmove-right)  ;; Moverse a la ventana derecha
  (define-key evil-normal-state-map (kbd "C-S-k") 'windmove-up)     ;; Moverse a la ventana superior
  (define-key evil-normal-state-map (kbd "C-S-j") 'windmove-down)   ;; Moverse a la ventana inferior
)

(use-package bufferlo
 :ensure t
 :after ivy
 :config
 (bufferlo-mode 1))

(defun ivy-bufferlo-switch-buffer ()
  "Switch to another local buffer.
If the prefix arument is given, include all buffers."
    (interactive)
    (if current-prefix-arg
        (ivy-switch-buffer)
      (ivy-read "Switch to local buffer: " #'internal-complete-buffer
                :predicate (lambda (b) (bufferlo-local-buffer-p (cdr b)))
                :keymap ivy-switch-buffer-map
                :preselect (buffer-name (other-buffer (current-buffer)))
                :action #'ivy--switch-buffer-action
                :matcher #'ivy--switch-buffer-matcher
                :caller 'ivy-switch-buffer)))

(defun open-init-file ()
  (interactive)
  (find-file "~/.config/emacs/init.el"))

;; ===== Keybindings
(general-auto-unbind-keys)
(use-package general)
(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out")
  ("q" nil "finished" :exit t))

(general-create-definer rog/leader-keys
  :keymaps '(normal visual emacs)
  :prefix "SPC")

(rog/leader-keys
  "bb" 'ivy-bufferlo-switch-buffer
  "bd" 'bufferlo-bury
  "ff" 'find-file
  "|" 'evil-window-vsplit
  "-" 'evil-window-split
  "SPC" 'hydra-text-scale/body :which-key "scale text")

(general-create-definer rog/leader-tabs
  :keymaps '(normal visual emacs)
  :prefix "SPC <tab>")

(rog/leader-tabs
  "<tab>" 'tab-new
  "d" 'tab-close)

;; Configurar la apertura de ventanas de ayuda para que no sobrescriban ventanas actuales
(setq display-buffer-alist
      '(("\\*Help\\*"                 ;; Para buffers de ayuda (Help)
         (display-buffer-reuse-window ;; Reusar ventana si ya existe
          display-buffer-pop-up-window) ;; Si no existe, abrir en una nueva
         (reusable-frames . visible))))



