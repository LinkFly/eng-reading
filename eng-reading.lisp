(mapc #'ql:quickload '(:cl-unicode :uiop))
(defpackage :eng-reading
  (:use :cl :cl-unicode :uiop)
  (:export #:run))
(in-package :eng-reading)

;(defparameter *this-dir* 
(defparameter *data-file* (make-pathname :defaults *load-pathname* :name "data" :type "sexp"))

;;; Internal parameters
(defparameter *all-syms* (read-file-form *data-file*))
;;; end Internal parameters

(defun as-list (sym)
  (if (consp sym)
      sym
      (list sym)))

(defun syms-to-hash (syms &optional (hash (make-hash-table :test 'equal)))
  (dolist (sound syms)
    (dolist (sound-chars (as-list (first sound)))
      (setf (gethash (string-downcase
		      (string sound-chars))
		     hash)
	    (second sound)))))

(defun create-dict-part (&optional key-dict-part &aux syms all-syms (hash (make-hash-table :test 'equal)))
  (setf all-syms (copy-tree *all-syms*))
  (setf syms
	(if key-dict-part
	    (cadr (assoc key-dict-part all-syms))
	    (let ((res '(t)))
	      (dolist (part all-syms)
		(nconc res (second part)))
	      (pop res)
	      res)))
  (syms-to-hash syms hash)
  hash)
;(setf sound-symbols-part1-three (create-dict-part :part1-three))
;(setf sound-symbols-part1-three (create-dict-part :part4-two-set))

(defun hash-table-keys (hash)
  (let (res)
    (maphash #'(lambda(k v)
		 (declare (ignore v))
		 (push k res)) hash)
    (nreverse res)))

(defun random-word-part (word-parts)
  (nth (random (length word-parts)) word-parts))
;(random-word-part (hash-table-keys sound-symbols-part1-three))

(defun run (&optional (dict-part (create-dict-part))  &aux input check-exit part)
  (setf check-exit (lambda (input)
		     (when (equal "exit" input)
		       (return-from run))))
  (when (keywordp dict-part)
    (setf dict-part (create-dict-part dict-part)))
  
  (princ "Press ENTER to start (type 'exit' for exit):")
  (finish-output)
  (setf input (read-line))
  (funcall check-exit input)
  (loop
     (setf part (random-word-part (hash-table-keys dict-part)))
     (format t "~&~A " part)
     (finish-output)
     (setf input (read-line))
     (funcall check-exit input)
     (let ((sound-transcripts (as-list (gethash part dict-part))))
       (format t "~A -> ~{[~A] ~}" part sound-transcripts))
     (finish-output)
     (funcall check-exit input)))
;(run)
#| TODO
 - Сделать возможность указывать несколько режимов (сливая соотв. данные)

|# 
