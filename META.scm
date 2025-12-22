;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;;; META.scm — sparkle-ssg

(define-module (sparkle-ssg meta)
  #:export (architecture-decisions development-practices design-rationale components))

;; ═══════════════════════════════════════════════════════════════════════════════
;; ARCHITECTURE DECISION RECORDS
;; ═══════════════════════════════════════════════════════════════════════════════

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
     (consequences . ("Prevents command injection" "Path traversal protection" "Safe CLI wrapping")))

    (adr-004
     (title . "Deno Runtime")
     (status . "accepted")
     (date . "2025-12-22")
     (context . "Need secure JavaScript runtime for adapter execution")
     (decision . "Use Deno with explicit permissions model")
     (consequences . ("Fine-grained permissions" "TypeScript support" "Secure by default")))

    (adr-005
     (title . "Hub-Satellite Architecture")
     (status . "accepted")
     (date . "2025-12-22")
     (context . "Need to maintain consistency with poly-ssg-mcp hub")
     (decision . "Satellite implementation synchronized from hub")
     (consequences . ("Single source of truth" "Automated sync" "Consistent adapters")))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; DEVELOPMENT PRACTICES
;; ═══════════════════════════════════════════════════════════════════════════════

(define development-practices
  '((code-style
     (languages . ("JavaScript" "Scheme"))
     (formatter . "deno fmt")
     (linter . "deno lint"))

    (security
     (sast . "CodeQL")
     (credentials . "env vars only")
     (input-validation . "required")
     (dependency-scanning . "Dependabot"))

    (testing
     (framework . "Deno.test")
     (coverage-minimum . 70)
     (types . ("unit" "integration" "security")))

    (versioning
     (scheme . "SemVer 2.0.0"))

    (ci-cd
     (platform . "GitHub Actions")
     (pinning . "SHA-pinned")
     (checks . ("lint" "test" "security" "build")))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; DESIGN RATIONALE
;; ═══════════════════════════════════════════════════════════════════════════════

(define design-rationale
  '((why-rsr "RSR ensures consistency, security, and maintainability.")
    (why-mcp "MCP provides unified tool interface for AI assistants.")
    (why-adapters "Adapters allow language-agnostic control of diverse SSG tools.")
    (why-deno "Deno provides security-first runtime with TypeScript support.")
    (why-satellite "Satellite pattern enables independent deployment while maintaining hub consistency.")))

;; ═══════════════════════════════════════════════════════════════════════════════
;; COMPONENT MANIFEST (44/44)
;; ═══════════════════════════════════════════════════════════════════════════════

(define components
  '((total . 44)
    (complete . 44)

    (categories
     ((core-engine . 4)
      (build-system . 4)
      (adapters . 28)
      (testing . 4)
      (documentation . 4)))))
