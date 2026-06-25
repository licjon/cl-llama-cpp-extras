(defpackage cl-llama-cpp-extras/tests/main
  (:use :cl
        :cl-llama-cpp-extras
        :rove))
(in-package :cl-llama-cpp-extras/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-llama-cpp-extras)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
