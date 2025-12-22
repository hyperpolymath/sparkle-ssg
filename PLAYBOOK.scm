;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;;; PLAYBOOK.scm — sparkle-ssg
;;; Development playbook and operational procedures

(define-module (sparkle-ssg playbook)
  #:export (workflows procedures runbooks escalation))

;; ═══════════════════════════════════════════════════════════════════════════════
;; DEVELOPMENT WORKFLOWS
;; ═══════════════════════════════════════════════════════════════════════════════

(define workflows
  '((feature-development
     (description . "Adding new SSG adapter or feature")
     (steps
      (("Create branch" . "git checkout -b feature/adapter-name")
       ("Generate adapter" . "just generate-adapter name language ssg")
       ("Implement tools" . "Edit adapters/name.js")
       ("Add validation" . "Import from validation.js")
       ("Write tests" . "Create tests/name.test.js")
       ("Run checks" . "just check")
       ("Run tests" . "just test")
       ("Commit" . "git commit -m 'feat: add name adapter'")
       ("Push" . "git push -u origin feature/adapter-name")
       ("Create PR" . "gh pr create"))))

    (bug-fix
     (description . "Fixing issues in existing adapters")
     (steps
      (("Create branch" . "git checkout -b fix/issue-description")
       ("Reproduce issue" . "Write failing test")
       ("Fix implementation" . "Edit adapter code")
       ("Verify fix" . "just test")
       ("Security check" . "just security-check")
       ("Commit" . "git commit -m 'fix: description'")
       ("Push and PR" . "git push && gh pr create"))))

    (security-patch
     (description . "Addressing security vulnerabilities")
     (priority . "critical")
     (steps
      (("Create private branch" . "git checkout -b security/cve-id")
       ("Assess impact" . "Review affected adapters")
       ("Apply fix" . "Update validation.js or affected adapters")
       ("Run security scan" . "just security-check")
       ("Run full test suite" . "just test-all")
       ("Create security advisory" . "Use GitHub Security Advisories")
       ("Coordinate disclosure" . "Follow SECURITY.md timeline"))))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; OPERATIONAL PROCEDURES
;; ═══════════════════════════════════════════════════════════════════════════════

(define procedures
  '((adapter-sync
     (description . "Synchronizing adapters from poly-ssg-mcp hub")
     (frequency . "weekly")
     (steps
      (("Pull latest hub" . "cd ../poly-ssg-mcp && git pull")
       ("Run sync script" . "just sync-adapters")
       ("Verify adapters" . "just build-adapters")
       ("Run tests" . "just test")
       ("Commit if changed" . "git add adapters/ && git commit -m 'chore: sync adapters'"))))

    (release
     (description . "Creating a new release")
     (steps
      (("Update version" . "just release-prep X.Y.Z")
       ("Update STATE.scm" . "Bump version and update completion")
       ("Update CHANGELOG" . "Document changes")
       ("Run full suite" . "just test-all")
       ("Create tag" . "git tag vX.Y.Z")
       ("Push tag" . "git push --tags")
       ("Create release" . "gh release create vX.Y.Z"))))

    (dependency-update
     (description . "Updating dependencies")
     (frequency . "weekly")
     (steps
      (("Review Dependabot PRs" . "Check GitHub")
       ("Test each update" . "Checkout PR branch, run tests")
       ("Merge if passing" . "gh pr merge")
       ("Update lockfiles" . "Commit any lockfile changes"))))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; RUNBOOKS
;; ═══════════════════════════════════════════════════════════════════════════════

(define runbooks
  '((ci-failure
     (description . "Handling CI/CD pipeline failures")
     (symptoms . ("Red CI status" "Failed checks" "Blocked PRs"))
     (diagnosis
      (("Check workflow logs" . "gh run view --log-failed")
       ("Identify failing step" . "Look for first error")
       ("Check recent changes" . "git log --oneline -10")))
     (resolution
      (("Fix code issue" . "If test/lint failure, fix code")
       ("Retry flaky test" . "gh run rerun --failed")
       ("Check GitHub status" . "If infra issue, wait and retry"))))

    (adapter-failure
     (description . "SSG adapter not working")
     (symptoms . ("Connection failure" "Command errors" "Unexpected output"))
     (diagnosis
      (("Check SSG installed" . "Run SSG binary directly")
       ("Check version" . "Compare with adapter expectations")
       ("Check permissions" . "Verify Deno permissions")))
     (resolution
      (("Install SSG" . "Follow SSG installation docs")
       ("Update adapter" . "Adjust for SSG version changes")
       ("Grant permissions" . "Add required Deno flags"))))

    (security-incident
     (description . "Responding to security vulnerabilities")
     (priority . "critical")
     (steps
      (("Assess severity" . "Review vulnerability report")
       ("Notify maintainers" . "Private communication")
       ("Develop fix" . "Create security branch")
       ("Test fix" . "Run security tests")
       ("Coordinate disclosure" . "Follow SECURITY.md")
       ("Release patch" . "Expedited release process"))))))

;; ═══════════════════════════════════════════════════════════════════════════════
;; ESCALATION MATRIX
;; ═══════════════════════════════════════════════════════════════════════════════

(define escalation
  '((levels
     ((p1 (name . "Critical")
          (response-time . "1 hour")
          (examples . ("Security vulnerability" "Complete service outage")))
      (p2 (name . "High")
          (response-time . "4 hours")
          (examples . ("Adapter broken" "CI completely failing")))
      (p3 (name . "Medium")
          (response-time . "24 hours")
          (examples . ("Non-critical bug" "Documentation issue")))
      (p4 (name . "Low")
          (response-time . "1 week")
          (examples . ("Enhancement request" "Style improvements")))))

    (contacts
     ((security . "GitHub Security Advisories")
      (general . "GitHub Issues")
      (urgent . "GitHub Discussions - Urgent label")))))
