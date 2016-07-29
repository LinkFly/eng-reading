(load "~/quicklisp/setup.lisp")
(mapc #'ql:quickload '(:cl-unicode :uiop))
(load "eng-reading.lisp")
(sb-ext:save-lisp-and-die "eng-reading-0-0-1.elf" :toplevel #'eng-reading:run :executable t)
