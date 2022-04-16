#!/usr/bin/racket
#lang racket

;; Let's try this out

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)
;; => 5
(new-if (= 1 1) 0 5)
;; => 0

;; So far, it looks like `new-if` is working.  Let's try our iterative
;; root finder. First we must create all the supporting fns

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

;; Classic `if`
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)
;; => 3.00009155413138

;; `new-if` version
(define (new-sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (new-sqrt-iter (improve guess x) x)))

(define (new-sqrt x)
  (new-sqrt-iter 1.0 x))

(new-sqrt 9)
;; => (never returns)

;; The `new-sqrt-iter` has a problem. We pass the arguments
;; `(good-enough?  guess x)`, `guess`, and the recursive call to
;; `(new-sqrt-iter (improve guess x) x)` to `new-if; however, since
;; the Lisp interpreter evaluates the expressions in "applicative
;; order" instead of "normal order", the interpreter will evaluate the
;; operator (`new-if`) to retrieve the procedure, then it will
;; evaluate _all_ the operands before finally applying the procedure
;; to the resulting arguments.
;;
;; By evaluating all the operands, including the `else-clause`, the
;; interpreter unfortunately enters an infinitely recursive process
;; (`new-sqrt-iter` calls itself, forever, and never terminates).
