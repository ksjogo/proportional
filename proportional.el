;;; proportional.el --- use an emacs-wide proportional font

;; Author: Johannes Goslar
;; Created: 30 June 2016
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.4")(use-package))
;; Keywords: font
;; URL: https://github.com/ksjogo/proportional

;; Copyright (C) 2016 Johannes Goslar

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;;; Code:

(defgroup proportional nil
  "Use proportional fonts where appropiate"
  :group 'environment)

(defcustom proportional-font
  "DejaVu Sans"
  "Default proportional-font to activate."
  :group 'proportional
  :type 'string)

(defcustom proportional-monospace-font
  "DejaVu Sans Mono"
  "Default proportional-font to activate."
  :group 'proportional
  :type 'string)

(defun proportional-use-monospace ()
  (interactive)
  "Switch the current buffer to a monospace font."
  (face-remap-add-relative 'header-line `(:family ,proportional-monospace-font))
  (face-remap-add-relative 'mode-line `(:family ,proportional-monospace-font))
  (face-remap-add-relative 'default `(:family ,proportional-monospace-font)))

;;;###autoload
(define-minor-mode proportional-mode "" :global t
  (if proportional-mode
      (progn
        (add-to-list 'default-frame-alist `(font . ,proportional-font))
        (set-frame-font proportional-font)
        (set-fontset-font "fontset-default" 'symbol proportional-font)
        (setq variable-pitch `((t :family ,proportional-font)))
        (add-hook 'dired-mode-hook 'proportional-use-monospace)
        (add-hook 'spacemacs-buffer-mode-hook 'proportional-use-monospace)
        (add-hook 'tabulated-list-mode 'proportional-use-monospace)
        (add-hook 'package-menu-mode-hook 'proportional-use-monospace)
        (add-hook 'magit-popup-mode-hook 'proportional-use-monospace)
        (add-hook 'magit-log-mode-hook 'proportional-use-monospace)
        (add-hook 'which-key-init-buffer-hook 'proportional-use-monospace)
        (add-hook 'mu4e-headers-mode-hook 'proportional-use-monospace))
    (progn
      (add-to-list 'default-frame-alist `(font . ,proportional-monospace-font))
      (set-frame-font proportional-monospace-font)
      (set-fontset-font "fontset-default" 'symbol proportional-monospace-font)
      (setq variable-pitch `((t :family ,proportional-monospace-font)))
      (remove-hook 'dired-mode-hook 'proportional-use-monospace)
      (remove-hook 'spacemacs-buffer-mode-hook 'proportional-use-monospace)
      (remove-hook 'tabulated-list-mode 'proportional-use-monospace)
      (remove-hook 'package-menu-mode-hook 'proportional-use-monospace)
      (remove-hook 'magit-popup-mode-hook 'proportional-use-monospace)
      (remove-hook 'magit-log-mode-hook 'proportional-use-monospace)
      (remove-hook 'which-key-init-buffer-hook 'proportional-use-monospace)
      (remove-hook 'mu4e-headers-mode-hook 'proportional-use-monospace))))

(use-package which-key
  :defer t
  :config
  (progn
    (which-key--init-buffer)
    (with-current-buffer which-key--buffer
      (proportional-use-monospace))))

(provide 'proportional)
;;; proportional.el ends here
