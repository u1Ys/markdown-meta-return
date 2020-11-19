(defun markdown-meta-return ()
  "Insert a newline and a new element according to the context
like `org-meta-return'. (heading, unorded list, ordered list)"
  (interactive)
  (let*
      ((this-line (markdown-meta-return-this-line))
       (new-line (cond
		  ;; heading
		  ((string-match "^\\(#+ \\)" this-line)
		   (match-string 1 this-line))
		  ;; unorded list
		  ((string-match "^\\( *- \\)" this-line)
		   (match-string 1 this-line))
		  ;; ordered list
		  ((markdown-meta-return-match-ordered-list this-line)
		   (markdown-meta-return-ordered-list))
		  (t "")
		  )))
    (save-excursion (open-line '1))
    (end-of-line)
    (next-line)
    (insert new-line)
    ))


(defun markdown-meta-return-this-line ()
  (buffer-substring-no-properties (line-beginning-position) (line-end-position))
  )


(defun markdown-meta-return-match-ordered-list (line)
  (string-match "^\\( *\\)\\([0-9]+\\)\\. " line)
  )


(defun markdown-meta-return-ordered-list ()
  ;; replace continuous ordered list
  (save-excursion
    (next-line)
    (let
	((this-line (markdown-meta-return-this-line)))
      (while (markdown-meta-return-match-ordered-list this-line)
	;; replace line number to incremented one
	(replace-string
	 this-line
	 (markdown-meta-return-ordered-list-string this-line)
	 nil
	 (line-beginning-position) (line-end-position)
	 )
	;; increment sequence
	(next-line)
	(setq this-line (markdown-meta-return-this-line))
	))
    )
  ;; return new string of this-line
  (let
      ((this-line (markdown-meta-return-this-line)))
    (markdown-meta-return-match-ordered-list this-line)
    (markdown-meta-return-ordered-list-string this-line)
    ))


(defun markdown-meta-return-ordered-list-string (str)
  "NOTICE: this function should be used after
`markdown-meta-return-match-ordered-list'"
  (concat
   ;; white space
   (match-string 1 str)
   ;; new number = current number + 1
   (number-to-string (+ 1
			(string-to-number (match-string 2 str))))
   ". "))


(provide 'markdown-meta-return)
