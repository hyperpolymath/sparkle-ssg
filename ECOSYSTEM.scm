;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm — sparkle-ssg

(ecosystem
  (version "2.0.0")
  (name "sparkle-ssg")
  (type "satellite")
  (purpose "Unified MCP adapters for 28 static site generators")

  ;; ═══════════════════════════════════════════════════════════════════════════
  ;; POSITION IN ECOSYSTEM
  ;; ═══════════════════════════════════════════════════════════════════════════

  (position-in-ecosystem
    "Sparkle-SSG is a satellite implementation in the hyperpolymath ecosystem.
     It provides MCP-compatible adapters for 28 static site generators across
     12+ programming languages. Synchronized from the poly-ssg-mcp hub.
     Follows RSR (Rhodium Standard Repository) guidelines for Gold compliance.")

  ;; ═══════════════════════════════════════════════════════════════════════════
  ;; RELATED PROJECTS
  ;; ═══════════════════════════════════════════════════════════════════════════

  (related-projects
    (project
      (name "poly-ssg-mcp")
      (url "https://github.com/hyperpolymath/poly-ssg-mcp")
      (relationship "hub")
      (description "Unified MCP server for 28 SSGs - provides adapter interface")
      (differentiation
        "poly-ssg-mcp = Hub MCP server with all SSG adapters
         sparkle-ssg = Satellite implementation synchronized from hub"))

    (project
      (name "rhodium-standard-repositories")
      (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
      (relationship "standard")
      (description "RSR compliance guidelines and templates"))

    (project
      (name "noteg-ssg")
      (url "https://github.com/hyperpolymath/noteg-ssg")
      (relationship "sibling")
      (description "Note G SSG implementation with Ada/SPARK engine")))

  ;; ═══════════════════════════════════════════════════════════════════════════
  ;; WHAT THIS IS
  ;; ═══════════════════════════════════════════════════════════════════════════

  (what-this-is
    "Sparkle-SSG provides:
     - 28 SSG adapters for MCP integration
     - Security-hardened input validation
     - Deno-based runtime with explicit permissions
     - Justfile/Mustfile build system
     - Comprehensive test suite
     - 6 SCM files for project governance")

  ;; ═══════════════════════════════════════════════════════════════════════════
  ;; WHAT THIS IS NOT
  ;; ═══════════════════════════════════════════════════════════════════════════

  (what-this-is-not
    "- NOT a standalone SSG implementation
     - NOT exempt from RSR compliance
     - NOT a replacement for poly-ssg-mcp hub
     - NOT a content management system
     - NOT tied to any specific hosting platform")

  ;; ═══════════════════════════════════════════════════════════════════════════
  ;; LANGUAGE COVERAGE
  ;; ═══════════════════════════════════════════════════════════════════════════

  (languages-covered
    ((rust . 3)
     (haskell . 2)
     (elixir . 3)
     (julia . 3)
     (clojure . 3)
     (racket . 2)
     (scala . 2)
     (fsharp . 1)
     (kotlin . 1)
     (nim . 1)
     (ocaml . 1)
     (crystal . 1)
     (d . 1)
     (swift . 1)
     (tcl . 1)
     (erlang . 1)
     (common-lisp . 1)))

  ;; ═══════════════════════════════════════════════════════════════════════════
  ;; COMPLIANCE
  ;; ═══════════════════════════════════════════════════════════════════════════

  (compliance
    ((rsr . "Gold")
     (spdx . "all files")
     (codeql . "enabled")
     (dependabot . "enabled")
     (signed-commits . "required"))))
