;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm — sparkle-ssg

(ecosystem
  (version "1.0.0")
  (name "sparkle-ssg")
  (type "satellite")
  (purpose "Unified MCP adapters for 28 static site generators")

  (position-in-ecosystem
    "Satellite implementation in hyperpolymath ecosystem providing SSG adapters via MCP.
     Synchronized from poly-ssg-mcp hub. Follows RSR guidelines.")

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
      (description "RSR compliance guidelines and templates")))

  (what-this-is
    "Sparkle-SSG provides MCP adapters for 28 static site generators across
     multiple programming languages (Rust, Haskell, Elixir, Julia, etc.)")

  (what-this-is-not
    "- NOT a standalone SSG implementation
     - NOT exempt from RSR compliance
     - NOT a replacement for poly-ssg-mcp hub"))
