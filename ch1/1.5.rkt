#!/usr/bin/racket
#lang racket

(define (p) (p))

(define (test x y)
  (if (= (x 0))
      0
      y))

;; The idea is that it will test to see if the interpreter is applicative order evaluation or normal order evaluation. Applicative order will evaluate function arguments when the interpreter needs them, wheras normal order will evaluate all function arguments, then calculate the result.

;; So, for an applicative order interpreter:
;; (test 0 (p))
;; test => the procedure
;; 0 => 0
;; (p) => ((p)) => (((p))) => etc.

;; Wheras, for a normal order interpreter:
;; (test 0 (p))
;; => ((if (= (0 0))
;;         0
;;         (p)))
;; => 0
;; etc.

;; So, in other words, an applicative order interpreter will loop
;; forever attempting to resolve the call to `p` into successively
;; recursive calls to `p`. A normal order interpreter will evaluate
;; the primitive expression (= 0 0) first, and thereby return 0 due to
;; therules of the `if` procedure.
