(load (some #'(lambda (pathname)
		   (ignore-errors (probe-file pathname)))
	       '(
		 #P"~/quicklisp/setup.lisp"
		 #P"D:/program-files/lispstick/quicklisp/setup.lisp"
		 )))
(mapc #'ql:quickload '(:cl-unicode :uiop))
(load "eng-reading.lisp")
(sb-ext:save-lisp-and-die 
 #+:linux "eng-reading-0-0-2.elf"
 :toplevel #'eng-reading:run :executable t)
