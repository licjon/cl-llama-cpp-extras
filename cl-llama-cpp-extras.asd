(defsystem "cl-llama-cpp-extras"
  :version "0.1.0"
  :author "Jonathan Hustad"
  :license "MIT"
  :depends-on ("cl-llama-cpp")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "Umbrella project for optional cl-llama-cpp extensions"
  :in-order-to ((test-op (test-op "cl-llama-cpp-extras/tests"))))

(defsystem "cl-llama-cpp-extras/shim"
  :description "Shared C++ shim build and load infrastructure for cl-llama-cpp-extras"
  :version "0.1.0"
  :author "Jonathan Hustad"
  :license "MIT"
  :depends-on ("cl-llama-cpp")
  :serial t
  :components ((:module "src/shim"
                :serial t
                :components
                ((:file "packages")
                 (:file "library")))))

(defsystem "cl-llama-cpp-extras/json-schema"
  :description "JSON Schema to GBNF grammar conversion for cl-llama-cpp"
  :version "0.1.0"
  :author "Jonathan Hustad"
  :license "MIT"
  :depends-on ("cl-llama-cpp-extras/shim" "yason")
  :serial t
  :components ((:module "src/json-schema"
                :serial t
                :components
                ((:file "packages")
                 (:file "bindings")
                 (:file "json-schema")))))

(defsystem "cl-llama-cpp-extras/json-partial"
  :description "Streaming JSON healer — parse incomplete JSON mid-generation"
  :version "0.1.0"
  :author "Jonathan Hustad"
  :license "MIT"
  :depends-on ("cl-llama-cpp-extras/shim" "yason")
  :serial t
  :components ((:module "src/json-partial"
                :serial t
                :components
                ((:file "packages")
                 (:file "bindings")
                 (:file "json-partial")))))

(defsystem "cl-llama-cpp-extras/json-partial/tests"
  :description "Tests for cl-llama-cpp-extras/json-partial"
  :depends-on ("cl-llama-cpp-extras/json-partial" "rove")
  :components ((:module "tests"
                :components
                ((:file "json-partial"))))
  :perform (test-op (op c) (symbol-call :rove :run c)))

(defsystem "cl-llama-cpp-extras/examples"
  :description "Example programs for cl-llama-cpp-extras"
  :depends-on ("cl-llama-cpp-extras/json-schema")
  :components ((:module "examples"
                :components
                ((:file "json-schema")))))

(defsystem "cl-llama-cpp-extras/tests"
  :author "Jonathan Hustad"
  :license "MIT"
  :depends-on ("cl-llama-cpp-extras"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cl-llama-cpp-extras"
  :perform (test-op (op c) (symbol-call :rove :run c)))

(defsystem "cl-llama-cpp-extras/json-schema/tests"
  :description "Tests for cl-llama-cpp-extras/json-schema"
  :depends-on ("cl-llama-cpp-extras/json-schema" "rove")
  :components ((:module "tests"
                :components
                ((:file "json-schema"))))
  :perform (test-op (op c) (symbol-call :rove :run c)))

(defsystem "cl-llama-cpp-extras/speculative"
  :description "Speculative decoding for cl-llama-cpp"
  :version "0.1.0"
  :author "Jonathan Hustad"
  :license "MIT"
  :depends-on ("cl-llama-cpp-extras/shim" "trivial-garbage")
  :serial t
  :components ((:module "src/speculative"
                :serial t
                :components
                ((:file "packages")
                 (:file "bindings")
                 (:file "speculative")))))

(defsystem "cl-llama-cpp-extras/speculative/tests"
  :description "Tests for cl-llama-cpp-extras/speculative"
  :depends-on ("cl-llama-cpp-extras/speculative" "rove")
  :components ((:module "tests"
                :components
                ((:file "speculative"))))
  :perform (test-op (op c) (symbol-call :rove :run c)))
