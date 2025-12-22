// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// mod.js — sparkle-ssg adapter module entry point

/**
 * Sparkle-SSG Adapter Module
 * Unified MCP adapters for 28 static site generators
 *
 * @module @hyperpolymath/sparkle-ssg
 */

// Validation utilities
export * from "./validation.js";

// Import all adapters dynamically
export const adapters = {
  // Clojure
  babashka: () => import("./babashka.js"),
  cryogen: () => import("./cryogen.js"),
  perun: () => import("./perun.js"),

  // Common Lisp
  coleslaw: () => import("./coleslaw.js"),

  // Crystal
  marmot: () => import("./marmot.js"),

  // D
  reggae: () => import("./reggae.js"),

  // Elixir
  nimblePublisher: () => import("./nimble-publisher.js"),
  serum: () => import("./serum.js"),
  tableau: () => import("./tableau.js"),

  // Erlang
  zotonic: () => import("./zotonic.js"),

  // F#
  fornax: () => import("./fornax.js"),

  // Haskell
  ema: () => import("./ema.js"),
  hakyll: () => import("./hakyll.js"),

  // Julia
  documenter: () => import("./documenter.js"),
  franklin: () => import("./franklin.js"),
  staticwebpages: () => import("./staticwebpages.js"),

  // Kotlin
  orchid: () => import("./orchid.js"),

  // Nim
  nimrod: () => import("./nimrod.js"),

  // OCaml
  yocaml: () => import("./yocaml.js"),

  // Racket
  frog: () => import("./frog.js"),
  pollen: () => import("./pollen.js"),

  // Rust
  cobalt: () => import("./cobalt.js"),
  mdbook: () => import("./mdbook.js"),
  zola: () => import("./zola.js"),

  // Scala
  laika: () => import("./laika.js"),
  scalatex: () => import("./scalatex.js"),

  // Swift
  publish: () => import("./publish.js"),

  // Tcl
  wub: () => import("./wub.js"),
};

/**
 * Get adapter by name
 * @param {string} name - Adapter name
 * @returns {Promise<object>} Adapter module
 */
export async function getAdapter(name) {
  const loader = adapters[name];
  if (!loader) {
    throw new Error(`Unknown adapter: ${name}. Available: ${Object.keys(adapters).join(", ")}`);
  }
  return await loader();
}

/**
 * List all available adapters
 * @returns {string[]} Array of adapter names
 */
export function listAdapters() {
  return Object.keys(adapters);
}

/**
 * Get adapter count
 * @returns {number} Number of available adapters
 */
export function adapterCount() {
  return Object.keys(adapters).length;
}

// Export metadata
export const metadata = {
  name: "sparkle-ssg",
  version: "0.2.0",
  description: "Unified MCP adapters for 28 static site generators",
  license: "MIT OR AGPL-3.0-or-later",
  ecosystem: "hyperpolymath",
  hub: "poly-ssg-mcp",
  adapters: listAdapters(),
  count: adapterCount(),
};

// Default export
export default { adapters, getAdapter, listAdapters, adapterCount, metadata };
