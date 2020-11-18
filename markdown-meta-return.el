(defun markdown-meta-return ()
  "Insert a newline and a new element according to the context
like `org-meta-return'. (heading, unorded list, ordered list)"
  (interactive)
  (let*
      ((this-line (buffer-substring (line-beginning-position) (line-end-position)))
       (new-line (cond
		  ;; heading
		  ((string-match "^\\(#+ \\)" this-line)
		   (match-string 1 this-line))
		  ;; unorded list
		  ((string-match "^\\( *- \\)" this-line)
		   (match-string 1 this-line))
		  ;; ordered list
		  ((string-match "^\\( *\\)\\([0-9]+\\)\\. " this-line)
		   (concat (match-string 1 this-line)
			   ;; new number = current number + 1
		  	   (number-to-string (+ 1
	    	  				(string-to-number (match-string 2 this-line))))
		  	   ". "))
		  (t "")
		  )))
    (save-excursion (open-line '1))
    (end-of-line)
    (next-line)
    (insert new-line)
    ))

(provide 'markdown-meta-return)
