
;(setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages:")

(require 'cl)

;;setup package manager
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; script from: http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar my-packages
  '(auctex auto-complete magit yasnippet)
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  (loop for p in my-packages
          when (not (package-installed-p p)) do (return -1)
	          finally (return 1)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; path to plugins: http://zmjones.com/mac-setup/ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(let ((default-directory "~/.emacs.d/elpa/"))
     (normal-top-level-add-to-load-path '("."))
     (normal-top-level-add-subdirs-to-load-path))

(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
      (exec-path-from-shell-initialize))


;;setings from:
;; 	  http://www.aaronbedra.com/emacs.d/
;;	  http://truongtx.me/2013/01/06/config-yasnippet-and-autocomplete-on-emacs/
;;	  http://www.jesshamrick.com/2013/03/31/macs-and-emacs/

;;;;;;;;;;;;;;
;; start up ;;
;;;;;;;;;;;;;;

(setq inhibit-splash-screen 1		;;turn off splash screen
      initial-scratch-message nil	;;remove initial message
      initial-major-mode 'org-mode) 	;;turn on org-mode

;;;;;;;;;;
;; bars ;;
;;;;;;;;;;

(scroll-bar-mode -1)  ;;turn off scroll bar
(tool-bar-mode -1)    ;;turn off tool bar
(menu-bar-mode -1)    ;;turn off menu bar

;;;;;;;;;;;;;;;;;;
;; marking text ;;
;;;;;;;;;;;;;;;;;;

(delete-selection-mode 1)
(transient-mark-mode 1)
(setq x-select-enable-clipboard 1)

;;;;;;;;;;;;;;;;;;;;;;
;; display settings ;;
;;;;;;;;;;;;;;;;;;;;;;

;;this is only used when running cocoa app. 
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
    (set-face-attribute 'default nil
                          :family "Inconsolata"
			  :height 140
			  :weight 'normal
			  :width 'normal)

  (when (functionp 'set-fontset-font)
      (set-fontset-font "fontset-default"
                        'unicode
			(font-spec :family "DejaVu Sans Mono"
			:width 'normal
			:size 12.4
			:weight 'normal))))

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))


;set custom window width and height
(defun custom-set-frame-size ()
  (add-to-list 'default-frame-alist '(height . 65))
  (add-to-list 'default-frame-alist '(width . 99)))
(custom-set-frame-size)
(add-hook 'before-make-frame-hook 'custom-set-frame-size)


;;;;;;;;;;;;;;;;;
;; Indentation ;;
;;;;;;;;;;;;;;;;;

(setq tab-width 2)
(setq indent-tabs-mode nil)

;;;;;;;;;;;;;;;;;;
;; backup files ;;
;;;;;;;;;;;;;;;;;;

(setq make-backup-files -1) ;;turn off backup files

;;;;;;;;;;;;;;;;;;;;;;;;;
;; global key bindings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


(global-set-key (kbd "RET") 'newline-and-indent)
;(global-set-key (kbd "C-;") 'comment-or-uncomment-region) ;already bound to "M-;"
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)

;;;;;;;;;;;
;; Misc  ;;
;;;;;;;;;;;

(setq echo-keystrokes 0.1
      use-dialog-box -1
      visible-bell 1)
(show-paren-mode 1)

;;;;;;;;;;;;;;
;;  AucTeX  ;;
;;;;;;;;;;;;;;
;; largely from: http://www.stefanom.org/setting-up-a-nice-auctex-environment-on-mac-os-x/

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)  ;Query for master file

(add-hook 'LaTex-mode-hook 'visual-line-mode)
(add-hook 'LaTex-mode-hook 'flyspell-mode)
(add-hook 'LaTex-mode-hook 'LaTex-math-mode)

(add-hook 'LaTex-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;use Skim as viewer
(add-hook 'LaTeX-mode-hook (lambda()
(push
    '("latexmk" "latexmk -synctex=1 -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))

(add-hook 'TeX-mode-hook '(lambda() (setq TeX-command-default "latexmk")))


(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
  '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

;(server-start); start emacs in server mode so that skim can talk to it.

;;;;;;;;;;;;;;
;; Org Mode ;;
;;;;;;;;;;;;;;



;;;;;;;;;;
;; Ido  ;;
;;;;;;;;;;

(ido-mode 1)
(setq ido-enable-flex-matching 1
      ido-use-virtual-buffers 1)

;;column number mode
(setq column-number-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet and autocomplete ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'yasnippet)
(setq yas-snippet-dirs 'yas-installed-snippets-dir)
(yas-global-mode 1)

(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;;;;;;;;;;;
;; LaTex ;;
;;;;;;;;;;;

(require 'tex-site)
(require 'font-latex)
