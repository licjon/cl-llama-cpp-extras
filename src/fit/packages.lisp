(defpackage #:cl-llama-cpp-extras/fit
  (:use #:cl)
  (:export
   ;; Conditions
   #:fit-error
   #:fit-error-path
   ;; Data structures
   #:fit-result
   #:fit-result-status
   #:fit-result-n-gpu-layers
   #:fit-result-n-ctx
   #:fit-result-tensor-split
   ;; API
   #:fit-params
   #:fit-print
   #:memory-breakdown-print))
