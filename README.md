# markdown-meta-return

Insert a newline and a new element according to the context like
`org-meta-return'. (heading, unorded list, ordered list)

## Configure example

```emacs-lisp
(require 'markdown-meta-return)
(add-hook 'markdown-mode-hook
          '(lambda ()
	     (define-key markdown-mode-map (kbd "<C-return>") 'markdown-meta-return)
	     ))
```
