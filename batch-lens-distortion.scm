; =============================================================
; batch-lens-distortion.scm  —  GIMP 3.0+ Script-Fu
; =============================================================

(define (process-one-image input-path output-path
                            barrel edge zoom shift-x shift-y brighten)

  (script-fu-use-v3)

  (let* ((image    (gimp-file-load RUN-NONINTERACTIVE input-path))
         (drawable (vector-ref (gimp-image-get-layers image) 0)))

    ; Apply lens distortion via GEGL in one destructive step
    (gimp-drawable-merge-new-filter
      drawable
      "gegl:lens-distortion"
      0
      LAYER-MODE-REPLACE
      1.0
      "main"     barrel
      "edge"     edge
      "zoom"     zoom
      "x_shift"  shift-x
      "y_shift"  shift-y
      "brighten" brighten)

    (gimp-image-flatten image)

    ; Export — GIMP 3.0 renamed file-jpeg-save → file-jpeg-export
    ; Uses #: named-argument syntax, no drawable parameter needed
    (file-jpeg-export
      #:run-mode RUN-NONINTERACTIVE
      #:image    image
      #:file     output-path
      #:options  -1
      #:quality  0.92)

    (gimp-image-delete image)))
