#!/usr/bin/racket
#lang racket

;; Define a procedure that takes three numbers as arguments and
;; returns the sum of squares of the two larger numbers

(define (square x)
  (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (larger-sum-of-squares x y z)
  (cond
    ((>= x y z) (sum-of-squares x y))
    ((>= y x z) (sum-of-squares x y))
    ((>= x z y) (sum-of-squares x z))
    ((>= z x y) (sum-of-squares z x))
    ((>= y z x) (sum-of-squares y z))
    ((>= z y x) (sum-of-squares z y))))

(larger-sum-of-squares 1 2 3)
(larger-sum-of-squares 3 2 1)
(larger-sum-of-squares 3 2 2)
(larger-sum-of-squares 3 3 3)
(larger-sum-of-squares 1 3 2)
