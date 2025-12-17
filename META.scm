;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;;; META.scm — sparkle-ssg

(define-module (sparkle-ssg meta)
  #:export (architecture-decisions development-practices design-rationale))

(define architecture-decisions
  '((adr-001
     (title . "RSR Compliance")
     (status . "accepted")
     (date . "2025-12-15")
     (context . "Satellite SSG implementation in the hyperpolymath ecosystem")
     (decision . "Follow Rhodium Standard Repository guidelines")
     (consequences . ("RSR Gold target" "SHA-pinned actions" "SPDX headers" "Multi-platform CI")))
    (adr-002
     (title . "MCP Adapter Architecture")
     (status . "accepted")
     (date . "2025-12-15")
     (context . "Need unified interface for 28 different SSGs")
     (decision . "Use JavaScript adapters wrapping CLI tools via Deno.Command")
     (consequences . ("Consistent API" "Language-agnostic" "Secure command execution")))
    (adr-003
     (title . "Input Sanitization")
     (status . "accepted")
     (date . "2025-12-17")
     (context . "Command injection risk from user-supplied paths")
     (decision . "Validate all inputs before passing to shell commands")
     (consequences . ("Prevents command injection" "Path traversal protection" "Safe CLI wrapping")))))

(define development-practices
  '((code-style (languages . ("JavaScript" "Scheme")) (formatter . "prettier") (linter . "eslint"))
    (security (sast . "CodeQL") (credentials . "env vars only") (input-validation . "required"))
    (testing (coverage-minimum . 70))
    (versioning (scheme . "SemVer 2.0.0"))))

(define design-rationale
  '((why-rsr "RSR ensures consistency, security, and maintainability.")
    (why-mcp "MCP provides unified tool interface for AI assistants.")
    (why-adapters "Adapters allow language-agnostic control of diverse SSG tools.")))
