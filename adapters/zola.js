// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

/**
 * Zola adapter - Fast static site generator in Rust
 * https://www.getzola.org/
 */

import {
  safeRunCommand,
  isValidPath,
  isValidUrl,
  isValidPort,
  isValidInterface,
} from "./validation.js";

export const name = "Zola";
export const language = "Rust";
export const description = "Fast static site generator written in Rust with built-in Sass compilation and syntax highlighting";

let connected = false;
const binaryName = "zola";

async function runCommand(args, cwd = null) {
  return await safeRunCommand(binaryName, args, cwd);
}

export async function connect() {
  try {
    const result = await runCommand(["--version"]);
    connected = result.success;
    return connected;
  } catch {
    connected = false;
    return false;
  }
}

export async function disconnect() {
  connected = false;
}

export function isConnected() {
  return connected;
}

export const tools = [
  {
    name: "zola_init",
    description: "Initialize a new Zola site",
    inputSchema: {
      type: "object",
      properties: {
        path: { type: "string", description: "Path for the new site" },
        force: { type: "boolean", description: "Overwrite existing directory" },
      },
      required: ["path"],
    },
    execute: async ({ path, force }) => {
      if (!isValidPath(path)) {
        return { success: false, stdout: "", stderr: "Invalid path", code: 1 };
      }
      const args = ["init", path];
      if (force) args.push("--force");
      return await runCommand(args);
    },
  },
  {
    name: "zola_build",
    description: "Build the Zola site",
    inputSchema: {
      type: "object",
      properties: {
        path: { type: "string", description: "Path to site root" },
        baseUrl: { type: "string", description: "Base URL for the site" },
        outputDir: { type: "string", description: "Output directory" },
        drafts: { type: "boolean", description: "Include drafts" },
      },
    },
    execute: async ({ path, baseUrl, outputDir, drafts }) => {
      if (path && !isValidPath(path)) {
        return { success: false, stdout: "", stderr: "Invalid path", code: 1 };
      }
      if (baseUrl && !isValidUrl(baseUrl)) {
        return { success: false, stdout: "", stderr: "Invalid base URL", code: 1 };
      }
      if (outputDir && !isValidPath(outputDir)) {
        return { success: false, stdout: "", stderr: "Invalid output directory", code: 1 };
      }
      const args = ["build"];
      if (baseUrl) args.push("--base-url", baseUrl);
      if (outputDir) args.push("--output-dir", outputDir);
      if (drafts) args.push("--drafts");
      return await runCommand(args, path);
    },
  },
  {
    name: "zola_serve",
    description: "Start Zola development server",
    inputSchema: {
      type: "object",
      properties: {
        path: { type: "string", description: "Path to site root" },
        port: { type: "number", description: "Port number (default: 1111)" },
        interface: { type: "string", description: "Interface to bind to" },
        drafts: { type: "boolean", description: "Include drafts" },
        openBrowser: { type: "boolean", description: "Open browser automatically" },
      },
    },
    execute: async ({ path, port, interface: iface, drafts, openBrowser }) => {
      if (path && !isValidPath(path)) {
        return { success: false, stdout: "", stderr: "Invalid path", code: 1 };
      }
      if (port && !isValidPort(port)) {
        return { success: false, stdout: "", stderr: "Invalid port number", code: 1 };
      }
      if (iface && !isValidInterface(iface)) {
        return { success: false, stdout: "", stderr: "Invalid interface", code: 1 };
      }
      const args = ["serve"];
      if (port) args.push("--port", String(port));
      if (iface) args.push("--interface", iface);
      if (drafts) args.push("--drafts");
      if (openBrowser) args.push("--open");
      return await runCommand(args, path);
    },
  },
  {
    name: "zola_check",
    description: "Check the site for errors",
    inputSchema: {
      type: "object",
      properties: {
        path: { type: "string", description: "Path to site root" },
        drafts: { type: "boolean", description: "Include drafts" },
      },
    },
    execute: async ({ path, drafts }) => {
      if (path && !isValidPath(path)) {
        return { success: false, stdout: "", stderr: "Invalid path", code: 1 };
      }
      const args = ["check"];
      if (drafts) args.push("--drafts");
      return await runCommand(args, path);
    },
  },
  {
    name: "zola_version",
    description: "Get Zola version",
    inputSchema: { type: "object", properties: {} },
    execute: async () => await runCommand(["--version"]),
  },
];
