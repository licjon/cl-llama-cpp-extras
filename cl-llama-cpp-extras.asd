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

(defsystem "cl-llama-cpp-extras/json-schema"
  :description "JSON Schema to GBNF grammar conversion for cl-llama-cpp"
  :version "0.1.0"
  :author "Jonathan Hustad"
  :license "MIT"
  :depends-on ("cl-llama-cpp" "yason")
  :serial t
  :components ((:module "src/json-schema"
                :serial t
                :components
                ((:file "packages")
                 (:file "library")
                 (:file "bindings")
                 (:file "json-schema")))))

(defsystem "cl-llama-cpp-extras/examples"
  :description "Example programs for cl-llama-cpp-extras"
  :depends-on ("cl-llama-cpp-extras/json-schema")
  :components ((:module "examples"
                :components
                ((:file "json-schema")))))

(defsystem "cl-llama-cpp-extras/json-schema/tests"
  :description "Tests for cl-llama-cpp-extras/json-schema"
  :depends-on ("cl-llama-cpp-extras/json-schema" "rove")
  :components ((:module "tests"
                :components
                ((:file "json-schema"))))
  :perform (test-op (op c) (symbol-call :rove :run c)))
