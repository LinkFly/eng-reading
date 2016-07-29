;;; Used for create data file
(mapc #'ql:quickload '(:cl-unicode :uiop))
(defpackage :eng-reading.prepare
  (:use :cl :cl-unicode :uiop))
(in-package :eng-reading.prepare)

(defparameter *transcripts-spec-file* "~/work/projects/eng-reading/transcript-symbols-specs.sexp")
(defparameter *transcript-symbols-specs* (read-file-form  *transcripts-spec-file*))
(setf transcript-symbols
      (loop
	 with res = (make-array (length *transcript-symbols-specs*))
	 for sym across *transcript-symbols-specs*
	 for idx from 0
	 for tsym = (character-named (concatenate 'string "U+" (third sym)) :try-hex-notation-p t)
	 do (setf (aref res idx) tsym)
	 finally (return res)))
;(princ transcript-symbols)
