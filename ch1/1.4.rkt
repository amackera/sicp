#!/usr/bin/racket
#lang racket

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 1 2)
(a-plus-abs-b 1 -2)
(a-plus-abs-b -1 -2)
(a-plus-abs-b 1 -10)

;; The "if" expression itself returns a procedure (`+` or `-`) that's
;; used to evaluate the final result. If `b` is positive, the
;; operation will be to add the args together. If `b` is negative, the
;; operation will be to subtract `b` from `a` (in effect, adding
;; together `a` with the absolute value of `b`.
