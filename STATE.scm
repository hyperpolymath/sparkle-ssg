;;; STATE.scm — sparkle-ssg
;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

(define metadata
  '((version . "0.1.1") (updated . "2025-12-17") (project . "sparkle-ssg")))

(define current-position
  '((phase . "v0.1 - Security Hardening")
    (overall-completion . 40)
    (components
     ((rsr-compliance ((status . "complete") (completion . 100)))
      (adapters ((status . "complete") (completion . 100) (count . 28)))
      (security-hardening ((status . "in-progress") (completion . 50)))
      (documentation ((status . "pending") (completion . 25)))
      (testing ((status . "pending") (completion . 0)))))))

(define blockers-and-issues
  '((critical ())
    (high-priority ())))

(define critical-next-actions
  '((immediate
     (("Add input validation to adapters" . high)
      ("Complete SECURITY.md" . high)))
    (this-week
     (("Add adapter tests" . medium)
      ("Populate README.adoc" . medium)))))

(define session-history
  '((snapshots
     ((date . "2025-12-15") (session . "initial") (notes . "SCM files added"))
     ((date . "2025-12-17") (session . "security-review") (notes . "SCM security audit, input validation")))))

(define state-summary
  '((project . "sparkle-ssg") (completion . 40) (blockers . 0) (updated . "2025-12-17")))
