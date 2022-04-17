#!/usr/bin/racket
#lang racket

;; here we are asked to write a procedure to implement Newton's method
;; for cube roots analagous to the method of square roots we
;; implemented in previous exercises.

;; The major difference lies in the `improve` fn that improves the
;; approximation of the cube root over successive iterations.

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (good-enough? prev-guess guess)
  (< (abs (/ (- guess prev-guess) guess)) 0.000000001))


(define (improve guess x)
  (/
   (+
    (/ x (square guess))
    (* 2 guess))
   3))

(define (cubrt-iter guess x)
  (if (good-enough? guess (improve guess x))
      guess
      (cubrt-iter (improve guess x) x)))

(define (cubrt x)
  (cubrt-iter 1.0 x))

(define (err root original)
  (* 100 (/ (- (cube root) original) original)))

;; Let's take it for a spin
(cubrt 27)
;; => 3.0000000000000977
(err (cubrt 27) 27)
;; => 9.776541716106563e-1
;; not bad!

(cubrt 0.0001)
;; => 0.04641588833612779

(err (cubrt 0.01) 0.01)
;; => 1.3357370765021415e-12
;; pretty good!
