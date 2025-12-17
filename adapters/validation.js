// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

/**
 * Input validation utilities for SSG adapters
 * Prevents command injection and path traversal attacks
 */

/**
 * Validates a path to prevent path traversal attacks
 * @param {string} path - The path to validate
 * @returns {boolean} - True if path is safe
 */
export function isValidPath(path) {
  if (typeof path !== "string") return false;
  if (path.length === 0) return false;
  if (path.length > 4096) return false; // Reasonable path length limit

  // Reject null bytes (command injection via null byte)
  if (path.includes("\0")) return false;

  // Reject shell metacharacters
  const shellMetachars = /[;&|`$(){}[\]<>!#*?~]/;
  if (shellMetachars.test(path)) return false;

  // Reject paths trying to escape via ..
  const normalized = path.replace(/\\/g, "/");
  const segments = normalized.split("/");
  let depth = 0;
  for (const segment of segments) {
    if (segment === "..") {
      depth--;
      if (depth < 0) return false; // Trying to escape root
    } else if (segment !== "." && segment !== "") {
      depth++;
    }
  }

  return true;
}

/**
 * Validates a string argument to prevent injection
 * @param {string} arg - The argument to validate
 * @returns {boolean} - True if argument is safe
 */
export function isValidArgument(arg) {
  if (typeof arg !== "string") return false;
  if (arg.length > 1024) return false; // Reasonable argument length

  // Reject null bytes
  if (arg.includes("\0")) return false;

  // Reject shell metacharacters that could be dangerous
  const dangerousChars = /[;&|`$(){}[\]<>]/;
  if (dangerousChars.test(arg)) return false;

  return true;
}

/**
 * Validates a URL string
 * @param {string} url - The URL to validate
 * @returns {boolean} - True if URL is safe
 */
export function isValidUrl(url) {
  if (typeof url !== "string") return false;
  if (url.length > 2048) return false;

  try {
    const parsed = new URL(url);
    // Only allow http and https protocols
    return parsed.protocol === "http:" || parsed.protocol === "https:";
  } catch {
    return false;
  }
}

/**
 * Validates a port number
 * @param {number} port - The port to validate
 * @returns {boolean} - True if port is valid
 */
export function isValidPort(port) {
  if (typeof port !== "number") return false;
  return Number.isInteger(port) && port >= 1 && port <= 65535;
}

/**
 * Validates an interface/hostname
 * @param {string} iface - The interface to validate
 * @returns {boolean} - True if interface is safe
 */
export function isValidInterface(iface) {
  if (typeof iface !== "string") return false;
  if (iface.length > 253) return false;

  // Allow localhost, 0.0.0.0, or valid hostnames
  const hostnamePattern = /^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)*$/;
  const ipv4Pattern = /^(\d{1,3}\.){3}\d{1,3}$/;
  const ipv6Pattern = /^[a-fA-F0-9:]+$/;

  return (
    iface === "localhost" ||
    hostnamePattern.test(iface) ||
    ipv4Pattern.test(iface) ||
    ipv6Pattern.test(iface)
  );
}

/**
 * Sanitizes a path by resolving it and checking bounds
 * @param {string} basePath - The base path that must contain the result
 * @param {string} userPath - The user-provided path
 * @returns {string|null} - Sanitized path or null if invalid
 */
export function sanitizePath(basePath, userPath) {
  if (!isValidPath(userPath)) return null;

  // Use Deno's path resolution if available
  try {
    const resolved = userPath.startsWith("/")
      ? userPath
      : `${basePath}/${userPath}`;

    // Normalize the path
    const normalized = resolved
      .replace(/\\/g, "/")
      .replace(/\/+/g, "/")
      .replace(/\/\.$/, "")
      .replace(/\/\.\//g, "/");

    return normalized;
  } catch {
    return null;
  }
}

/**
 * Wraps command execution with input validation
 * @param {string} binary - The binary to execute
 * @param {string[]} args - Command arguments
 * @param {string|null} cwd - Working directory
 * @returns {Promise<object>} - Command result
 */
export async function safeRunCommand(binary, args, cwd = null) {
  // Validate binary name (no path separators allowed)
  if (binary.includes("/") || binary.includes("\\")) {
    return {
      success: false,
      stdout: "",
      stderr: "Invalid binary path",
      code: 1,
    };
  }

  // Validate all arguments
  for (const arg of args) {
    if (!isValidArgument(arg)) {
      return {
        success: false,
        stdout: "",
        stderr: `Invalid argument: ${arg}`,
        code: 1,
      };
    }
  }

  // Validate cwd if provided
  if (cwd !== null && !isValidPath(cwd)) {
    return {
      success: false,
      stdout: "",
      stderr: "Invalid working directory",
      code: 1,
    };
  }

  try {
    const cmd = new Deno.Command(binary, {
      args,
      cwd: cwd || Deno.cwd(),
      stdout: "piped",
      stderr: "piped",
    });

    const output = await cmd.output();
    const decoder = new TextDecoder();

    return {
      success: output.success,
      stdout: decoder.decode(output.stdout),
      stderr: decoder.decode(output.stderr),
      code: output.code,
    };
  } catch (error) {
    return {
      success: false,
      stdout: "",
      stderr: error.message || "Command execution failed",
      code: 1,
    };
  }
}
