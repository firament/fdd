# Configuration settings
> Last updated 2020-01-17 10:28:38


## VS Code workspace - dotnet core
```jsonc

```

## VS Code workspace - Ruby
```jsonc
	//
	// RUBY
	"ruby.useBundler": false,
	"ruby.pathToBundler": "bundle",
	// "/10-Base/rbenv-root/shims/bundler" | /10-Base/rbenv-root/versions/2.1.5/bin/bundler | "/usr/bin/ruby"
	"ruby.interpreter.commandPath": "ruby",
	// "/10-Base/rbenv-root/versions/2.1.5/bin/ruby" | "/10-Base/rbenv-root/shims/ruby"
	"ruby.codeCompletion": "rcodetools",
	"ruby.format": "rufo",
	"ruby.intellisense": "rubyLocate",
	"ruby.useLanguageServer": true,
	"ruby.lint": {
		"rubocop": {
			"lint": true,
			"rails": true
		}
	},
	"solargraph.logLevel": "debug",
	"solargraph.useBundler": false,
	"solargraph.bundlerPath": "bundle",
	// "/usr/local/bin/bundler" | "/10-Base/rbenv-root/shims/bundler"
	"solargraph.commandPath": "/10-Base/rbenv-root/versions/2.7.0/bin/solargraph",
	// "/usr/local/bin/solargraph"
	"files.watcherExclude": {
		"**/vendor/bundle/**": true
	},
	"solargraph.checkGemVersion": false,
```

## VS Code workspace - GO Lang
```jsonc
    //
    // GO LANG
    "go.inferGopath": false,
    "go.goroot": "/10-Base/go",
    "go.toolsGopath": "/10-Base/go-tools",
    "go.gopath": "/10-Base/go-package-lib:/YOUR/PROJECT/PATH",
    // Environment variables that will passed to the processes that run the Go tools (e.g. CGO_CFLAGS)
    "go.toolsEnvVars": {
        "GOPATH": "/10-Base/go-package-lib:/YOUR/PROJECT/PATH"
    },
    "[go]": {
        "editor.insertSpaces": true,
        "editor.wordWrap": "off",
        "editor.formatOnSave": true,
        "editor.tabSize": 4,
    },
    // Use gotype on the file currently being edited and report any semantic or syntactic errors found after configured delay.
    "go.liveErrors": {
        "enabled": true,
        "delay": 500
    },
    //
    // FORMAT
    //
    // Pick 'gofmt', 'goimports' or 'goreturns' to run on format.
    "go.formatTool": "goimports",
    // Flags to pass to format tool (e.g. ['-s'])
    "go.formatFlags": [],
    //
    // LINT
    //
    // Specifies Lint tool name.
    "go.lintTool": "gometalinter",
    // Lints code on file save using the configured Lint tool. Options are 'workspace', 'package or 'off'.
    "go.lintOnSave": "package",
    // Flags to pass to Lint tool (e.g. ["-min_confidence=.8"])
    "go.lintFlags": [],
    //
    // VET
    //
    // Vets code on file save using 'go tool vet'. Options are 'workspace', 'package or 'off'.
    "go.vetOnSave": "package",
    // Flags to pass to `go tool vet` (e.g. ['-all', '-shadow'])
    "go.vetFlags": [],
    //
    // BUILD
    //
    // Enable gocode's autobuild feature
    "go.gocodeAutoBuild": false,
    // Flags to `go build`/`go test` used during build-on-save or running tests. (e.g. ['-ldflags="-s"'])
    "go.buildFlags": [],
    // Compiles code on file save using 'go build -i' or 'go test -c -i'. Options are 'workspace', 'package or 'off'.
    "go.buildOnSave": "package",
    //
    // DOC
    //
    // Pick 'godoc' or 'gogetdoc' to get documentation. In Go 1.5, godoc is used regardless of the choice here.
    "go.docsTool": "godoc",
    //
    // GENERAL
    //
    "go.coverOnTestPackage": false,
    "go.enableCodeLens": {
        "references": true,
        "runtest": false
    },
    // If go, use standard Go package lookup rules for completions. If gb, use gb-specific lookup rules for completions
    "go.gocodePackageLookupMode": "go",
    // Folder names (not paths) to ignore while using Go to Symbol in Workspace feature
    "go.gotoSymbol.ignoreFolders": [],
    // If false, the import statements will be excluded while using the Go to Symbol in File feature
    "go.gotoSymbol.includeImports": false,
    "go.gotoSymbol.includeGoroot": true,
    // Complete functions with their parameter signature, including the variable types
    "go.useCodeSnippetsOnFunctionSuggest": false,
    // Complete functions with their parameter signature, excluding the variable types
    "go.useCodeSnippetsOnFunctionSuggestWithoutType": false,
```
