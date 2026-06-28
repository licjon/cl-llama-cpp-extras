(in-package #:cl-llama-cpp-extras/shim)

(defun %build-shim-if-needed ()
  "Build the unified extras shim .so if it is missing or older than
libllama-common.so or any shim source file."
  (let* ((extras-dir (asdf:system-source-directory "cl-llama-cpp-extras/shim"))
         (llama-dir  (asdf:system-source-directory "cl-llama-cpp"))
         (build-dir  (merge-pathnames "llama.cpp/build/bin/" llama-dir))
         (shim-so    (merge-pathnames "libllama-extras-shim.so" build-dir))
         (common-so  (merge-pathnames "libllama-common.so" build-dir))
         (shim-srcs  (directory (merge-pathnames "shim/*.cpp" extras-dir)))
         (old-shim   (merge-pathnames "libllama-json-schema-shim.so" build-dir)))
    (when (and (probe-file common-so)
               shim-srcs
               (or (not (probe-file shim-so))
                   (> (file-write-date common-so) (file-write-date shim-so))
                   (some (lambda (src)
                           (> (file-write-date src) (file-write-date shim-so)))
                         shim-srcs)))
      (format *error-output* "~&; Building libllama-extras-shim.so...~%")
      (let ((makefile-dir (merge-pathnames "shim/" extras-dir)))
        (multiple-value-bind (output error-output exit-code)
            (uiop:run-program
             (list "make" "-C" (namestring makefile-dir)
                   (format nil "LLAMA_CPP_DIR=~A"
                           (namestring (merge-pathnames "llama.cpp/" llama-dir))))
             :output :string :error-output :string :ignore-error-status t)
          (declare (ignore output))
          (unless (zerop exit-code)
            (error "Failed to build extras shim (exit ~D):~%~A"
                   exit-code error-output))
          (format *error-output* "; Done.~%")))
      (when (probe-file old-shim)
        (handler-case (delete-file old-shim)
          (error (c)
            (format *error-output*
                    "; Warning: could not remove old shim ~A: ~A~%"
                    old-shim c)))))))

(%build-shim-if-needed)

(cffi:define-foreign-library libllama-extras-shim
  (:unix (:or "libllama-extras-shim.so"))
  (:darwin (:or "libllama-extras-shim.dylib"))
  (t (:default "libllama-extras-shim")))

(cffi:use-foreign-library libllama-extras-shim)
