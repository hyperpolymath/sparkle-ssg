;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;;; AGENTIC.scm — sparkle-ssg
;;; AI agent integration and MCP tool specifications

(define-module (sparkle-ssg agentic)
  #:export (mcp-tools agent-capabilities integration-patterns hooks))

;; ═══════════════════════════════════════════════════════════════════════════════
;; MCP TOOL SPECIFICATIONS
;; ═══════════════════════════════════════════════════════════════════════════════

(define mcp-tools
  '((adapter-tools
     (description . "Tools exposed by SSG adapters via MCP")
     (pattern . "{ssg}_{action}")
     (common-actions
      (("init" . "Initialize new site")
       ("build" . "Build site to output directory")
       ("serve" . "Start development server")
       ("check" . "Validate site configuration")
       ("version" . "Get SSG version")))
     (examples
      (("zola_build" . "Build Zola site")
       ("hakyll_serve" . "Start Hakyll dev server")
       ("mdbook_init" . "Initialize mdBook project"))))

    (validation-tools
     (description . "Input validation utilities for secure execution")
     (functions
      (("isValidPath" . "Validate filesystem paths")
       ("isValidArgument" . "Validate command arguments")
       ("isValidUrl" . "Validate URL inputs")
       ("isValidPort" . "Validate port numbers")
       ("isValidInterface" . "Validate network interfaces")
       ("sanitizePath" . "Normalize and validate paths")
       ("safeRunCommand" . "Execute commands with validation"))))

    (meta-tools
     (description . "Tools for managing adapters")
     (functions
      (("listAdapters" . "Get list of available adapters")
       ("getAdapter" . "Load specific adapter by name")
       ("adapterCount" . "Get total adapter count")
       ("metadata" . "Get sparkle-ssg metadata"))))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; AGENT CAPABILITIES
;; ═══════════════════════════════════════════════════════════════════════════════

(define agent-capabilities
  '((site-generation
     (description . "Agents can create and build static sites")
     (workflow
      (("Select SSG" . "Choose appropriate generator for project")
       ("Initialize" . "Create new site structure")
       ("Configure" . "Set up site configuration")
       ("Add content" . "Create pages and posts")
       ("Build" . "Generate static output")
       ("Serve" . "Preview locally")))
     (security-constraints
      (("Path validation" . "All paths validated before use")
       ("No shell expansion" . "Arguments passed directly, not through shell")
       ("Sandboxed execution" . "Limited filesystem access"))))

    (multi-ssg-orchestration
     (description . "Agents can work with multiple SSGs")
     (use-cases
      (("Migration" . "Convert site from one SSG to another")
       ("Comparison" . "Build same content with different SSGs")
       ("Aggregation" . "Combine outputs from multiple SSGs")))
     (patterns
      (("Sequential" . "One SSG at a time")
       ("Parallel" . "Multiple SSGs concurrently")
       ("Pipeline" . "Chain SSG operations"))))

    (content-aware
     (description . "Agents understand SSG content patterns")
     (formats
      (("Markdown" . "Standard content format")
       ("YAML frontmatter" . "Metadata in content files")
       ("Templates" . "SSG-specific template syntax")
       ("Configuration" . "Site config files"))))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; INTEGRATION PATTERNS
;; ═══════════════════════════════════════════════════════════════════════════════

(define integration-patterns
  '((mcp-server
     (description . "Running as MCP server for AI tools")
     (protocol . "Model Context Protocol")
     (transport . ("stdio" "http"))
     (capabilities . ("tools" "resources" "prompts")))

    (direct-import
     (description . "Importing adapters directly in Deno/Node")
     (example . "import { getAdapter } from '@hyperpolymath/sparkle-ssg'"))

    (cli-wrapper
     (description . "Command-line interface for manual use")
     (commands
      (("sparkle list" . "List available adapters")
       ("sparkle run {adapter} {tool} [args]" . "Run adapter tool")
       ("sparkle check" . "Validate all adapters"))))

    (hub-satellite
     (description . "Relationship with poly-ssg-mcp hub")
     (hub . "poly-ssg-mcp")
     (sync-direction . "hub -> satellite")
     (frequency . "weekly"))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; HOOKS CONFIGURATION
;; ═══════════════════════════════════════════════════════════════════════════════

(define hooks
  '((pre-execution
     (description . "Hooks before command execution")
     (available
      (("validate-inputs" . "Validate all inputs before running")
       ("check-permissions" . "Verify Deno permissions")
       ("log-command" . "Log command for audit"))))

    (post-execution
     (description . "Hooks after command execution")
     (available
      (("capture-output" . "Store command output")
       ("check-errors" . "Analyze stderr for issues")
       ("notify-completion" . "Signal command complete"))))

    (error-handling
     (description . "Hooks for error conditions")
     (available
      (("retry-transient" . "Retry on transient failures")
       ("fallback-adapter" . "Try alternative SSG")
       ("report-error" . "Log error details"))))

    (security-hooks
     (description . "Security-focused hooks")
     (required . #t)
     (available
      (("validate-path" . "Block path traversal")
       ("validate-args" . "Block injection attempts")
       ("rate-limit" . "Prevent DoS via rapid calls"))))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; COPILOT GUIDELINES (from copilot-instructions.md)
;; ═══════════════════════════════════════════════════════════════════════════════

(define copilot-guidelines
  '((language-preferences
     (preferred . ("Zig" "Rust" "Ada/SPARK" "Haskell" "Elixir" "ReScript" "Chapel" "Julia"))
     (avoid . ("C" "C++" "Python" "JavaScript")))

    (code-review-flags
     (security . ("injection" "traversal" "credentials" "secrets"))
     (performance . ("blocking" "memory-leak" "n+1"))
     (style . ("naming" "documentation" "tests")))

    (testing-requirements
     (minimum-coverage . 70)
     (required-tests . ("unit" "integration" "security")))))
