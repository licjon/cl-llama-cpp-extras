(defpackage #:cl-llama-cpp-extras/reasoning-budget/tests
  (:use #:cl #:rove))
(in-package #:cl-llama-cpp-extras/reasoning-budget/tests)

;;; Package and symbol tests

(deftest test-package-exists
  (testing "cl-llama-cpp-extras/reasoning-budget package exists"
    (ok (find-package :cl-llama-cpp-extras/reasoning-budget))))

(deftest test-symbols-exported
  (testing "core functions are exported and fbound"
    (ok (fboundp (find-symbol "MAKE-REASONING-BUDGET-SAMPLER"
                              :cl-llama-cpp-extras/reasoning-budget)))
    (ok (fboundp (find-symbol "REASONING-BUDGET-STATE"
                              :cl-llama-cpp-extras/reasoning-budget)))
    (ok (fboundp (find-symbol "REASONING-BUDGET-FORCE"
                              :cl-llama-cpp-extras/reasoning-budget))))
  (testing "condition symbols are exported"
    (ok (find-symbol "REASONING-BUDGET-INIT-ERROR"
                     :cl-llama-cpp-extras/reasoning-budget))
    (ok (find-symbol "REASONING-BUDGET-INIT-ERROR-MESSAGE"
                     :cl-llama-cpp-extras/reasoning-budget))))

(deftest test-condition-hierarchy
  (testing "reasoning-budget-init-error subtypes llama-error"
    (ok (subtypep 'cl-llama-cpp-extras/reasoning-budget:reasoning-budget-init-error
                  'cl-llama-cpp:llama-error))))

(deftest test-condition-signaling
  (testing "reasoning-budget-init-error can be constructed and caught"
    (ok (typep
         (handler-case
             (error 'cl-llama-cpp-extras/reasoning-budget:reasoning-budget-init-error
                    :message "test error")
           (cl-llama-cpp-extras/reasoning-budget:reasoning-budget-init-error (c) c))
         'cl-llama-cpp-extras/reasoning-budget:reasoning-budget-init-error))))

(deftest test-condition-message
  (testing "reasoning-budget-init-error-message returns the message"
    (let ((c (make-condition
              'cl-llama-cpp-extras/reasoning-budget:reasoning-budget-init-error
              :message "test msg")))
      (ok (string= "test msg"
                    (cl-llama-cpp-extras/reasoning-budget:reasoning-budget-init-error-message c))))))

(deftest test-state-vector
  (testing "+reasoning-budget-states+ contains the expected keywords"
    (let ((states cl-llama-cpp-extras/reasoning-budget:+reasoning-budget-states+))
      (ok (vectorp states))
      (ok (= 5 (length states)))
      (ok (eq :idle         (aref states 0)))
      (ok (eq :counting     (aref states 1)))
      (ok (eq :forcing      (aref states 2)))
      (ok (eq :waiting-utf8 (aref states 3)))
      (ok (eq :done         (aref states 4))))))
