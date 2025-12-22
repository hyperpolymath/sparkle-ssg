;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;;; NEUROSYM.scm — sparkle-ssg
;;; Neurosymbolic reasoning and semantic specifications

(define-module (sparkle-ssg neurosym)
  #:export (ontology semantics reasoning constraints))

;; ═══════════════════════════════════════════════════════════════════════════════
;; DOMAIN ONTOLOGY
;; ═══════════════════════════════════════════════════════════════════════════════

(define ontology
  '((concepts
     ((static-site-generator
       (definition . "Software that generates static HTML from source files")
       (properties . ("language" "template-engine" "content-format" "build-system"))
       (relationships . ("generates" "uses" "extends")))

      (adapter
       (definition . "Interface layer between MCP and SSG CLI")
       (properties . ("name" "language" "ssg" "tools"))
       (relationships . ("wraps" "exposes" "validates")))

      (mcp-tool
       (definition . "Function exposed via Model Context Protocol")
       (properties . ("name" "description" "input-schema" "execute"))
       (relationships . ("belongs-to" "invokes" "returns")))

      (validation
       (definition . "Security check on inputs before execution")
       (properties . ("type" "pattern" "constraint"))
       (relationships . ("protects" "validates" "rejects")))))

    (taxonomy
     ((ssg-by-language
       (rust . ("zola" "cobalt" "mdbook"))
       (haskell . ("hakyll" "ema"))
       (elixir . ("serum" "nimble-publisher" "tableau"))
       (julia . ("franklin" "documenter" "staticwebpages"))
       (clojure . ("cryogen" "babashka" "perun"))
       (racket . ("frog" "pollen"))
       (scala . ("laika" "scalatex"))
       (other . ("fornax" "orchid" "nimrod" "yocaml" "marmot" "reggae" "publish" "wub" "zotonic" "coleslaw")))

      (tool-by-action
       (initialization . ("init" "new" "create"))
       (building . ("build" "compile" "generate"))
       (serving . ("serve" "dev" "watch"))
       (validation . ("check" "validate" "lint"))
       (information . ("version" "help" "info")))))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; SEMANTIC MAPPINGS
;; ═══════════════════════════════════════════════════════════════════════════════

(define semantics
  '((tool-semantics
     (description . "Meaning of common SSG operations")
     (mappings
      ((init
        (meaning . "Create new site project structure")
        (inputs . ("path" "template" "force"))
        (effects . ("creates-directory" "generates-config" "scaffolds-content")))

       (build
        (meaning . "Transform source files to static output")
        (inputs . ("path" "output-dir" "base-url" "drafts"))
        (effects . ("reads-source" "processes-templates" "writes-html")))

       (serve
        (meaning . "Start local development server with live reload")
        (inputs . ("path" "port" "interface" "drafts"))
        (effects . ("binds-port" "watches-files" "serves-http")))

       (check
        (meaning . "Validate site configuration and content")
        (inputs . ("path" "strict"))
        (effects . ("reads-config" "validates-links" "reports-errors"))))))

    (error-semantics
     (description . "Meaning of common error conditions")
     (mappings
      ((path-traversal
        (meaning . "Attempt to access files outside allowed scope")
        (cause . "Malicious or malformed path input")
        (response . "Reject with 'Invalid path' error"))

       (command-injection
        (meaning . "Attempt to execute arbitrary commands")
        (cause . "Shell metacharacters in input")
        (response . "Reject with validation error"))

       (binary-not-found
        (meaning . "SSG binary not installed or not in PATH")
        (cause . "Missing dependency")
        (response . "Return connection failure"))))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; REASONING RULES
;; ═══════════════════════════════════════════════════════════════════════════════

(define reasoning
  '((inference-rules
     (description . "Rules for deriving knowledge about SSGs")
     (rules
      ((rule-ssg-language
        (if . "adapter.language = X")
        (then . "adapter requires X runtime"))

       (rule-tool-safety
        (if . "tool uses validation.js")
        (then . "tool is protected against injection"))

       (rule-adapter-connection
        (if . "adapter.connect() returns true")
        (then . "SSG binary is available and functional"))

       (rule-build-dependencies
        (if . "tool = build AND path = P")
        (then . "requires read access to P and write access to output")))))

    (decision-rules
     (description . "Rules for selecting SSGs")
     (rules
      ((select-by-performance
        (if . "priority = speed")
        (prefer . ("zola" "cobalt" "mdbook"))
        (reason . "Rust SSGs are typically fastest"))

       (select-by-features
        (if . "need = academic-publishing")
        (prefer . ("hakyll" "franklin" "documenter"))
        (reason . "Strong math/science support"))

       (select-by-ecosystem
        (if . "existing-lang = elixir")
        (prefer . ("serum" "nimble-publisher" "tableau"))
        (reason . "Same language ecosystem"))))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; CONSTRAINTS
;; ═══════════════════════════════════════════════════════════════════════════════

(define constraints
  '((security-constraints
     (description . "Invariants that must always hold")
     (invariants
      ((no-shell-expansion
        (constraint . "Arguments never passed through shell")
        (enforcement . "Deno.Command with args array"))

       (path-validation
        (constraint . "All paths validated before use")
        (enforcement . "isValidPath() called on all path inputs"))

       (no-arbitrary-code
        (constraint . "Cannot execute arbitrary user code")
        (enforcement . "Only predefined SSG commands allowed")))))

    (correctness-constraints
     (description . "Constraints for correct operation")
     (invariants
      ((adapter-contract
        (constraint . "All adapters implement standard interface")
        (interface . ("name" "language" "tools" "connect" "disconnect" "isConnected")))

       (tool-contract
        (constraint . "All tools have required schema")
        (schema . ("name" "description" "inputSchema" "execute")))

       (validation-contract
        (constraint . "Validation functions return boolean or null")
        (returns . ("true" "false" "null"))))))

    (performance-constraints
     (description . "Performance expectations")
     (limits
      ((path-length . 4096)
       (argument-length . 1024)
       (url-length . 2048)
       (timeout-ms . 60000))))))
