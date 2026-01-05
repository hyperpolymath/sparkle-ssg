// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// sparkle-ssg - Static site generator (ReScript)

module Options = {
  type t = {
    input: string,
    output: string,
    minify: bool,
    watch: bool,
  }

  let default: t = {
    input: "pages",
    output: "dist",
    minify: false,
    watch: false,
  }
}

module Compiler = {
  let compile = async (opts: Options.t): int => {
    Js.Console.log(`Compiling ${opts.input} -> ${opts.output}`)
    if opts.minify {
      Js.Console.log("Minification enabled")
    }
    0 // files compiled
  }

  let watch = async (opts: Options.t): unit => {
    Js.Console.log("Watching for changes...")
    let _ = await compile(opts)
  }
}

let name = "sparkle-ssg"
let version = "0.1.0"

let main = async () => {
  Js.Console.log(`${name} v${version}`)
  let opts = Options.default

  if opts.watch {
    await Compiler.watch(opts)
  } else {
    let count = await Compiler.compile(opts)
    Js.Console.log(`Compiled ${count->Belt.Int.toString} files`)
  }
}

let _ = main()
