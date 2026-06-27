(in-package #:cl-llama-cpp-extras/json-schema)

(defun %build-shim-if-needed ()
  "Build the JSON Schema shim .so if it is missing or older than libllama-common."
  (let* ((extras-dir (asdf:system-source-directory "cl-llama-cpp-extras/json-schema"))
         (llama-dir  (asdf:system-source-directory "cl-llama-cpp"))
         (build-dir  (merge-pathnames "llama.cpp/build/bin/" llama-dir))
         (shim-so    (merge-pathnames "libllama-json-schema-shim.so" build-dir))
         (common-so  (merge-pathnames "libllama-common.so" build-dir))
         (shim-src   (merge-pathnames "shim/json-schema-shim.cpp" extras-dir)))
    (when (and (probe-file common-so)
               (probe-file shim-src)
               (or (not (probe-file shim-so))
                   (> (file-write-date common-so) (file-write-date shim-so))
                   (> (file-write-date shim-src) (file-write-date shim-so))))
      (format *error-output* "~&; Building libllama-json-schema-shim.so...~%")
      (let ((makefile-dir (merge-pathnames "shim/" extras-dir)))
        (multiple-value-bind (output error-output exit-code)
            (uiop:run-program
             (list "make" "-C" (namestring makefile-dir)
                   (format nil "LLAMA_CPP_DIR=~A"
                           (namestring (merge-pathnames "llama.cpp/" llama-dir))))
             :output :string :error-output :string :ignore-error-status t)
          (declare (ignore output))
          (unless (zerop exit-code)
            (error "Failed to build JSON Schema shim (exit ~D):~%~A"
                   exit-code error-output))
          (format *error-output* "; Done.~%"))))))

(%build-shim-if-needed)

(cffi:define-foreign-library libllama-json-schema-shim
  (:unix (:or "libllama-json-schema-shim.so"))
  (:darwin (:or "libllama-json-schema-shim.dylib"))
  (t (:default "libllama-json-schema-shim")))

(cffi:use-foreign-library libllama-json-schema-shim)
