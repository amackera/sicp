#!/usr/bin/racket
#lang racket

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (err root original)
  (* 100 (/ (- (square root) original) original)))

;; (sqrt 9)
;; => 3.00009155413138

;; Where does this break down for small numbers?
;; (sqrt 4)
;; => 2.0000000929222947
;; (sqrt 1)
;; => 1.0
;; (sqrt 0.1)
;; => 0.316245562280389
;; (square (sqrt 0.1)) ;; should be 0.1
;; => 0.10001125566203942
;; (square (sqrt 0.01)) ;; should be 0.01
;; => 0.0100652631578588
;; (square (sqrt 0.001)) ;; should be 0.001
;; => 0.0017011851721075596
;; (* 100 (/ ( - (square (sqrt 0.001)) 0.001) 0.001))
;; => 70.11851721075595
;; In other words, it's error is ~70%

;; (sqrt 0.0001)
;; => 0.03230844833048122
;; (square (sqrt 0.0001)) ;; should be 0.0001
;; => 0.0010438358335233748
;; (* 100 (/ (- (square (sqrt 0.0001)) 0.0001) 0.0001))
;; 943.8358335233747
;; In other words, the error is ~943%

;; The smaller the number, the higher the error. This ie because the
;; `good-enough?` fn requires a "good enough margin", which we have
;; arbitrarily set to 0.001. Any time we're trying to calculate a
;; square root for a number that's close to or less than 0.001 will
;; result in `good-enough` giving up too early, and declaring
;; increasingly inaccurate guesses as "good enough".

;; Let's see how sqrt deals with large numbers
;; (sqrt 12345)
;; => 111.10805770848404
;; This takes a few seconds to calculate

;; (sqrt 123456789123456)
;; => does not finish!

;; (sqrt 12345678912347)
;; Does not finish!

;; Let's try the alternative implementation

(define (new-good-enough? prev-guess guess)
  (< (abs (/ (- guess prev-guess) guess)) 0.000000001))

(define (new-sqrt-iter guess x)
  (if (new-good-enough? guess (improve guess x))
      guess
      (new-sqrt-iter (improve guess x) x)))

(define (new-sqrt x)
  (new-sqrt-iter 1.0 x))

;; let's try the new method with values that didn't work well before
(new-sqrt 123456789012345)
;; => 11111111.061826538

(new-sqrt 12345678912347)
;; => 3513641.8304014714

(err (sqrt 0.000001) 0.000001)
;; => 97622.85838805523
(err (new-sqrt 0.000001) 0.000001)
;; => 2.3505164286306834e-1

(err (new-sqrt 100) 100)
