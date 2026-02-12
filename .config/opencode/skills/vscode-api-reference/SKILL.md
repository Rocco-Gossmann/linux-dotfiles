---
name: vscode-api-reference
description: this is the entire vscode api reference
---

# VS Code API

**VS Code API** is a set of JavaScript APIs that you can invoke in your Visual Studio Code extension. This page lists all VS Code APIs available to extension authors.

## API namespaces and classes

This listing is compiled from the [vscode.d.ts](https://github.com/microsoft/vscode/blob/main/src/vscode-dts/vscode.d.ts) file from the VS Code repository.

## authentication

Namespace for authentication.

#### Events

onDidChangeSessions: [Event](#Event&lt;T&gt;)<[AuthenticationSessionsChangeEvent](#AuthenticationSessionsChangeEvent)\>

An [Event](#Event) which fires when the authentication sessions of an authentication provider have been added, removed, or changed.

#### Functions

getAccounts(providerId: string): Thenable<readonly [AuthenticationSessionAccountInformation](#AuthenticationSessionAccountInformation)\[\]>

Get all accounts that the user is logged in to for the specified provider. Use this paired with [getSession](#authentication.getSession) in order to get an authentication session for a specific account.

Currently, there are only two authentication providers that are contributed from built in extensions to the editor that implement GitHub and Microsoft authentication: their providerId's are 'github' and 'microsoft'.

Note: Getting accounts does not imply that your extension has access to that account or its authentication sessions. You can verify access to the account by calling [getSession](#authentication.getSession).

| Parameter | Description |
| --- | --- |
| providerId: string | The id of the provider to use |
| Returns | Description |
| Thenable<readonly [AuthenticationSessionAccountInformation](#AuthenticationSessionAccountInformation)\[\]> | A thenable that resolves to a readonly array of authentication accounts. |

getSession(providerId: string, scopeListOrRequest: readonly string\[\] | [AuthenticationWwwAuthenticateRequest](#AuthenticationWwwAuthenticateRequest), options: [AuthenticationGetSessionOptions](#AuthenticationGetSessionOptions) & {createIfNone: true | [AuthenticationGetSessionPresentationOptions](#AuthenticationGetSessionPresentationOptions)}): Thenable<[AuthenticationSession](#AuthenticationSession)\>

Get an authentication session matching the desired scopes or satisfying the WWW-Authenticate request. Rejects if a provider with providerId is not registered, or if the user does not consent to sharing authentication information with the extension. If there are multiple sessions with the same scopes, the user will be shown a quickpick to select which account they would like to use.

Built-in auth providers include:

*   'github' - For GitHub.com
*   'microsoft' For both personal & organizational Microsoft accounts
*   (less common) 'github-enterprise' - for alternative GitHub hostings, GHE.com, GitHub Enterprise Server
*   (less common) 'microsoft-sovereign-cloud' - for alternative Microsoft clouds

| Parameter | Description |
| --- | --- |
| providerId: string | The id of the provider to use |
| scopeListOrRequest: readonly string\[\] \| [AuthenticationWwwAuthenticateRequest](#AuthenticationWwwAuthenticateRequest) | A scope list of permissions requested or a WWW-Authenticate request. These are dependent on the authentication provider. |
| options: [AuthenticationGetSessionOptions](#AuthenticationGetSessionOptions) & {createIfNone: true \| [AuthenticationGetSessionPresentationOptions](#AuthenticationGetSessionPresentationOptions)} | The [AuthenticationGetSessionOptions](#AuthenticationGetSessionOptions) to use |
| Returns | Description |
| Thenable<[AuthenticationSession](#AuthenticationSession)\> | A thenable that resolves to an authentication session |

getSession(providerId: string, scopeListOrRequest: readonly string\[\] | [AuthenticationWwwAuthenticateRequest](#AuthenticationWwwAuthenticateRequest), options: [AuthenticationGetSessionOptions](#AuthenticationGetSessionOptions) & {forceNewSession: true | [AuthenticationGetSessionPresentationOptions](#AuthenticationGetSessionPresentationOptions)}): Thenable<[AuthenticationSession](#AuthenticationSession)\>

Get an authentication session matching the desired scopes or request. Rejects if a provider with providerId is not registered, or if the user does not consent to sharing authentication information with the extension. If there are multiple sessions with the same scopes, the user will be shown a quickpick to select which account they would like to use.

Built-in auth providers include:

*   'github' - For GitHub.com
*   'microsoft' For both personal & organizational Microsoft accounts
*   (less common) 'github-enterprise' - for alternative GitHub hostings, GHE.com, GitHub Enterprise Server
*   (less common) 'microsoft-sovereign-cloud' - for alternative Microsoft clouds

| Parameter | Description |
| --- | --- |
| providerId: string | The id of the provider to use |
| scopeListOrRequest: readonly string\[\] \| [AuthenticationWwwAuthenticateRequest](#AuthenticationWwwAuthenticateRequest) | A scope list of permissions requested or a WWW-Authenticate request. These are dependent on the authentication provider. |
| options: [AuthenticationGetSessionOptions](#AuthenticationGetSessionOptions) & {forceNewSession: true \| [AuthenticationGetSessionPresentationOptions](#AuthenticationGetSessionPresentationOptions)} | The [AuthenticationGetSessionOptions](#AuthenticationGetSessionOptions) to use |
| Returns | Description |
| Thenable<[AuthenticationSession](#AuthenticationSession)\> | A thenable that resolves to an authentication session |

getSession(providerId: string, scopeListOrRequest: readonly string\[\] | [AuthenticationWwwAuthenticateRequest](#AuthenticationWwwAuthenticateRequest), options?: [AuthenticationGetSessionOptions](#AuthenticationGetSessionOptions)): Thenable<[AuthenticationSession](#AuthenticationSession) | undefined\>

Get an authentication session matching the desired scopes or request. Rejects if a provider with providerId is not registered, or if the user does not consent to sharing authentication information with the extension. If there are multiple sessions with the same scopes, the user will be shown a quickpick to select which account they would like to use.

Built-in auth providers include:

*   'github' - For GitHub.com
*   'microsoft' For both personal & organizational Microsoft accounts
*   (less common) 'github-enterprise' - for alternative GitHub hostings, GHE.com, GitHub Enterprise Server
*   (less common) 'microsoft-sovereign-cloud' - for alternative Microsoft clouds

| Parameter | Description |
| --- | --- |
| providerId: string | The id of the provider to use |
| scopeListOrRequest: readonly string\[\] \| [AuthenticationWwwAuthenticateRequest](#AuthenticationWwwAuthenticateRequest) | A scope list of permissions requested or a WWW-Authenticate request. These are dependent on the authentication provider. |
| options?: [AuthenticationGetSessionOptions](#AuthenticationGetSessionOptions) | The [AuthenticationGetSessionOptions](#AuthenticationGetSessionOptions) to use |
| Returns | Description |
| Thenable<[AuthenticationSession](#AuthenticationSession) \| undefined\> | A thenable that resolves to an authentication session or undefined if a silent flow was used and no session was found |

registerAuthenticationProvider(id: string, label: string, provider: [AuthenticationProvider](#AuthenticationProvider), options?: [AuthenticationProviderOptions](#AuthenticationProviderOptions)): [Disposable](#Disposable)

Register an authentication provider.

There can only be one provider per id and an error is being thrown when an id has already been used by another provider. Ids are case-sensitive.

| Parameter | Description |
| --- | --- |
| id: string | The unique identifier of the provider. |
| label: string | The human-readable name of the provider. |
| provider: [AuthenticationProvider](#AuthenticationProvider) | The authentication provider provider. |
| options?: [AuthenticationProviderOptions](#AuthenticationProviderOptions) | Additional options for the provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

## chat

Namespace for chat functionality. Users interact with chat participants by sending messages to them in the chat view. Chat participants can respond with markdown or other types of content via the [ChatResponseStream](#ChatResponseStream).

#### Functions

createChatParticipant(id: string, handler: [ChatRequestHandler](#ChatRequestHandler)): [ChatParticipant](#ChatParticipant)

Create a new [chat participant](#ChatParticipant) instance.

| Parameter | Description |
| --- | --- |
| id: string | A unique identifier for the participant. |
| handler: [ChatRequestHandler](#ChatRequestHandler) | A request handler for the participant. |
| Returns | Description |
| [ChatParticipant](#ChatParticipant) | A new chat participant |

## commands

Namespace for dealing with commands. In short, a command is a function with a unique identifier. The function is sometimes also called _command handler_.

Commands can be added to the editor using the [registerCommand](#commands.registerCommand) and [registerTextEditorCommand](#commands.registerTextEditorCommand) functions. Commands can be executed [manually](#commands.executeCommand) or from a UI gesture. Those are:

*   palette - Use the `commands`\-section in `package.json` to make a command show in the [command palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette).
*   keybinding - Use the `keybindings`\-section in `package.json` to enable [keybindings](https://code.visualstudio.com/docs/getstarted/keybindings#_advanced-customization) for your extension.

Commands from other extensions and from the editor itself are accessible to an extension. However, when invoking an editor command not all argument types are supported.

This is a sample that registers a command handler and adds an entry for that command to the palette. First register a command handler with the identifier `extension.sayHello`.

```
commands.registerCommand('extension.sayHello', () => {
  window.showInformationMessage('Hello World!');
});
```

Second, bind the command identifier to a title under which it will show in the palette (`package.json`).

```
{
  "contributes": {
    "commands": [
      {
        "command": "extension.sayHello",
        "title": "Hello World"
      }
    ]
  }
}
```

#### Functions

executeCommand<T\>(command: string, ...rest: any\[\]): Thenable<T\>

Executes the command denoted by the given command identifier.

*   _Note 1:_ When executing an editor command not all types are allowed to be passed as arguments. Allowed are the primitive types `string`, `boolean`, `number`, `undefined`, and `null`, as well as [Position](#Position), [Range](#Range), [Uri](#Uri) and [Location](#Location).
*   _Note 2:_ There are no restrictions when executing commands that have been contributed by extensions.

| Parameter | Description |
| --- | --- |
| command: string | Identifier of the command to execute. |
| ...rest: any\[\] | Parameters passed to the command function. |
| Returns | Description |
| Thenable<T\> | A thenable that resolves to the returned value of the given command. Returns `undefined` when the command handler function doesn't return anything. |

getCommands(filterInternal?: boolean): Thenable<string\[\]>

Retrieve the list of all available commands. Commands starting with an underscore are treated as internal commands.

| Parameter | Description |
| --- | --- |
| filterInternal?: boolean | Set `true` to not see internal commands (starting with an underscore) |
| Returns | Description |
| Thenable<string\[\]> | Thenable that resolves to a list of command ids. |

registerCommand(command: string, callback: (args: any\[\]) => any, thisArg?: any): [Disposable](#Disposable)

Registers a command that can be invoked via a keyboard shortcut, a menu item, an action, or directly.

Registering a command with an existing command identifier twice will cause an error.

| Parameter | Description |
| --- | --- |
| command: string | A unique identifier for the command. |
| callback: (args: any\[\]) => any | A command handler function. |
| thisArg?: any | The `this` context used when invoking the handler function. |
| Returns | Description |
| [Disposable](#Disposable) | Disposable which unregisters this command on disposal. |

registerTextEditorCommand(command: string, callback: (textEditor: [TextEditor](#TextEditor), edit: [TextEditorEdit](#TextEditorEdit), args: any\[\]) => void, thisArg?: any): [Disposable](#Disposable)

Registers a text editor command that can be invoked via a keyboard shortcut, a menu item, an action, or directly.

Text editor commands are different from ordinary [commands](#commands.registerCommand) as they only execute when there is an active editor when the command is called. Also, the command handler of an editor command has access to the active editor and to an [edit](#TextEditorEdit)\-builder. Note that the edit-builder is only valid while the callback executes.

| Parameter | Description |
| --- | --- |
| command: string | A unique identifier for the command. |
| callback: (textEditor: [TextEditor](#TextEditor), edit: [TextEditorEdit](#TextEditorEdit), args: any\[\]) => void | A command handler function with access to an [editor](#TextEditor) and an [edit](#TextEditorEdit). |
| thisArg?: any | The `this` context used when invoking the handler function. |
| Returns | Description |
| [Disposable](#Disposable) | Disposable which unregisters this command on disposal. |

## comments

#### Functions

createCommentController(id: string, label: string): [CommentController](#CommentController)

Creates a new [comment controller](#CommentController) instance.

| Parameter | Description |
| --- | --- |
| id: string | An `id` for the comment controller. |
| label: string | A human-readable string for the comment controller. |
| Returns | Description |
| [CommentController](#CommentController) | An instance of [comment controller](#CommentController). |

## debug

Namespace for debug functionality.

#### Variables

activeDebugConsole: [DebugConsole](#DebugConsole)

The currently active [debug console](#DebugConsole). If no debug session is active, output sent to the debug console is not shown.

activeDebugSession: [DebugSession](#DebugSession) | undefined

The currently active [debug session](#DebugSession) or `undefined`. The active debug session is the one represented by the debug action floating window or the one currently shown in the drop down menu of the debug action floating window. If no debug session is active, the value is `undefined`.

activeStackItem: [DebugThread](#DebugThread) | [DebugStackFrame](#DebugStackFrame) | undefined

The currently focused thread or stack frame, or `undefined` if no thread or stack is focused. A thread can be focused any time there is an active debug session, while a stack frame can only be focused when a session is paused and the call stack has been retrieved.

breakpoints: readonly [Breakpoint](#Breakpoint)\[\]

List of breakpoints.

#### Events

onDidChangeActiveDebugSession: [Event](#Event&lt;T&gt;)<[DebugSession](#DebugSession) | undefined\>

An [Event](#Event) which fires when the [active debug session](#debug.activeDebugSession) has changed. _Note_ that the event also fires when the active debug session changes to `undefined`.

onDidChangeActiveStackItem: [Event](#Event&lt;T&gt;)<[DebugThread](#DebugThread) | [DebugStackFrame](#DebugStackFrame) | undefined\>

An event which fires when the [debug.activeStackItem](#debug.activeStackItem) has changed.

onDidChangeBreakpoints: [Event](#Event&lt;T&gt;)<[BreakpointsChangeEvent](#BreakpointsChangeEvent)\>

An [Event](#Event) that is emitted when the set of breakpoints is added, removed, or changed.

onDidReceiveDebugSessionCustomEvent: [Event](#Event&lt;T&gt;)<[DebugSessionCustomEvent](#DebugSessionCustomEvent)\>

An [Event](#Event) which fires when a custom DAP event is received from the [debug session](#DebugSession).

onDidStartDebugSession: [Event](#Event&lt;T&gt;)<[DebugSession](#DebugSession)\>

An [Event](#Event) which fires when a new [debug session](#DebugSession) has been started.

onDidTerminateDebugSession: [Event](#Event&lt;T&gt;)<[DebugSession](#DebugSession)\>

An [Event](#Event) which fires when a [debug session](#DebugSession) has terminated.

#### Functions

addBreakpoints(breakpoints: readonly [Breakpoint](#Breakpoint)\[\]): void

Add breakpoints.

| Parameter | Description |
| --- | --- |
| breakpoints: readonly [Breakpoint](#Breakpoint)\[\] | The breakpoints to add. |
| Returns | Description |
| void |     |

asDebugSourceUri(source: [DebugProtocolSource](#DebugProtocolSource), session?: [DebugSession](#DebugSession)): [Uri](#Uri)

Converts a "Source" descriptor object received via the Debug Adapter Protocol into a Uri that can be used to load its contents. If the source descriptor is based on a path, a file Uri is returned. If the source descriptor uses a reference number, a specific debug Uri (scheme 'debug') is constructed that requires a corresponding ContentProvider and a running debug session

If the "Source" descriptor has insufficient information for creating the Uri, an error is thrown.

| Parameter | Description |
| --- | --- |
| source: [DebugProtocolSource](#DebugProtocolSource) | An object conforming to the [Source](https://microsoft.github.io/debug-adapter-protocol/specification#Types_Source) type defined in the Debug Adapter Protocol. |
| session?: [DebugSession](#DebugSession) | An optional debug session that will be used when the source descriptor uses a reference number to load the contents from an active debug session. |
| Returns | Description |
| [Uri](#Uri) | A uri that can be used to load the contents of the source. |

registerDebugAdapterDescriptorFactory(debugType: string, factory: [DebugAdapterDescriptorFactory](#DebugAdapterDescriptorFactory)): [Disposable](#Disposable)

Register a [debug adapter descriptor factory](#DebugAdapterDescriptorFactory) for a specific debug type. An extension is only allowed to register a DebugAdapterDescriptorFactory for the debug type(s) defined by the extension. Otherwise an error is thrown. Registering more than one DebugAdapterDescriptorFactory for a debug type results in an error.

| Parameter | Description |
| --- | --- |
| debugType: string | The debug type for which the factory is registered. |
| factory: [DebugAdapterDescriptorFactory](#DebugAdapterDescriptorFactory) | The [debug adapter descriptor factory](#DebugAdapterDescriptorFactory) to register. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this factory when being disposed. |

registerDebugAdapterTrackerFactory(debugType: string, factory: [DebugAdapterTrackerFactory](#DebugAdapterTrackerFactory)): [Disposable](#Disposable)

Register a debug adapter tracker factory for the given debug type.

| Parameter | Description |
| --- | --- |
| debugType: string | The debug type for which the factory is registered or '\*' for matching all debug types. |
| factory: [DebugAdapterTrackerFactory](#DebugAdapterTrackerFactory) | The [debug adapter tracker factory](#DebugAdapterTrackerFactory) to register. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this factory when being disposed. |

registerDebugConfigurationProvider(debugType: string, provider: [DebugConfigurationProvider](#DebugConfigurationProvider), triggerKind?: [DebugConfigurationProviderTriggerKind](#DebugConfigurationProviderTriggerKind)): [Disposable](#Disposable)

Register a [debug configuration provider](#DebugConfigurationProvider) for a specific debug type. The optional [triggerKind](#DebugConfigurationProviderTriggerKind) can be used to specify when the `provideDebugConfigurations` method of the provider is triggered. Currently two trigger kinds are possible: with the value `Initial` (or if no trigger kind argument is given) the `provideDebugConfigurations` method is used to provide the initial debug configurations to be copied into a newly created launch.json. With the trigger kind `Dynamic` the `provideDebugConfigurations` method is used to dynamically determine debug configurations to be presented to the user (in addition to the static configurations from the launch.json). Please note that the `triggerKind` argument only applies to the `provideDebugConfigurations` method: so the `resolveDebugConfiguration` methods are not affected at all. Registering a single provider with resolve methods for different trigger kinds, results in the same resolve methods called multiple times. More than one provider can be registered for the same type.

| Parameter | Description |
| --- | --- |
| debugType: string | The debug type for which the provider is registered. |
| provider: [DebugConfigurationProvider](#DebugConfigurationProvider) | The [debug configuration provider](#DebugConfigurationProvider) to register. |
| triggerKind?: [DebugConfigurationProviderTriggerKind](#DebugConfigurationProviderTriggerKind) | The [trigger](#DebugConfigurationProviderTriggerKind) for which the 'provideDebugConfiguration' method of the provider is registered. If `triggerKind` is missing, the value `DebugConfigurationProviderTriggerKind.Initial` is assumed. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

removeBreakpoints(breakpoints: readonly [Breakpoint](#Breakpoint)\[\]): void

Remove breakpoints.

| Parameter | Description |
| --- | --- |
| breakpoints: readonly [Breakpoint](#Breakpoint)\[\] | The breakpoints to remove. |
| Returns | Description |
| void |     |

startDebugging(folder: [WorkspaceFolder](#WorkspaceFolder), nameOrConfiguration: string | [DebugConfiguration](#DebugConfiguration), parentSessionOrOptions?: [DebugSession](#DebugSession) | [DebugSessionOptions](#DebugSessionOptions)): Thenable<boolean\>

Start debugging by using either a named launch or named compound configuration, or by directly passing a [DebugConfiguration](#DebugConfiguration). The named configurations are looked up in '.vscode/launch.json' found in the given folder. Before debugging starts, all unsaved files are saved and the launch configurations are brought up-to-date. Folder specific variables used in the configuration (e.g. '${workspaceFolder}') are resolved against the given folder.

| Parameter | Description |
| --- | --- |
| folder: [WorkspaceFolder](#WorkspaceFolder) | The [workspace folder](#WorkspaceFolder) for looking up named configurations and resolving variables or `undefined` for a non-folder setup. |
| nameOrConfiguration: string \| [DebugConfiguration](#DebugConfiguration) | Either the name of a debug or compound configuration or a [DebugConfiguration](#DebugConfiguration) object. |
| parentSessionOrOptions?: [DebugSession](#DebugSession) \| [DebugSessionOptions](#DebugSessionOptions) | Debug session options. When passed a parent [debug session](#DebugSession), assumes options with just this parent session. |
| Returns | Description |
| Thenable<boolean\> | A thenable that resolves when debugging could be successfully started. |

stopDebugging(session?: [DebugSession](#DebugSession)): Thenable<void\>

Stop the given debug session or stop all debug sessions if session is omitted.

| Parameter | Description |
| --- | --- |
| session?: [DebugSession](#DebugSession) | The [debug session](#DebugSession) to stop; if omitted all sessions are stopped. |
| Returns | Description |
| Thenable<void\> | A thenable that resolves when the session(s) have been stopped. |

## env

Namespace describing the environment the editor runs in.

#### Variables

appHost: string

The hosted location of the application On desktop this is 'desktop' In the web this is the specified embedder i.e. 'github.dev', 'codespaces', or 'web' if the embedder does not provide that information

appName: string

The application name of the editor, like 'VS Code'.

appRoot: string

The application root folder from which the editor is running.

_Note_ that the value is the empty string when running in an environment that has no representation of an application root folder.

clipboard: [Clipboard](#Clipboard)

The system clipboard.

isNewAppInstall: boolean

Indicates that this is a fresh install of the application. `true` if within the first day of installation otherwise `false`.

isTelemetryEnabled: boolean

Indicates whether the users has telemetry enabled. Can be observed to determine if the extension should send telemetry.

language: string

Represents the preferred user-language, like `de-CH`, `fr`, or `en-US`.

logLevel: [LogLevel](#LogLevel)

The current log level of the editor.

machineId: string

A unique identifier for the computer.

remoteName: string | undefined

The name of a remote. Defined by extensions, popular samples are `wsl` for the Windows Subsystem for Linux or `ssh-remote` for remotes using a secure shell.

_Note_ that the value is `undefined` when there is no remote extension host but that the value is defined in all extension hosts (local and remote) in case a remote extension host exists. Use [Extension.extensionKind](#Extension.extensionKind) to know if a specific extension runs remote or not.

sessionId: string

A unique identifier for the current session. Changes each time the editor is started.

shell: string

The detected default shell for the extension host, this is overridden by the `terminal.integrated.defaultProfile` setting for the extension host's platform. Note that in environments that do not support a shell the value is the empty string.

uiKind: [UIKind](#UIKind)

The UI kind property indicates from which UI extensions are accessed from. For example, extensions could be accessed from a desktop application or a web browser.

uriScheme: string

The custom uri scheme the editor registers to in the operating system.

#### Events

onDidChangeLogLevel: [Event](#Event&lt;T&gt;)<[LogLevel](#LogLevel)\>

An [Event](#Event) which fires when the log level of the editor changes.

onDidChangeShell: [Event](#Event&lt;T&gt;)<string\>

An [Event](#Event) which fires when the default shell changes. This fires with the new shell path.

onDidChangeTelemetryEnabled: [Event](#Event&lt;T&gt;)<boolean\>

An [Event](#Event) which fires when the user enabled or disables telemetry. `true` if the user has enabled telemetry or `false` if the user has disabled telemetry.

#### Functions

asExternalUri(target: [Uri](#Uri)): Thenable<[Uri](#Uri)\>

Resolves a uri to a form that is accessible externally.

#### `http:` or `https:` scheme

Resolves an _external_ uri, such as a `http:` or `https:` link, from where the extension is running to a uri to the same resource on the client machine.

This is a no-op if the extension is running on the client machine.

If the extension is running remotely, this function automatically establishes a port forwarding tunnel from the local machine to `target` on the remote and returns a local uri to the tunnel. The lifetime of the port forwarding tunnel is managed by the editor and the tunnel can be closed by the user.

_Note_ that uris passed through `openExternal` are automatically resolved and you should not call `asExternalUri` on them.

#### `vscode.env.uriScheme`

Creates a uri that - if opened in a browser (e.g. via `openExternal`) - will result in a registered [UriHandler](#UriHandler) to trigger.

Extensions should not make any assumptions about the resulting uri and should not alter it in any way. Rather, extensions can e.g. use this uri in an authentication flow, by adding the uri as callback query argument to the server to authenticate to.

_Note_ that if the server decides to add additional query parameters to the uri (e.g. a token or secret), it will appear in the uri that is passed to the [UriHandler](#UriHandler).

**Example** of an authentication flow:

```
vscode.window.registerUriHandler({
  handleUri(uri: vscode.Uri): vscode.ProviderResult<void> {
    if (uri.path === '/did-authenticate') {
      console.log(uri.toString());
    }
  }
});

const callableUri = await vscode.env.asExternalUri(
  vscode.Uri.parse(vscode.env.uriScheme + '://my.extension/did-authenticate')
);
await vscode.env.openExternal(callableUri);
```

_Note_ that extensions should not cache the result of `asExternalUri` as the resolved uri may become invalid due to a system or user action — for example, in remote cases, a user may close a port forwarding tunnel that was opened by `asExternalUri`.

#### Any other scheme

Any other scheme will be handled as if the provided URI is a workspace URI. In that case, the method will return a URI which, when handled, will make the editor open the workspace.

| Parameter | Description |
| --- | --- |
| target: [Uri](#Uri) |     |
| Returns | Description |
| Thenable<[Uri](#Uri)\> | A uri that can be used on the client machine. |

createTelemetryLogger(sender: [TelemetrySender](#TelemetrySender), options?: [TelemetryLoggerOptions](#TelemetryLoggerOptions)): [TelemetryLogger](#TelemetryLogger)

Creates a new [telemetry logger](#TelemetryLogger).

| Parameter | Description |
| --- | --- |
| sender: [TelemetrySender](#TelemetrySender) | The telemetry sender that is used by the telemetry logger. |
| options?: [TelemetryLoggerOptions](#TelemetryLoggerOptions) | Options for the telemetry logger. |
| Returns | Description |
| [TelemetryLogger](#TelemetryLogger) | A new telemetry logger |

openExternal(target: [Uri](#Uri)): Thenable<boolean\>

Opens a link externally using the default application. Depending on the used scheme this can be:

*   a browser (`http:`, `https:`)
*   a mail client (`mailto:`)
*   VSCode itself (`vscode:` from `vscode.env.uriScheme`)

_Note_ that [showTextDocument](#window.showTextDocument) is the right way to open a text document inside the editor, not this function.

| Parameter | Description |
| --- | --- |
| target: [Uri](#Uri) | The uri that should be opened. |
| Returns | Description |
| Thenable<boolean\> | A promise indicating if open was successful. |

## extensions

Namespace for dealing with installed extensions. Extensions are represented by an [Extension](#Extension)\-interface which enables reflection on them.

Extension writers can provide APIs to other extensions by returning their API public surface from the `activate`\-call.

```
export function activate(context: vscode.ExtensionContext) {
  let api = {
    sum(a, b) {
      return a + b;
    },
    mul(a, b) {
      return a * b;
    }
  };
  // 'export' public api-surface
  return api;
}
```

When depending on the API of another extension add an `extensionDependencies`\-entry to `package.json`, and use the [getExtension](#extensions.getExtension)\-function and the [exports](#Extension.exports)\-property, like below:

```
let mathExt = extensions.getExtension('genius.math');
let importedApi = mathExt.exports;

console.log(importedApi.mul(42, 1));
```

#### Variables

all: readonly [Extension](#Extension&lt;T&gt;)<any\>\[\]

All extensions currently known to the system.

#### Events

onDidChange: [Event](#Event&lt;T&gt;)<void\>

An event which fires when `extensions.all` changes. This can happen when extensions are installed, uninstalled, enabled or disabled.

#### Functions

getExtension<T\>(extensionId: string): [Extension](#Extension&lt;T&gt;)<T\> | undefined

Get an extension by its full identifier in the form of: `publisher.name`.

| Parameter | Description |
| --- | --- |
| extensionId: string | An extension identifier. |
| Returns | Description |
| [Extension](#Extension&lt;T&gt;)<T\> \| undefined | An extension or `undefined`. |

## l10n

Namespace for localization-related functionality in the extension API. To use this properly, you must have `l10n` defined in your extension manifest and have bundle.l10n..json files. For more information on how to generate bundle.l10n..json files, check out the [vscode-l10n repo](https://github.com/microsoft/vscode-l10n).

Note: Built-in extensions (for example, Git, TypeScript Language Features, GitHub Authentication) are excluded from the `l10n` property requirement. In other words, they do not need to specify a `l10n` in the extension manifest because their translated strings come from Language Packs.

#### Variables

bundle: | undefined

The bundle of localized strings that have been loaded for the extension. It's undefined if no bundle has been loaded. The bundle is typically not loaded if there was no bundle found or when we are running with the default language.

uri: [Uri](#Uri) | undefined

The URI of the localization bundle that has been loaded for the extension. It's undefined if no bundle has been loaded. The bundle is typically not loaded if there was no bundle found or when we are running with the default language.

#### Functions

t(message: string, ...args: Array<string | number | boolean\>): string

Marks a string for localization. If a localized bundle is available for the language specified by [env.language](#env.language) and the bundle has a localized value for this message, then that localized value will be returned (with injected [args](#l10n.t.args) values for any templated values).

**Example**

```
l10n.t('Hello {0}!', 'World');
```

| Parameter | Description |
| --- | --- |
| message: string | The message to localize. Supports index templating where strings like `{0}` and `{1}` are replaced by the item at that index in the [args](#l10n.t.args) array. |
| ...args: Array<string \| number \| boolean\> | The arguments to be used in the localized string. The index of the argument is used to match the template placeholder in the localized string. |
| Returns | Description |
| string | localized string with injected arguments. |

t(message: string, args: Record<string, string | number | boolean\>): string

Marks a string for localization. If a localized bundle is available for the language specified by [env.language](#env.language) and the bundle has a localized value for this message, then that localized value will be returned (with injected [args](#l10n.t.args) values for any templated values).

**Example**

```
l10n.t('Hello {name}', { name: 'Erich' });
```

| Parameter | Description |
| --- | --- |
| message: string | The message to localize. Supports named templating where strings like `{foo}` and `{bar}` are replaced by the value in the Record for that key (foo, bar, etc). |
| args: Record<string, string \| number \| boolean\> | The arguments to be used in the localized string. The name of the key in the record is used to match the template placeholder in the localized string. |
| Returns | Description |
| string | localized string with injected arguments. |

t(options: {args: Array<string | number | boolean\> | Record<string, string | number | boolean\>, comment: string | string\[\], message: string}): string

Marks a string for localization. If a localized bundle is available for the language specified by [env.language](#env.language) and the bundle has a localized value for this message, then that localized value will be returned (with injected args values for any templated values).

| Parameter | Description |
| --- | --- |
| options: {args: Array<string \| number \| boolean\> \| Record<string, string \| number \| boolean\>, comment: string \| string\[\], message: string} | The options to use when localizing the message. |
| Returns | Description |
| string | localized string with injected arguments. |

## languages

Namespace for participating in language-specific editor [features](https://code.visualstudio.com/docs/editor/editingevolved), like IntelliSense, code actions, diagnostics etc.

Many programming languages exist and there is huge variety in syntaxes, semantics, and paradigms. Despite that, features like automatic word-completion, code navigation, or code checking have become popular across different tools for different programming languages.

The editor provides an API that makes it simple to provide such common features by having all UI and actions already in place and by allowing you to participate by providing data only. For instance, to contribute a hover all you have to do is provide a function that can be called with a [TextDocument](#TextDocument) and a [Position](#Position) returning hover info. The rest, like tracking the mouse, positioning the hover, keeping the hover stable etc. is taken care of by the editor.

```
languages.registerHoverProvider('javascript', {
  provideHover(document, position, token) {
    return new Hover('I am a hover!');
  }
});
```

Registration is done using a [document selector](#DocumentSelector) which is either a language id, like `javascript` or a more complex [filter](#DocumentFilter) like `{ language: 'typescript', scheme: 'file' }`. Matching a document against such a selector will result in a [score](#languages.match) that is used to determine if and how a provider shall be used. When scores are equal the provider that came last wins. For features that allow full arity, like [hover](#languages.registerHoverProvider), the score is only checked to be `>0`, for other features, like [IntelliSense](#languages.registerCompletionItemProvider) the score is used for determining the order in which providers are asked to participate.

#### Events

onDidChangeDiagnostics: [Event](#Event&lt;T&gt;)<[DiagnosticChangeEvent](#DiagnosticChangeEvent)\>

An [Event](#Event) which fires when the global set of diagnostics changes. This is newly added and removed diagnostics.

#### Functions

createDiagnosticCollection(name?: string): [DiagnosticCollection](#DiagnosticCollection)

Create a diagnostics collection.

| Parameter | Description |
| --- | --- |
| name?: string | The [name](#DiagnosticCollection.name) of the collection. |
| Returns | Description |
| [DiagnosticCollection](#DiagnosticCollection) | A new diagnostic collection. |

createLanguageStatusItem(id: string, selector: [DocumentSelector](#DocumentSelector)): [LanguageStatusItem](#LanguageStatusItem)

Creates a new [language status item](#LanguageStatusItem).

| Parameter | Description |
| --- | --- |
| id: string | The identifier of the item. |
| selector: [DocumentSelector](#DocumentSelector) | The document selector that defines for what editors the item shows. |
| Returns | Description |
| [LanguageStatusItem](#LanguageStatusItem) | A new language status item. |

getDiagnostics(resource: [Uri](#Uri)): [Diagnostic](#Diagnostic)\[\]

Get all diagnostics for a given resource.

| Parameter | Description |
| --- | --- |
| resource: [Uri](#Uri) | A resource |
| Returns | Description |
| [Diagnostic](#Diagnostic)\[\] | An array of [diagnostics](#Diagnostic) objects or an empty array. |

getDiagnostics(): Array<\[[Uri](#Uri), [Diagnostic](#Diagnostic)\[\]\]>

Get all diagnostics.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Array<\[[Uri](#Uri), [Diagnostic](#Diagnostic)\[\]\]> | An array of uri-diagnostics tuples or an empty array. |

getLanguages(): Thenable<string\[\]>

Return the identifiers of all known languages.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Thenable<string\[\]> | Promise resolving to an array of identifier strings. |

match(selector: [DocumentSelector](#DocumentSelector), document: [TextDocument](#TextDocument)): number

Compute the match between a document [selector](#DocumentSelector) and a document. Values greater than zero mean the selector matches the document.

A match is computed according to these rules:

1.  When [DocumentSelector](#DocumentSelector) is an array, compute the match for each contained `DocumentFilter` or language identifier and take the maximum value.
2.  A string will be desugared to become the `language`\-part of a [DocumentFilter](#DocumentFilter), so `"fooLang"` is like `{ language: "fooLang" }`.
3.  A [DocumentFilter](#DocumentFilter) will be matched against the document by comparing its parts with the document. The following rules apply:
    1.  When the `DocumentFilter` is empty (`{}`) the result is `0`
    2.  When `scheme`, `language`, `pattern`, or `notebook` are defined but one doesn't match, the result is `0`
    3.  Matching against `*` gives a score of `5`, matching via equality or via a glob-pattern gives a score of `10`
    4.  The result is the maximum value of each match

Samples:

```
// default document from disk (file-scheme)
doc.uri; //'file:///my/file.js'
doc.languageId; // 'javascript'
match('javascript', doc); // 10;
match({ language: 'javascript' }, doc); // 10;
match({ language: 'javascript', scheme: 'file' }, doc); // 10;
match('*', doc); // 5
match('fooLang', doc); // 0
match(['fooLang', '*'], doc); // 5

// virtual document, e.g. from git-index
doc.uri; // 'git:/my/file.js'
doc.languageId; // 'javascript'
match('javascript', doc); // 10;
match({ language: 'javascript', scheme: 'git' }, doc); // 10;
match('*', doc); // 5

// notebook cell document
doc.uri; // `vscode-notebook-cell:///my/notebook.ipynb#gl65s2pmha`;
doc.languageId; // 'python'
match({ notebookType: 'jupyter-notebook' }, doc); // 10
match({ notebookType: 'fooNotebook', language: 'python' }, doc); // 0
match({ language: 'python' }, doc); // 10
match({ notebookType: '*' }, doc); // 5
```

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A document selector. |
| document: [TextDocument](#TextDocument) | A text document. |
| Returns | Description |
| number | A number `>0` when the selector matches and `0` when the selector does not match. |

registerCallHierarchyProvider(selector: [DocumentSelector](#DocumentSelector), provider: [CallHierarchyProvider](#CallHierarchyProvider)): [Disposable](#Disposable)

Register a call hierarchy provider.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [CallHierarchyProvider](#CallHierarchyProvider) | A call hierarchy provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerCodeActionsProvider(selector: [DocumentSelector](#DocumentSelector), provider: [CodeActionProvider](#CodeActionProvider&lt;T&gt;)<[CodeAction](#CodeAction)\>, metadata?: [CodeActionProviderMetadata](#CodeActionProviderMetadata)): [Disposable](#Disposable)

Register a code action provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [CodeActionProvider](#CodeActionProvider&lt;T&gt;)<[CodeAction](#CodeAction)\> | A code action provider. |
| metadata?: [CodeActionProviderMetadata](#CodeActionProviderMetadata) | Metadata about the kind of code actions the provider provides. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerCodeLensProvider(selector: [DocumentSelector](#DocumentSelector), provider: [CodeLensProvider](#CodeLensProvider&lt;T&gt;)<[CodeLens](#CodeLens)\>): [Disposable](#Disposable)

Register a code lens provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [CodeLensProvider](#CodeLensProvider&lt;T&gt;)<[CodeLens](#CodeLens)\> | A code lens provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerColorProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentColorProvider](#DocumentColorProvider)): [Disposable](#Disposable)

Register a color provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DocumentColorProvider](#DocumentColorProvider) | A color provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerCompletionItemProvider(selector: [DocumentSelector](#DocumentSelector), provider: [CompletionItemProvider](#CompletionItemProvider&lt;T&gt;)<[CompletionItem](#CompletionItem)\>, ...triggerCharacters: string\[\]): [Disposable](#Disposable)

Register a completion provider.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and groups of equal score are sequentially asked for completion items. The process stops when one or many providers of a group return a result. A failing provider (rejected promise or exception) will not fail the whole operation.

A completion item provider can be associated with a set of `triggerCharacters`. When trigger characters are being typed, completions are requested but only from providers that registered the typed character. Because of that trigger characters should be different than [word characters](#LanguageConfiguration.wordPattern), a common trigger character is `.` to trigger member completions.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [CompletionItemProvider](#CompletionItemProvider&lt;T&gt;)<[CompletionItem](#CompletionItem)\> | A completion provider. |
| ...triggerCharacters: string\[\] | Trigger completion when the user types one of the characters. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerDeclarationProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DeclarationProvider](#DeclarationProvider)): [Disposable](#Disposable)

Register a declaration provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DeclarationProvider](#DeclarationProvider) | A declaration provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerDefinitionProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DefinitionProvider](#DefinitionProvider)): [Disposable](#Disposable)

Register a definition provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DefinitionProvider](#DefinitionProvider) | A definition provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerDocumentDropEditProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentDropEditProvider](#DocumentDropEditProvider&lt;T&gt;)<[DocumentDropEdit](#DocumentDropEdit)\>, metadata?: [DocumentDropEditProviderMetadata](#DocumentDropEditProviderMetadata)): [Disposable](#Disposable)

Registers a new [DocumentDropEditProvider](#DocumentDropEditProvider).

Multiple drop providers can be registered for a language. When dropping content into an editor, all registered providers for the editor's language will be invoked based on the mimetypes they handle as specified by their [DocumentDropEditProviderMetadata](#DocumentDropEditProviderMetadata).

Each provider can return one or more [DocumentDropEdits](#DocumentDropEdit). The edits are sorted using the [DocumentDropEdit.yieldTo](#DocumentDropEdit.yieldTo) property. By default the first edit will be applied. If there are any additional edits, these will be shown to the user as selectable drop options in the drop widget.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider applies to. |
| provider: [DocumentDropEditProvider](#DocumentDropEditProvider&lt;T&gt;)<[DocumentDropEdit](#DocumentDropEdit)\> | A drop provider. |
| metadata?: [DocumentDropEditProviderMetadata](#DocumentDropEditProviderMetadata) | Additional metadata about the provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when disposed of. |

registerDocumentFormattingEditProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentFormattingEditProvider](#DocumentFormattingEditProvider)): [Disposable](#Disposable)

Register a formatting provider for a document.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and the best-matching provider is used. Failure of the selected provider will cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DocumentFormattingEditProvider](#DocumentFormattingEditProvider) | A document formatting edit provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerDocumentHighlightProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentHighlightProvider](#DocumentHighlightProvider)): [Disposable](#Disposable)

Register a document highlight provider.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and groups sequentially asked for document highlights. The process stops when a provider returns a `non-falsy` or `non-failure` result.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DocumentHighlightProvider](#DocumentHighlightProvider) | A document highlight provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerDocumentLinkProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentLinkProvider](#DocumentLinkProvider&lt;T&gt;)<[DocumentLink](#DocumentLink)\>): [Disposable](#Disposable)

Register a document link provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DocumentLinkProvider](#DocumentLinkProvider&lt;T&gt;)<[DocumentLink](#DocumentLink)\> | A document link provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerDocumentPasteEditProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentPasteEditProvider](#DocumentPasteEditProvider&lt;T&gt;)<[DocumentPasteEdit](#DocumentPasteEdit)\>, metadata: [DocumentPasteProviderMetadata](#DocumentPasteProviderMetadata)): [Disposable](#Disposable)

Registers a new [DocumentPasteEditProvider](#DocumentPasteEditProvider).

Multiple providers can be registered for a language. All registered providers for a language will be invoked for copy and paste operations based on their handled mimetypes as specified by the [DocumentPasteProviderMetadata](#DocumentPasteProviderMetadata).

For [copy operations](#DocumentPasteEditProvider.prepareDocumentPaste), changes to the [DataTransfer](#DataTransfer) made by each provider will be merged into a single [DataTransfer](#DataTransfer) that is used to populate the clipboard.

For \[DocumentPasteEditProvider.providerDocumentPasteEdits paste operations\](#\_DocumentPasteEditProvider.providerDocumentPasteEdits paste operations), each provider will be invoked and can return one or more [DocumentPasteEdits](#DocumentPasteEdit). The edits are sorted using the [DocumentPasteEdit.yieldTo](#DocumentPasteEdit.yieldTo) property. By default the first edit will be applied and the rest of the edits will be shown to the user as selectable paste options in the paste widget.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider applies to. |
| provider: [DocumentPasteEditProvider](#DocumentPasteEditProvider&lt;T&gt;)<[DocumentPasteEdit](#DocumentPasteEdit)\> | A paste editor provider. |
| metadata: [DocumentPasteProviderMetadata](#DocumentPasteProviderMetadata) | Additional metadata about the provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when disposed of. |

registerDocumentRangeFormattingEditProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentRangeFormattingEditProvider](#DocumentRangeFormattingEditProvider)): [Disposable](#Disposable)

Register a formatting provider for a document range.

_Note:_ A document range provider is also a [document formatter](#DocumentFormattingEditProvider) which means there is no need to [register](#languages.registerDocumentFormattingEditProvider) a document formatter when also registering a range provider.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and the best-matching provider is used. Failure of the selected provider will cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DocumentRangeFormattingEditProvider](#DocumentRangeFormattingEditProvider) | A document range formatting edit provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerDocumentRangeSemanticTokensProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentRangeSemanticTokensProvider](#DocumentRangeSemanticTokensProvider), legend: [SemanticTokensLegend](#SemanticTokensLegend)): [Disposable](#Disposable)

Register a semantic tokens provider for a document range.

_Note:_ If a document has both a `DocumentSemanticTokensProvider` and a `DocumentRangeSemanticTokensProvider`, the range provider will be invoked only initially, for the time in which the full document provider takes to resolve the first request. Once the full document provider resolves the first request, the semantic tokens provided via the range provider will be discarded and from that point forward, only the document provider will be used.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and the best-matching provider is used. Failure of the selected provider will cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DocumentRangeSemanticTokensProvider](#DocumentRangeSemanticTokensProvider) | A document range semantic tokens provider. |
| legend: [SemanticTokensLegend](#SemanticTokensLegend) |     |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerDocumentSemanticTokensProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentSemanticTokensProvider](#DocumentSemanticTokensProvider), legend: [SemanticTokensLegend](#SemanticTokensLegend)): [Disposable](#Disposable)

Register a semantic tokens provider for a whole document.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and the best-matching provider is used. Failure of the selected provider will cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DocumentSemanticTokensProvider](#DocumentSemanticTokensProvider) | A document semantic tokens provider. |
| legend: [SemanticTokensLegend](#SemanticTokensLegend) |     |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerDocumentSymbolProvider(selector: [DocumentSelector](#DocumentSelector), provider: [DocumentSymbolProvider](#DocumentSymbolProvider), metaData?: [DocumentSymbolProviderMetadata](#DocumentSymbolProviderMetadata)): [Disposable](#Disposable)

Register a document symbol provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [DocumentSymbolProvider](#DocumentSymbolProvider) | A document symbol provider. |
| metaData?: [DocumentSymbolProviderMetadata](#DocumentSymbolProviderMetadata) | metadata about the provider |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerEvaluatableExpressionProvider(selector: [DocumentSelector](#DocumentSelector), provider: [EvaluatableExpressionProvider](#EvaluatableExpressionProvider)): [Disposable](#Disposable)

Register a provider that locates evaluatable expressions in text documents. The editor will evaluate the expression in the active debug session and will show the result in the debug hover.

If multiple providers are registered for a language an arbitrary provider will be used.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [EvaluatableExpressionProvider](#EvaluatableExpressionProvider) | An evaluatable expression provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerFoldingRangeProvider(selector: [DocumentSelector](#DocumentSelector), provider: [FoldingRangeProvider](#FoldingRangeProvider)): [Disposable](#Disposable)

Register a folding range provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. If multiple folding ranges start at the same position, only the range of the first registered provider is used. If a folding range overlaps with an other range that has a smaller position, it is also ignored.

A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [FoldingRangeProvider](#FoldingRangeProvider) | A folding range provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerHoverProvider(selector: [DocumentSelector](#DocumentSelector), provider: [HoverProvider](#HoverProvider)): [Disposable](#Disposable)

Register a hover provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [HoverProvider](#HoverProvider) | A hover provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerImplementationProvider(selector: [DocumentSelector](#DocumentSelector), provider: [ImplementationProvider](#ImplementationProvider)): [Disposable](#Disposable)

Register an implementation provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [ImplementationProvider](#ImplementationProvider) | An implementation provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerInlayHintsProvider(selector: [DocumentSelector](#DocumentSelector), provider: [InlayHintsProvider](#InlayHintsProvider&lt;T&gt;)<[InlayHint](#InlayHint)\>): [Disposable](#Disposable)

Register a inlay hints provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [InlayHintsProvider](#InlayHintsProvider&lt;T&gt;)<[InlayHint](#InlayHint)\> | An inlay hints provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerInlineCompletionItemProvider(selector: [DocumentSelector](#DocumentSelector), provider: [InlineCompletionItemProvider](#InlineCompletionItemProvider)): [Disposable](#Disposable)

Registers an inline completion provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [InlineCompletionItemProvider](#InlineCompletionItemProvider) | An inline completion provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerInlineValuesProvider(selector: [DocumentSelector](#DocumentSelector), provider: [InlineValuesProvider](#InlineValuesProvider)): [Disposable](#Disposable)

Register a provider that returns data for the debugger's 'inline value' feature. Whenever the generic debugger has stopped in a source file, providers registered for the language of the file are called to return textual data that will be shown in the editor at the end of lines.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [InlineValuesProvider](#InlineValuesProvider) | An inline values provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerLinkedEditingRangeProvider(selector: [DocumentSelector](#DocumentSelector), provider: [LinkedEditingRangeProvider](#LinkedEditingRangeProvider)): [Disposable](#Disposable)

Register a linked editing range provider.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and the best-matching provider that has a result is used. Failure of the selected provider will cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [LinkedEditingRangeProvider](#LinkedEditingRangeProvider) | A linked editing range provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerOnTypeFormattingEditProvider(selector: [DocumentSelector](#DocumentSelector), provider: [OnTypeFormattingEditProvider](#OnTypeFormattingEditProvider), firstTriggerCharacter: string, ...moreTriggerCharacter: string\[\]): [Disposable](#Disposable)

Register a formatting provider that works on type. The provider is active when the user enables the setting `editor.formatOnType`.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and the best-matching provider is used. Failure of the selected provider will cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [OnTypeFormattingEditProvider](#OnTypeFormattingEditProvider) | An on type formatting edit provider. |
| firstTriggerCharacter: string | A character on which formatting should be triggered, like `}`. |
| ...moreTriggerCharacter: string\[\] | More trigger characters. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerReferenceProvider(selector: [DocumentSelector](#DocumentSelector), provider: [ReferenceProvider](#ReferenceProvider)): [Disposable](#Disposable)

Register a reference provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [ReferenceProvider](#ReferenceProvider) | A reference provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerRenameProvider(selector: [DocumentSelector](#DocumentSelector), provider: [RenameProvider](#RenameProvider)): [Disposable](#Disposable)

Register a rename provider.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and asked in sequence. The first provider producing a result defines the result of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [RenameProvider](#RenameProvider) | A rename provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerSelectionRangeProvider(selector: [DocumentSelector](#DocumentSelector), provider: [SelectionRangeProvider](#SelectionRangeProvider)): [Disposable](#Disposable)

Register a selection range provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [SelectionRangeProvider](#SelectionRangeProvider) | A selection range provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerSignatureHelpProvider(selector: [DocumentSelector](#DocumentSelector), provider: [SignatureHelpProvider](#SignatureHelpProvider), ...triggerCharacters: string\[\]): [Disposable](#Disposable)

Register a signature help provider.

Multiple providers can be registered for a language. In that case providers are sorted by their [score](#languages.match) and called sequentially until a provider returns a valid result.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [SignatureHelpProvider](#SignatureHelpProvider) | A signature help provider. |
| ...triggerCharacters: string\[\] | Trigger signature help when the user types one of the characters, like `,` or `(`. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerSignatureHelpProvider(selector: [DocumentSelector](#DocumentSelector), provider: [SignatureHelpProvider](#SignatureHelpProvider), metadata: [SignatureHelpProviderMetadata](#SignatureHelpProviderMetadata)): [Disposable](#Disposable)

_See also_ [languages.registerSignatureHelpProvider](#languages.registerSignatureHelpProvider)

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [SignatureHelpProvider](#SignatureHelpProvider) | A signature help provider. |
| metadata: [SignatureHelpProviderMetadata](#SignatureHelpProviderMetadata) | Information about the provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerTypeDefinitionProvider(selector: [DocumentSelector](#DocumentSelector), provider: [TypeDefinitionProvider](#TypeDefinitionProvider)): [Disposable](#Disposable)

Register a type definition provider.

Multiple providers can be registered for a language. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [TypeDefinitionProvider](#TypeDefinitionProvider) | A type definition provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerTypeHierarchyProvider(selector: [DocumentSelector](#DocumentSelector), provider: [TypeHierarchyProvider](#TypeHierarchyProvider)): [Disposable](#Disposable)

Register a type hierarchy provider.

| Parameter | Description |
| --- | --- |
| selector: [DocumentSelector](#DocumentSelector) | A selector that defines the documents this provider is applicable to. |
| provider: [TypeHierarchyProvider](#TypeHierarchyProvider) | A type hierarchy provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerWorkspaceSymbolProvider(provider: [WorkspaceSymbolProvider](#WorkspaceSymbolProvider&lt;T&gt;)<[SymbolInformation](#SymbolInformation)\>): [Disposable](#Disposable)

Register a workspace symbol provider.

Multiple providers can be registered. In that case providers are asked in parallel and the results are merged. A failing provider (rejected promise or exception) will not cause a failure of the whole operation.

| Parameter | Description |
| --- | --- |
| provider: [WorkspaceSymbolProvider](#WorkspaceSymbolProvider&lt;T&gt;)<[SymbolInformation](#SymbolInformation)\> | A workspace symbol provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

setLanguageConfiguration(language: string, configuration: [LanguageConfiguration](#LanguageConfiguration)): [Disposable](#Disposable)

Set a [language configuration](#LanguageConfiguration) for a language.

| Parameter | Description |
| --- | --- |
| language: string | A language identifier like `typescript`. |
| configuration: [LanguageConfiguration](#LanguageConfiguration) | Language configuration. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unsets this configuration. |

setTextDocumentLanguage(document: [TextDocument](#TextDocument), languageId: string): Thenable<[TextDocument](#TextDocument)\>

Set (and change) the [language](#TextDocument.languageId) that is associated with the given document.

_Note_ that calling this function will trigger the [onDidCloseTextDocument](#workspace.onDidCloseTextDocument) event followed by the [onDidOpenTextDocument](#workspace.onDidOpenTextDocument) event.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document which language is to be changed |
| languageId: string | The new language identifier. |
| Returns | Description |
| Thenable<[TextDocument](#TextDocument)\> | A thenable that resolves with the updated document. |

## lm

Namespace for language model related functionality.

#### Variables

tools: readonly [LanguageModelToolInformation](#LanguageModelToolInformation)\[\]

A list of all available tools that were registered by all extensions using [lm.registerTool](#lm.registerTool). They can be called with [lm.invokeTool](#lm.invokeTool) with input that match their declared `inputSchema`.

#### Events

onDidChangeChatModels: [Event](#Event&lt;T&gt;)<void\>

An event that is fired when the set of available chat models changes.

#### Functions

invokeTool(name: string, options: [LanguageModelToolInvocationOptions](#LanguageModelToolInvocationOptions&lt;T&gt;)<object\>, token?: [CancellationToken](#CancellationToken)): Thenable<[LanguageModelToolResult](#LanguageModelToolResult)\>

Invoke a tool listed in [lm.tools](#lm.tools) by name with the given input. The input will be validated against the schema declared by the tool

A tool can be invoked by a chat participant, in the context of handling a chat request, or globally by any extension in any custom flow.

In the former case, the caller shall pass the [toolInvocationToken](#LanguageModelToolInvocationOptions.toolInvocationToken), which comes from a [chat request](#ChatRequest.toolInvocationToken). This makes sure the chat UI shows the tool invocation for the correct conversation.

A tool [result](#LanguageModelToolResult) is an array of [text-](#LanguageModelTextPart) and [prompt-tsx](#LanguageModelPromptTsxPart)\-parts. If the tool caller is using `vscode/prompt-tsx`, it can incorporate the response parts into its prompt using a `ToolResult`. If not, the parts can be passed along to the [LanguageModelChat](#LanguageModelChat) via a user message with a [LanguageModelToolResultPart](#LanguageModelToolResultPart).

If a chat participant wants to preserve tool results for requests across multiple turns, it can store tool results in the [ChatResult.metadata](#ChatResult.metadata) returned from the handler and retrieve them on the next turn from [ChatResponseTurn.result](#ChatResponseTurn.result).

| Parameter | Description |
| --- | --- |
| name: string | The name of the tool to call. |
| options: [LanguageModelToolInvocationOptions](#LanguageModelToolInvocationOptions&lt;T&gt;)<object\> | The options to use when invoking the tool. |
| token?: [CancellationToken](#CancellationToken) | A cancellation token. See [CancellationTokenSource](#CancellationTokenSource) for how to create one. |
| Returns | Description |
| Thenable<[LanguageModelToolResult](#LanguageModelToolResult)\> | The result of the tool invocation. |

registerLanguageModelChatProvider(vendor: string, provider: [LanguageModelChatProvider](#LanguageModelChatProvider&lt;T&gt;)<[LanguageModelChatInformation](#LanguageModelChatInformation)\>): [Disposable](#Disposable)

Registers a [LanguageModelChatProvider](#LanguageModelChatProvider) Note: You must also define the language model chat provider via the `languageModelChatProviders` contribution point in package.json

| Parameter | Description |
| --- | --- |
| vendor: string | The vendor for this provider. Must be globally unique. An example is `copilot` or `openai`. |
| provider: [LanguageModelChatProvider](#LanguageModelChatProvider&lt;T&gt;)<[LanguageModelChatInformation](#LanguageModelChatInformation)\> | The provider to register |
| Returns | Description |
| [Disposable](#Disposable) | A disposable that unregisters the provider when disposed |

registerMcpServerDefinitionProvider(id: string, provider: [McpServerDefinitionProvider](#McpServerDefinitionProvider&lt;T&gt;)<[McpServerDefinition](#McpServerDefinition)\>): [Disposable](#Disposable)

Registers a provider that publishes Model Context Protocol servers for the editor to consume. This allows MCP servers to be dynamically provided to the editor in addition to those the user creates in their configuration files.

Before calling this method, extensions must register the `contributes.mcpServerDefinitionProviders` extension point with the corresponding [id](#lm.registerMcpServerDefinitionProvider.id), for example:

```
    "contributes": {
        "mcpServerDefinitionProviders": [
            {
                "id": "cool-cloud-registry.mcp-servers",
                "label": "Cool Cloud Registry",
            }
        ]
    }
```

When a new McpServerDefinitionProvider is available, the editor will, by default, automatically invoke it to discover new servers and tools when a chat message is submitted. To enable this flow, extensions should call `registerMcpServerDefinitionProvider` during activation.

| Parameter | Description |
| --- | --- |
| id: string | The ID of the provider, which is unique to the extension. |
| provider: [McpServerDefinitionProvider](#McpServerDefinitionProvider&lt;T&gt;)<[McpServerDefinition](#McpServerDefinition)\> | The provider to register |
| Returns | Description |
| [Disposable](#Disposable) | A disposable that unregisters the provider when disposed. |

registerTool<T\>(name: string, tool: [LanguageModelTool](#LanguageModelTool&lt;T&gt;)<T\>): [Disposable](#Disposable)

Register a LanguageModelTool. The tool must also be registered in the package.json `languageModelTools` contribution point. A registered tool is available in the [lm.tools](#lm.tools) list for any extension to see. But in order for it to be seen by a language model, it must be passed in the list of available tools in [LanguageModelChatRequestOptions.tools](#LanguageModelChatRequestOptions.tools).

| Parameter | Description |
| --- | --- |
| name: string |     |
| tool: [LanguageModelTool](#LanguageModelTool&lt;T&gt;)<T\> |     |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters the tool when disposed. |

selectChatModels(selector?: [LanguageModelChatSelector](#LanguageModelChatSelector)): Thenable<[LanguageModelChat](#LanguageModelChat)\[\]>

Select chat models by a [selector](#LanguageModelChatSelector). This can yield multiple or no chat models and extensions must handle these cases, esp. when no chat model exists, gracefully.

```
const models = await vscode.lm.selectChatModels({ family: 'gpt-3.5-turbo' });
if (models.length > 0) {
    const [first] = models;
    const response = await first.sendRequest(...)
    // ...
} else {
    // NO chat models available
}
```

A selector can be written to broadly match all models of a given vendor or family, or it can narrowly select one model by ID. Keep in mind that the available set of models will change over time, but also that prompts may perform differently in different models.

_Note_ that extensions can hold on to the results returned by this function and use them later. However, when the [onDidChangeChatModels](#lm.onDidChangeChatModels)\-event is fired the list of chat models might have changed and extensions should re-query.

| Parameter | Description |
| --- | --- |
| selector?: [LanguageModelChatSelector](#LanguageModelChatSelector) | A chat model selector. When omitted all chat models are returned. |
| Returns | Description |
| Thenable<[LanguageModelChat](#LanguageModelChat)\[\]> | An array of chat models, can be empty! |

## notebooks

Namespace for notebooks.

The notebooks functionality is composed of three loosely coupled components:

1.  [NotebookSerializer](#NotebookSerializer) enable the editor to open, show, and save notebooks
2.  [NotebookController](#NotebookController) own the execution of notebooks, e.g they create output from code cells.
3.  NotebookRenderer present notebook output in the editor. They run in a separate context.

#### Functions

createNotebookController(id: string, notebookType: string, label: string, handler?: (cells: [NotebookCell](#NotebookCell)\[\], notebook: [NotebookDocument](#NotebookDocument), controller: [NotebookController](#NotebookController)) => void | Thenable<void\>): [NotebookController](#NotebookController)

Creates a new notebook controller.

| Parameter | Description |
| --- | --- |
| id: string | Identifier of the controller. Must be unique per extension. |
| notebookType: string | A notebook type for which this controller is for. |
| label: string | The label of the controller. |
| handler?: (cells: [NotebookCell](#NotebookCell)\[\], notebook: [NotebookDocument](#NotebookDocument), controller: [NotebookController](#NotebookController)) => void \| Thenable<void\> | The execute-handler of the controller. |
| Returns | Description |
| [NotebookController](#NotebookController) | A new notebook controller. |

createRendererMessaging(rendererId: string): [NotebookRendererMessaging](#NotebookRendererMessaging)

Creates a new messaging instance used to communicate with a specific renderer.

*   _Note 1:_ Extensions can only create renderer that they have defined in their `package.json`\-file
*   _Note 2:_ A renderer only has access to messaging if `requiresMessaging` is set to `always` or `optional` in its `notebookRenderer` contribution.

| Parameter | Description |
| --- | --- |
| rendererId: string | The renderer ID to communicate with |
| Returns | Description |
| [NotebookRendererMessaging](#NotebookRendererMessaging) | A new notebook renderer messaging object. |

registerNotebookCellStatusBarItemProvider(notebookType: string, provider: [NotebookCellStatusBarItemProvider](#NotebookCellStatusBarItemProvider)): [Disposable](#Disposable)

Register a [cell statusbar item provider](#NotebookCellStatusBarItemProvider) for the given notebook type.

| Parameter | Description |
| --- | --- |
| notebookType: string | The notebook type to register for. |
| provider: [NotebookCellStatusBarItemProvider](#NotebookCellStatusBarItemProvider) | A cell status bar provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

## scm

Namespace for source control management.

#### Variables

inputBox: [SourceControlInputBox](#SourceControlInputBox)

The [input box](#SourceControlInputBox) for the last source control created by the extension.

*   _deprecated_ - Use SourceControl.inputBox instead

#### Functions

createSourceControl(id: string, label: string, rootUri?: [Uri](#Uri)): [SourceControl](#SourceControl)

Creates a new [source control](#SourceControl) instance.

| Parameter | Description |
| --- | --- |
| id: string | An `id` for the source control. Something short, e.g.: `git`. |
| label: string | A human-readable string for the source control. E.g.: `Git`. |
| rootUri?: [Uri](#Uri) | An optional Uri of the root of the source control. E.g.: `Uri.parse(workspaceRoot)`. |
| Returns | Description |
| [SourceControl](#SourceControl) | An instance of [source control](#SourceControl). |

## tasks

Namespace for tasks functionality.

#### Variables

taskExecutions: readonly [TaskExecution](#TaskExecution)\[\]

The currently active task executions or an empty array.

#### Events

onDidEndTask: [Event](#Event&lt;T&gt;)<[TaskEndEvent](#TaskEndEvent)\>

Fires when a task ends.

onDidEndTaskProcess: [Event](#Event&lt;T&gt;)<[TaskProcessEndEvent](#TaskProcessEndEvent)\>

Fires when the underlying process has ended. This event will not fire for tasks that don't execute an underlying process.

onDidStartTask: [Event](#Event&lt;T&gt;)<[TaskStartEvent](#TaskStartEvent)\>

Fires when a task starts.

onDidStartTaskProcess: [Event](#Event&lt;T&gt;)<[TaskProcessStartEvent](#TaskProcessStartEvent)\>

Fires when the underlying process has been started. This event will not fire for tasks that don't execute an underlying process.

#### Functions

executeTask(task: [Task](#Task)): Thenable<[TaskExecution](#TaskExecution)\>

Executes a task that is managed by the editor. The returned task execution can be used to terminate the task.

*   _throws_ - When running a ShellExecution or a ProcessExecution task in an environment where a new process cannot be started. In such an environment, only CustomExecution tasks can be run.

| Parameter | Description |
| --- | --- |
| task: [Task](#Task) | the task to execute |
| Returns | Description |
| Thenable<[TaskExecution](#TaskExecution)\> | A thenable that resolves to a task execution. |

fetchTasks(filter?: [TaskFilter](#TaskFilter)): Thenable<[Task](#Task)\[\]>

Fetches all tasks available in the systems. This includes tasks from `tasks.json` files as well as tasks from task providers contributed through extensions.

| Parameter | Description |
| --- | --- |
| filter?: [TaskFilter](#TaskFilter) | Optional filter to select tasks of a certain type or version. |
| Returns | Description |
| Thenable<[Task](#Task)\[\]> | A thenable that resolves to an array of tasks. |

registerTaskProvider(type: string, provider: [TaskProvider](#TaskProvider&lt;T&gt;)<[Task](#Task)\>): [Disposable](#Disposable)

Register a task provider.

| Parameter | Description |
| --- | --- |
| type: string | The task kind type this provider is registered for. |
| provider: [TaskProvider](#TaskProvider&lt;T&gt;)<[Task](#Task)\> | A task provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

## tests

Namespace for testing functionality. Tests are published by registering [TestController](#TestController) instances, then adding [TestItems](#TestItem). Controllers may also describe how to run tests by creating one or more [TestRunProfile](#TestRunProfile) instances.

#### Functions

createTestController(id: string, label: string): [TestController](#TestController)

Creates a new test controller.

| Parameter | Description |
| --- | --- |
| id: string | Identifier for the controller, must be globally unique. |
| label: string | A human-readable label for the controller. |
| Returns | Description |
| [TestController](#TestController) | An instance of the [TestController](#TestController). |

## window

Namespace for dealing with the current window of the editor. That is visible and active editors, as well as, UI elements to show messages, selections, and asking for user input.

#### Variables

activeColorTheme: [ColorTheme](#ColorTheme)

The currently active color theme as configured in the settings. The active theme can be changed via the `workbench.colorTheme` setting.

activeNotebookEditor: [NotebookEditor](#NotebookEditor) | undefined

The currently active [notebook editor](#NotebookEditor) or `undefined`. The active editor is the one that currently has focus or, when none has focus, the one that has changed input most recently.

activeTerminal: [Terminal](#Terminal) | undefined

The currently active terminal or `undefined`. The active terminal is the one that currently has focus or most recently had focus.

activeTextEditor: [TextEditor](#TextEditor) | undefined

The currently active editor or `undefined`. The active editor is the one that currently has focus or, when none has focus, the one that has changed input most recently.

state: [WindowState](#WindowState)

Represents the current window's state.

tabGroups: [TabGroups](#TabGroups)

Represents the grid widget within the main editor area

terminals: readonly [Terminal](#Terminal)\[\]

The currently opened terminals or an empty array.

visibleNotebookEditors: readonly [NotebookEditor](#NotebookEditor)\[\]

The currently visible [notebook editors](#NotebookEditor) or an empty array.

visibleTextEditors: readonly [TextEditor](#TextEditor)\[\]

The currently visible editors or an empty array.

#### Events

onDidChangeActiveColorTheme: [Event](#Event&lt;T&gt;)<[ColorTheme](#ColorTheme)\>

An [Event](#Event) which fires when the active color theme is changed or has changes.

onDidChangeActiveNotebookEditor: [Event](#Event&lt;T&gt;)<[NotebookEditor](#NotebookEditor) | undefined\>

An [Event](#Event) which fires when the [active notebook editor](#window.activeNotebookEditor) has changed. _Note_ that the event also fires when the active editor changes to `undefined`.

onDidChangeActiveTerminal: [Event](#Event&lt;T&gt;)<[Terminal](#Terminal) | undefined\>

An [Event](#Event) which fires when the [active terminal](#window.activeTerminal) has changed. _Note_ that the event also fires when the active terminal changes to `undefined`.

onDidChangeActiveTextEditor: [Event](#Event&lt;T&gt;)<[TextEditor](#TextEditor) | undefined\>

An [Event](#Event) which fires when the [active editor](#window.activeTextEditor) has changed. _Note_ that the event also fires when the active editor changes to `undefined`.

onDidChangeNotebookEditorSelection: [Event](#Event&lt;T&gt;)<[NotebookEditorSelectionChangeEvent](#NotebookEditorSelectionChangeEvent)\>

An [Event](#Event) which fires when the [notebook editor selections](#NotebookEditor.selections) have changed.

onDidChangeNotebookEditorVisibleRanges: [Event](#Event&lt;T&gt;)<[NotebookEditorVisibleRangesChangeEvent](#NotebookEditorVisibleRangesChangeEvent)\>

An [Event](#Event) which fires when the [notebook editor visible ranges](#NotebookEditor.visibleRanges) have changed.

onDidChangeTerminalShellIntegration: [Event](#Event&lt;T&gt;)<[TerminalShellIntegrationChangeEvent](#TerminalShellIntegrationChangeEvent)\>

Fires when shell integration activates or one of its properties changes in a terminal.

onDidChangeTerminalState: [Event](#Event&lt;T&gt;)<[Terminal](#Terminal)\>

An [Event](#Event) which fires when a [terminal's state](#Terminal.state) has changed.

onDidChangeTextEditorOptions: [Event](#Event&lt;T&gt;)<[TextEditorOptionsChangeEvent](#TextEditorOptionsChangeEvent)\>

An [Event](#Event) which fires when the options of an editor have changed.

onDidChangeTextEditorSelection: [Event](#Event&lt;T&gt;)<[TextEditorSelectionChangeEvent](#TextEditorSelectionChangeEvent)\>

An [Event](#Event) which fires when the selection in an editor has changed.

onDidChangeTextEditorViewColumn: [Event](#Event&lt;T&gt;)<[TextEditorViewColumnChangeEvent](#TextEditorViewColumnChangeEvent)\>

An [Event](#Event) which fires when the view column of an editor has changed.

onDidChangeTextEditorVisibleRanges: [Event](#Event&lt;T&gt;)<[TextEditorVisibleRangesChangeEvent](#TextEditorVisibleRangesChangeEvent)\>

An [Event](#Event) which fires when the visible ranges of an editor has changed.

onDidChangeVisibleNotebookEditors: [Event](#Event&lt;T&gt;)<readonly [NotebookEditor](#NotebookEditor)\[\]>

An [Event](#Event) which fires when the [visible notebook editors](#window.visibleNotebookEditors) has changed.

onDidChangeVisibleTextEditors: [Event](#Event&lt;T&gt;)<readonly [TextEditor](#TextEditor)\[\]>

An [Event](#Event) which fires when the array of [visible editors](#window.visibleTextEditors) has changed.

onDidChangeWindowState: [Event](#Event&lt;T&gt;)<[WindowState](#WindowState)\>

An [Event](#Event) which fires when the focus or activity state of the current window changes. The value of the event represents whether the window is focused.

onDidCloseTerminal: [Event](#Event&lt;T&gt;)<[Terminal](#Terminal)\>

An [Event](#Event) which fires when a terminal is disposed.

onDidEndTerminalShellExecution: [Event](#Event&lt;T&gt;)<[TerminalShellExecutionEndEvent](#TerminalShellExecutionEndEvent)\>

This will be fired when a terminal command is ended. This event will fire only when [shell integration](https://code.visualstudio.com/docs/terminal/shell-integration) is activated for the terminal.

onDidOpenTerminal: [Event](#Event&lt;T&gt;)<[Terminal](#Terminal)\>

An [Event](#Event) which fires when a terminal has been created, either through the [createTerminal](#window.createTerminal) API or commands.

onDidStartTerminalShellExecution: [Event](#Event&lt;T&gt;)<[TerminalShellExecutionStartEvent](#TerminalShellExecutionStartEvent)\>

This will be fired when a terminal command is started. This event will fire only when [shell integration](https://code.visualstudio.com/docs/terminal/shell-integration) is activated for the terminal.

#### Functions

createInputBox(): [InputBox](#InputBox)

Creates a [InputBox](#InputBox) to let the user enter some text input.

Note that in many cases the more convenient [window.showInputBox](#window.showInputBox) is easier to use. [window.createInputBox](#window.createInputBox) should be used when [window.showInputBox](#window.showInputBox) does not offer the required flexibility.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [InputBox](#InputBox) | A new [InputBox](#InputBox). |

createOutputChannel(name: string, languageId?: string): [OutputChannel](#OutputChannel)

Creates a new [output channel](#OutputChannel) with the given name and language id If language id is not provided, then **Log** is used as default language id.

You can access the visible or active output channel as a [text document](#TextDocument) from [visible editors](#window.visibleTextEditors) or [active editor](#window.activeTextEditor) and use the language id to contribute language features like syntax coloring, code lens etc.,

| Parameter | Description |
| --- | --- |
| name: string | Human-readable string which will be used to represent the channel in the UI. |
| languageId?: string | The identifier of the language associated with the channel. |
| Returns | Description |
| [OutputChannel](#OutputChannel) | A new output channel. |

createOutputChannel(name: string, options: {log: true}): [LogOutputChannel](#LogOutputChannel)

Creates a new [log output channel](#LogOutputChannel) with the given name.

| Parameter | Description |
| --- | --- |
| name: string | Human-readable string which will be used to represent the channel in the UI. |
| options: {log: true} | Options for the log output channel. |
| Returns | Description |
| [LogOutputChannel](#LogOutputChannel) | A new log output channel. |

createQuickPick<T extends [QuickPickItem](#QuickPickItem)\>(): [QuickPick](#QuickPick&lt;T&gt;)<T\>

Creates a [QuickPick](#QuickPick) to let the user pick an item from a list of items of type `T`.

Note that in many cases the more convenient [window.showQuickPick](#window.showQuickPick) is easier to use. [window.createQuickPick](#window.createQuickPick) should be used when [window.showQuickPick](#window.showQuickPick) does not offer the required flexibility.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [QuickPick](#QuickPick&lt;T&gt;)<T\> | A new [QuickPick](#QuickPick). |

createStatusBarItem(id: string, alignment?: [StatusBarAlignment](#StatusBarAlignment), priority?: number): [StatusBarItem](#StatusBarItem)

Creates a status bar [item](#StatusBarItem).

| Parameter | Description |
| --- | --- |
| id: string | The identifier of the item. Must be unique within the extension. |
| alignment?: [StatusBarAlignment](#StatusBarAlignment) | The alignment of the item. |
| priority?: number | The priority of the item. Higher values mean the item should be shown more to the left. |
| Returns | Description |
| [StatusBarItem](#StatusBarItem) | A new status bar item. |

createStatusBarItem(alignment?: [StatusBarAlignment](#StatusBarAlignment), priority?: number): [StatusBarItem](#StatusBarItem)

Creates a status bar [item](#StatusBarItem).

_See also_ [createStatusBarItem](#window.createStatusBarItem) for creating a status bar item with an identifier.

| Parameter | Description |
| --- | --- |
| alignment?: [StatusBarAlignment](#StatusBarAlignment) | The alignment of the item. |
| priority?: number | The priority of the item. Higher values mean the item should be shown more to the left. |
| Returns | Description |
| [StatusBarItem](#StatusBarItem) | A new status bar item. |

createTerminal(name?: string, shellPath?: string, shellArgs?: string | readonly string\[\]): [Terminal](#Terminal)

Creates a [Terminal](#Terminal) with a backing shell process. The cwd of the terminal will be the workspace directory if it exists.

*   _throws_ - When running in an environment where a new process cannot be started.

| Parameter | Description |
| --- | --- |
| name?: string | Optional human-readable string which will be used to represent the terminal in the UI. |
| shellPath?: string | Optional path to a custom shell executable to be used in the terminal. |
| shellArgs?: string \| readonly string\[\] | Optional args for the custom shell executable. A string can be used on Windows only which allows specifying shell args in [command-line format](https://msdn.microsoft.com/en-au/08dfcab2-eb6e-49a4-80eb-87d4076c98c6). |
| Returns | Description |
| [Terminal](#Terminal) | A new Terminal. |

createTerminal(options: [TerminalOptions](#TerminalOptions)): [Terminal](#Terminal)

Creates a [Terminal](#Terminal) with a backing shell process.

*   _throws_ - When running in an environment where a new process cannot be started.

| Parameter | Description |
| --- | --- |
| options: [TerminalOptions](#TerminalOptions) | A TerminalOptions object describing the characteristics of the new terminal. |
| Returns | Description |
| [Terminal](#Terminal) | A new Terminal. |

createTerminal(options: [ExtensionTerminalOptions](#ExtensionTerminalOptions)): [Terminal](#Terminal)

Creates a [Terminal](#Terminal) where an extension controls its input and output.

| Parameter | Description |
| --- | --- |
| options: [ExtensionTerminalOptions](#ExtensionTerminalOptions) | An [ExtensionTerminalOptions](#ExtensionTerminalOptions) object describing the characteristics of the new terminal. |
| Returns | Description |
| [Terminal](#Terminal) | A new Terminal. |

createTextEditorDecorationType(options: [DecorationRenderOptions](#DecorationRenderOptions)): [TextEditorDecorationType](#TextEditorDecorationType)

Create a TextEditorDecorationType that can be used to add decorations to text editors.

| Parameter | Description |
| --- | --- |
| options: [DecorationRenderOptions](#DecorationRenderOptions) | Rendering options for the decoration type. |
| Returns | Description |
| [TextEditorDecorationType](#TextEditorDecorationType) | A new decoration type instance. |

createTreeView<T\>(viewId: string, options: [TreeViewOptions](#TreeViewOptions&lt;T&gt;)<T\>): [TreeView](#TreeView&lt;T&gt;)<T\>

Create a [TreeView](#TreeView) for the view contributed using the extension point `views`.

| Parameter | Description |
| --- | --- |
| viewId: string | Id of the view contributed using the extension point `views`. |
| options: [TreeViewOptions](#TreeViewOptions&lt;T&gt;)<T\> | Options for creating the [TreeView](#TreeView) |
| Returns | Description |
| [TreeView](#TreeView&lt;T&gt;)<T\> | a [TreeView](#TreeView). |

createWebviewPanel(viewType: string, title: string, showOptions: [ViewColumn](#ViewColumn) | {preserveFocus: boolean, viewColumn: [ViewColumn](#ViewColumn)}, options?: [WebviewPanelOptions](#WebviewPanelOptions) & [WebviewOptions](#WebviewOptions)): [WebviewPanel](#WebviewPanel)

Create and show a new webview panel.

| Parameter | Description |
| --- | --- |
| viewType: string | Identifies the type of the webview panel. |
| title: string | Title of the panel. |
| showOptions: [ViewColumn](#ViewColumn) \| {preserveFocus: boolean, viewColumn: [ViewColumn](#ViewColumn)} | Where to show the webview in the editor. If preserveFocus is set, the new webview will not take focus. |
| options?: [WebviewPanelOptions](#WebviewPanelOptions) & [WebviewOptions](#WebviewOptions) | Settings for the new panel. |
| Returns | Description |
| [WebviewPanel](#WebviewPanel) | New webview panel. |

registerCustomEditorProvider(viewType: string, provider: [CustomTextEditorProvider](#CustomTextEditorProvider) | [CustomReadonlyEditorProvider](#CustomReadonlyEditorProvider&lt;T&gt;)<[CustomDocument](#CustomDocument)\> | [CustomEditorProvider](#CustomEditorProvider&lt;T&gt;)<[CustomDocument](#CustomDocument)\>, options?: {supportsMultipleEditorsPerDocument: boolean, webviewOptions: [WebviewPanelOptions](#WebviewPanelOptions)}): [Disposable](#Disposable)

Register a provider for custom editors for the `viewType` contributed by the `customEditors` extension point.

When a custom editor is opened, an `onCustomEditor:viewType` activation event is fired. Your extension must register a [CustomTextEditorProvider](#CustomTextEditorProvider), [CustomReadonlyEditorProvider](#CustomReadonlyEditorProvider), [CustomEditorProvider](#CustomEditorProvider)for `viewType` as part of activation.

| Parameter | Description |
| --- | --- |
| viewType: string | Unique identifier for the custom editor provider. This should match the `viewType` from the `customEditors` contribution point. |
| provider: [CustomTextEditorProvider](#CustomTextEditorProvider) \| [CustomReadonlyEditorProvider](#CustomReadonlyEditorProvider&lt;T&gt;)<[CustomDocument](#CustomDocument)\> \| [CustomEditorProvider](#CustomEditorProvider&lt;T&gt;)<[CustomDocument](#CustomDocument)\> | Provider that resolves custom editors. |
| options?: {supportsMultipleEditorsPerDocument: boolean, webviewOptions: [WebviewPanelOptions](#WebviewPanelOptions)} | Options for the provider. |
| Returns | Description |
| [Disposable](#Disposable) | Disposable that unregisters the provider. |

registerFileDecorationProvider(provider: [FileDecorationProvider](#FileDecorationProvider)): [Disposable](#Disposable)

Register a file decoration provider.

| Parameter | Description |
| --- | --- |
| provider: [FileDecorationProvider](#FileDecorationProvider) | A [FileDecorationProvider](#FileDecorationProvider). |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters the provider. |

registerTerminalLinkProvider(provider: [TerminalLinkProvider](#TerminalLinkProvider&lt;T&gt;)<[TerminalLink](#TerminalLink)\>): [Disposable](#Disposable)

Register provider that enables the detection and handling of links within the terminal.

| Parameter | Description |
| --- | --- |
| provider: [TerminalLinkProvider](#TerminalLinkProvider&lt;T&gt;)<[TerminalLink](#TerminalLink)\> | The provider that provides the terminal links. |
| Returns | Description |
| [Disposable](#Disposable) | Disposable that unregisters the provider. |

registerTerminalProfileProvider(id: string, provider: [TerminalProfileProvider](#TerminalProfileProvider)): [Disposable](#Disposable)

Registers a provider for a contributed terminal profile.

| Parameter | Description |
| --- | --- |
| id: string | The ID of the contributed terminal profile. |
| provider: [TerminalProfileProvider](#TerminalProfileProvider) | The terminal profile provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [disposable](#Disposable) that unregisters the provider. |

registerTreeDataProvider<T\>(viewId: string, treeDataProvider: [TreeDataProvider](#TreeDataProvider&lt;T&gt;)<T\>): [Disposable](#Disposable)

Register a [TreeDataProvider](#TreeDataProvider) for the view contributed using the extension point `views`. This will allow you to contribute data to the [TreeView](#TreeView) and update if the data changes.

**Note:** To get access to the [TreeView](#TreeView) and perform operations on it, use [createTreeView](#window.createTreeView).

| Parameter | Description |
| --- | --- |
| viewId: string | Id of the view contributed using the extension point `views`. |
| treeDataProvider: [TreeDataProvider](#TreeDataProvider&lt;T&gt;)<T\> | A [TreeDataProvider](#TreeDataProvider) that provides tree data for the view |
| Returns | Description |
| [Disposable](#Disposable) | A [disposable](#Disposable) that unregisters the [TreeDataProvider](#TreeDataProvider). |

registerUriHandler(handler: [UriHandler](#UriHandler)): [Disposable](#Disposable)

Registers a [uri handler](#UriHandler) capable of handling system-wide [uris](#Uri). In case there are multiple windows open, the topmost window will handle the uri. A uri handler is scoped to the extension it is contributed from; it will only be able to handle uris which are directed to the extension itself. A uri must respect the following rules:

*   The uri-scheme must be `vscode.env.uriScheme`;
*   The uri-authority must be the extension id (e.g. `my.extension`);
*   The uri-path, -query and -fragment parts are arbitrary.

For example, if the `my.extension` extension registers a uri handler, it will only be allowed to handle uris with the prefix `product-name://my.extension`.

An extension can only register a single uri handler in its entire activation lifetime.

*   _Note:_ There is an activation event `onUri` that fires when a uri directed for the current extension is about to be handled.

| Parameter | Description |
| --- | --- |
| handler: [UriHandler](#UriHandler) | The uri handler to register for this extension. |
| Returns | Description |
| [Disposable](#Disposable) | A [disposable](#Disposable) that unregisters the handler. |

registerWebviewPanelSerializer(viewType: string, serializer: [WebviewPanelSerializer](#WebviewPanelSerializer&lt;T&gt;)<unknown\>): [Disposable](#Disposable)

Registers a webview panel serializer.

Extensions that support reviving should have an `"onWebviewPanel:viewType"` activation event and make sure that `registerWebviewPanelSerializer` is called during activation.

Only a single serializer may be registered at a time for a given `viewType`.

| Parameter | Description |
| --- | --- |
| viewType: string | Type of the webview panel that can be serialized. |
| serializer: [WebviewPanelSerializer](#WebviewPanelSerializer&lt;T&gt;)<unknown\> | Webview serializer. |
| Returns | Description |
| [Disposable](#Disposable) | A [disposable](#Disposable) that unregisters the serializer. |

registerWebviewViewProvider(viewId: string, provider: [WebviewViewProvider](#WebviewViewProvider), options?: {webviewOptions: {retainContextWhenHidden: boolean}}): [Disposable](#Disposable)

Register a new provider for webview views.

| Parameter | Description |
| --- | --- |
| viewId: string | Unique id of the view. This should match the `id` from the `views` contribution in the package.json. |
| provider: [WebviewViewProvider](#WebviewViewProvider) | Provider for the webview views. |
| options?: {webviewOptions: {retainContextWhenHidden: boolean}} |     |
| Returns | Description |
| [Disposable](#Disposable) | Disposable that unregisters the provider. |

setStatusBarMessage(text: string, hideAfterTimeout: number): [Disposable](#Disposable)

Set a message to the status bar. This is a short hand for the more powerful status bar [items](#window.createStatusBarItem).

| Parameter | Description |
| --- | --- |
| text: string | The message to show, supports icon substitution as in status bar [items](#StatusBarItem.text). |
| hideAfterTimeout: number | Timeout in milliseconds after which the message will be disposed. |
| Returns | Description |
| [Disposable](#Disposable) | A disposable which hides the status bar message. |

setStatusBarMessage(text: string, hideWhenDone: Thenable<any\>): [Disposable](#Disposable)

Set a message to the status bar. This is a short hand for the more powerful status bar [items](#window.createStatusBarItem).

| Parameter | Description |
| --- | --- |
| text: string | The message to show, supports icon substitution as in status bar [items](#StatusBarItem.text). |
| hideWhenDone: Thenable<any\> | Thenable on which completion (resolve or reject) the message will be disposed. |
| Returns | Description |
| [Disposable](#Disposable) | A disposable which hides the status bar message. |

setStatusBarMessage(text: string): [Disposable](#Disposable)

Set a message to the status bar. This is a short hand for the more powerful status bar [items](#window.createStatusBarItem).

_Note_ that status bar messages stack and that they must be disposed when no longer used.

| Parameter | Description |
| --- | --- |
| text: string | The message to show, supports icon substitution as in status bar [items](#StatusBarItem.text). |
| Returns | Description |
| [Disposable](#Disposable) | A disposable which hides the status bar message. |

showErrorMessage<T extends string\>(message: string, ...items: T\[\]): Thenable<T | undefined\>

Show an error message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showErrorMessage<T extends string\>(message: string, options: [MessageOptions](#MessageOptions), ...items: T\[\]): Thenable<T | undefined\>

Show an error message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| options: [MessageOptions](#MessageOptions) | Configures the behaviour of the message. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showErrorMessage<T extends [MessageItem](#MessageItem)\>(message: string, ...items: T\[\]): Thenable<T | undefined\>

Show an error message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showErrorMessage<T extends [MessageItem](#MessageItem)\>(message: string, options: [MessageOptions](#MessageOptions), ...items: T\[\]): Thenable<T | undefined\>

Show an error message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| options: [MessageOptions](#MessageOptions) | Configures the behaviour of the message. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showInformationMessage<T extends string\>(message: string, ...items: T\[\]): Thenable<T | undefined\>

Show an information message to users. Optionally provide an array of items which will be presented as clickable buttons.

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showInformationMessage<T extends string\>(message: string, options: [MessageOptions](#MessageOptions), ...items: T\[\]): Thenable<T | undefined\>

Show an information message to users. Optionally provide an array of items which will be presented as clickable buttons.

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| options: [MessageOptions](#MessageOptions) | Configures the behaviour of the message. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showInformationMessage<T extends [MessageItem](#MessageItem)\>(message: string, ...items: T\[\]): Thenable<T | undefined\>

Show an information message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showInformationMessage<T extends [MessageItem](#MessageItem)\>(message: string, options: [MessageOptions](#MessageOptions), ...items: T\[\]): Thenable<T | undefined\>

Show an information message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| options: [MessageOptions](#MessageOptions) | Configures the behaviour of the message. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showInputBox(options?: [InputBoxOptions](#InputBoxOptions), token?: [CancellationToken](#CancellationToken)): Thenable<string | undefined\>

Opens an input box to ask the user for input.

The returned value will be `undefined` if the input box was canceled (e.g., pressing ESC). Otherwise the returned value will be the string typed by the user or an empty string if the user did not type anything but dismissed the input box with OK.

| Parameter | Description |
| --- | --- |
| options?: [InputBoxOptions](#InputBoxOptions) | Configures the behavior of the input box. |
| token?: [CancellationToken](#CancellationToken) | A token that can be used to signal cancellation. |
| Returns | Description |
| Thenable<string \| undefined\> | A thenable that resolves to a string the user provided or to `undefined` in case of dismissal. |

showNotebookDocument(document: [NotebookDocument](#NotebookDocument), options?: [NotebookDocumentShowOptions](#NotebookDocumentShowOptions)): Thenable<[NotebookEditor](#NotebookEditor)\>

Show the given [NotebookDocument](#NotebookDocument) in a [notebook editor](#NotebookEditor).

| Parameter | Description |
| --- | --- |
| document: [NotebookDocument](#NotebookDocument) | A text document to be shown. |
| options?: [NotebookDocumentShowOptions](#NotebookDocumentShowOptions) | [Editor options](#NotebookDocumentShowOptions) to configure the behavior of showing the [notebook editor](#NotebookEditor). |
| Returns | Description |
| Thenable<[NotebookEditor](#NotebookEditor)\> | A promise that resolves to an [notebook editor](#NotebookEditor). |

showOpenDialog(options?: [OpenDialogOptions](#OpenDialogOptions)): Thenable<[Uri](#Uri)\[\] | undefined\>

Shows a file open dialog to the user which allows to select a file for opening-purposes.

| Parameter | Description |
| --- | --- |
| options?: [OpenDialogOptions](#OpenDialogOptions) | Options that control the dialog. |
| Returns | Description |
| Thenable<[Uri](#Uri)\[\] \| undefined\> | A promise that resolves to the selected resources or `undefined`. |

showQuickPick(items: readonly string\[\] | Thenable<readonly string\[\]>, options: [QuickPickOptions](#QuickPickOptions) & {canPickMany: true}, token?: [CancellationToken](#CancellationToken)): Thenable<string\[\] | undefined\>

Shows a selection list allowing multiple selections.

| Parameter | Description |
| --- | --- |
| items: readonly string\[\] \| Thenable<readonly string\[\]> | An array of strings, or a promise that resolves to an array of strings. |
| options: [QuickPickOptions](#QuickPickOptions) & {canPickMany: true} | Configures the behavior of the selection list. |
| token?: [CancellationToken](#CancellationToken) | A token that can be used to signal cancellation. |
| Returns | Description |
| Thenable<string\[\] \| undefined\> | A thenable that resolves to the selected items or `undefined`. |

showQuickPick(items: readonly string\[\] | Thenable<readonly string\[\]>, options?: [QuickPickOptions](#QuickPickOptions), token?: [CancellationToken](#CancellationToken)): Thenable<string | undefined\>

Shows a selection list.

| Parameter | Description |
| --- | --- |
| items: readonly string\[\] \| Thenable<readonly string\[\]> | An array of strings, or a promise that resolves to an array of strings. |
| options?: [QuickPickOptions](#QuickPickOptions) | Configures the behavior of the selection list. |
| token?: [CancellationToken](#CancellationToken) | A token that can be used to signal cancellation. |
| Returns | Description |
| Thenable<string \| undefined\> | A thenable that resolves to the selected string or `undefined`. |

showQuickPick<T extends [QuickPickItem](#QuickPickItem)\>(items: readonly T\[\] | Thenable<readonly T\[\]>, options: [QuickPickOptions](#QuickPickOptions) & {canPickMany: true}, token?: [CancellationToken](#CancellationToken)): Thenable<T\[\] | undefined\>

Shows a selection list allowing multiple selections.

| Parameter | Description |
| --- | --- |
| items: readonly T\[\] \| Thenable<readonly T\[\]> | An array of items, or a promise that resolves to an array of items. |
| options: [QuickPickOptions](#QuickPickOptions) & {canPickMany: true} | Configures the behavior of the selection list. |
| token?: [CancellationToken](#CancellationToken) | A token that can be used to signal cancellation. |
| Returns | Description |
| Thenable<T\[\] \| undefined\> | A thenable that resolves to the selected items or `undefined`. |

showQuickPick<T extends [QuickPickItem](#QuickPickItem)\>(items: readonly T\[\] | Thenable<readonly T\[\]>, options?: [QuickPickOptions](#QuickPickOptions), token?: [CancellationToken](#CancellationToken)): Thenable<T | undefined\>

Shows a selection list.

| Parameter | Description |
| --- | --- |
| items: readonly T\[\] \| Thenable<readonly T\[\]> | An array of items, or a promise that resolves to an array of items. |
| options?: [QuickPickOptions](#QuickPickOptions) | Configures the behavior of the selection list. |
| token?: [CancellationToken](#CancellationToken) | A token that can be used to signal cancellation. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined`. |

showSaveDialog(options?: [SaveDialogOptions](#SaveDialogOptions)): Thenable<[Uri](#Uri) | undefined\>

Shows a file save dialog to the user which allows to select a file for saving-purposes.

| Parameter | Description |
| --- | --- |
| options?: [SaveDialogOptions](#SaveDialogOptions) | Options that control the dialog. |
| Returns | Description |
| Thenable<[Uri](#Uri) \| undefined\> | A promise that resolves to the selected resource or `undefined`. |

showTextDocument(document: [TextDocument](#TextDocument), column?: [ViewColumn](#ViewColumn), preserveFocus?: boolean): Thenable<[TextEditor](#TextEditor)\>

Show the given document in a text editor. A [column](#ViewColumn) can be provided to control where the editor is being shown. Might change the [active editor](#window.activeTextEditor).

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | A text document to be shown. |
| column?: [ViewColumn](#ViewColumn) | A view column in which the [editor](#TextEditor) should be shown. The default is the [active](#ViewColumn.Active). Columns that do not exist will be created as needed up to the maximum of [ViewColumn.Nine](#ViewColumn.Nine). Use [ViewColumn.Beside](#ViewColumn.Beside) to open the editor to the side of the currently active one. |
| preserveFocus?: boolean | When `true` the editor will not take focus. |
| Returns | Description |
| Thenable<[TextEditor](#TextEditor)\> | A promise that resolves to an [editor](#TextEditor). |

showTextDocument(document: [TextDocument](#TextDocument), options?: [TextDocumentShowOptions](#TextDocumentShowOptions)): Thenable<[TextEditor](#TextEditor)\>

Show the given document in a text editor. [Options](#TextDocumentShowOptions) can be provided to control options of the editor is being shown. Might change the [active editor](#window.activeTextEditor).

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | A text document to be shown. |
| options?: [TextDocumentShowOptions](#TextDocumentShowOptions) | [Editor options](#TextDocumentShowOptions) to configure the behavior of showing the [editor](#TextEditor). |
| Returns | Description |
| Thenable<[TextEditor](#TextEditor)\> | A promise that resolves to an [editor](#TextEditor). |

showTextDocument(uri: [Uri](#Uri), options?: [TextDocumentShowOptions](#TextDocumentShowOptions)): Thenable<[TextEditor](#TextEditor)\>

A short-hand for `openTextDocument(uri).then(document => showTextDocument(document, options))`.

_See also_ [workspace.openTextDocument](#workspace.openTextDocument)

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| options?: [TextDocumentShowOptions](#TextDocumentShowOptions) | [Editor options](#TextDocumentShowOptions) to configure the behavior of showing the [editor](#TextEditor). |
| Returns | Description |
| Thenable<[TextEditor](#TextEditor)\> | A promise that resolves to an [editor](#TextEditor). |

showWarningMessage<T extends string\>(message: string, ...items: T\[\]): Thenable<T | undefined\>

Show a warning message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showWarningMessage<T extends string\>(message: string, options: [MessageOptions](#MessageOptions), ...items: T\[\]): Thenable<T | undefined\>

Show a warning message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| options: [MessageOptions](#MessageOptions) | Configures the behaviour of the message. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showWarningMessage<T extends [MessageItem](#MessageItem)\>(message: string, ...items: T\[\]): Thenable<T | undefined\>

Show a warning message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showWarningMessage<T extends [MessageItem](#MessageItem)\>(message: string, options: [MessageOptions](#MessageOptions), ...items: T\[\]): Thenable<T | undefined\>

Show a warning message.

_See also_ [showInformationMessage](#window.showInformationMessage)

| Parameter | Description |
| --- | --- |
| message: string | The message to show. |
| options: [MessageOptions](#MessageOptions) | Configures the behaviour of the message. |
| ...items: T\[\] | A set of items that will be rendered as actions in the message. |
| Returns | Description |
| Thenable<T \| undefined\> | A thenable that resolves to the selected item or `undefined` when being dismissed. |

showWorkspaceFolderPick(options?: [WorkspaceFolderPickOptions](#WorkspaceFolderPickOptions)): Thenable<[WorkspaceFolder](#WorkspaceFolder) | undefined\>

Shows a selection list of [workspace folders](#workspace.workspaceFolders) to pick from. Returns `undefined` if no folder is open.

| Parameter | Description |
| --- | --- |
| options?: [WorkspaceFolderPickOptions](#WorkspaceFolderPickOptions) | Configures the behavior of the workspace folder list. |
| Returns | Description |
| Thenable<[WorkspaceFolder](#WorkspaceFolder) \| undefined\> | A promise that resolves to the workspace folder or `undefined`. |

withProgress<R\>(options: [ProgressOptions](#ProgressOptions), task: (progress: [Progress](#Progress&lt;T&gt;)<{increment: number, message: string}>, token: [CancellationToken](#CancellationToken)) => Thenable<[R](#R)\>): Thenable<[R](#R)\>

Show progress in the editor. Progress is shown while running the given callback and while the promise it returned isn't resolved nor rejected. The location at which progress should show (and other details) is defined via the passed [ProgressOptions](#ProgressOptions).

| Parameter | Description |
| --- | --- |
| options: [ProgressOptions](#ProgressOptions) | A [ProgressOptions](#ProgressOptions)\-object describing the options to use for showing progress, like its location |
| task: (progress: [Progress](#Progress&lt;T&gt;)<{increment: number, message: string}>, token: [CancellationToken](#CancellationToken)) => Thenable<[R](#R)\> | A callback returning a promise. Progress state can be reported with the provided [Progress](#Progress)\-object.<br><br>To report discrete progress, use `increment` to indicate how much work has been completed. Each call with a `increment` value will be summed up and reflected as overall progress until 100% is reached (a value of e.g. `10` accounts for `10%` of work done). Note that currently only `ProgressLocation.Notification` is capable of showing discrete progress.<br><br>To monitor if the operation has been cancelled by the user, use the provided [CancellationToken](#CancellationToken). Note that currently only `ProgressLocation.Notification` is supporting to show a cancel button to cancel the long running operation. |
| Returns | Description |
| Thenable<[R](#R)\> | The thenable the task-callback returned. |

withScmProgress<R\>(task: (progress: [Progress](#Progress&lt;T&gt;)<number\>) => Thenable<[R](#R)\>): Thenable<[R](#R)\>

Show progress in the Source Control viewlet while running the given callback and while its returned promise isn't resolve or rejected.

*   _deprecated_ - Use `withProgress` instead.

| Parameter | Description |
| --- | --- |
| task: (progress: [Progress](#Progress&lt;T&gt;)<number\>) => Thenable<[R](#R)\> | A callback returning a promise. Progress increments can be reported with the provided [Progress](#Progress)\-object. |
| Returns | Description |
| Thenable<[R](#R)\> | The thenable the task did return. |

## workspace

Namespace for dealing with the current workspace. A workspace is the collection of one or more folders that are opened in an editor window (instance).

It is also possible to open an editor without a workspace. For example, when you open a new editor window by selecting a file from your platform's File menu, you will not be inside a workspace. In this mode, some of the editor's capabilities are reduced but you can still open text files and edit them.

Refer to [https://code.visualstudio.com/docs/editor/workspaces](https://code.visualstudio.com/docs/editor/workspaces) for more information on the concept of workspaces.

The workspace offers support for [listening](#workspace.createFileSystemWatcher) to fs events and for [finding](#workspace.findFiles) files. Both perform well and run _outside_ the editor-process so that they should be always used instead of nodejs-equivalents.

#### Variables

fs: [FileSystem](#FileSystem)

A [file system](#FileSystem) instance that allows to interact with local and remote files, e.g. `vscode.workspace.fs.readDirectory(someUri)` allows to retrieve all entries of a directory or `vscode.workspace.fs.stat(anotherUri)` returns the meta data for a file.

isTrusted: boolean

When true, the user has explicitly trusted the contents of the workspace.

name: string | undefined

The name of the workspace. `undefined` when no workspace has been opened.

Refer to [https://code.visualstudio.com/docs/editor/workspaces](https://code.visualstudio.com/docs/editor/workspaces) for more information on the concept of workspaces.

notebookDocuments: readonly [NotebookDocument](#NotebookDocument)\[\]

All notebook documents currently known to the editor.

rootPath: string | undefined

The uri of the first entry of [workspaceFolders](#workspace.workspaceFolders) as `string`. `undefined` if there is no first entry.

Refer to [https://code.visualstudio.com/docs/editor/workspaces](https://code.visualstudio.com/docs/editor/workspaces) for more information on workspaces.

*   _deprecated_ - Use [workspaceFolders](#workspace.workspaceFolders) instead.

textDocuments: readonly [TextDocument](#TextDocument)\[\]

All text documents currently known to the editor.

workspaceFile: [Uri](#Uri) | undefined

The location of the workspace file, for example:

`file:///Users/name/Development/myProject.code-workspace`

or

`untitled:1555503116870`

for a workspace that is untitled and not yet saved.

Depending on the workspace that is opened, the value will be:

*   `undefined` when no workspace is opened
*   the path of the workspace file as `Uri` otherwise. if the workspace is untitled, the returned URI will use the `untitled:` scheme

The location can e.g. be used with the `vscode.openFolder` command to open the workspace again after it has been closed.

**Example:**

```
vscode.commands.executeCommand('vscode.openFolder', uriOfWorkspace);
```

Refer to [https://code.visualstudio.com/docs/editor/workspaces](https://code.visualstudio.com/docs/editor/workspaces) for more information on the concept of workspaces.

**Note:** it is not advised to use `workspace.workspaceFile` to write configuration data into the file. You can use `workspace.getConfiguration().update()` for that purpose which will work both when a single folder is opened as well as an untitled or saved workspace.

workspaceFolders: readonly [WorkspaceFolder](#WorkspaceFolder)\[\] | undefined

List of workspace folders (0-N) that are open in the editor. `undefined` when no workspace has been opened.

Refer to [https://code.visualstudio.com/docs/editor/workspaces](https://code.visualstudio.com/docs/editor/workspaces) for more information on workspaces.

#### Events

onDidChangeConfiguration: [Event](#Event&lt;T&gt;)<[ConfigurationChangeEvent](#ConfigurationChangeEvent)\>

An event that is emitted when the [configuration](#WorkspaceConfiguration) changed.

onDidChangeNotebookDocument: [Event](#Event&lt;T&gt;)<[NotebookDocumentChangeEvent](#NotebookDocumentChangeEvent)\>

An event that is emitted when a [notebook](#NotebookDocument) has changed.

onDidChangeTextDocument: [Event](#Event&lt;T&gt;)<[TextDocumentChangeEvent](#TextDocumentChangeEvent)\>

An event that is emitted when a [text document](#TextDocument) is changed. This usually happens when the [contents](#TextDocument.getText) changes but also when other things like the [dirty](#TextDocument.isDirty)\-state changes.

onDidChangeWorkspaceFolders: [Event](#Event&lt;T&gt;)<[WorkspaceFoldersChangeEvent](#WorkspaceFoldersChangeEvent)\>

An event that is emitted when a workspace folder is added or removed.

**Note:** this event will not fire if the first workspace folder is added, removed or changed, because in that case the currently executing extensions (including the one that listens to this event) will be terminated and restarted so that the (deprecated) `rootPath` property is updated to point to the first workspace folder.

onDidCloseNotebookDocument: [Event](#Event&lt;T&gt;)<[NotebookDocument](#NotebookDocument)\>

An event that is emitted when a [notebook](#NotebookDocument) is disposed.

_Note 1:_ There is no guarantee that this event fires when an editor tab is closed.

_Note 2:_ A notebook can be open but not shown in an editor which means this event can fire for a notebook that has not been shown in an editor.

onDidCloseTextDocument: [Event](#Event&lt;T&gt;)<[TextDocument](#TextDocument)\>

An event that is emitted when a [text document](#TextDocument) is disposed or when the language id of a text document [has been changed](#languages.setTextDocumentLanguage).

_Note 1:_ There is no guarantee that this event fires when an editor tab is closed, use the [onDidChangeVisibleTextEditors](#window.onDidChangeVisibleTextEditors)\-event to know when editors change.

_Note 2:_ A document can be open but not shown in an editor which means this event can fire for a document that has not been shown in an editor.

onDidCreateFiles: [Event](#Event&lt;T&gt;)<[FileCreateEvent](#FileCreateEvent)\>

An event that is emitted when files have been created.

_Note:_ This event is triggered by user gestures, like creating a file from the explorer, or from the [workspace.applyEdit](#workspace.applyEdit)\-api, but this event is _not_ fired when files change on disk, e.g triggered by another application, or when using the [workspace.fs](#FileSystem)\-api.

onDidDeleteFiles: [Event](#Event&lt;T&gt;)<[FileDeleteEvent](#FileDeleteEvent)\>

An event that is emitted when files have been deleted.

_Note 1:_ This event is triggered by user gestures, like deleting a file from the explorer, or from the [workspace.applyEdit](#workspace.applyEdit)\-api, but this event is _not_ fired when files change on disk, e.g triggered by another application, or when using the [workspace.fs](#FileSystem)\-api.

_Note 2:_ When deleting a folder with children only one event is fired.

onDidGrantWorkspaceTrust: [Event](#Event&lt;T&gt;)<void\>

Event that fires when the current workspace has been trusted.

onDidOpenNotebookDocument: [Event](#Event&lt;T&gt;)<[NotebookDocument](#NotebookDocument)\>

An event that is emitted when a [notebook](#NotebookDocument) is opened.

onDidOpenTextDocument: [Event](#Event&lt;T&gt;)<[TextDocument](#TextDocument)\>

An event that is emitted when a [text document](#TextDocument) is opened or when the language id of a text document [has been changed](#languages.setTextDocumentLanguage).

To add an event listener when a visible text document is opened, use the [TextEditor](#TextEditor) events in the [window](#window) namespace. Note that:

*   The event is emitted before the [document](#TextDocument) is updated in the [active text editor](#window.activeTextEditor)
*   When a [text document](#TextDocument) is already open (e.g.: open in another [visible text editor](#window.visibleTextEditors)) this event is not emitted

onDidRenameFiles: [Event](#Event&lt;T&gt;)<[FileRenameEvent](#FileRenameEvent)\>

An event that is emitted when files have been renamed.

_Note 1:_ This event is triggered by user gestures, like renaming a file from the explorer, and from the [workspace.applyEdit](#workspace.applyEdit)\-api, but this event is _not_ fired when files change on disk, e.g triggered by another application, or when using the [workspace.fs](#FileSystem)\-api.

_Note 2:_ When renaming a folder with children only one event is fired.

onDidSaveNotebookDocument: [Event](#Event&lt;T&gt;)<[NotebookDocument](#NotebookDocument)\>

An event that is emitted when a [notebook](#NotebookDocument) is saved.

onDidSaveTextDocument: [Event](#Event&lt;T&gt;)<[TextDocument](#TextDocument)\>

An event that is emitted when a [text document](#TextDocument) is saved to disk.

onWillCreateFiles: [Event](#Event&lt;T&gt;)<[FileWillCreateEvent](#FileWillCreateEvent)\>

An event that is emitted when files are being created.

_Note 1:_ This event is triggered by user gestures, like creating a file from the explorer, or from the [workspace.applyEdit](#workspace.applyEdit)\-api. This event is _not_ fired when files change on disk, e.g triggered by another application, or when using the [workspace.fs](#FileSystem)\-api.

_Note 2:_ When this event is fired, edits to files that are are being created cannot be applied.

onWillDeleteFiles: [Event](#Event&lt;T&gt;)<[FileWillDeleteEvent](#FileWillDeleteEvent)\>

An event that is emitted when files are being deleted.

_Note 1:_ This event is triggered by user gestures, like deleting a file from the explorer, or from the [workspace.applyEdit](#workspace.applyEdit)\-api, but this event is _not_ fired when files change on disk, e.g triggered by another application, or when using the [workspace.fs](#FileSystem)\-api.

_Note 2:_ When deleting a folder with children only one event is fired.

onWillRenameFiles: [Event](#Event&lt;T&gt;)<[FileWillRenameEvent](#FileWillRenameEvent)\>

An event that is emitted when files are being renamed.

_Note 1:_ This event is triggered by user gestures, like renaming a file from the explorer, and from the [workspace.applyEdit](#workspace.applyEdit)\-api, but this event is _not_ fired when files change on disk, e.g triggered by another application, or when using the [workspace.fs](#FileSystem)\-api.

_Note 2:_ When renaming a folder with children only one event is fired.

onWillSaveNotebookDocument: [Event](#Event&lt;T&gt;)<[NotebookDocumentWillSaveEvent](#NotebookDocumentWillSaveEvent)\>

An event that is emitted when a [notebook document](#NotebookDocument) will be saved to disk.

_Note 1:_ Subscribers can delay saving by registering asynchronous work. For the sake of data integrity the editor might save without firing this event. For instance when shutting down with dirty files.

_Note 2:_ Subscribers are called sequentially and they can [delay](#NotebookDocumentWillSaveEvent.waitUntil) saving by registering asynchronous work. Protection against misbehaving listeners is implemented as such:

*   there is an overall time budget that all listeners share and if that is exhausted no further listener is called
*   listeners that take a long time or produce errors frequently will not be called anymore

The current thresholds are 1.5 seconds as overall time budget and a listener can misbehave 3 times before being ignored.

onWillSaveTextDocument: [Event](#Event&lt;T&gt;)<[TextDocumentWillSaveEvent](#TextDocumentWillSaveEvent)\>

An event that is emitted when a [text document](#TextDocument) will be saved to disk.

_Note 1:_ Subscribers can delay saving by registering asynchronous work. For the sake of data integrity the editor might save without firing this event. For instance when shutting down with dirty files.

_Note 2:_ Subscribers are called sequentially and they can [delay](#TextDocumentWillSaveEvent.waitUntil) saving by registering asynchronous work. Protection against misbehaving listeners is implemented as such:

*   there is an overall time budget that all listeners share and if that is exhausted no further listener is called
*   listeners that take a long time or produce errors frequently will not be called anymore

The current thresholds are 1.5 seconds as overall time budget and a listener can misbehave 3 times before being ignored.

#### Functions

applyEdit(edit: [WorkspaceEdit](#WorkspaceEdit), metadata?: [WorkspaceEditMetadata](#WorkspaceEditMetadata)): Thenable<boolean\>

Make changes to one or many resources or create, delete, and rename resources as defined by the given [workspace edit](#WorkspaceEdit).

All changes of a workspace edit are applied in the same order in which they have been added. If multiple textual inserts are made at the same position, these strings appear in the resulting text in the order the 'inserts' were made, unless that are interleaved with resource edits. Invalid sequences like 'delete file a' -> 'insert text in file a' cause failure of the operation.

When applying a workspace edit that consists only of text edits an 'all-or-nothing'-strategy is used. A workspace edit with resource creations or deletions aborts the operation, e.g. consecutive edits will not be attempted, when a single edit fails.

| Parameter | Description |
| --- | --- |
| edit: [WorkspaceEdit](#WorkspaceEdit) | A workspace edit. |
| metadata?: [WorkspaceEditMetadata](#WorkspaceEditMetadata) | Optional [metadata](#WorkspaceEditMetadata) for the edit. |
| Returns | Description |
| Thenable<boolean\> | A thenable that resolves when the edit could be applied. |

asRelativePath(pathOrUri: string | [Uri](#Uri), includeWorkspaceFolder?: boolean): string

Returns a path that is relative to the workspace folder or folders.

When there are no [workspace folders](#workspace.workspaceFolders) or when the path is not contained in them, the input is returned.

| Parameter | Description |
| --- | --- |
| pathOrUri: string \| [Uri](#Uri) | A path or uri. When a uri is given its [fsPath](#Uri.fsPath) is used. |
| includeWorkspaceFolder?: boolean | When `true` and when the given path is contained inside a workspace folder the name of the workspace is prepended. Defaults to `true` when there are multiple workspace folders and `false` otherwise. |
| Returns | Description |
| string | A path relative to the root or the input. |

createFileSystemWatcher(globPattern: [GlobPattern](#GlobPattern), ignoreCreateEvents?: boolean, ignoreChangeEvents?: boolean, ignoreDeleteEvents?: boolean): [FileSystemWatcher](#FileSystemWatcher)

Creates a file system watcher that is notified on file events (create, change, delete) depending on the parameters provided.

By default, all opened [workspace folders](#workspace.workspaceFolders) will be watched for file changes recursively.

Additional paths can be added for file watching by providing a [RelativePattern](#RelativePattern) with a `base` path to watch. If the path is a folder and the `pattern` is complex (e.g. contains `**` or path segments), it will be watched recursively and otherwise will be watched non-recursively (i.e. only changes to the first level of the path will be reported).

_Note_ that paths that do not exist in the file system will be monitored with a delay until created and then watched depending on the parameters provided. If a watched path is deleted, the watcher will suspend and not report any events until the path is created again.

If possible, keep the use of recursive watchers to a minimum because recursive file watching is quite resource intense.

Providing a `string` as `globPattern` acts as convenience method for watching file events in all opened workspace folders. It cannot be used to add more folders for file watching, nor will it report any file events from folders that are not part of the opened workspace folders.

_Note_ that case-sensitivity of the [globPattern](#workspace.createFileSystemWatcher.globPattern) parameter will depend on the file system where the watcher is running: on Windows and macOS the matching will be case-insensitive and on Linux it will be case-sensitive.

Optionally, flags to ignore certain kinds of events can be provided.

To stop listening to events the watcher must be disposed.

_Note_ that file events from deleting a folder may not include events for the contained files. For example, when a folder is moved to the trash, only one event is reported because technically this is a rename/move operation and not a delete operation for each files within. On top of that, performance optimizations are in place to fold multiple events that all belong to the same parent operation (e.g. delete folder) into one event for that parent. As such, if you need to know about all deleted files, you have to watch with `**` and deal with all file events yourself.

_Note_ that file events from recursive file watchers may be excluded based on user configuration. The setting `files.watcherExclude` helps to reduce the overhead of file events from folders that are known to produce many file changes at once (such as `.git` folders). As such, it is highly recommended to watch with simple patterns that do not require recursive watchers where the exclude settings are ignored and you have full control over the events.

_Note_ that symbolic links are not automatically followed for file watching unless the path to watch itself is a symbolic link.

_Note_ that the file paths that are reported for having changed may have a different path casing compared to the actual casing on disk on case-insensitive platforms (typically macOS and Windows but not Linux). We allow a user to open a workspace folder with any desired path casing and try to preserve that. This means:

*   if the path is within any of the workspace folders, the path will match the casing of the workspace folder up to that portion of the path and match the casing on disk for children
*   if the path is outside of any of the workspace folders, the casing will match the case of the path that was provided for watching In the same way, symbolic links are preserved, i.e. the file event will report the path of the symbolic link as it was provided for watching and not the target.

### Examples

The basic anatomy of a file watcher is as follows:

```
const watcher = vscode.workspace.createFileSystemWatcher(new vscode.RelativePattern(<folder>, <pattern>));

watcher.onDidChange(uri => { ... }); // listen to files being changed
watcher.onDidCreate(uri => { ... }); // listen to files/folders being created
watcher.onDidDelete(uri => { ... }); // listen to files/folders getting deleted

watcher.dispose(); // dispose after usage
```

#### Workspace file watching

If you only care about file events in a specific workspace folder:

```
vscode.workspace.createFileSystemWatcher(
  new vscode.RelativePattern(vscode.workspace.workspaceFolders[0], '**/*.js')
);
```

If you want to monitor file events across all opened workspace folders:

```
vscode.workspace.createFileSystemWatcher('**/*.js');
```

_Note:_ the array of workspace folders can be empty if no workspace is opened (empty window).

#### Out of workspace file watching

To watch a folder for changes to \*.js files outside the workspace (non recursively), pass in a `Uri` to such a folder:

```
vscode.workspace.createFileSystemWatcher(new vscode.RelativePattern(vscode.Uri.file(<path to folder outside workspace>), '*.js'));
```

And use a complex glob pattern to watch recursively:

```
vscode.workspace.createFileSystemWatcher(new vscode.RelativePattern(vscode.Uri.file(<path to folder outside workspace>), '**/*.js'));
```

Here is an example for watching the active editor for file changes:

```
vscode.workspace.createFileSystemWatcher(
  new vscode.RelativePattern(vscode.window.activeTextEditor.document.uri, '*')
);
```

| Parameter | Description |
| --- | --- |
| globPattern: [GlobPattern](#GlobPattern) | A [glob pattern](#GlobPattern) that controls which file events the watcher should report. |
| ignoreCreateEvents?: boolean | Ignore when files have been created. |
| ignoreChangeEvents?: boolean | Ignore when files have been changed. |
| ignoreDeleteEvents?: boolean | Ignore when files have been deleted. |
| Returns | Description |
| [FileSystemWatcher](#FileSystemWatcher) | A new file system watcher instance. Must be disposed when no longer needed. |

decode(content: Uint8Array): Thenable<string\>

Decodes the content from a `Uint8Array` to a `string`. You MUST provide the entire content at once to ensure that the encoding can properly apply. Do not use this method to decode content in chunks, as that may lead to incorrect results.

Will pick an encoding based on settings and the content of the buffer (for example byte order marks).

_Note_ that if you decode content that is unsupported by the encoding, the result may contain substitution characters as appropriate.

*   _throws_ - This method will throw an error when the content is binary.

| Parameter | Description |
| --- | --- |
| content: Uint8Array | The text content to decode as a `Uint8Array`. |
| Returns | Description |
| Thenable<string\> | A thenable that resolves to the decoded `string`. |

decode(content: Uint8Array, options: {encoding: string}): Thenable<string\>

Decodes the content from a `Uint8Array` to a `string` using the provided encoding. You MUST provide the entire content at once to ensure that the encoding can properly apply. Do not use this method to decode content in chunks, as that may lead to incorrect results.

_Note_ that if you decode content that is unsupported by the encoding, the result may contain substitution characters as appropriate.

*   _throws_ - This method will throw an error when the content is binary.

| Parameter | Description |
| --- | --- |
| content: Uint8Array | The text content to decode as a `Uint8Array`. |
| options: {encoding: string} | Additional context for picking the encoding. |
| Returns | Description |
| Thenable<string\> | A thenable that resolves to the decoded `string`. |

decode(content: Uint8Array, options: {uri: [Uri](#Uri)}): Thenable<string\>

Decodes the content from a `Uint8Array` to a `string`. You MUST provide the entire content at once to ensure that the encoding can properly apply. Do not use this method to decode content in chunks, as that may lead to incorrect results.

The encoding is picked based on settings and the content of the buffer (for example byte order marks).

_Note_ that if you decode content that is unsupported by the encoding, the result may contain substitution characters as appropriate.

*   _throws_ - This method will throw an error when the content is binary.

| Parameter | Description |
| --- | --- |
| content: Uint8Array | The content to decode as a `Uint8Array`. |
| options: {uri: [Uri](#Uri)} | Additional context for picking the encoding. |
| Returns | Description |
| Thenable<string\> | A thenable that resolves to the decoded `string`. |

encode(content: string): Thenable<Uint8Array\>

Encodes the content of a `string` to a `Uint8Array`.

Will pick an encoding based on settings.

| Parameter | Description |
| --- | --- |
| content: string | The content to decode as a `string`. |
| Returns | Description |
| Thenable<Uint8Array\> | A thenable that resolves to the encoded `Uint8Array`. |

encode(content: string, options: {encoding: string}): Thenable<Uint8Array\>

Encodes the content of a `string` to a `Uint8Array` using the provided encoding.

| Parameter | Description |
| --- | --- |
| content: string | The content to decode as a `string`. |
| options: {encoding: string} | Additional context for picking the encoding. |
| Returns | Description |
| Thenable<Uint8Array\> | A thenable that resolves to the encoded `Uint8Array`. |

encode(content: string, options: {uri: [Uri](#Uri)}): Thenable<Uint8Array\>

Encodes the content of a `string` to a `Uint8Array`.

The encoding is picked based on settings.

| Parameter | Description |
| --- | --- |
| content: string | The content to decode as a `string`. |
| options: {uri: [Uri](#Uri)} | Additional context for picking the encoding. |
| Returns | Description |
| Thenable<Uint8Array\> | A thenable that resolves to the encoded `Uint8Array`. |

findFiles(include: [GlobPattern](#GlobPattern), exclude?: [GlobPattern](#GlobPattern), maxResults?: number, token?: [CancellationToken](#CancellationToken)): Thenable<[Uri](#Uri)\[\]>

Find files across all [workspace folders](#workspace.workspaceFolders) in the workspace.

**Example**

```
findFiles('**/*.js', '**/node_modules/**', 10);
```

| Parameter | Description |
| --- | --- |
| include: [GlobPattern](#GlobPattern) | A [glob pattern](#GlobPattern) that defines the files to search for. The glob pattern will be matched against the file paths of resulting matches relative to their workspace. Use a [relative pattern](#RelativePattern) to restrict the search results to a [workspace folder](#WorkspaceFolder). |
| exclude?: [GlobPattern](#GlobPattern) | A [glob pattern](#GlobPattern) that defines files and folders to exclude. The glob pattern will be matched against the file paths of resulting matches relative to their workspace. When `undefined`, default file-excludes (e.g. the `files.exclude`\-setting but not `search.exclude`) will apply. When `null`, no excludes will apply. |
| maxResults?: number | An upper-bound for the result. |
| token?: [CancellationToken](#CancellationToken) | A token that can be used to signal cancellation to the underlying search engine. |
| Returns | Description |
| Thenable<[Uri](#Uri)\[\]> | A thenable that resolves to an array of resource identifiers. Will return no results if no [workspace folders](#workspace.workspaceFolders) are opened. |

getConfiguration(section?: string, scope?: [ConfigurationScope](#ConfigurationScope)): [WorkspaceConfiguration](#WorkspaceConfiguration)

Get a workspace configuration object.

When a section-identifier is provided only that part of the configuration is returned. Dots in the section-identifier are interpreted as child-access, like `{ myExt: { setting: { doIt: true }}}` and `getConfiguration('myExt.setting').get('doIt') === true`.

When a scope is provided configuration confined to that scope is returned. Scope can be a resource or a language identifier or both.

| Parameter | Description |
| --- | --- |
| section?: string | A dot-separated identifier. |
| scope?: [ConfigurationScope](#ConfigurationScope) | A scope for which the configuration is asked for. |
| Returns | Description |
| [WorkspaceConfiguration](#WorkspaceConfiguration) | The full configuration or a subset. |

getWorkspaceFolder(uri: [Uri](#Uri)): [WorkspaceFolder](#WorkspaceFolder) | undefined

Returns the [workspace folder](#WorkspaceFolder) that contains a given uri.

*   returns `undefined` when the given uri doesn't match any workspace folder
*   returns the _input_ when the given uri is a workspace folder itself

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | An uri. |
| Returns | Description |
| [WorkspaceFolder](#WorkspaceFolder) \| undefined | A workspace folder or `undefined` |

openNotebookDocument(uri: [Uri](#Uri)): Thenable<[NotebookDocument](#NotebookDocument)\>

Open a notebook. Will return early if this notebook is already [loaded](#workspace.notebookDocuments). Otherwise the notebook is loaded and the [onDidOpenNotebookDocument](#workspace.onDidOpenNotebookDocument)\-event fires.

_Note_ that the lifecycle of the returned notebook is owned by the editor and not by the extension. That means an [onDidCloseNotebookDocument](#workspace.onDidCloseNotebookDocument)\-event can occur at any time after.

_Note_ that opening a notebook does not show a notebook editor. This function only returns a notebook document which can be shown in a notebook editor but it can also be used for other things.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The resource to open. |
| Returns | Description |
| Thenable<[NotebookDocument](#NotebookDocument)\> | A promise that resolves to a [notebook](#NotebookDocument) |

openNotebookDocument(notebookType: string, content?: [NotebookData](#NotebookData)): Thenable<[NotebookDocument](#NotebookDocument)\>

Open an untitled notebook. The editor will prompt the user for a file path when the document is to be saved.

_See also_ [workspace.openNotebookDocument](#workspace.openNotebookDocument)

| Parameter | Description |
| --- | --- |
| notebookType: string | The notebook type that should be used. |
| content?: [NotebookData](#NotebookData) | The initial contents of the notebook. |
| Returns | Description |
| Thenable<[NotebookDocument](#NotebookDocument)\> | A promise that resolves to a [notebook](#NotebookDocument). |

openTextDocument(uri: [Uri](#Uri), options?: {encoding: string}): Thenable<[TextDocument](#TextDocument)\>

Opens a document. Will return early if this document is already open. Otherwise the document is loaded and the [didOpen](#workspace.onDidOpenTextDocument)\-event fires.

The document is denoted by an [Uri](#Uri). Depending on the [scheme](#Uri.scheme) the following rules apply:

*   `file`\-scheme: Open a file on disk (`openTextDocument(Uri.file(path))`). Will be rejected if the file does not exist or cannot be loaded.
*   `untitled`\-scheme: Open a blank untitled file with associated path (`openTextDocument(Uri.file(path).with({ scheme: 'untitled' }))`). The language will be derived from the file name.
*   For all other schemes contributed [text document content providers](#TextDocumentContentProvider) and [file system providers](#FileSystemProvider) are consulted.

_Note_ that the lifecycle of the returned document is owned by the editor and not by the extension. That means an [onDidClose](#workspace.onDidCloseTextDocument)\-event can occur at any time after opening it.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | Identifies the resource to open. |
| options?: {encoding: string} |     |
| Returns | Description |
| Thenable<[TextDocument](#TextDocument)\> | A promise that resolves to a [document](#TextDocument). |

openTextDocument(path: string, options?: {encoding: string}): Thenable<[TextDocument](#TextDocument)\>

A short-hand for `openTextDocument(Uri.file(path))`.

_See also_ [workspace.openTextDocument](#workspace.openTextDocument)

| Parameter | Description |
| --- | --- |
| path: string | A path of a file on disk. |
| options?: {encoding: string} |     |
| Returns | Description |
| Thenable<[TextDocument](#TextDocument)\> | A promise that resolves to a [document](#TextDocument). |

openTextDocument(options?: {content: string, encoding: string, language: string}): Thenable<[TextDocument](#TextDocument)\>

Opens an untitled text document. The editor will prompt the user for a file path when the document is to be saved. The `options` parameter allows to specify the _language_ and/or the _content_ of the document.

| Parameter | Description |
| --- | --- |
| options?: {content: string, encoding: string, language: string} | Options to control how the document will be created. |
| Returns | Description |
| Thenable<[TextDocument](#TextDocument)\> | A promise that resolves to a [document](#TextDocument). |

registerFileSystemProvider(scheme: string, provider: [FileSystemProvider](#FileSystemProvider), options?: {isCaseSensitive: boolean, isReadonly: boolean | [MarkdownString](#MarkdownString)}): [Disposable](#Disposable)

Register a filesystem provider for a given scheme, e.g. `ftp`.

There can only be one provider per scheme and an error is being thrown when a scheme has been claimed by another provider or when it is reserved.

| Parameter | Description |
| --- | --- |
| scheme: string | The uri-[scheme](#Uri.scheme) the provider registers for. |
| provider: [FileSystemProvider](#FileSystemProvider) | The filesystem provider. |
| options?: {isCaseSensitive: boolean, isReadonly: boolean \| [MarkdownString](#MarkdownString)} | Immutable metadata about the provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerNotebookSerializer(notebookType: string, serializer: [NotebookSerializer](#NotebookSerializer), options?: [NotebookDocumentContentOptions](#NotebookDocumentContentOptions)): [Disposable](#Disposable)

Register a [notebook serializer](#NotebookSerializer).

A notebook serializer must be contributed through the `notebooks` extension point. When opening a notebook file, the editor will send the `onNotebook:<notebookType>` activation event, and extensions must register their serializer in return.

| Parameter | Description |
| --- | --- |
| notebookType: string | A notebook. |
| serializer: [NotebookSerializer](#NotebookSerializer) | A notebook serializer. |
| options?: [NotebookDocumentContentOptions](#NotebookDocumentContentOptions) | Optional context options that define what parts of a notebook should be persisted |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this serializer when being disposed. |

registerTaskProvider(type: string, provider: [TaskProvider](#TaskProvider&lt;T&gt;)<[Task](#Task)\>): [Disposable](#Disposable)

Register a task provider.

*   _deprecated_ - Use the corresponding function on the `tasks` namespace instead

| Parameter | Description |
| --- | --- |
| type: string | The task kind type this provider is registered for. |
| provider: [TaskProvider](#TaskProvider&lt;T&gt;)<[Task](#Task)\> | A task provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

registerTextDocumentContentProvider(scheme: string, provider: [TextDocumentContentProvider](#TextDocumentContentProvider)): [Disposable](#Disposable)

Register a text document content provider.

Only one provider can be registered per scheme.

| Parameter | Description |
| --- | --- |
| scheme: string | The uri-scheme to register for. |
| provider: [TextDocumentContentProvider](#TextDocumentContentProvider) | A content provider. |
| Returns | Description |
| [Disposable](#Disposable) | A [Disposable](#Disposable) that unregisters this provider when being disposed. |

save(uri: [Uri](#Uri)): Thenable<[Uri](#Uri) | undefined\>

Saves the editor identified by the given resource and returns the resulting resource or `undefined` if save was not successful or no editor with the given resource was found.

**Note** that an editor with the provided resource must be opened in order to be saved.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | the associated uri for the opened editor to save. |
| Returns | Description |
| Thenable<[Uri](#Uri) \| undefined\> | A thenable that resolves when the save operation has finished. |

saveAll(includeUntitled?: boolean): Thenable<boolean\>

Save all dirty files.

| Parameter | Description |
| --- | --- |
| includeUntitled?: boolean | Also save files that have been created during this session. |
| Returns | Description |
| Thenable<boolean\> | A thenable that resolves when the files have been saved. Will return `false` for any file that failed to save. |

saveAs(uri: [Uri](#Uri)): Thenable<[Uri](#Uri) | undefined\>

Saves the editor identified by the given resource to a new file name as provided by the user and returns the resulting resource or `undefined` if save was not successful or cancelled or no editor with the given resource was found.

**Note** that an editor with the provided resource must be opened in order to be saved as.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | the associated uri for the opened editor to save as. |
| Returns | Description |
| Thenable<[Uri](#Uri) \| undefined\> | A thenable that resolves when the save-as operation has finished. |

updateWorkspaceFolders(start: number, deleteCount: number, ...workspaceFoldersToAdd: Array<{name: string, uri: [Uri](#Uri)}>): boolean

This method replaces `deleteCount` [workspace folders](#workspace.workspaceFolders) starting at index `start` by an optional set of `workspaceFoldersToAdd` on the `vscode.workspace.workspaceFolders` array. This "splice" behavior can be used to add, remove and change workspace folders in a single operation.

**Note:** in some cases calling this method may result in the currently executing extensions (including the one that called this method) to be terminated and restarted. For example when the first workspace folder is added, removed or changed the (deprecated) `rootPath` property is updated to point to the first workspace folder. Another case is when transitioning from an empty or single-folder workspace into a multi-folder workspace (see also: [https://code.visualstudio.com/docs/editor/workspaces](https://code.visualstudio.com/docs/editor/workspaces)).

Use the [onDidChangeWorkspaceFolders()](#workspace.onDidChangeWorkspaceFolders) event to get notified when the workspace folders have been updated.

**Example:** adding a new workspace folder at the end of workspace folders

```
workspace.updateWorkspaceFolders(workspace.workspaceFolders ? workspace.workspaceFolders.length : 0, null, { uri: ...});
```

**Example:** removing the first workspace folder

```
workspace.updateWorkspaceFolders(0, 1);
```

**Example:** replacing an existing workspace folder with a new one

```
workspace.updateWorkspaceFolders(0, 1, { uri: ...});
```

It is valid to remove an existing workspace folder and add it again with a different name to rename that folder.

**Note:** it is not valid to call [updateWorkspaceFolders()](#workspace.updateWorkspaceFolders) multiple times without waiting for the [onDidChangeWorkspaceFolders()](#workspace.onDidChangeWorkspaceFolders) to fire.

| Parameter | Description |
| --- | --- |
| start: number | the zero-based location in the list of currently opened [workspace folders](#WorkspaceFolder) from which to start deleting workspace folders. |
| deleteCount: number | the optional number of workspace folders to remove. |
| ...workspaceFoldersToAdd: Array<{name: string, uri: [Uri](#Uri)}> | the optional variable set of workspace folders to add in place of the deleted ones. Each workspace is identified with a mandatory URI and an optional name. |
| Returns | Description |
| boolean | true if the operation was successfully started and false otherwise if arguments were used that would result in invalid workspace folder state (e.g. 2 folders with the same URI). |

### AccessibilityInformation

Accessibility information which controls screen reader behavior.

#### Properties

label: string

Label to be read out by a screen reader once the item has focus.

role?: string

Role of the widget which defines how a screen reader interacts with it. The role should be set in special cases when for example a tree-like element behaves like a checkbox. If role is not specified the editor will pick the appropriate role automatically. More about aria roles can be found here [https://w3c.github.io/aria/#widget\_roles](https://w3c.github.io/aria/#widget_roles)

### AuthenticationForceNewSessionOptions

Optional options to be used when calling [authentication.getSession](#authentication.getSession) with the flag `forceNewSession`.

*   _deprecated_ - Use [AuthenticationGetSessionPresentationOptions](#AuthenticationGetSessionPresentationOptions) instead.

AuthenticationForceNewSessionOptions: [AuthenticationGetSessionPresentationOptions](#AuthenticationGetSessionPresentationOptions)

### AuthenticationGetSessionOptions

Options to be used when getting an [AuthenticationSession](#AuthenticationSession) from an [AuthenticationProvider](#AuthenticationProvider).

#### Properties

account?: [AuthenticationSessionAccountInformation](#AuthenticationSessionAccountInformation)

The account that you would like to get a session for. This is passed down to the Authentication Provider to be used for creating the correct session.

clearSessionPreference?: boolean

Whether the existing session preference should be cleared.

For authentication providers that support being signed into multiple accounts at once, the user will be prompted to select an account to use when [getSession](#authentication.getSession) is called. This preference is remembered until [getSession](#authentication.getSession) is called with this flag.

Note: The preference is extension specific. So if one extension calls [getSession](#authentication.getSession), it will not affect the session preference for another extension calling [getSession](#authentication.getSession). Additionally, the preference is set for the current workspace and also globally. This means that new workspaces will use the "global" value at first and then when this flag is provided, a new value can be set for that workspace. This also means that pre-existing workspaces will not lose their preference if a new workspace sets this flag.

Defaults to false.

createIfNone?: boolean | [AuthenticationGetSessionPresentationOptions](#AuthenticationGetSessionPresentationOptions)

Whether login should be performed if there is no matching session.

If true, a modal dialog will be shown asking the user to sign in. If false, a numbered badge will be shown on the accounts activity bar icon. An entry for the extension will be added under the menu to sign in. This allows quietly prompting the user to sign in.

If you provide options, you will also see the dialog but with the additional context provided.

If there is a matching session but the extension has not been granted access to it, setting this to true will also result in an immediate modal dialog, and false will add a numbered badge to the accounts icon.

Defaults to false.

Note: you cannot use this option with [silent](#AuthenticationGetSessionOptions.silent).

forceNewSession?: boolean | [AuthenticationGetSessionPresentationOptions](#AuthenticationGetSessionPresentationOptions)

Whether we should attempt to reauthenticate even if there is already a session available.

If true, a modal dialog will be shown asking the user to sign in again. This is mostly used for scenarios where the token needs to be re minted because it has lost some authorization.

If you provide options, you will also see the dialog but with the additional context provided.

If there are no existing sessions and forceNewSession is true, it will behave identically to [createIfNone](#AuthenticationGetSessionOptions.createIfNone).

This defaults to false.

silent?: boolean

Whether we should show the indication to sign in in the Accounts menu.

If false, the user will be shown a badge on the Accounts menu with an option to sign in for the extension. If true, no indication will be shown.

Defaults to false.

Note: you cannot use this option with any other options that prompt the user like [createIfNone](#AuthenticationGetSessionOptions.createIfNone).

### AuthenticationGetSessionPresentationOptions

Optional options to be used when calling [authentication.getSession](#authentication.getSession) with interactive options `forceNewSession` & `createIfNone`.

#### Properties

detail?: string

An optional message that will be displayed to the user when we ask to re-authenticate. Providing additional context as to why you are asking a user to re-authenticate can help increase the odds that they will accept.

### AuthenticationProvider

A provider for performing authentication to a service.

#### Events

onDidChangeSessions: [Event](#Event&lt;T&gt;)<[AuthenticationProviderAuthenticationSessionsChangeEvent](#AuthenticationProviderAuthenticationSessionsChangeEvent)\>

An [Event](#Event) which fires when the array of sessions has changed, or data within a session has changed.

#### Methods

createSession(scopes: readonly string\[\], options: [AuthenticationProviderSessionOptions](#AuthenticationProviderSessionOptions)): Thenable<[AuthenticationSession](#AuthenticationSession)\>

Prompts a user to login.

If login is successful, the onDidChangeSessions event should be fired.

If login fails, a rejected promise should be returned.

If the provider has specified that it does not support multiple accounts, then this should never be called if there is already an existing session matching these scopes.

| Parameter | Description |
| --- | --- |
| scopes: readonly string\[\] | A list of scopes, permissions, that the new session should be created with. |
| options: [AuthenticationProviderSessionOptions](#AuthenticationProviderSessionOptions) | Additional options for creating a session. |
| Returns | Description |
| Thenable<[AuthenticationSession](#AuthenticationSession)\> | A promise that resolves to an authentication session. |

getSessions(scopes: readonly string\[\], options: [AuthenticationProviderSessionOptions](#AuthenticationProviderSessionOptions)): Thenable<[AuthenticationSession](#AuthenticationSession)\[\]>

Get a list of sessions.

| Parameter | Description |
| --- | --- |
| scopes: readonly string\[\] | An optional list of scopes. If provided, the sessions returned should match these permissions, otherwise all sessions should be returned. |
| options: [AuthenticationProviderSessionOptions](#AuthenticationProviderSessionOptions) | Additional options for getting sessions. |
| Returns | Description |
| Thenable<[AuthenticationSession](#AuthenticationSession)\[\]> | A promise that resolves to an array of authentication sessions. |

removeSession(sessionId: string): Thenable<void\>

Removes the session corresponding to session id.

If the removal is successful, the onDidChangeSessions event should be fired.

If a session cannot be removed, the provider should reject with an error message.

| Parameter | Description |
| --- | --- |
| sessionId: string | The id of the session to remove. |
| Returns | Description |
| Thenable<void\> |     |

### AuthenticationProviderAuthenticationSessionsChangeEvent

An [Event](#Event) which fires when an [AuthenticationSession](#AuthenticationSession) is added, removed, or changed.

#### Properties

added: readonly [AuthenticationSession](#AuthenticationSession)\[\]

The [AuthenticationSessions](#AuthenticationSession) of the [AuthenticationProvider](#AuthenticationProvider) that have been added.

changed: readonly [AuthenticationSession](#AuthenticationSession)\[\]

The [AuthenticationSessions](#AuthenticationSession) of the [AuthenticationProvider](#AuthenticationProvider) that have been changed. A session changes when its data excluding the id are updated. An example of this is a session refresh that results in a new access token being set for the session.

removed: readonly [AuthenticationSession](#AuthenticationSession)\[\]

The [AuthenticationSessions](#AuthenticationSession) of the [AuthenticationProvider](#AuthenticationProvider) that have been removed.

### AuthenticationProviderInformation

Basic information about an [AuthenticationProvider](#AuthenticationProvider)

#### Properties

id: string

The unique identifier of the authentication provider.

label: string

The human-readable name of the authentication provider.

### AuthenticationProviderOptions

Options for creating an [AuthenticationProvider](#AuthenticationProvider).

#### Properties

supportsMultipleAccounts?: boolean

Whether it is possible to be signed into multiple accounts at once with this provider. If not specified, will default to false.

### AuthenticationProviderSessionOptions

The options passed in to the [AuthenticationProvider.getSessions](#AuthenticationProvider.getSessions) and [AuthenticationProvider.createSession](#AuthenticationProvider.createSession) call.

#### Properties

account?: [AuthenticationSessionAccountInformation](#AuthenticationSessionAccountInformation)

The account that is being asked about. If this is passed in, the provider should attempt to return the sessions that are only related to this account.

### AuthenticationSession

Represents a session of a currently logged in user.

#### Properties

accessToken: string

The access token. This token should be used to authenticate requests to a service. Popularized by OAuth.

*   _reference_ - [https://oauth.net/2/access-tokens/](https://oauth.net/2/access-tokens/)

account: [AuthenticationSessionAccountInformation](#AuthenticationSessionAccountInformation)

The account associated with the session.

id: string

The identifier of the authentication session.

idToken?: string

The ID token. This token contains identity information about the user. Popularized by OpenID Connect.

*   _reference_ - [https://openid.net/specs/openid-connect-core-1\_0.html#IDToken](https://openid.net/specs/openid-connect-core-1_0.html#IDToken)

scopes: readonly string\[\]

The permissions granted by the session's access token. Available scopes are defined by the [AuthenticationProvider](#AuthenticationProvider).

### AuthenticationSessionAccountInformation

The information of an account associated with an [AuthenticationSession](#AuthenticationSession).

#### Properties

id: string

The unique identifier of the account.

label: string

The human-readable name of the account.

### AuthenticationSessionsChangeEvent

An [Event](#Event) which fires when an [AuthenticationSession](#AuthenticationSession) is added, removed, or changed.

#### Properties

provider: [AuthenticationProviderInformation](#AuthenticationProviderInformation)

The [AuthenticationProvider](#AuthenticationProvider) that has had its sessions change.

### AuthenticationWwwAuthenticateRequest

Represents parameters for creating a session based on a WWW-Authenticate header value. This is used when an API returns a 401 with a WWW-Authenticate header indicating that additional authentication is required. The details of which will be passed down to the authentication provider to create a session.

*   _note_ - The authorization provider must support handling challenges and specifically the challenges in this WWW-Authenticate value.

*   _note_ - For more information on WWW-Authenticate please see [https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/WWW-Authenticate](https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/WWW-Authenticate)

#### Properties

fallbackScopes?: readonly string\[\]

The fallback scopes to use if no scopes are found in the WWW-Authenticate header.

wwwAuthenticate: string

The raw WWW-Authenticate header value that triggered this challenge. This will be parsed by the authentication provider to extract the necessary challenge information.

### AutoClosingPair

Describes pairs of strings where the close string will be automatically inserted when typing the opening string.

#### Properties

close: string

The closing string that will be automatically inserted when typing the opening string.

notIn?: [SyntaxTokenType](#SyntaxTokenType)\[\]

A set of tokens where the pair should not be auto closed.

open: string

The string that will trigger the automatic insertion of the closing string.

### BranchCoverage

Contains coverage information for a branch of a [StatementCoverage](#StatementCoverage).

#### Constructors

new BranchCoverage(executed: number | boolean, location?: [Range](#Range) | [Position](#Position), label?: string): [BranchCoverage](#BranchCoverage)

| Parameter | Description |
| --- | --- |
| executed: number \| boolean | The number of times this branch was executed, or a boolean indicating whether it was executed if the exact count is unknown. If zero or false, the branch will be marked as un-covered. |
| location?: [Range](#Range) \| [Position](#Position) | The branch position. |
| label?: string |     |
| Returns | Description |
| [BranchCoverage](#BranchCoverage) |     |

#### Properties

executed: number | boolean

The number of times this branch was executed, or a boolean indicating whether it was executed if the exact count is unknown. If zero or false, the branch will be marked as un-covered.

label?: string

Label for the branch, used in the context of "the ${label} branch was not taken," for example.

location?: [Range](#Range) | [Position](#Position)

Branch location.

### Breakpoint

The base class of all breakpoint types.

#### Constructors

new Breakpoint(enabled?: boolean, condition?: string, hitCondition?: string, logMessage?: string): [Breakpoint](#Breakpoint)

Creates a new breakpoint

| Parameter | Description |
| --- | --- |
| enabled?: boolean | Is breakpoint enabled. |
| condition?: string | Expression for conditional breakpoints |
| hitCondition?: string | Expression that controls how many hits of the breakpoint are ignored |
| logMessage?: string | Log message to display when breakpoint is hit |
| Returns | Description |
| [Breakpoint](#Breakpoint) |     |

#### Properties

condition?: string

An optional expression for conditional breakpoints.

enabled: boolean

Is breakpoint enabled.

hitCondition?: string

An optional expression that controls how many hits of the breakpoint are ignored.

id: string

The unique ID of the breakpoint.

logMessage?: string

An optional message that gets logged when this breakpoint is hit. Embedded expressions within {} are interpolated by the debug adapter.

### BreakpointsChangeEvent

An event describing the changes to the set of [breakpoints](#Breakpoint).

#### Properties

added: readonly [Breakpoint](#Breakpoint)\[\]

Added breakpoints.

changed: readonly [Breakpoint](#Breakpoint)\[\]

Changed breakpoints.

removed: readonly [Breakpoint](#Breakpoint)\[\]

Removed breakpoints.

### CallHierarchyIncomingCall

Represents an incoming call, e.g. a caller of a method or constructor.

#### Constructors

new CallHierarchyIncomingCall(item: [CallHierarchyItem](#CallHierarchyItem), fromRanges: [Range](#Range)\[\]): [CallHierarchyIncomingCall](#CallHierarchyIncomingCall)

Create a new call object.

| Parameter | Description |
| --- | --- |
| item: [CallHierarchyItem](#CallHierarchyItem) | The item making the call. |
| fromRanges: [Range](#Range)\[\] | The ranges at which the calls appear. |
| Returns | Description |
| [CallHierarchyIncomingCall](#CallHierarchyIncomingCall) |     |

#### Properties

from: [CallHierarchyItem](#CallHierarchyItem)

The item that makes the call.

fromRanges: [Range](#Range)\[\]

The range at which at which the calls appears. This is relative to the caller denoted by [this.from](#CallHierarchyIncomingCall.from).

### CallHierarchyItem

Represents programming constructs like functions or constructors in the context of call hierarchy.

#### Constructors

new CallHierarchyItem(kind: [SymbolKind](#SymbolKind), name: string, detail: string, uri: [Uri](#Uri), range: [Range](#Range), selectionRange: [Range](#Range)): [CallHierarchyItem](#CallHierarchyItem)

Creates a new call hierarchy item.

| Parameter | Description |
| --- | --- |
| kind: [SymbolKind](#SymbolKind) |     |
| name: string |     |
| detail: string |     |
| uri: [Uri](#Uri) |     |
| range: [Range](#Range) |     |
| selectionRange: [Range](#Range) |     |
| Returns | Description |
| [CallHierarchyItem](#CallHierarchyItem) |     |

#### Properties

detail?: string

More detail for this item, e.g. the signature of a function.

kind: [SymbolKind](#SymbolKind)

The kind of this item.

name: string

The name of this item.

range: [Range](#Range)

The range enclosing this symbol not including leading/trailing whitespace but everything else, e.g. comments and code.

selectionRange: [Range](#Range)

The range that should be selected and revealed when this symbol is being picked, e.g. the name of a function. Must be contained by the [range](#CallHierarchyItem.range).

tags?: readonly [SymbolTag](#SymbolTag)\[\]

Tags for this item.

uri: [Uri](#Uri)

The resource identifier of this item.

### CallHierarchyOutgoingCall

Represents an outgoing call, e.g. calling a getter from a method or a method from a constructor etc.

#### Constructors

new CallHierarchyOutgoingCall(item: [CallHierarchyItem](#CallHierarchyItem), fromRanges: [Range](#Range)\[\]): [CallHierarchyOutgoingCall](#CallHierarchyOutgoingCall)

Create a new call object.

| Parameter | Description |
| --- | --- |
| item: [CallHierarchyItem](#CallHierarchyItem) | The item being called |
| fromRanges: [Range](#Range)\[\] | The ranges at which the calls appear. |
| Returns | Description |
| [CallHierarchyOutgoingCall](#CallHierarchyOutgoingCall) |     |

#### Properties

fromRanges: [Range](#Range)\[\]

The range at which this item is called. This is the range relative to the caller, e.g the item passed to [provideCallHierarchyOutgoingCalls](#CallHierarchyProvider.provideCallHierarchyOutgoingCalls) and not [this.to](#CallHierarchyOutgoingCall.to).

to: [CallHierarchyItem](#CallHierarchyItem)

The item that is called.

### CallHierarchyProvider

The call hierarchy provider interface describes the contract between extensions and the call hierarchy feature which allows to browse calls and caller of function, methods, constructor etc.

#### Methods

prepareCallHierarchy(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[CallHierarchyItem](#CallHierarchyItem) | [CallHierarchyItem](#CallHierarchyItem)\[\]>

Bootstraps call hierarchy by returning the item that is denoted by the given document and position. This item will be used as entry into the call graph. Providers should return `undefined` or `null` when there is no item at the given location.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[CallHierarchyItem](#CallHierarchyItem) \| [CallHierarchyItem](#CallHierarchyItem)\[\]> | One or multiple call hierarchy items or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

provideCallHierarchyIncomingCalls(item: [CallHierarchyItem](#CallHierarchyItem), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[CallHierarchyIncomingCall](#CallHierarchyIncomingCall)\[\]>

Provide all incoming calls for an item, e.g all callers for a method. In graph terms this describes directed and annotated edges inside the call graph, e.g the given item is the starting node and the result is the nodes that can be reached.

| Parameter | Description |
| --- | --- |
| item: [CallHierarchyItem](#CallHierarchyItem) | The hierarchy item for which incoming calls should be computed. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[CallHierarchyIncomingCall](#CallHierarchyIncomingCall)\[\]> | A set of incoming calls or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

provideCallHierarchyOutgoingCalls(item: [CallHierarchyItem](#CallHierarchyItem), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[CallHierarchyOutgoingCall](#CallHierarchyOutgoingCall)\[\]>

Provide all outgoing calls for an item, e.g call calls to functions, methods, or constructors from the given item. In graph terms this describes directed and annotated edges inside the call graph, e.g the given item is the starting node and the result is the nodes that can be reached.

| Parameter | Description |
| --- | --- |
| item: [CallHierarchyItem](#CallHierarchyItem) | The hierarchy item for which outgoing calls should be computed. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[CallHierarchyOutgoingCall](#CallHierarchyOutgoingCall)\[\]> | A set of outgoing calls or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### CancellationError

An error type that should be used to signal cancellation of an operation.

This type can be used in response to a [cancellation token](#CancellationToken) being cancelled or when an operation is being cancelled by the executor of that operation.

#### Constructors

new CancellationError(): [CancellationError](#CancellationError)

Creates a new cancellation error.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [CancellationError](#CancellationError) |     |

### CancellationToken

A cancellation token is passed to an asynchronous or long running operation to request cancellation, like cancelling a request for completion items because the user continued to type.

To get an instance of a `CancellationToken` use a [CancellationTokenSource](#CancellationTokenSource).

#### Properties

isCancellationRequested: boolean

Is `true` when the token has been cancelled, `false` otherwise.

onCancellationRequested: [Event](#Event&lt;T&gt;)<any\>

An [Event](#Event) which fires upon cancellation.

### CancellationTokenSource

A cancellation source creates and controls a [cancellation token](#CancellationToken).

#### Constructors

new CancellationTokenSource(): [CancellationTokenSource](#CancellationTokenSource)

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [CancellationTokenSource](#CancellationTokenSource) |     |

#### Properties

token: [CancellationToken](#CancellationToken)

The cancellation token of this source.

#### Methods

cancel(): void

Signal cancellation on the token.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

dispose(): void

Dispose object and free resources.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### CharacterPair

A tuple of two characters, like a pair of opening and closing brackets.

CharacterPair: \[string, string\]

### ChatContext

Extra context passed to a participant.

#### Properties

history: ReadonlyArray<[ChatRequestTurn](#ChatRequestTurn) | [ChatResponseTurn](#ChatResponseTurn)\>

All of the chat messages so far in the current chat session. Currently, only chat messages for the current participant are included.

### ChatErrorDetails

Represents an error result from a chat request.

#### Properties

message: string

An error message that is shown to the user.

responseIsFiltered?: boolean

If set to true, the response will be partly blurred out.

### ChatFollowup

A followup question suggested by the participant.

#### Properties

command?: string

By default, the followup goes to the same participant/command. But this property can be set to invoke a different command.

label?: string

A title to show the user. The prompt will be shown by default, when this is unspecified.

participant?: string

By default, the followup goes to the same participant/command. But this property can be set to invoke a different participant by ID. Followups can only invoke a participant that was contributed by the same extension.

prompt: string

The message to send to the chat.

### ChatFollowupProvider

Will be invoked once after each request to get suggested followup questions to show the user. The user can click the followup to send it to the chat.

#### Methods

provideFollowups(result: [ChatResult](#ChatResult), context: [ChatContext](#ChatContext), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[ChatFollowup](#ChatFollowup)\[\]>

Provide followups for the given result.

| Parameter | Description |
| --- | --- |
| result: [ChatResult](#ChatResult) | This object has the same properties as the result returned from the participant callback, including `metadata`, but is not the same instance. |
| context: [ChatContext](#ChatContext) | Extra context passed to a participant. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[ChatFollowup](#ChatFollowup)\[\]> |     |

### ChatLanguageModelToolReference

A reference to a tool that the user manually attached to their request, either using the `#`\-syntax inline, or as an attachment via the paperclip button.

#### Properties

name: string

The tool name. Refers to a tool listed in [lm.tools](#lm.tools).

range?: \[start: number, end: number\]

The start and end index of the reference in the [prompt](#ChatRequest.prompt). When undefined, the reference was not part of the prompt text.

_Note_ that the indices take the leading `#`\-character into account which means they can be used to modify the prompt as-is.

### ChatParticipant

A chat participant can be invoked by the user in a chat session, using the prefix. When it is invoked, it handles the chat request and is solely responsible for providing a response to the user. A ChatParticipant is created using [chat.createChatParticipant](#chat.createChatParticipant).

#### Events

onDidReceiveFeedback: [Event](#Event&lt;T&gt;)<[ChatResultFeedback](#ChatResultFeedback)\>

An event that fires whenever feedback for a result is received, e.g. when a user up- or down-votes a result.

The passed [result](#ChatResultFeedback.result) is guaranteed to have the same properties as the result that was previously returned from this chat participant's handler.

#### Properties

followupProvider?: [ChatFollowupProvider](#ChatFollowupProvider)

This provider will be called once after each request to retrieve suggested followup questions.

iconPath?: [IconPath](#IconPath)

An icon for the participant shown in UI.

id: string

A unique ID for this participant.

requestHandler: [ChatRequestHandler](#ChatRequestHandler)

The handler for requests to this participant.

#### Methods

dispose(): void

Dispose this participant and free resources.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### ChatParticipantToolToken

A token that can be passed to [lm.invokeTool](#lm.invokeTool) when invoking a tool inside the context of handling a chat request.

ChatParticipantToolToken: never

### ChatPromptReference

A reference to a value that the user added to their chat request.

#### Properties

id: string

A unique identifier for this kind of reference.

modelDescription?: string

A description of this value that could be used in an LLM prompt.

range?: \[start: number, end: number\]

The start and end index of the reference in the [prompt](#ChatRequest.prompt). When undefined, the reference was not part of the prompt text.

_Note_ that the indices take the leading `#`\-character into account which means they can used to modify the prompt as-is.

value: unknown

The value of this reference. The `string | Uri | Location` types are used today, but this could expand in the future.

### ChatRequest

A request to a chat participant.

#### Properties

command: string

The name of the \[ChatCommand command\](#\_ChatCommand command) that was selected for this request.

model: [LanguageModelChat](#LanguageModelChat)

This is the model that is currently selected in the UI. Extensions can use this or use [lm.selectChatModels](#lm.selectChatModels) to pick another model. Don't hold onto this past the lifetime of the request.

prompt: string

The prompt as entered by the user.

Information about references used in this request is stored in [ChatRequest.references](#ChatRequest.references).

_Note_ that the \[ChatParticipant.name name\](#\_ChatParticipant.name name) of the participant and the \[ChatCommand.name command\](#\_ChatCommand.name command) are not part of the prompt.

references: readonly [ChatPromptReference](#ChatPromptReference)\[\]

The list of references and their values that are referenced in the prompt.

_Note_ that the prompt contains references as authored and that it is up to the participant to further modify the prompt, for instance by inlining reference values or creating links to headings which contain the resolved values. References are sorted in reverse by their range in the prompt. That means the last reference in the prompt is the first in this list. This simplifies string-manipulation of the prompt.

toolInvocationToken: never

A token that can be passed to [lm.invokeTool](#lm.invokeTool) when invoking a tool inside the context of handling a chat request. This associates the tool invocation to a chat session.

toolReferences: readonly [ChatLanguageModelToolReference](#ChatLanguageModelToolReference)\[\]

The list of tools that the user attached to their request.

When a tool reference is present, the chat participant should make a chat request using [LanguageModelChatToolMode.Required](#LanguageModelChatToolMode.Required) to force the language model to generate input for the tool. Then, the participant can use [lm.invokeTool](#lm.invokeTool) to use the tool attach the result to its request for the user's prompt. The tool may contribute useful extra context for the user's request.

### ChatRequestHandler

ChatRequestHandler: (request: [ChatRequest](#ChatRequest), context: [ChatContext](#ChatContext), response: [ChatResponseStream](#ChatResponseStream), token: [CancellationToken](#CancellationToken)) => [ProviderResult](#ProviderResult&lt;T&gt;)<[ChatResult](#ChatResult) | void\>

### ChatRequestTurn

Represents a user request in chat history.

#### Properties

command?: string

The name of the \[ChatCommand command\](#\_ChatCommand command) that was selected for this request.

participant: string

The id of the chat participant to which this request was directed.

prompt: string

The prompt as entered by the user.

Information about references used in this request is stored in [ChatRequestTurn.references](#ChatRequestTurn.references).

_Note_ that the \[ChatParticipant.name name\](#\_ChatParticipant.name name) of the participant and the \[ChatCommand.name command\](#\_ChatCommand.name command) are not part of the prompt.

references: [ChatPromptReference](#ChatPromptReference)\[\]

The references that were used in this message.

toolReferences: readonly [ChatLanguageModelToolReference](#ChatLanguageModelToolReference)\[\]

The list of tools were attached to this request.

### ChatResponseAnchorPart

Represents a part of a chat response that is an anchor, that is rendered as a link to a target.

#### Constructors

new ChatResponseAnchorPart(value: [Uri](#Uri) | [Location](#Location), title?: string): [ChatResponseAnchorPart](#ChatResponseAnchorPart)

Create a new ChatResponseAnchorPart.

| Parameter | Description |
| --- | --- |
| value: [Uri](#Uri) \| [Location](#Location) | A uri or location. |
| title?: string | An optional title that is rendered with value. |
| Returns | Description |
| [ChatResponseAnchorPart](#ChatResponseAnchorPart) |     |

#### Properties

title?: string

An optional title that is rendered with value.

value: [Uri](#Uri) | [Location](#Location)

The target of this anchor.

### ChatResponseCommandButtonPart

Represents a part of a chat response that is a button that executes a command.

#### Constructors

new ChatResponseCommandButtonPart(value: [Command](#Command)): [ChatResponseCommandButtonPart](#ChatResponseCommandButtonPart)

Create a new ChatResponseCommandButtonPart.

| Parameter | Description |
| --- | --- |
| value: [Command](#Command) | A Command that will be executed when the button is clicked. |
| Returns | Description |
| [ChatResponseCommandButtonPart](#ChatResponseCommandButtonPart) |     |

#### Properties

value: [Command](#Command)

The command that will be executed when the button is clicked.

### ChatResponseFileTree

Represents a file tree structure in a chat response.

#### Properties

children?: [ChatResponseFileTree](#ChatResponseFileTree)\[\]

An array of child file trees, if the current file tree is a directory.

name: string

The name of the file or directory.

### ChatResponseFileTreePart

Represents a part of a chat response that is a file tree.

#### Constructors

new ChatResponseFileTreePart(value: [ChatResponseFileTree](#ChatResponseFileTree)\[\], baseUri: [Uri](#Uri)): [ChatResponseFileTreePart](#ChatResponseFileTreePart)

Create a new ChatResponseFileTreePart.

| Parameter | Description |
| --- | --- |
| value: [ChatResponseFileTree](#ChatResponseFileTree)\[\] | File tree data. |
| baseUri: [Uri](#Uri) | The base uri to which this file tree is relative. |
| Returns | Description |
| [ChatResponseFileTreePart](#ChatResponseFileTreePart) |     |

#### Properties

baseUri: [Uri](#Uri)

The base uri to which this file tree is relative

value: [ChatResponseFileTree](#ChatResponseFileTree)\[\]

File tree data.

### ChatResponseMarkdownPart

Represents a part of a chat response that is formatted as Markdown.

#### Constructors

new ChatResponseMarkdownPart(value: string | [MarkdownString](#MarkdownString)): [ChatResponseMarkdownPart](#ChatResponseMarkdownPart)

Create a new ChatResponseMarkdownPart.

| Parameter | Description |
| --- | --- |
| value: string \| [MarkdownString](#MarkdownString) | A markdown string or a string that should be interpreted as markdown. The boolean form of [MarkdownString.isTrusted](#MarkdownString.isTrusted) is NOT supported. |
| Returns | Description |
| [ChatResponseMarkdownPart](#ChatResponseMarkdownPart) |     |

#### Properties

value: [MarkdownString](#MarkdownString)

A markdown string or a string that should be interpreted as markdown.

### ChatResponsePart

Represents the different chat response types.

ChatResponsePart: [ChatResponseMarkdownPart](#ChatResponseMarkdownPart) | [ChatResponseFileTreePart](#ChatResponseFileTreePart) | [ChatResponseAnchorPart](#ChatResponseAnchorPart) | [ChatResponseProgressPart](#ChatResponseProgressPart) | [ChatResponseReferencePart](#ChatResponseReferencePart) | [ChatResponseCommandButtonPart](#ChatResponseCommandButtonPart)

### ChatResponseProgressPart

Represents a part of a chat response that is a progress message.

#### Constructors

new ChatResponseProgressPart(value: string): [ChatResponseProgressPart](#ChatResponseProgressPart)

Create a new ChatResponseProgressPart.

| Parameter | Description |
| --- | --- |
| value: string | A progress message |
| Returns | Description |
| [ChatResponseProgressPart](#ChatResponseProgressPart) |     |

#### Properties

value: string

The progress message

### ChatResponseReferencePart

Represents a part of a chat response that is a reference, rendered separately from the content.

#### Constructors

new ChatResponseReferencePart(value: [Uri](#Uri) | [Location](#Location), iconPath?: [IconPath](#IconPath)): [ChatResponseReferencePart](#ChatResponseReferencePart)

Create a new ChatResponseReferencePart.

| Parameter | Description |
| --- | --- |
| value: [Uri](#Uri) \| [Location](#Location) | A uri or location |
| iconPath?: [IconPath](#IconPath) | Icon for the reference shown in UI |
| Returns | Description |
| [ChatResponseReferencePart](#ChatResponseReferencePart) |     |

#### Properties

iconPath?: [IconPath](#IconPath)

The icon for the reference.

value: [Uri](#Uri) | [Location](#Location)

The reference target.

### ChatResponseStream

The ChatResponseStream is how a participant is able to return content to the chat view. It provides several methods for streaming different types of content which will be rendered in an appropriate way in the chat view. A participant can use the helper method for the type of content it wants to return, or it can instantiate a [ChatResponsePart](#ChatResponsePart) and use the generic [ChatResponseStream.push](#ChatResponseStream.push) method to return it.

#### Methods

anchor(value: [Uri](#Uri) | [Location](#Location), title?: string): void

Push an anchor part to this stream. Short-hand for `push(new ChatResponseAnchorPart(value, title))`. An anchor is an inline reference to some type of resource.

| Parameter | Description |
| --- | --- |
| value: [Uri](#Uri) \| [Location](#Location) | A uri or location. |
| title?: string | An optional title that is rendered with value. |
| Returns | Description |
| void |     |

button(command: [Command](#Command)): void

Push a command button part to this stream. Short-hand for `push(new ChatResponseCommandButtonPart(value, title))`.

| Parameter | Description |
| --- | --- |
| command: [Command](#Command) | A Command that will be executed when the button is clicked. |
| Returns | Description |
| void |     |

filetree(value: [ChatResponseFileTree](#ChatResponseFileTree)\[\], baseUri: [Uri](#Uri)): void

Push a filetree part to this stream. Short-hand for `push(new ChatResponseFileTreePart(value))`.

| Parameter | Description |
| --- | --- |
| value: [ChatResponseFileTree](#ChatResponseFileTree)\[\] | File tree data. |
| baseUri: [Uri](#Uri) | The base uri to which this file tree is relative. |
| Returns | Description |
| void |     |

markdown(value: string | [MarkdownString](#MarkdownString)): void

Push a markdown part to this stream. Short-hand for `push(new ChatResponseMarkdownPart(value))`.

_See also_ [ChatResponseStream.push](#ChatResponseStream.push)

| Parameter | Description |
| --- | --- |
| value: string \| [MarkdownString](#MarkdownString) | A markdown string or a string that should be interpreted as markdown. The boolean form of [MarkdownString.isTrusted](#MarkdownString.isTrusted) is NOT supported. |
| Returns | Description |
| void |     |

progress(value: string): void

Push a progress part to this stream. Short-hand for `push(new ChatResponseProgressPart(value))`.

| Parameter | Description |
| --- | --- |
| value: string | A progress message |
| Returns | Description |
| void |     |

push(part: [ChatResponsePart](#ChatResponsePart)): void

Pushes a part to this stream.

| Parameter | Description |
| --- | --- |
| part: [ChatResponsePart](#ChatResponsePart) | A response part, rendered or metadata |
| Returns | Description |
| void |     |

reference(value: [Uri](#Uri) | [Location](#Location), iconPath?: [IconPath](#IconPath)): void

Push a reference to this stream. Short-hand for `push(new ChatResponseReferencePart(value))`.

_Note_ that the reference is not rendered inline with the response.

| Parameter | Description |
| --- | --- |
| value: [Uri](#Uri) \| [Location](#Location) | A uri or location |
| iconPath?: [IconPath](#IconPath) | Icon for the reference shown in UI |
| Returns | Description |
| void |     |

### ChatResponseTurn

Represents a chat participant's response in chat history.

#### Properties

command?: string

The name of the command that this response came from.

participant: string

The id of the chat participant that this response came from.

response: ReadonlyArray<[ChatResponseMarkdownPart](#ChatResponseMarkdownPart) | [ChatResponseFileTreePart](#ChatResponseFileTreePart) | [ChatResponseAnchorPart](#ChatResponseAnchorPart) | [ChatResponseCommandButtonPart](#ChatResponseCommandButtonPart)\>

The content that was received from the chat participant. Only the stream parts that represent actual content (not metadata) are represented.

result: [ChatResult](#ChatResult)

The result that was received from the chat participant.

### ChatResult

The result of a chat request.

#### Properties

errorDetails?: [ChatErrorDetails](#ChatErrorDetails)

If the request resulted in an error, this property defines the error details.

metadata?:

Arbitrary metadata for this result. Can be anything, but must be JSON-stringifyable.

### ChatResultFeedback

Represents user feedback for a result.

#### Properties

kind: [ChatResultFeedbackKind](#ChatResultFeedbackKind)

The kind of feedback that was received.

result: [ChatResult](#ChatResult)

The ChatResult for which the user is providing feedback. This object has the same properties as the result returned from the participant callback, including `metadata`, but is not the same instance.

### ChatResultFeedbackKind

Represents the type of user feedback received.

#### Enumeration Members

Unhelpful: 0

The user marked the result as unhelpful.

Helpful: 1

The user marked the result as helpful.

### Clipboard

The clipboard provides read and write access to the system's clipboard.

#### Methods

readText(): Thenable<string\>

Read the current clipboard contents as text.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Thenable<string\> | A thenable that resolves to a string. |

writeText(value: string): Thenable<void\>

Writes text into the clipboard.

| Parameter | Description |
| --- | --- |
| value: string |     |
| Returns | Description |
| Thenable<void\> | A thenable that resolves when writing happened. |

### CodeAction

A code action represents a change that can be performed in code, e.g. to fix a problem or to refactor code.

A CodeAction must set either [edit](#CodeAction.edit) and/or a [command](#CodeAction.command). If both are supplied, the `edit` is applied first, then the command is executed.

#### Constructors

new CodeAction(title: string, kind?: [CodeActionKind](#CodeActionKind)): [CodeAction](#CodeAction)

Creates a new code action.

A code action must have at least a [title](#CodeAction.title) and [edits](#CodeAction.edit) and/or a [command](#CodeAction.command).

| Parameter | Description |
| --- | --- |
| title: string | The title of the code action. |
| kind?: [CodeActionKind](#CodeActionKind) | The kind of the code action. |
| Returns | Description |
| [CodeAction](#CodeAction) |     |

#### Properties

command?: [Command](#Command)

A [Command](#Command) this code action executes.

If this command throws an exception, the editor displays the exception message to users in the editor at the current cursor position.

diagnostics?: [Diagnostic](#Diagnostic)\[\]

[Diagnostics](#Diagnostic) that this code action resolves.

disabled?: {reason: string}

Marks that the code action cannot currently be applied.

*   Disabled code actions are not shown in automatic [lightbulb](https://code.visualstudio.com/docs/editor/editingevolved#_code-action) code action menu.
    
*   Disabled actions are shown as faded out in the code action menu when the user request a more specific type of code action, such as refactorings.
    
*   If the user has a [keybinding](https://code.visualstudio.com/docs/editor/refactoring#_keybindings-for-code-actions) that auto applies a code action and only a disabled code actions are returned, the editor will show the user an error message with `reason` in the editor.
    

| Parameter | Description |
| --- | --- |
| reason: string | Human readable description of why the code action is currently disabled.<br><br>This is displayed in the code actions UI. |

edit?: [WorkspaceEdit](#WorkspaceEdit)

A [workspace edit](#WorkspaceEdit) this code action performs.

isPreferred?: boolean

Marks this as a preferred action. Preferred actions are used by the `auto fix` command and can be targeted by keybindings.

A quick fix should be marked preferred if it properly addresses the underlying error. A refactoring should be marked preferred if it is the most reasonable choice of actions to take.

kind?: [CodeActionKind](#CodeActionKind)

[Kind](#CodeActionKind) of the code action.

Used to filter code actions.

title: string

A short, human-readable, title for this code action.

### CodeActionContext

Contains additional diagnostic information about the context in which a [code action](#CodeActionProvider.provideCodeActions) is run.

#### Properties

diagnostics: readonly [Diagnostic](#Diagnostic)\[\]

An array of diagnostics.

only: [CodeActionKind](#CodeActionKind)

Requested kind of actions to return.

Actions not of this kind are filtered out before being shown by the [lightbulb](https://code.visualstudio.com/docs/editor/editingevolved#_code-action).

triggerKind: [CodeActionTriggerKind](#CodeActionTriggerKind)

The reason why code actions were requested.

### CodeActionKind

Kind of a code action.

Kinds are a hierarchical list of identifiers separated by `.`, e.g. `"refactor.extract.function"`.

Code action kinds are used by the editor for UI elements such as the refactoring context menu. Users can also trigger code actions with a specific kind with the `editor.action.codeAction` command.

#### Static

Empty: [CodeActionKind](#CodeActionKind)

Empty kind.

Notebook: [CodeActionKind](#CodeActionKind)

Base kind for all code actions applying to the entire notebook's scope. CodeActionKinds using this should always begin with `notebook.`

This requires that new CodeActions be created for it and contributed via extensions. Pre-existing kinds can not just have the new `notebook.` prefix added to them, as the functionality is unique to the full-notebook scope.

Notebook CodeActionKinds can be initialized as either of the following (both resulting in `notebook.source.xyz`):

*   `const newKind = CodeActionKind.Notebook.append(CodeActionKind.Source.append('xyz').value)`
*   `const newKind = CodeActionKind.Notebook.append('source.xyz')`

Example Kinds/Actions:

*   `notebook.source.organizeImports` (might move all imports to a new top cell)
*   `notebook.source.normalizeVariableNames` (might rename all variables to a standardized casing format)

QuickFix: [CodeActionKind](#CodeActionKind)

Base kind for quickfix actions: `quickfix`.

Quick fix actions address a problem in the code and are shown in the normal code action context menu.

Refactor: [CodeActionKind](#CodeActionKind)

Base kind for refactoring actions: `refactor`

Refactoring actions are shown in the refactoring context menu.

RefactorExtract: [CodeActionKind](#CodeActionKind)

Base kind for refactoring extraction actions: `refactor.extract`

Example extract actions:

*   Extract method
*   Extract function
*   Extract variable
*   Extract interface from class
*   ...

RefactorInline: [CodeActionKind](#CodeActionKind)

Base kind for refactoring inline actions: `refactor.inline`

Example inline actions:

*   Inline function
*   Inline variable
*   Inline constant
*   ...

RefactorMove: [CodeActionKind](#CodeActionKind)

Base kind for refactoring move actions: `refactor.move`

Example move actions:

*   Move a function to a new file
*   Move a property between classes
*   Move method to base class
*   ...

RefactorRewrite: [CodeActionKind](#CodeActionKind)

Base kind for refactoring rewrite actions: `refactor.rewrite`

Example rewrite actions:

*   Convert JavaScript function to class
*   Add or remove parameter
*   Encapsulate field
*   Make method static
*   ...

Source: [CodeActionKind](#CodeActionKind)

Base kind for source actions: `source`

Source code actions apply to the entire file. They must be explicitly requested and will not show in the normal [lightbulb](https://code.visualstudio.com/docs/editor/editingevolved#_code-action) menu. Source actions can be run on save using `editor.codeActionsOnSave` and are also shown in the `source` context menu.

SourceFixAll: [CodeActionKind](#CodeActionKind)

Base kind for auto-fix source actions: `source.fixAll`.

Fix all actions automatically fix errors that have a clear fix that do not require user input. They should not suppress errors or perform unsafe fixes such as generating new types or classes.

SourceOrganizeImports: [CodeActionKind](#CodeActionKind)

Base kind for an organize imports source action: `source.organizeImports`.

#### Constructors

new CodeActionKind(value: string): [CodeActionKind](#CodeActionKind)

Private constructor, use static `CodeActionKind.XYZ` to derive from an existing code action kind.

| Parameter | Description |
| --- | --- |
| value: string | The value of the kind, such as `refactor.extract.function`. |
| Returns | Description |
| [CodeActionKind](#CodeActionKind) |     |

#### Properties

value: string

String value of the kind, e.g. `"refactor.extract.function"`.

#### Methods

append(parts: string): [CodeActionKind](#CodeActionKind)

Create a new kind by appending a more specific selector to the current kind.

Does not modify the current kind.

| Parameter | Description |
| --- | --- |
| parts: string |     |
| Returns | Description |
| [CodeActionKind](#CodeActionKind) |     |

contains(other: [CodeActionKind](#CodeActionKind)): boolean

Checks if `other` is a sub-kind of this `CodeActionKind`.

The kind `"refactor.extract"` for example contains `"refactor.extract"` and \`\`"refactor.extract.function"`, but not` "unicorn.refactor.extract"`, or` "refactor.extractAll"`or`refactor\`.

| Parameter | Description |
| --- | --- |
| other: [CodeActionKind](#CodeActionKind) | Kind to check. |
| Returns | Description |
| boolean |     |

intersects(other: [CodeActionKind](#CodeActionKind)): boolean

Checks if this code action kind intersects `other`.

The kind `"refactor.extract"` for example intersects `refactor`, `"refactor.extract"` and `"refactor.extract.function"`, but not `"unicorn.refactor.extract"`, or `"refactor.extractAll"`.

| Parameter | Description |
| --- | --- |
| other: [CodeActionKind](#CodeActionKind) | Kind to check. |
| Returns | Description |
| boolean |     |

### CodeActionProvider<T>

Provides contextual actions for code. Code actions typically either fix problems or beautify/refactor code.

Code actions are surfaced to users in a few different ways:

*   The [lightbulb](https://code.visualstudio.com/docs/editor/editingevolved#_code-action) feature, which shows a list of code actions at the current cursor position. The lightbulb's list of actions includes both quick fixes and refactorings.
*   As commands that users can run, such as `Refactor`. Users can run these from the command palette or with keybindings.
*   As source actions, such `Organize Imports`.
*   [Quick fixes](#CodeActionKind.QuickFix) are shown in the problems view.
*   Change applied on save by the `editor.codeActionsOnSave` setting.

#### Methods

provideCodeActions(document: [TextDocument](#TextDocument), range: [Range](#Range) | [Selection](#Selection), context: [CodeActionContext](#CodeActionContext), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<Array<[Command](#Command) | T\>>

Get code actions for a given range in a document.

Only return code actions that are relevant to user for the requested range. Also keep in mind how the returned code actions will appear in the UI. The lightbulb widget and `Refactor` commands for instance show returned code actions as a list, so do not return a large number of code actions that will overwhelm the user.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| range: [Range](#Range) \| [Selection](#Selection) | The selector or range for which the command was invoked. This will always be a [selection](#Selection) if the actions are being requested in the currently active editor. |
| context: [CodeActionContext](#CodeActionContext) | Provides additional information about what code actions are being requested. You can use this to see what specific type of code actions are being requested by the editor in order to return more relevant actions and avoid returning irrelevant code actions that the editor will discard. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<Array<[Command](#Command) \| T\>> | An array of code actions, such as quick fixes or refactorings. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array.<br><br>We also support returning `Command` for legacy reasons, however all new extensions should return `CodeAction` object instead. |

resolveCodeAction(codeAction: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

Given a code action fill in its [edit](#CodeAction.edit)\-property. Changes to all other properties, like title, are ignored. A code action that has an edit will not be resolved.

_Note_ that a code action provider that returns commands, not code actions, cannot successfully implement this function. Returning commands is deprecated and instead code actions should be returned.

| Parameter | Description |
| --- | --- |
| codeAction: T | A code action. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | The resolved code action or a thenable that resolves to such. It is OK to return the given `item`. When no result is returned, the given `item` will be used. |

### CodeActionProviderMetadata

Metadata about the type of code actions that a [CodeActionProvider](#CodeActionProvider) provides.

#### Properties

documentation?: ReadonlyArray<{command: [Command](#Command), kind: [CodeActionKind](#CodeActionKind)}>

Static documentation for a class of code actions.

Documentation from the provider is shown in the code actions menu if either:

*   Code actions of `kind` are requested by the editor. In this case, the editor will show the documentation that most closely matches the requested code action kind. For example, if a provider has documentation for both `Refactor` and `RefactorExtract`, when the user requests code actions for `RefactorExtract`, the editor will use the documentation for `RefactorExtract` instead of the documentation for `Refactor`.
    
*   Any code actions of `kind` are returned by the provider.
    

At most one documentation entry will be shown per provider.

providedCodeActionKinds?: readonly [CodeActionKind](#CodeActionKind)\[\]

List of [CodeActionKinds](#CodeActionKind) that a [CodeActionProvider](#CodeActionProvider) may return.

This list is used to determine if a given `CodeActionProvider` should be invoked or not. To avoid unnecessary computation, every `CodeActionProvider` should list use `providedCodeActionKinds`. The list of kinds may either be generic, such as `[CodeActionKind.Refactor]`, or list out every kind provided, such as `[CodeActionKind.Refactor.Extract.append('function'), CodeActionKind.Refactor.Extract.append('constant'), ...]`.

### CodeActionTriggerKind

The reason why code actions were requested.

#### Enumeration Members

Invoke: 1

Code actions were explicitly requested by the user or by an extension.

Automatic: 2

Code actions were requested automatically.

This typically happens when current selection in a file changes, but can also be triggered when file content changes.

### CodeLens

A code lens represents a [Command](#Command) that should be shown along with source text, like the number of references, a way to run tests, etc.

A code lens is _unresolved_ when no command is associated to it. For performance reasons the creation of a code lens and resolving should be done to two stages.

_See also_

*   [CodeLensProvider.provideCodeLenses](#CodeLensProvider.provideCodeLenses)
*   [CodeLensProvider.resolveCodeLens](#CodeLensProvider.resolveCodeLens)

#### Constructors

new CodeLens(range: [Range](#Range), command?: [Command](#Command)): [CodeLens](#CodeLens)

Creates a new code lens object.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The range to which this code lens applies. |
| command?: [Command](#Command) | The command associated to this code lens. |
| Returns | Description |
| [CodeLens](#CodeLens) |     |

#### Properties

command?: [Command](#Command)

The command this code lens represents.

isResolved: boolean

`true` when there is a command associated.

range: [Range](#Range)

The range in which this code lens is valid. Should only span a single line.

### CodeLensProvider<T>

A code lens provider adds [commands](#Command) to source text. The commands will be shown as dedicated horizontal lines in between the source text.

#### Events

onDidChangeCodeLenses?: [Event](#Event&lt;T&gt;)<void\>

An optional event to signal that the code lenses from this provider have changed.

#### Methods

provideCodeLenses(document: [TextDocument](#TextDocument), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Compute a list of [lenses](#CodeLens). This call should return as fast as possible and if computing the commands is expensive implementors should only return code lens objects with the range set and implement [resolve](#CodeLensProvider.resolveCodeLens).

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | An array of code lenses or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

resolveCodeLens(codeLens: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

This function will be called for each visible code lens, usually when scrolling and after calls to [compute](#CodeLensProvider.provideCodeLenses)\-lenses.

| Parameter | Description |
| --- | --- |
| codeLens: T | Code lens that must be resolved. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | The given, resolved code lens or thenable that resolves to such. |

### Color

Represents a color in RGBA space.

#### Constructors

new Color(red: number, green: number, blue: number, alpha: number): [Color](#Color)

Creates a new color instance.

| Parameter | Description |
| --- | --- |
| red: number | The red component. |
| green: number | The green component. |
| blue: number | The blue component. |
| alpha: number | The alpha component. |
| Returns | Description |
| [Color](#Color) |     |

#### Properties

alpha: number

The alpha component of this color in the range `[0-1]`.

blue: number

The blue component of this color in the range `[0-1]`.

green: number

The green component of this color in the range `[0-1]`.

red: number

The red component of this color in the range `[0-1]`.

### ColorInformation

Represents a color range from a document.

#### Constructors

new ColorInformation(range: [Range](#Range), color: [Color](#Color)): [ColorInformation](#ColorInformation)

Creates a new color range.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The range the color appears in. Must not be empty. |
| color: [Color](#Color) | The value of the color. |
| Returns | Description |
| [ColorInformation](#ColorInformation) |     |

#### Properties

color: [Color](#Color)

The actual color value for this color range.

range: [Range](#Range)

The range in the document where this color appears.

### ColorPresentation

A color presentation object describes how a [Color](#Color) should be represented as text and what edits are required to refer to it from source code.

For some languages one color can have multiple presentations, e.g. css can represent the color red with the constant `Red`, the hex-value `#ff0000`, or in rgba and hsla forms. In csharp other representations apply, e.g. `System.Drawing.Color.Red`.

#### Constructors

new ColorPresentation(label: string): [ColorPresentation](#ColorPresentation)

Creates a new color presentation.

| Parameter | Description |
| --- | --- |
| label: string | The label of this color presentation. |
| Returns | Description |
| [ColorPresentation](#ColorPresentation) |     |

#### Properties

additionalTextEdits?: [TextEdit](#TextEdit)\[\]

An optional array of additional [text edits](#TextEdit) that are applied when selecting this color presentation. Edits must not overlap with the main [edit](#ColorPresentation.textEdit) nor with themselves.

label: string

The label of this color presentation. It will be shown on the color picker header. By default this is also the text that is inserted when selecting this color presentation.

textEdit?: [TextEdit](#TextEdit)

An [edit](#TextEdit) which is applied to a document when selecting this presentation for the color. When `falsy` the [label](#ColorPresentation.label) is used.

### ColorTheme

Represents a color theme.

#### Properties

kind: [ColorThemeKind](#ColorThemeKind)

The kind of this color theme: light, dark, high contrast dark and high contrast light.

### ColorThemeKind

Represents a color theme kind.

#### Enumeration Members

Light: 1

A light color theme.

Dark: 2

A dark color theme.

HighContrast: 3

A dark high contrast color theme.

HighContrastLight: 4

A light high contrast color theme.

### Command

Represents a reference to a command. Provides a title which will be used to represent a command in the UI and, optionally, an array of arguments which will be passed to the command handler function when invoked.

#### Properties

arguments?: any\[\]

Arguments that the command handler should be invoked with.

command: string

The identifier of the actual command handler.

_See also_ [commands.registerCommand](#commands.registerCommand)

title: string

Title of the command, like `save`.

tooltip?: string

A tooltip for the command, when represented in the UI.

### Comment

A comment is displayed within the editor or the Comments Panel, depending on how it is provided.

#### Properties

author: [CommentAuthorInformation](#CommentAuthorInformation)

The [author information](#CommentAuthorInformation) of the comment

body: string | [MarkdownString](#MarkdownString)

The human-readable comment body

contextValue?: string

Context value of the comment. This can be used to contribute comment specific actions. For example, a comment is given a context value as `editable`. When contributing actions to `comments/comment/title` using `menus` extension point, you can specify context value for key `comment` in `when` expression like `comment == editable`.

```
    "contributes": {
        "menus": {
            "comments/comment/title": [
                {
                    "command": "extension.deleteComment",
                    "when": "comment == editable"
                }
            ]
        }
    }
```

This will show action `extension.deleteComment` only for comments with `contextValue` is `editable`.

label?: string

Optional label describing the [Comment](#Comment) Label will be rendered next to authorName if exists.

mode: [CommentMode](#CommentMode)

[Comment mode](#CommentMode) of the comment

reactions?: [CommentReaction](#CommentReaction)\[\]

Optional reactions of the [Comment](#Comment)

timestamp?: Date

Optional timestamp that will be displayed in comments. The date will be formatted according to the user's locale and settings.

### CommentAuthorInformation

Author information of a [Comment](#Comment)

#### Properties

iconPath?: [Uri](#Uri)

The optional icon path for the author

name: string

The display name of the author of the comment

### CommentController

A comment controller is able to provide [comments](#CommentThread) support to the editor and provide users various ways to interact with comments.

#### Properties

commentingRangeProvider?: [CommentingRangeProvider](#CommentingRangeProvider)

Optional commenting range provider. Provide a list [ranges](#Range) which support commenting to any given resource uri.

If not provided, users cannot leave any comments.

id: string

The id of this comment controller.

label: string

The human-readable label of this comment controller.

options?: [CommentOptions](#CommentOptions)

Comment controller options

reactionHandler?: (comment: [Comment](#Comment), reaction: [CommentReaction](#CommentReaction)) => Thenable<void\>

Optional reaction handler for creating and deleting reactions on a [Comment](#Comment).

| Parameter | Description |
| --- | --- |
| comment: [Comment](#Comment) |     |
| reaction: [CommentReaction](#CommentReaction) |     |
| Returns | Description |
| Thenable<void\> |     |

#### Methods

createCommentThread(uri: [Uri](#Uri), range: [Range](#Range), comments: readonly [Comment](#Comment)\[\]): [CommentThread](#CommentThread)

Create a [comment thread](#CommentThread). The comment thread will be displayed in visible text editors (if the resource matches) and Comments Panel once created.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the document the thread has been created on. |
| range: [Range](#Range) | The range the comment thread is located within the document. |
| comments: readonly [Comment](#Comment)\[\] | The ordered comments of the thread. |
| Returns | Description |
| [CommentThread](#CommentThread) |     |

dispose(): void

Dispose this comment controller.

Once disposed, all [comment threads](#CommentThread) created by this comment controller will also be removed from the editor and Comments Panel.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### CommentingRangeProvider

Commenting range provider for a [comment controller](#CommentController).

#### Methods

provideCommentingRanges(document: [TextDocument](#TextDocument), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[Range](#Range)\[\] | [CommentingRanges](#CommentingRanges)\>

Provide a list of ranges which allow new comment threads creation or null for a given document

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) |     |
| token: [CancellationToken](#CancellationToken) |     |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[Range](#Range)\[\] \| [CommentingRanges](#CommentingRanges)\> |     |

### CommentingRanges

The ranges a CommentingRangeProvider enables commenting on.

#### Properties

enableFileComments: boolean

Enables comments to be added to a file without a specific range.

ranges?: [Range](#Range)\[\]

The ranges which allow new comment threads creation.

### CommentMode

Comment mode of a [Comment](#Comment)

#### Enumeration Members

Editing: 0

Displays the comment editor

Preview: 1

Displays the preview of the comment

### CommentOptions

Represents a [comment controller](#CommentController)'s [options](#CommentController.options).

#### Properties

placeHolder?: string

An optional string to show as placeholder in the comment input box when it's focused.

prompt?: string

An optional string to show on the comment input box when it's collapsed.

### CommentReaction

Reactions of a [Comment](#Comment)

#### Properties

authorHasReacted: boolean

Whether the [author](#CommentAuthorInformation) of the comment has reacted to this reaction

count: number

The number of users who have reacted to this reaction

iconPath: string | [Uri](#Uri)

Icon for the reaction shown in UI.

label: string

The human-readable label for the reaction

### CommentReply

Command argument for actions registered in `comments/commentThread/context`.

#### Properties

text: string

The value in the comment editor

thread: [CommentThread](#CommentThread)

The active [comment thread](#CommentThread)

### CommentRule

Describes how comments for a language work.

#### Properties

blockComment?: [CharacterPair](#CharacterPair)

The block comment character pair, like `/* block comment *&#47;`

lineComment?: string

The line comment token, like `// this is a comment`

### CommentThread

A collection of [comments](#Comment) representing a conversation at a particular range in a document.

#### Properties

canReply: boolean | [CommentAuthorInformation](#CommentAuthorInformation)

Whether the thread supports reply. Defaults to true.

collapsibleState: [CommentThreadCollapsibleState](#CommentThreadCollapsibleState)

Whether the thread should be collapsed or expanded when opening the document. Defaults to Collapsed.

comments: readonly [Comment](#Comment)\[\]

The ordered comments of the thread.

contextValue?: string

Context value of the comment thread. This can be used to contribute thread specific actions. For example, a comment thread is given a context value as `editable`. When contributing actions to `comments/commentThread/title` using `menus` extension point, you can specify context value for key `commentThread` in `when` expression like `commentThread == editable`.

```
"contributes": {
  "menus": {
    "comments/commentThread/title": [
      {
        "command": "extension.deleteCommentThread",
        "when": "commentThread == editable"
      }
    ]
  }
}
```

This will show action `extension.deleteCommentThread` only for comment threads with `contextValue` is `editable`.

label?: string

The optional human-readable label describing the [Comment Thread](#CommentThread)

range: [Range](#Range)

The range the comment thread is located within the document. The thread icon will be shown at the last line of the range. When set to undefined, the comment will be associated with the file, and not a specific range.

state?: [CommentThreadState](#CommentThreadState)

The optional state of a comment thread, which may affect how the comment is displayed.

uri: [Uri](#Uri)

The uri of the document the thread has been created on.

#### Methods

dispose(): void

Dispose this comment thread.

Once disposed, this comment thread will be removed from visible editors and Comment Panel when appropriate.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### CommentThreadCollapsibleState

Collapsible state of a [comment thread](#CommentThread)

#### Enumeration Members

Collapsed: 0

Determines an item is collapsed

Expanded: 1

Determines an item is expanded

### CommentThreadState

The state of a comment thread.

#### Enumeration Members

Unresolved: 0

Unresolved thread state

Resolved: 1

Resolved thread state

### CompletionContext

Contains additional information about the context in which [completion provider](#CompletionItemProvider.provideCompletionItems) is triggered.

#### Properties

triggerCharacter: string

Character that triggered the completion item provider.

`undefined` if the provider was not triggered by a character.

The trigger character is already in the document when the completion provider is triggered.

triggerKind: [CompletionTriggerKind](#CompletionTriggerKind)

How the completion was triggered.

### CompletionItem

A completion item represents a text snippet that is proposed to complete text that is being typed.

It is sufficient to create a completion item from just a [label](#CompletionItem.label). In that case the completion item will replace the [word](#TextDocument.getWordRangeAtPosition) until the cursor with the given label or [insertText](#CompletionItem.insertText). Otherwise the given [edit](#CompletionItem.textEdit) is used.

When selecting a completion item in the editor its defined or synthesized text edit will be applied to _all_ cursors/selections whereas [additionalTextEdits](#CompletionItem.additionalTextEdits) will be applied as provided.

_See also_

*   [CompletionItemProvider.provideCompletionItems](#CompletionItemProvider.provideCompletionItems)
*   [CompletionItemProvider.resolveCompletionItem](#CompletionItemProvider.resolveCompletionItem)

#### Constructors

new CompletionItem(label: string | [CompletionItemLabel](#CompletionItemLabel), kind?: [CompletionItemKind](#CompletionItemKind)): [CompletionItem](#CompletionItem)

Creates a new completion item.

Completion items must have at least a [label](#CompletionItem.label) which then will be used as insert text as well as for sorting and filtering.

| Parameter | Description |
| --- | --- |
| label: string \| [CompletionItemLabel](#CompletionItemLabel) | The label of the completion. |
| kind?: [CompletionItemKind](#CompletionItemKind) | The [kind](#CompletionItemKind) of the completion. |
| Returns | Description |
| [CompletionItem](#CompletionItem) |     |

#### Properties

additionalTextEdits?: [TextEdit](#TextEdit)\[\]

An optional array of additional [text edits](#TextEdit) that are applied when selecting this completion. Edits must not overlap with the main [edit](#CompletionItem.textEdit) nor with themselves.

command?: [Command](#Command)

An optional [Command](#Command) that is executed _after_ inserting this completion. _Note_ that additional modifications to the current document should be described with the [additionalTextEdits](#CompletionItem.additionalTextEdits)\-property.

commitCharacters?: string\[\]

An optional set of characters that when pressed while this completion is active will accept it first and then type that character. _Note_ that all commit characters should have `length=1` and that superfluous characters will be ignored.

detail?: string

A human-readable string with additional information about this item, like type or symbol information.

documentation?: string | [MarkdownString](#MarkdownString)

A human-readable string that represents a doc-comment.

filterText?: string

A string that should be used when filtering a set of completion items. When `falsy` the [label](#CompletionItem.label) is used.

Note that the filter text is matched against the leading word (prefix) which is defined by the [range](#CompletionItem.range)\-property.

insertText?: string | [SnippetString](#SnippetString)

A string or snippet that should be inserted in a document when selecting this completion. When `falsy` the [label](#CompletionItem.label) is used.

keepWhitespace?: boolean

Keep whitespace of the [insertText](#CompletionItem.insertText) as is. By default, the editor adjusts leading whitespace of new lines so that they match the indentation of the line for which the item is accepted - setting this to `true` will prevent that.

kind?: [CompletionItemKind](#CompletionItemKind)

The kind of this completion item. Based on the kind an icon is chosen by the editor.

label: string | [CompletionItemLabel](#CompletionItemLabel)

The label of this completion item. By default this is also the text that is inserted when selecting this completion.

preselect?: boolean

Select this item when showing. _Note_ that only one completion item can be selected and that the editor decides which item that is. The rule is that the _first_ item of those that match best is selected.

range?: [Range](#Range) | {inserting: [Range](#Range), replacing: [Range](#Range)}

A range or a insert and replace range selecting the text that should be replaced by this completion item.

When omitted, the range of the [current word](#TextDocument.getWordRangeAtPosition) is used as replace-range and as insert-range the start of the [current word](#TextDocument.getWordRangeAtPosition) to the current position is used.

_Note 1:_ A range must be a [single line](#Range.isSingleLine) and it must [contain](#Range.contains) the position at which completion has been [requested](#CompletionItemProvider.provideCompletionItems). _Note 2:_ A insert range must be a prefix of a replace range, that means it must be contained and starting at the same position.

sortText?: string

A string that should be used when comparing this item with other items. When `falsy` the [label](#CompletionItem.label) is used.

Note that `sortText` is only used for the initial ordering of completion items. When having a leading word (prefix) ordering is based on how well completions match that prefix and the initial ordering is only used when completions match equally well. The prefix is defined by the [range](#CompletionItem.range)\-property and can therefore be different for each completion.

tags?: readonly [CompletionItemTag](#CompletionItemTag)\[\]

Tags for this completion item.

textEdit?: [TextEdit](#TextEdit)

*   _deprecated_ - Use `CompletionItem.insertText` and `CompletionItem.range` instead.

An [edit](#TextEdit) which is applied to a document when selecting this completion. When an edit is provided the value of [insertText](#CompletionItem.insertText) is ignored.

The [Range](#Range) of the edit must be single-line and on the same line completions were [requested](#CompletionItemProvider.provideCompletionItems) at.

### CompletionItemKind

Completion item kinds.

#### Enumeration Members

Text: 0

The `Text` completion item kind.

Method: 1

The `Method` completion item kind.

Function: 2

The `Function` completion item kind.

Constructor: 3

The `Constructor` completion item kind.

Field: 4

The `Field` completion item kind.

Variable: 5

The `Variable` completion item kind.

Class: 6

The `Class` completion item kind.

Interface: 7

The `Interface` completion item kind.

Module: 8

The `Module` completion item kind.

Property: 9

The `Property` completion item kind.

Unit: 10

The `Unit` completion item kind.

Value: 11

The `Value` completion item kind.

Enum: 12

The `Enum` completion item kind.

Keyword: 13

The `Keyword` completion item kind.

Snippet: 14

The `Snippet` completion item kind.

Color: 15

The `Color` completion item kind.

File: 16

The `File` completion item kind.

Reference: 17

The `Reference` completion item kind.

Folder: 18

The `Folder` completion item kind.

EnumMember: 19

The `EnumMember` completion item kind.

Constant: 20

The `Constant` completion item kind.

Struct: 21

The `Struct` completion item kind.

Event: 22

The `Event` completion item kind.

Operator: 23

The `Operator` completion item kind.

TypeParameter: 24

The `TypeParameter` completion item kind.

User: 25

The `User` completion item kind.

Issue: 26

The `Issue` completion item kind.

### CompletionItemLabel

A structured label for a [completion item](#CompletionItem).

#### Properties

description?: string

An optional string which is rendered less prominently after [CompletionItemLabel.detail](#CompletionItemLabel.detail). Should be used for fully qualified names or file path.

detail?: string

An optional string which is rendered less prominently directly after [label](#CompletionItemLabel.label), without any spacing. Should be used for function signatures or type annotations.

label: string

The label of this completion item.

By default this is also the text that is inserted when this completion is selected.

### CompletionItemProvider<T>

The completion item provider interface defines the contract between extensions and [IntelliSense](https://code.visualstudio.com/docs/editor/intellisense).

Providers can delay the computation of the [detail](#CompletionItem.detail) and [documentation](#CompletionItem.documentation) properties by implementing the [resolveCompletionItem](#CompletionItemProvider.resolveCompletionItem)\-function. However, properties that are needed for the initial sorting and filtering, like `sortText`, `filterText`, `insertText`, and `range`, must not be changed during resolve.

Providers are asked for completions either explicitly by a user gesture or -depending on the configuration- implicitly when typing words or trigger characters.

#### Methods

provideCompletionItems(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken), context: [CompletionContext](#CompletionContext)): [ProviderResult](#ProviderResult&lt;T&gt;)<[CompletionList](#CompletionList&lt;T&gt;)<T\> | T\[\]>

Provide completion items for the given position and document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| context: [CompletionContext](#CompletionContext) | How the completion was triggered. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[CompletionList](#CompletionList&lt;T&gt;)<T\> \| T\[\]> | An array of completions, a [completion list](#CompletionList), or a thenable that resolves to either. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

resolveCompletionItem(item: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

Given a completion item fill in more data, like [doc-comment](#CompletionItem.documentation) or [details](#CompletionItem.detail).

The editor will only resolve a completion item once.

_Note_ that this function is called when completion items are already showing in the UI or when an item has been selected for insertion. Because of that, no property that changes the presentation (label, sorting, filtering etc) or the (primary) insert behaviour ([insertText](#CompletionItem.insertText)) can be changed.

This function may fill in [additionalTextEdits](#CompletionItem.additionalTextEdits). However, that means an item might be inserted _before_ resolving is done and in that case the editor will do a best effort to still apply those additional text edits.

| Parameter | Description |
| --- | --- |
| item: T | A completion item currently active in the UI. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | The resolved completion item or a thenable that resolves to of such. It is OK to return the given `item`. When no result is returned, the given `item` will be used. |

### CompletionItemTag

Completion item tags are extra annotations that tweak the rendering of a completion item.

#### Enumeration Members

Deprecated: 1

Render a completion as obsolete, usually using a strike-out.

### CompletionList<T>

Represents a collection of [completion items](#CompletionItem) to be presented in the editor.

#### Constructors

new CompletionList<T extends [CompletionItem](#CompletionItem)\>(items?: T\[\], isIncomplete?: boolean): [CompletionList](#CompletionList&lt;T&gt;)<T\>

Creates a new completion list.

| Parameter | Description |
| --- | --- |
| items?: T\[\] | The completion items. |
| isIncomplete?: boolean | The list is not complete. |
| Returns | Description |
| [CompletionList](#CompletionList&lt;T&gt;)<T\> |     |

#### Properties

isIncomplete?: boolean

This list is not complete. Further typing should result in recomputing this list.

items: T\[\]

The completion items.

### CompletionTriggerKind

How a [completion provider](#CompletionItemProvider) was triggered

#### Enumeration Members

Invoke: 0

Completion was triggered normally.

TriggerCharacter: 1

Completion was triggered by a trigger character.

TriggerForIncompleteCompletions: 2

Completion was re-triggered as current completion list is incomplete

### ConfigurationChangeEvent

An event describing the change in Configuration

#### Methods

affectsConfiguration(section: string, scope?: [ConfigurationScope](#ConfigurationScope)): boolean

Checks if the given section has changed. If scope is provided, checks if the section has changed for resources under the given scope.

| Parameter | Description |
| --- | --- |
| section: string | Configuration name, supports _dotted_ names. |
| scope?: [ConfigurationScope](#ConfigurationScope) | A scope in which to check. |
| Returns | Description |
| boolean | `true` if the given section has changed. |

### ConfigurationScope

The configuration scope which can be:

*   a [Uri](#Uri) representing a resource
*   a [TextDocument](#TextDocument) representing an open text document
*   a [WorkspaceFolder](#WorkspaceFolder) representing a workspace folder
*   an object containing:
    *   `uri`: an optional [Uri](#Uri) of a text document
    *   `languageId`: the language identifier of a text document

ConfigurationScope: [Uri](#Uri) | [TextDocument](#TextDocument) | [WorkspaceFolder](#WorkspaceFolder) | {languageId: string, uri: [Uri](#Uri)}

### ConfigurationTarget

The configuration target

#### Enumeration Members

Global: 1

Global configuration

Workspace: 2

Workspace configuration

WorkspaceFolder: 3

Workspace folder configuration

### CustomDocument

Represents a custom document used by a [CustomEditorProvider](#CustomEditorProvider).

Custom documents are only used within a given `CustomEditorProvider`. The lifecycle of a `CustomDocument` is managed by the editor. When no more references remain to a `CustomDocument`, it is disposed of.

#### Properties

uri: [Uri](#Uri)

The associated uri for this document.

#### Methods

dispose(): void

Dispose of the custom document.

This is invoked by the editor when there are no more references to a given `CustomDocument` (for example when all editors associated with the document have been closed.)

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### CustomDocumentBackup

A backup for an [CustomDocument](#CustomDocument).

#### Properties

id: string

Unique identifier for the backup.

This id is passed back to your extension in [openCustomDocument](#CustomReadonlyEditorProvider.openCustomDocument) when opening a custom editor from a backup.

#### Methods

delete(): void

Delete the current backup.

This is called by the editor when it is clear the current backup is no longer needed, such as when a new backup is made or when the file is saved.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### CustomDocumentBackupContext

Additional information used to implement [CustomDocumentBackup](#CustomDocumentBackup).

#### Properties

destination: [Uri](#Uri)

Suggested file location to write the new backup.

Note that your extension is free to ignore this and use its own strategy for backup.

If the editor is for a resource from the current workspace, `destination` will point to a file inside `ExtensionContext.storagePath`. The parent folder of `destination` may not exist, so make sure to created it before writing the backup to this location.

### CustomDocumentContentChangeEvent<T>

Event triggered by extensions to signal to the editor that the content of a [CustomDocument](#CustomDocument) has changed.

_See also_ [CustomEditorProvider.onDidChangeCustomDocument](#CustomEditorProvider.onDidChangeCustomDocument).

#### Properties

document: T

The document that the change is for.

### CustomDocumentEditEvent<T>

Event triggered by extensions to signal to the editor that an edit has occurred on an [CustomDocument](#CustomDocument).

_See also_ [CustomEditorProvider.onDidChangeCustomDocument](#CustomEditorProvider.onDidChangeCustomDocument).

#### Properties

document: T

The document that the edit is for.

label?: string

Display name describing the edit.

This will be shown to users in the UI for undo/redo operations.

#### Methods

redo(): void | Thenable<void\>

Redo the edit operation.

This is invoked by the editor when the user redoes this edit. To implement `redo`, your extension should restore the document and editor to the state they were in just after this edit was added to the editor's internal edit stack by [CustomEditorProvider.onDidChangeCustomDocument](#CustomEditorProvider.onDidChangeCustomDocument).

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void \| Thenable<void\> |     |

undo(): void | Thenable<void\>

Undo the edit operation.

This is invoked by the editor when the user undoes this edit. To implement `undo`, your extension should restore the document and editor to the state they were in just before this edit was added to the editor's internal edit stack by [CustomEditorProvider.onDidChangeCustomDocument](#CustomEditorProvider.onDidChangeCustomDocument).

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void \| Thenable<void\> |     |

### CustomDocumentOpenContext

Additional information about the opening custom document.

#### Properties

backupId: string

The id of the backup to restore the document from or `undefined` if there is no backup.

If this is provided, your extension should restore the editor from the backup instead of reading the file from the user's workspace.

untitledDocumentData: Uint8Array

If the URI is an untitled file, this will be populated with the byte data of that file

If this is provided, your extension should utilize this byte data rather than executing fs APIs on the URI passed in

### CustomEditorProvider<T>

Provider for editable custom editors that use a custom document model.

Custom editors use [CustomDocument](#CustomDocument) as their document model instead of a [TextDocument](#TextDocument). This gives extensions full control over actions such as edit, save, and backup.

You should use this type of custom editor when dealing with binary files or more complex scenarios. For simple text based documents, use [CustomTextEditorProvider](#CustomTextEditorProvider) instead.

#### Events

onDidChangeCustomDocument: [Event](#Event&lt;T&gt;)<[CustomDocumentEditEvent](#CustomDocumentEditEvent&lt;T&gt;)<T\>> | [Event](#Event&lt;T&gt;)<[CustomDocumentContentChangeEvent](#CustomDocumentContentChangeEvent&lt;T&gt;)<T\>>

Signal that an edit has occurred inside a custom editor.

This event must be fired by your extension whenever an edit happens in a custom editor. An edit can be anything from changing some text, to cropping an image, to reordering a list. Your extension is free to define what an edit is and what data is stored on each edit.

Firing [onDidChangeCustomDocument](#CustomEditorProvider.onDidChangeCustomDocument) causes the editors to be marked as being dirty. This is cleared when the user either saves or reverts the file.

Editors that support undo/redo must fire a [CustomDocumentEditEvent](#CustomDocumentEditEvent) whenever an edit happens. This allows users to undo and redo the edit using the editor's standard keyboard shortcuts. The editor will also mark the editor as no longer being dirty if the user undoes all edits to the last saved state.

Editors that support editing but cannot use the editor's standard undo/redo mechanism must fire a [CustomDocumentContentChangeEvent](#CustomDocumentContentChangeEvent). The only way for a user to clear the dirty state of an editor that does not support undo/redo is to either `save` or `revert` the file.

An editor should only ever fire [CustomDocumentEditEvent](#CustomDocumentEditEvent) events, or only ever fire [CustomDocumentContentChangeEvent](#CustomDocumentContentChangeEvent) events.

#### Methods

backupCustomDocument(document: T, context: [CustomDocumentBackupContext](#CustomDocumentBackupContext), cancellation: [CancellationToken](#CancellationToken)): Thenable<[CustomDocumentBackup](#CustomDocumentBackup)\>

Back up a dirty custom document.

Backups are used for hot exit and to prevent data loss. Your [backupCustomDocument](#CustomEditorProvider.backupCustomDocument) method should persist the resource in its current state, i.e. with the edits applied. Most commonly this means saving the resource to disk in the `ExtensionContext.storagePath`. When the editor reloads and your custom editor is opened for a resource, your extension should first check to see if any backups exist for the resource. If there is a backup, your extension should load the file contents from there instead of from the resource in the workspace.

[backupCustomDocument](#CustomEditorProvider.backupCustomDocument) is triggered approximately one second after the user stops editing the document. If the user rapidly edits the document, [backupCustomDocument](#CustomEditorProvider.backupCustomDocument) will not be invoked until the editing stops.

[backupCustomDocument](#CustomEditorProvider.backupCustomDocument) is not invoked when `auto save` is enabled (since auto save already persists the resource).

| Parameter | Description |
| --- | --- |
| document: T | Document to backup. |
| context: [CustomDocumentBackupContext](#CustomDocumentBackupContext) | Information that can be used to backup the document. |
| cancellation: [CancellationToken](#CancellationToken) | Token that signals the current backup since a new backup is coming in. It is up to your extension to decided how to respond to cancellation. If for example your extension is backing up a large file in an operation that takes time to complete, your extension may decide to finish the ongoing backup rather than cancelling it to ensure that the editor has some valid backup. |
| Returns | Description |
| Thenable<[CustomDocumentBackup](#CustomDocumentBackup)\> | A [Thenable](#Thenable) signaling that the backup has completed. |

openCustomDocument(uri: [Uri](#Uri), openContext: [CustomDocumentOpenContext](#CustomDocumentOpenContext), token: [CancellationToken](#CancellationToken)): T | Thenable<T\>

Create a new document for a given resource.

`openCustomDocument` is called when the first time an editor for a given resource is opened. The opened document is then passed to [resolveCustomEditor](#CustomReadonlyEditorProvider.resolveCustomEditor) so that the editor can be shown to the user.

Already opened [CustomDocuments](#CustomDocument) are re-used if the user opened additional editors. When all editors for a given resource are closed, the [CustomDocuments](#CustomDocument) is disposed of. Opening an editor at this point will trigger another call to `openCustomDocument`.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | Uri of the document to open. |
| openContext: [CustomDocumentOpenContext](#CustomDocumentOpenContext) | Additional information about the opening custom document. |
| token: [CancellationToken](#CancellationToken) | A cancellation token that indicates the result is no longer needed. |
| Returns | Description |
| T \| Thenable<T\> | The custom document. |

resolveCustomEditor(document: T, webviewPanel: [WebviewPanel](#WebviewPanel), token: [CancellationToken](#CancellationToken)): void | Thenable<void\>

Resolve a custom editor for a given resource.

This is called whenever the user opens a new editor for this `CustomEditorProvider`.

| Parameter | Description |
| --- | --- |
| document: T | Document for the resource being resolved. |
| webviewPanel: [WebviewPanel](#WebviewPanel) | The webview panel used to display the editor UI for this resource.<br><br>During resolve, the provider must fill in the initial html for the content webview panel and hook up all the event listeners on it that it is interested in. The provider can also hold onto the `WebviewPanel` to use later for example in a command. See [WebviewPanel](#WebviewPanel) for additional details. |
| token: [CancellationToken](#CancellationToken) | A cancellation token that indicates the result is no longer needed. |
| Returns | Description |
| void \| Thenable<void\> | Optional thenable indicating that the custom editor has been resolved. |

revertCustomDocument(document: T, cancellation: [CancellationToken](#CancellationToken)): Thenable<void\>

Revert a custom document to its last saved state.

This method is invoked by the editor when the user triggers `File: Revert File` in a custom editor. (Note that this is only used using the editor's `File: Revert File` command and not on a `git revert` of the file).

The implementer must make sure all editor instances (webviews) for [document](#CustomEditorProvider.revertCustomDocument.document) are displaying the document in the same state is saved in. This usually means reloading the file from the workspace.

| Parameter | Description |
| --- | --- |
| document: T | Document to revert. |
| cancellation: [CancellationToken](#CancellationToken) | Token that signals the revert is no longer required. |
| Returns | Description |
| Thenable<void\> | A [Thenable](#Thenable) signaling that the revert has completed. |

saveCustomDocument(document: T, cancellation: [CancellationToken](#CancellationToken)): Thenable<void\>

Save a custom document.

This method is invoked by the editor when the user saves a custom editor. This can happen when the user triggers save while the custom editor is active, by commands such as `save all`, or by auto save if enabled.

The implementer must persist the custom editor. This usually means writing the file data for the custom document to disk. After [saveCustomDocument](#CustomEditorProvider.saveCustomDocument) completes, any associated editor instances will no longer be marked as dirty.

| Parameter | Description |
| --- | --- |
| document: T | Document to save. |
| cancellation: [CancellationToken](#CancellationToken) | Token that signals the save is no longer required (for example, if another save was triggered). |
| Returns | Description |
| Thenable<void\> | A [Thenable](#Thenable) that saving has completed. |

saveCustomDocumentAs(document: T, destination: [Uri](#Uri), cancellation: [CancellationToken](#CancellationToken)): Thenable<void\>

Save a custom document to a different location.

This method is invoked by the editor when the user triggers 'save as' on a custom editor. The implementer must persist the custom editor to [destination](#CustomEditorProvider.saveCustomDocumentAs.destination).

When the user accepts save as, the current editor is be replaced by an non-dirty editor for the newly saved file.

| Parameter | Description |
| --- | --- |
| document: T | Document to save. |
| destination: [Uri](#Uri) | Location to save to. |
| cancellation: [CancellationToken](#CancellationToken) | Token that signals the save is no longer required. |
| Returns | Description |
| Thenable<void\> | A [Thenable](#Thenable) signaling that saving has completed. |

### CustomExecution

Class used to execute an extension callback as a task.

#### Constructors

new CustomExecution(callback: (resolvedDefinition: [TaskDefinition](#TaskDefinition)) => Thenable<[Pseudoterminal](#Pseudoterminal)\>): [CustomExecution](#CustomExecution)

Constructs a CustomExecution task object. The callback will be executed when the task is run, at which point the extension should return the Pseudoterminal it will "run in". The task should wait to do further execution until [Pseudoterminal.open](#Pseudoterminal.open) is called. Task cancellation should be handled using [Pseudoterminal.close](#Pseudoterminal.close). When the task is complete fire [Pseudoterminal.onDidClose](#Pseudoterminal.onDidClose).

| Parameter | Description |
| --- | --- |
| callback: (resolvedDefinition: [TaskDefinition](#TaskDefinition)) => Thenable<[Pseudoterminal](#Pseudoterminal)\> | The callback that will be called when the task is started by a user. Any ${} style variables that were in the task definition will be resolved and passed into the callback as `resolvedDefinition`. |
| Returns | Description |
| [CustomExecution](#CustomExecution) |     |

### CustomReadonlyEditorProvider<T>

Provider for readonly custom editors that use a custom document model.

Custom editors use [CustomDocument](#CustomDocument) as their document model instead of a [TextDocument](#TextDocument).

You should use this type of custom editor when dealing with binary files or more complex scenarios. For simple text based documents, use [CustomTextEditorProvider](#CustomTextEditorProvider) instead.

#### Methods

openCustomDocument(uri: [Uri](#Uri), openContext: [CustomDocumentOpenContext](#CustomDocumentOpenContext), token: [CancellationToken](#CancellationToken)): T | Thenable<T\>

Create a new document for a given resource.

`openCustomDocument` is called when the first time an editor for a given resource is opened. The opened document is then passed to [resolveCustomEditor](#CustomReadonlyEditorProvider.resolveCustomEditor) so that the editor can be shown to the user.

Already opened [CustomDocuments](#CustomDocument) are re-used if the user opened additional editors. When all editors for a given resource are closed, the [CustomDocuments](#CustomDocument) is disposed of. Opening an editor at this point will trigger another call to `openCustomDocument`.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | Uri of the document to open. |
| openContext: [CustomDocumentOpenContext](#CustomDocumentOpenContext) | Additional information about the opening custom document. |
| token: [CancellationToken](#CancellationToken) | A cancellation token that indicates the result is no longer needed. |
| Returns | Description |
| T \| Thenable<T\> | The custom document. |

resolveCustomEditor(document: T, webviewPanel: [WebviewPanel](#WebviewPanel), token: [CancellationToken](#CancellationToken)): void | Thenable<void\>

Resolve a custom editor for a given resource.

This is called whenever the user opens a new editor for this `CustomEditorProvider`.

| Parameter | Description |
| --- | --- |
| document: T | Document for the resource being resolved. |
| webviewPanel: [WebviewPanel](#WebviewPanel) | The webview panel used to display the editor UI for this resource.<br><br>During resolve, the provider must fill in the initial html for the content webview panel and hook up all the event listeners on it that it is interested in. The provider can also hold onto the `WebviewPanel` to use later for example in a command. See [WebviewPanel](#WebviewPanel) for additional details. |
| token: [CancellationToken](#CancellationToken) | A cancellation token that indicates the result is no longer needed. |
| Returns | Description |
| void \| Thenable<void\> | Optional thenable indicating that the custom editor has been resolved. |

### CustomTextEditorProvider

Provider for text based custom editors.

Text based custom editors use a [TextDocument](#TextDocument) as their data model. This considerably simplifies implementing a custom editor as it allows the editor to handle many common operations such as undo and backup. The provider is responsible for synchronizing text changes between the webview and the [TextDocument](#TextDocument).

#### Methods

resolveCustomTextEditor(document: [TextDocument](#TextDocument), webviewPanel: [WebviewPanel](#WebviewPanel), token: [CancellationToken](#CancellationToken)): void | Thenable<void\>

Resolve a custom editor for a given text resource.

This is called when a user first opens a resource for a `CustomTextEditorProvider`, or if they reopen an existing editor using this `CustomTextEditorProvider`.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | Document for the resource to resolve. |
| webviewPanel: [WebviewPanel](#WebviewPanel) | The webview panel used to display the editor UI for this resource.<br><br>During resolve, the provider must fill in the initial html for the content webview panel and hook up all the event listeners on it that it is interested in. The provider can also hold onto the [WebviewPanel](#WebviewPanel) to use later for example in a command. See [WebviewPanel](#WebviewPanel) for additional details. |
| token: [CancellationToken](#CancellationToken) | A cancellation token that indicates the result is no longer needed. |
| Returns | Description |
| void \| Thenable<void\> | Thenable indicating that the custom editor has been resolved. |

### DataTransfer

A map containing a mapping of the mime type of the corresponding transferred data.

Drag and drop controllers that implement [`handleDrag`](#TreeDragAndDropController.handleDrag) can add additional mime types to the data transfer. These additional mime types will only be included in the `handleDrop` when the drag was initiated from an element in the same drag and drop controller.

#### Constructors

new DataTransfer(): [DataTransfer](#DataTransfer)

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [DataTransfer](#DataTransfer) |     |

#### Methods

\[iterator\](): IterableIterator<\[mimeType: string, item: [DataTransferItem](#DataTransferItem)\]>

Get a new iterator with the `[mime, item]` pairs for each element in this data transfer.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| IterableIterator<\[mimeType: string, item: [DataTransferItem](#DataTransferItem)\]> |     |

forEach(callbackfn: (item: [DataTransferItem](#DataTransferItem), mimeType: string, dataTransfer: [DataTransfer](#DataTransfer)) => void, thisArg?: any): void

Allows iteration through the data transfer items.

| Parameter | Description |
| --- | --- |
| callbackfn: (item: [DataTransferItem](#DataTransferItem), mimeType: string, dataTransfer: [DataTransfer](#DataTransfer)) => void | Callback for iteration through the data transfer items. |
| thisArg?: any | The `this` context used when invoking the handler function. |
| Returns | Description |
| void |     |

get(mimeType: string): [DataTransferItem](#DataTransferItem)

Retrieves the data transfer item for a given mime type.

| Parameter | Description |
| --- | --- |
| mimeType: string | The mime type to get the data transfer item for, such as `text/plain` or `image/png`. Mimes type look ups are case-insensitive.<br><br>Special mime types:<br><br>*   `text/uri-list` — A string with `toString()`ed Uris separated by `\r\n`. To specify a cursor position in the file, set the Uri's fragment to `L3,5`, where 3 is the line number and 5 is the column number. |
| Returns | Description |
| [DataTransferItem](#DataTransferItem) |     |

set(mimeType: string, value: [DataTransferItem](#DataTransferItem)): void

Sets a mime type to data transfer item mapping.

| Parameter | Description |
| --- | --- |
| mimeType: string | The mime type to set the data for. Mimes types stored in lower case, with case-insensitive looks up. |
| value: [DataTransferItem](#DataTransferItem) | The data transfer item for the given mime type. |
| Returns | Description |
| void |     |

### DataTransferFile

A file associated with a [DataTransferItem](#DataTransferItem).

Instances of this type can only be created by the editor and not by extensions.

#### Properties

name: string

The name of the file.

uri?: [Uri](#Uri)

The full file path of the file.

May be `undefined` on web.

#### Methods

data(): Thenable<Uint8Array\>

The full file contents of the file.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Thenable<Uint8Array\> |     |

### DataTransferItem

Encapsulates data transferred during drag and drop operations.

#### Constructors

new DataTransferItem(value: any): [DataTransferItem](#DataTransferItem)

| Parameter | Description |
| --- | --- |
| value: any | Custom data stored on this item. Can be retrieved using [DataTransferItem.value](#DataTransferItem.value). |
| Returns | Description |
| [DataTransferItem](#DataTransferItem) |     |

#### Properties

value: any

Custom data stored on this item.

You can use `value` to share data across operations. The original object can be retrieved so long as the extension that created the `DataTransferItem` runs in the same extension host.

#### Methods

asFile(): [DataTransferFile](#DataTransferFile)

Try getting the [file](#DataTransferFile) associated with this data transfer item.

Note that the file object is only valid for the scope of the drag and drop operation.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [DataTransferFile](#DataTransferFile) | The file for the data transfer or `undefined` if the item is either not a file or the file data cannot be accessed. |

asString(): Thenable<string\>

Get a string representation of this item.

If [DataTransferItem.value](#DataTransferItem.value) is an object, this returns the result of json stringifying [DataTransferItem.value](#DataTransferItem.value) value.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Thenable<string\> |     |

### DebugAdapter

A debug adapter that implements the Debug Adapter Protocol can be registered with the editor if it implements the DebugAdapter interface.

#### Events

onDidSendMessage: [Event](#Event&lt;T&gt;)<[DebugProtocolMessage](#DebugProtocolMessage)\>

An event which fires after the debug adapter has sent a Debug Adapter Protocol message to the editor. Messages can be requests, responses, or events.

#### Methods

dispose(): any

Dispose this object.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| any |     |

handleMessage(message: [DebugProtocolMessage](#DebugProtocolMessage)): void

Handle a Debug Adapter Protocol message. Messages can be requests, responses, or events. Results or errors are returned via onSendMessage events.

| Parameter | Description |
| --- | --- |
| message: [DebugProtocolMessage](#DebugProtocolMessage) | A Debug Adapter Protocol message |
| Returns | Description |
| void |     |

### DebugAdapterDescriptor

Represents the different types of debug adapters

DebugAdapterDescriptor: [DebugAdapterExecutable](#DebugAdapterExecutable) | [DebugAdapterServer](#DebugAdapterServer) | [DebugAdapterNamedPipeServer](#DebugAdapterNamedPipeServer) | [DebugAdapterInlineImplementation](#DebugAdapterInlineImplementation)

### DebugAdapterDescriptorFactory

A debug adapter factory that creates [debug adapter descriptors](#DebugAdapterDescriptor).

#### Methods

createDebugAdapterDescriptor(session: [DebugSession](#DebugSession), executable: [DebugAdapterExecutable](#DebugAdapterExecutable)): [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugAdapterDescriptor](#DebugAdapterDescriptor)\>

'createDebugAdapterDescriptor' is called at the start of a debug session to provide details about the debug adapter to use. These details must be returned as objects of type [DebugAdapterDescriptor](#DebugAdapterDescriptor). Currently two types of debug adapters are supported:

*   a debug adapter executable is specified as a command path and arguments (see [DebugAdapterExecutable](#DebugAdapterExecutable)),
*   a debug adapter server reachable via a communication port (see [DebugAdapterServer](#DebugAdapterServer)). If the method is not implemented the default behavior is this: createDebugAdapter(session: DebugSession, executable: DebugAdapterExecutable) { if (typeof session.configuration.debugServer === 'number') { return new DebugAdapterServer(session.configuration.debugServer); } return executable; }

| Parameter | Description |
| --- | --- |
| session: [DebugSession](#DebugSession) | The [debug session](#DebugSession) for which the debug adapter will be used. |
| executable: [DebugAdapterExecutable](#DebugAdapterExecutable) | The debug adapter's executable information as specified in the package.json (or undefined if no such information exists). |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugAdapterDescriptor](#DebugAdapterDescriptor)\> | a [debug adapter descriptor](#DebugAdapterDescriptor) or undefined. |

### DebugAdapterExecutable

Represents a debug adapter executable and optional arguments and runtime options passed to it.

#### Constructors

new DebugAdapterExecutable(command: string, args?: string\[\], options?: [DebugAdapterExecutableOptions](#DebugAdapterExecutableOptions)): [DebugAdapterExecutable](#DebugAdapterExecutable)

Creates a description for a debug adapter based on an executable program.

| Parameter | Description |
| --- | --- |
| command: string | The command or executable path that implements the debug adapter. |
| args?: string\[\] | Optional arguments to be passed to the command or executable. |
| options?: [DebugAdapterExecutableOptions](#DebugAdapterExecutableOptions) | Optional options to be used when starting the command or executable. |
| Returns | Description |
| [DebugAdapterExecutable](#DebugAdapterExecutable) |     |

#### Properties

args: string\[\]

The arguments passed to the debug adapter executable. Defaults to an empty array.

command: string

The command or path of the debug adapter executable. A command must be either an absolute path of an executable or the name of an command to be looked up via the PATH environment variable. The special value 'node' will be mapped to the editor's built-in Node.js runtime.

options?: [DebugAdapterExecutableOptions](#DebugAdapterExecutableOptions)

Optional options to be used when the debug adapter is started. Defaults to undefined.

### DebugAdapterExecutableOptions

Options for a debug adapter executable.

#### Properties

cwd?: string

The current working directory for the executed debug adapter.

env?:

The additional environment of the executed program or shell. If omitted the parent process' environment is used. If provided it is merged with the parent process' environment.

### DebugAdapterInlineImplementation

A debug adapter descriptor for an inline implementation.

#### Constructors

new DebugAdapterInlineImplementation(implementation: [DebugAdapter](#DebugAdapter)): [DebugAdapterInlineImplementation](#DebugAdapterInlineImplementation)

Create a descriptor for an inline implementation of a debug adapter.

| Parameter | Description |
| --- | --- |
| implementation: [DebugAdapter](#DebugAdapter) |     |
| Returns | Description |
| [DebugAdapterInlineImplementation](#DebugAdapterInlineImplementation) |     |

### DebugAdapterNamedPipeServer

Represents a debug adapter running as a Named Pipe (on Windows)/UNIX Domain Socket (on non-Windows) based server.

#### Constructors

new DebugAdapterNamedPipeServer(path: string): [DebugAdapterNamedPipeServer](#DebugAdapterNamedPipeServer)

Create a description for a debug adapter running as a Named Pipe (on Windows)/UNIX Domain Socket (on non-Windows) based server.

| Parameter | Description |
| --- | --- |
| path: string |     |
| Returns | Description |
| [DebugAdapterNamedPipeServer](#DebugAdapterNamedPipeServer) |     |

#### Properties

path: string

The path to the NamedPipe/UNIX Domain Socket.

### DebugAdapterServer

Represents a debug adapter running as a socket based server.

#### Constructors

new DebugAdapterServer(port: number, host?: string): [DebugAdapterServer](#DebugAdapterServer)

Create a description for a debug adapter running as a socket based server.

| Parameter | Description |
| --- | --- |
| port: number |     |
| host?: string |     |
| Returns | Description |
| [DebugAdapterServer](#DebugAdapterServer) |     |

#### Properties

host?: string

The host.

port: number

The port.

### DebugAdapterTracker

A Debug Adapter Tracker is a means to track the communication between the editor and a Debug Adapter.

#### Events

onDidSendMessage(message: any): void

The debug adapter has sent a Debug Adapter Protocol message to the editor.

| Parameter | Description |
| --- | --- |
| message: any |     |
| Returns | Description |
| void |     |

onWillReceiveMessage(message: any): void

The debug adapter is about to receive a Debug Adapter Protocol message from the editor.

| Parameter | Description |
| --- | --- |
| message: any |     |
| Returns | Description |
| void |     |

onWillStartSession(): void

A session with the debug adapter is about to be started.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

onWillStopSession(): void

The debug adapter session is about to be stopped.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

#### Methods

onError(error: Error): void

An error with the debug adapter has occurred.

| Parameter | Description |
| --- | --- |
| error: Error |     |
| Returns | Description |
| void |     |

onExit(code: number, signal: string): void

The debug adapter has exited with the given exit code or signal.

| Parameter | Description |
| --- | --- |
| code: number |     |
| signal: string |     |
| Returns | Description |
| void |     |

### DebugAdapterTrackerFactory

A debug adapter factory that creates [debug adapter trackers](#DebugAdapterTracker).

#### Methods

createDebugAdapterTracker(session: [DebugSession](#DebugSession)): [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugAdapterTracker](#DebugAdapterTracker)\>

The method 'createDebugAdapterTracker' is called at the start of a debug session in order to return a "tracker" object that provides read-access to the communication between the editor and a debug adapter.

| Parameter | Description |
| --- | --- |
| session: [DebugSession](#DebugSession) | The [debug session](#DebugSession) for which the debug adapter tracker will be used. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugAdapterTracker](#DebugAdapterTracker)\> | A [debug adapter tracker](#DebugAdapterTracker) or undefined. |

### DebugConfiguration

Configuration for a debug session.

#### Properties

name: string

The name of the debug session.

request: string

The request type of the debug session.

type: string

The type of the debug session.

### DebugConfigurationProvider

A debug configuration provider allows to add debug configurations to the debug service and to resolve launch configurations before they are used to start a debug session. A debug configuration provider is registered via [debug.registerDebugConfigurationProvider](#debug.registerDebugConfigurationProvider).

#### Methods

provideDebugConfigurations(folder: [WorkspaceFolder](#WorkspaceFolder), token?: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugConfiguration](#DebugConfiguration)\[\]>

Provides [debug configuration](#DebugConfiguration) to the debug service. If more than one debug configuration provider is registered for the same type, debug configurations are concatenated in arbitrary order.

| Parameter | Description |
| --- | --- |
| folder: [WorkspaceFolder](#WorkspaceFolder) | The workspace folder for which the configurations are used or `undefined` for a folderless setup. |
| token?: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugConfiguration](#DebugConfiguration)\[\]> | An array of [debug configurations](#DebugConfiguration). |

resolveDebugConfiguration(folder: [WorkspaceFolder](#WorkspaceFolder), debugConfiguration: [DebugConfiguration](#DebugConfiguration), token?: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugConfiguration](#DebugConfiguration)\>

Resolves a [debug configuration](#DebugConfiguration) by filling in missing values or by adding/changing/removing attributes. If more than one debug configuration provider is registered for the same type, the resolveDebugConfiguration calls are chained in arbitrary order and the initial debug configuration is piped through the chain. Returning the value 'undefined' prevents the debug session from starting. Returning the value 'null' prevents the debug session from starting and opens the underlying debug configuration instead.

| Parameter | Description |
| --- | --- |
| folder: [WorkspaceFolder](#WorkspaceFolder) | The workspace folder from which the configuration originates from or `undefined` for a folderless setup. |
| debugConfiguration: [DebugConfiguration](#DebugConfiguration) | The [debug configuration](#DebugConfiguration) to resolve. |
| token?: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugConfiguration](#DebugConfiguration)\> | The resolved debug configuration or undefined or null. |

resolveDebugConfigurationWithSubstitutedVariables(folder: [WorkspaceFolder](#WorkspaceFolder), debugConfiguration: [DebugConfiguration](#DebugConfiguration), token?: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugConfiguration](#DebugConfiguration)\>

This hook is directly called after 'resolveDebugConfiguration' but with all variables substituted. It can be used to resolve or verify a [debug configuration](#DebugConfiguration) by filling in missing values or by adding/changing/removing attributes. If more than one debug configuration provider is registered for the same type, the 'resolveDebugConfigurationWithSubstitutedVariables' calls are chained in arbitrary order and the initial debug configuration is piped through the chain. Returning the value 'undefined' prevents the debug session from starting. Returning the value 'null' prevents the debug session from starting and opens the underlying debug configuration instead.

| Parameter | Description |
| --- | --- |
| folder: [WorkspaceFolder](#WorkspaceFolder) | The workspace folder from which the configuration originates from or `undefined` for a folderless setup. |
| debugConfiguration: [DebugConfiguration](#DebugConfiguration) | The [debug configuration](#DebugConfiguration) to resolve. |
| token?: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[DebugConfiguration](#DebugConfiguration)\> | The resolved debug configuration or undefined or null. |

### DebugConfigurationProviderTriggerKind

A DebugConfigurationProviderTriggerKind specifies when the `provideDebugConfigurations` method of a `DebugConfigurationProvider` is triggered. Currently there are two situations: to provide the initial debug configurations for a newly created launch.json or to provide dynamically generated debug configurations when the user asks for them through the UI (e.g. via the "Select and Start Debugging" command). A trigger kind is used when registering a `DebugConfigurationProvider` with [debug.registerDebugConfigurationProvider](#debug.registerDebugConfigurationProvider).

#### Enumeration Members

Initial: 1

`DebugConfigurationProvider.provideDebugConfigurations` is called to provide the initial debug configurations for a newly created launch.json.

Dynamic: 2

`DebugConfigurationProvider.provideDebugConfigurations` is called to provide dynamically generated debug configurations when the user asks for them through the UI (e.g. via the "Select and Start Debugging" command).

### DebugConsole

Represents the debug console.

#### Methods

append(value: string): void

Append the given value to the debug console.

| Parameter | Description |
| --- | --- |
| value: string | A string, falsy values will not be printed. |
| Returns | Description |
| void |     |

appendLine(value: string): void

Append the given value and a line feed character to the debug console.

| Parameter | Description |
| --- | --- |
| value: string | A string, falsy values will be printed. |
| Returns | Description |
| void |     |

### DebugConsoleMode

Debug console mode used by debug session, see [options](#DebugSessionOptions).

#### Enumeration Members

Separate: 0

Debug session should have a separate debug console.

MergeWithParent: 1

Debug session should share debug console with its parent session. This value has no effect for sessions which do not have a parent session.

### DebugProtocolBreakpoint

A DebugProtocolBreakpoint is an opaque stand-in type for the [Breakpoint](https://microsoft.github.io/debug-adapter-protocol/specification#Types_Breakpoint) type defined in the Debug Adapter Protocol.

### DebugProtocolMessage

A DebugProtocolMessage is an opaque stand-in type for the [ProtocolMessage](https://microsoft.github.io/debug-adapter-protocol/specification#Base_Protocol_ProtocolMessage) type defined in the Debug Adapter Protocol.

### DebugProtocolSource

A DebugProtocolSource is an opaque stand-in type for the [Source](https://microsoft.github.io/debug-adapter-protocol/specification#Types_Source) type defined in the Debug Adapter Protocol.

### DebugSession

A debug session.

#### Properties

configuration: [DebugConfiguration](#DebugConfiguration)

The "resolved" [debug configuration](#DebugConfiguration) of this session. "Resolved" means that

*   all variables have been substituted and
*   platform specific attribute sections have been "flattened" for the matching platform and removed for non-matching platforms.

id: string

The unique ID of this debug session.

name: string

The debug session's name is initially taken from the [debug configuration](#DebugConfiguration). Any changes will be properly reflected in the UI.

parentSession?: [DebugSession](#DebugSession)

The parent session of this debug session, if it was created as a child.

_See also_ DebugSessionOptions.parentSession

type: string

The debug session's type from the [debug configuration](#DebugConfiguration).

workspaceFolder: [WorkspaceFolder](#WorkspaceFolder)

The workspace folder of this session or `undefined` for a folderless setup.

#### Methods

customRequest(command: string, args?: any): Thenable<any\>

Send a custom request to the debug adapter.

| Parameter | Description |
| --- | --- |
| command: string |     |
| args?: any |     |
| Returns | Description |
| Thenable<any\> |     |

getDebugProtocolBreakpoint(breakpoint: [Breakpoint](#Breakpoint)): Thenable<[DebugProtocolBreakpoint](#DebugProtocolBreakpoint)\>

Maps a breakpoint in the editor to the corresponding Debug Adapter Protocol (DAP) breakpoint that is managed by the debug adapter of the debug session. If no DAP breakpoint exists (either because the editor breakpoint was not yet registered or because the debug adapter is not interested in the breakpoint), the value `undefined` is returned.

| Parameter | Description |
| --- | --- |
| breakpoint: [Breakpoint](#Breakpoint) | A [Breakpoint](#Breakpoint) in the editor. |
| Returns | Description |
| Thenable<[DebugProtocolBreakpoint](#DebugProtocolBreakpoint)\> | A promise that resolves to the Debug Adapter Protocol breakpoint or `undefined`. |

### DebugSessionCustomEvent

A custom Debug Adapter Protocol event received from a [debug session](#DebugSession).

#### Properties

body: any

Event specific information.

event: string

Type of event.

session: [DebugSession](#DebugSession)

The [debug session](#DebugSession) for which the custom event was received.

### DebugSessionOptions

Options for [starting a debug session](#debug.startDebugging).

#### Properties

compact?: boolean

Controls if the debug session's parent session is shown in the CALL STACK view even if it has only a single child. By default, the debug session will never hide its parent. If compact is true, debug sessions with a single child are hidden in the CALL STACK view to make the tree more compact.

consoleMode?: [DebugConsoleMode](#DebugConsoleMode)

Controls whether this session should have a separate debug console or share it with the parent session. Has no effect for sessions which do not have a parent session. Defaults to Separate.

lifecycleManagedByParent?: boolean

Controls whether lifecycle requests like 'restart' are sent to the newly created session or its parent session. By default (if the property is false or missing), lifecycle requests are sent to the new session. This property is ignored if the session has no parent session.

noDebug?: boolean

Controls whether this session should run without debugging, thus ignoring breakpoints. When this property is not specified, the value from the parent session (if there is one) is used.

parentSession?: [DebugSession](#DebugSession)

When specified the newly created debug session is registered as a "child" session of this "parent" debug session.

suppressDebugStatusbar?: boolean

When true, the window statusbar color will not be changed for this session.

suppressDebugToolbar?: boolean

When true, the debug toolbar will not be shown for this session.

suppressDebugView?: boolean

When true, the debug viewlet will not be automatically revealed for this session.

suppressSaveBeforeStart?: boolean

When true, a save will not be triggered for open editors when starting a debug session, regardless of the value of the `debug.saveBeforeStart` setting.

testRun?: [TestRun](#TestRun)

Signals to the editor that the debug session was started from a test run request. This is used to link the lifecycle of the debug session and test run in UI actions.

### DebugStackFrame

Represents a stack frame in a debug session.

#### Properties

frameId: number

ID of the stack frame in the debug protocol.

session: [DebugSession](#DebugSession)

Debug session for thread.

threadId: number

ID of the associated thread in the debug protocol.

### DebugThread

Represents a thread in a debug session.

#### Properties

session: [DebugSession](#DebugSession)

Debug session for thread.

threadId: number

ID of the associated thread in the debug protocol.

### Declaration

The declaration of a symbol representation as one or many [locations](#Location) or [location links](#LocationLink).

Declaration: [Location](#Location) | [Location](#Location)\[\] | [LocationLink](#LocationLink)\[\]

### DeclarationCoverage

Contains coverage information for a declaration. Depending on the reporter and language, this may be types such as functions, methods, or namespaces.

#### Constructors

new DeclarationCoverage(name: string, executed: number | boolean, location: [Range](#Range) | [Position](#Position)): [DeclarationCoverage](#DeclarationCoverage)

| Parameter | Description |
| --- | --- |
| name: string |     |
| executed: number \| boolean | The number of times this declaration was executed, or a boolean indicating whether it was executed if the exact count is unknown. If zero or false, the declaration will be marked as un-covered. |
| location: [Range](#Range) \| [Position](#Position) | The declaration position. |
| Returns | Description |
| [DeclarationCoverage](#DeclarationCoverage) |     |

#### Properties

executed: number | boolean

The number of times this declaration was executed, or a boolean indicating whether it was executed if the exact count is unknown. If zero or false, the declaration will be marked as un-covered.

location: [Range](#Range) | [Position](#Position)

Declaration location.

name: string

Name of the declaration.

### DeclarationProvider

The declaration provider interface defines the contract between extensions and the go to declaration feature.

#### Methods

provideDeclaration(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[Declaration](#Declaration)\>

Provide the declaration of the symbol at the given position and document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[Declaration](#Declaration)\> | A declaration or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### DecorationInstanceRenderOptions

Represents render options for decoration instances. See [DecorationOptions.renderOptions](#DecorationOptions.renderOptions).

#### Properties

after?: [ThemableDecorationAttachmentRenderOptions](#ThemableDecorationAttachmentRenderOptions)

Defines the rendering options of the attachment that is inserted after the decorated text.

before?: [ThemableDecorationAttachmentRenderOptions](#ThemableDecorationAttachmentRenderOptions)

Defines the rendering options of the attachment that is inserted before the decorated text.

dark?: [ThemableDecorationInstanceRenderOptions](#ThemableDecorationInstanceRenderOptions)

Overwrite options for dark themes.

light?: [ThemableDecorationInstanceRenderOptions](#ThemableDecorationInstanceRenderOptions)

Overwrite options for light themes.

### DecorationOptions

Represents options for a specific decoration in a [decoration set](#TextEditorDecorationType).

#### Properties

hoverMessage?: [MarkdownString](#MarkdownString) | [MarkedString](#MarkedString) | Array<[MarkdownString](#MarkdownString) | [MarkedString](#MarkedString)\>

A message that should be rendered when hovering over the decoration.

range: [Range](#Range)

Range to which this decoration is applied. The range must not be empty.

renderOptions?: [DecorationInstanceRenderOptions](#DecorationInstanceRenderOptions)

Render options applied to the current decoration. For performance reasons, keep the number of decoration specific options small, and use decoration types wherever possible.

### DecorationRangeBehavior

Describes the behavior of decorations when typing/editing at their edges.

#### Enumeration Members

OpenOpen: 0

The decoration's range will widen when edits occur at the start or end.

ClosedClosed: 1

The decoration's range will not widen when edits occur at the start or end.

OpenClosed: 2

The decoration's range will widen when edits occur at the start, but not at the end.

ClosedOpen: 3

The decoration's range will widen when edits occur at the end, but not at the start.

### DecorationRenderOptions

Represents rendering styles for a [text editor decoration](#TextEditorDecorationType).

#### Properties

after?: [ThemableDecorationAttachmentRenderOptions](#ThemableDecorationAttachmentRenderOptions)

Defines the rendering options of the attachment that is inserted after the decorated text.

backgroundColor?: string | [ThemeColor](#ThemeColor)

Background color of the decoration. Use rgba() and define transparent background colors to play well with other decorations. Alternatively a color from the color registry can be [referenced](#ThemeColor).

before?: [ThemableDecorationAttachmentRenderOptions](#ThemableDecorationAttachmentRenderOptions)

Defines the rendering options of the attachment that is inserted before the decorated text.

border?: string

CSS styling property that will be applied to text enclosed by a decoration.

borderColor?: string | [ThemeColor](#ThemeColor)

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

borderRadius?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

borderSpacing?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

borderStyle?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

borderWidth?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

color?: string | [ThemeColor](#ThemeColor)

CSS styling property that will be applied to text enclosed by a decoration.

cursor?: string

CSS styling property that will be applied to text enclosed by a decoration.

dark?: [ThemableDecorationRenderOptions](#ThemableDecorationRenderOptions)

Overwrite options for dark themes.

fontStyle?: string

CSS styling property that will be applied to text enclosed by a decoration.

fontWeight?: string

CSS styling property that will be applied to text enclosed by a decoration.

gutterIconPath?: string | [Uri](#Uri)

An **absolute path** or an URI to an image to be rendered in the gutter.

gutterIconSize?: string

Specifies the size of the gutter icon. Available values are 'auto', 'contain', 'cover' and any percentage value. For further information: [https://msdn.microsoft.com/en-us/library/jj127316(v=vs.85).aspx](https://msdn.microsoft.com/en-us/library/jj127316(v=vs.85).aspx)

isWholeLine?: boolean

Should the decoration be rendered also on the whitespace after the line text. Defaults to `false`.

letterSpacing?: string

CSS styling property that will be applied to text enclosed by a decoration.

light?: [ThemableDecorationRenderOptions](#ThemableDecorationRenderOptions)

Overwrite options for light themes.

opacity?: string

CSS styling property that will be applied to text enclosed by a decoration.

outline?: string

CSS styling property that will be applied to text enclosed by a decoration.

outlineColor?: string | [ThemeColor](#ThemeColor)

CSS styling property that will be applied to text enclosed by a decoration. Better use 'outline' for setting one or more of the individual outline properties.

outlineStyle?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'outline' for setting one or more of the individual outline properties.

outlineWidth?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'outline' for setting one or more of the individual outline properties.

overviewRulerColor?: string | [ThemeColor](#ThemeColor)

The color of the decoration in the overview ruler. Use rgba() and define transparent colors to play well with other decorations.

overviewRulerLane?: [OverviewRulerLane](#OverviewRulerLane)

The position in the overview ruler where the decoration should be rendered.

rangeBehavior?: [DecorationRangeBehavior](#DecorationRangeBehavior)

Customize the growing behavior of the decoration when edits occur at the edges of the decoration's range. Defaults to `DecorationRangeBehavior.OpenOpen`.

textDecoration?: string

CSS styling property that will be applied to text enclosed by a decoration.

### Definition

The definition of a symbol represented as one or many [locations](#Location). For most programming languages there is only one location at which a symbol is defined.

Definition: [Location](#Location) | [Location](#Location)\[\]

### DefinitionLink

Information about where a symbol is defined.

Provides additional metadata over normal [Location](#Location) definitions, including the range of the defining symbol

DefinitionLink: [LocationLink](#LocationLink)

### DefinitionProvider

The definition provider interface defines the contract between extensions and the [go to definition](https://code.visualstudio.com/docs/editor/editingevolved#_go-to-definition) and peek definition features.

#### Methods

provideDefinition(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[Definition](#Definition) | [LocationLink](#LocationLink)\[\]>

Provide the definition of the symbol at the given position and document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[Definition](#Definition) \| [LocationLink](#LocationLink)\[\]> | A definition or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### Diagnostic

Represents a diagnostic, such as a compiler error or warning. Diagnostic objects are only valid in the scope of a file.

#### Constructors

new Diagnostic(range: [Range](#Range), message: string, severity?: [DiagnosticSeverity](#DiagnosticSeverity)): [Diagnostic](#Diagnostic)

Creates a new diagnostic object.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The range to which this diagnostic applies. |
| message: string | The human-readable message. |
| severity?: [DiagnosticSeverity](#DiagnosticSeverity) | The severity, default is [error](#DiagnosticSeverity.Error). |
| Returns | Description |
| [Diagnostic](#Diagnostic) |     |

#### Properties

code?: string | number | {target: [Uri](#Uri), value: string | number}

A code or identifier for this diagnostic. Should be used for later processing, e.g. when providing [code actions](#CodeActionContext).

message: string

The human-readable message.

range: [Range](#Range)

The range to which this diagnostic applies.

relatedInformation?: [DiagnosticRelatedInformation](#DiagnosticRelatedInformation)\[\]

An array of related diagnostic information, e.g. when symbol-names within a scope collide all definitions can be marked via this property.

severity: [DiagnosticSeverity](#DiagnosticSeverity)

The severity, default is [error](#DiagnosticSeverity.Error).

source?: string

A human-readable string describing the source of this diagnostic, e.g. 'typescript' or 'super lint'.

tags?: [DiagnosticTag](#DiagnosticTag)\[\]

Additional metadata about the diagnostic.

### DiagnosticChangeEvent

The event that is fired when diagnostics change.

#### Properties

uris: readonly [Uri](#Uri)\[\]

An array of resources for which diagnostics have changed.

### DiagnosticCollection

A diagnostics collection is a container that manages a set of [diagnostics](#Diagnostic). Diagnostics are always scopes to a diagnostics collection and a resource.

To get an instance of a `DiagnosticCollection` use [createDiagnosticCollection](#languages.createDiagnosticCollection).

#### Properties

name: string

The name of this diagnostic collection, for instance `typescript`. Every diagnostic from this collection will be associated with this name. Also, the task framework uses this name when defining [problem matchers](https://code.visualstudio.com/docs/editor/tasks#_defining-a-problem-matcher).

#### Methods

clear(): void

Remove all diagnostics from this collection. The same as calling `#set(undefined)`;

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

delete(uri: [Uri](#Uri)): void

Remove all diagnostics from this collection that belong to the provided `uri`. The same as `#set(uri, undefined)`.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| Returns | Description |
| void |     |

dispose(): void

Dispose and free associated resources. Calls [clear](#DiagnosticCollection.clear).

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

forEach(callback: (uri: [Uri](#Uri), diagnostics: readonly [Diagnostic](#Diagnostic)\[\], collection: [DiagnosticCollection](#DiagnosticCollection)) => any, thisArg?: any): void

Iterate over each entry in this collection.

| Parameter | Description |
| --- | --- |
| callback: (uri: [Uri](#Uri), diagnostics: readonly [Diagnostic](#Diagnostic)\[\], collection: [DiagnosticCollection](#DiagnosticCollection)) => any | Function to execute for each entry. |
| thisArg?: any | The `this` context used when invoking the handler function. |
| Returns | Description |
| void |     |

get(uri: [Uri](#Uri)): readonly [Diagnostic](#Diagnostic)\[\]

Get the diagnostics for a given resource. _Note_ that you cannot modify the diagnostics-array returned from this call.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| Returns | Description |
| readonly [Diagnostic](#Diagnostic)\[\] | An immutable array of [diagnostics](#Diagnostic) or `undefined`. |

has(uri: [Uri](#Uri)): boolean

Check if this collection contains diagnostics for a given resource.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| Returns | Description |
| boolean | `true` if this collection has diagnostic for the given resource. |

set(uri: [Uri](#Uri), diagnostics: readonly [Diagnostic](#Diagnostic)\[\]): void

Assign diagnostics for given resource. Will replace existing diagnostics for that resource.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| diagnostics: readonly [Diagnostic](#Diagnostic)\[\] | Array of diagnostics or `undefined` |
| Returns | Description |
| void |     |

set(entries: ReadonlyArray<\[[Uri](#Uri), readonly Diagnostic\[\]\]>): void

Replace diagnostics for multiple resources in this collection.

_Note_ that multiple tuples of the same uri will be merged, e.g `[[file1, [d1]], [file1, [d2]]]` is equivalent to `[[file1, [d1, d2]]]`. If a diagnostics item is `undefined` as in `[file1, undefined]` all previous but not subsequent diagnostics are removed.

| Parameter | Description |
| --- | --- |
| entries: ReadonlyArray<\[[Uri](#Uri), readonly Diagnostic\[\]\]> | An array of tuples, like `[[file1, [d1, d2]], [file2, [d3, d4, d5]]]`, or `undefined`. |
| Returns | Description |
| void |     |

### DiagnosticRelatedInformation

Represents a related message and source code location for a diagnostic. This should be used to point to code locations that cause or related to a diagnostics, e.g. when duplicating a symbol in a scope.

#### Constructors

new DiagnosticRelatedInformation(location: [Location](#Location), message: string): [DiagnosticRelatedInformation](#DiagnosticRelatedInformation)

Creates a new related diagnostic information object.

| Parameter | Description |
| --- | --- |
| location: [Location](#Location) | The location. |
| message: string | The message. |
| Returns | Description |
| [DiagnosticRelatedInformation](#DiagnosticRelatedInformation) |     |

#### Properties

location: [Location](#Location)

The location of this related diagnostic information.

message: string

The message of this related diagnostic information.

### DiagnosticSeverity

Represents the severity of diagnostics.

#### Enumeration Members

Error: 0

Something not allowed by the rules of a language or other means.

Warning: 1

Something suspicious but allowed.

Information: 2

Something to inform about but not a problem.

Hint: 3

Something to hint to a better way of doing it, like proposing a refactoring.

### DiagnosticTag

Additional metadata about the type of a diagnostic.

#### Enumeration Members

Unnecessary: 1

Unused or unnecessary code.

Diagnostics with this tag are rendered faded out. The amount of fading is controlled by the `"editorUnnecessaryCode.opacity"` theme color. For example, `"editorUnnecessaryCode.opacity": "#000000c0"` will render the code with 75% opacity. For high contrast themes, use the `"editorUnnecessaryCode.border"` theme color to underline unnecessary code instead of fading it out.

Deprecated: 2

Deprecated or obsolete code.

Diagnostics with this tag are rendered with a strike through.

### Disposable

Represents a type which can release resources, such as event listening or a timer.

#### Static

from(...disposableLikes: Array<{dispose: () => any}>): [Disposable](#Disposable)

Combine many disposable-likes into one. You can use this method when having objects with a dispose function which aren't instances of `Disposable`.

| Parameter | Description |
| --- | --- |
| ...disposableLikes: Array<{dispose: () => any}> | Objects that have at least a `dispose`\-function member. Note that asynchronous dispose-functions aren't awaited. |
| Returns | Description |
| [Disposable](#Disposable) | Returns a new disposable which, upon dispose, will dispose all provided disposables. |

#### Constructors

new Disposable(callOnDispose: () => any): [Disposable](#Disposable)

Creates a new disposable that calls the provided function on dispose.

_Note_ that an asynchronous function is not awaited.

| Parameter | Description |
| --- | --- |
| callOnDispose: () => any | Function that disposes something. |
| Returns | Description |
| [Disposable](#Disposable) |     |

#### Methods

dispose(): any

Dispose this object.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| any |     |

### DocumentColorProvider

The document color provider defines the contract between extensions and feature of picking and modifying colors in the editor.

#### Methods

provideColorPresentations(color: [Color](#Color), context: {document: [TextDocument](#TextDocument), range: [Range](#Range)}, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[ColorPresentation](#ColorPresentation)\[\]>

Provide [representations](#ColorPresentation) for a color.

| Parameter | Description |
| --- | --- |
| color: [Color](#Color) | The color to show and insert. |
| context: {document: [TextDocument](#TextDocument), range: [Range](#Range)} | A context object with additional information |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[ColorPresentation](#ColorPresentation)\[\]> | An array of color presentations or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

provideDocumentColors(document: [TextDocument](#TextDocument), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[ColorInformation](#ColorInformation)\[\]>

Provide colors for the given document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[ColorInformation](#ColorInformation)\[\]> | An array of [color information](#ColorInformation) or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

### DocumentDropEdit

An edit operation applied [on drop](#DocumentDropEditProvider).

#### Constructors

new DocumentDropEdit(insertText: string | [SnippetString](#SnippetString), title?: string, kind?: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)): [DocumentDropEdit](#DocumentDropEdit)

| Parameter | Description |
| --- | --- |
| insertText: string \| [SnippetString](#SnippetString) | The text or snippet to insert at the drop location. |
| title?: string | Human readable label that describes the edit. |
| kind?: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind) | [Kind](#DocumentDropOrPasteEditKind) of the edit. |
| Returns | Description |
| [DocumentDropEdit](#DocumentDropEdit) |     |

#### Properties

additionalEdit?: [WorkspaceEdit](#WorkspaceEdit)

An optional additional edit to apply on drop.

insertText: string | [SnippetString](#SnippetString)

The text or snippet to insert at the drop location.

kind?: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)

[Kind](#DocumentDropOrPasteEditKind) of the edit.

title?: string

Human readable label that describes the edit.

yieldTo?: readonly [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)\[\]

Controls the ordering or multiple edits. If this provider yield to edits, it will be shown lower in the list.

### DocumentDropEditProvider<T>

Provider which handles dropping of resources into a text editor.

This allows users to drag and drop resources (including resources from external apps) into the editor. While dragging and dropping files, users can hold down `shift` to drop the file into the editor instead of opening it. Requires `editor.dropIntoEditor.enabled` to be on.

#### Methods

provideDocumentDropEdits(document: [TextDocument](#TextDocument), position: [Position](#Position), dataTransfer: [DataTransfer](#DataTransfer), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T | T\[\]>

Provide edits which inserts the content being dragged and dropped into the document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the drop occurred. |
| position: [Position](#Position) | The position in the document where the drop occurred. |
| dataTransfer: [DataTransfer](#DataTransfer) | A [DataTransfer](#DataTransfer) object that holds data about what is being dragged and dropped. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T \| T\[\]> | A [DocumentDropEdit](#DocumentDropEdit) or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

resolveDocumentDropEdit(edit: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

Optional method which fills in the [DocumentDropEdit.additionalEdit](#DocumentDropEdit.additionalEdit) before the edit is applied.

This is called once per edit and should be used if generating the complete edit may take a long time. Resolve can only be used to change [DocumentDropEdit.additionalEdit](#DocumentDropEdit.additionalEdit).

| Parameter | Description |
| --- | --- |
| edit: T | The [DocumentDropEdit](#DocumentDropEdit) to resolve. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | The resolved edit or a thenable that resolves to such. It is OK to return the given `edit`. If no result is returned, the given `edit` is used. |

### DocumentDropEditProviderMetadata

Provides additional metadata about how a [DocumentDropEditProvider](#DocumentDropEditProvider) works.

#### Properties

dropMimeTypes: readonly string\[\]

List of [DataTransfer](#DataTransfer) mime types that the provider can handle.

This can either be an exact mime type such as `image/png`, or a wildcard pattern such as `image/*`.

Use `text/uri-list` for resources dropped from the explorer or other tree views in the workbench.

Use `files` to indicate that the provider should be invoked if any [files](#DataTransferFile) are present in the [DataTransfer](#DataTransfer). Note that [DataTransferFile](#DataTransferFile) entries are only created when dropping content from outside the editor, such as from the operating system.

providedDropEditKinds?: readonly [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)\[\]

List of [kinds](#DocumentDropOrPasteEditKind) that the provider may return in [provideDocumentDropEdits](#DocumentDropEditProvider.provideDocumentDropEdits).

This is used to filter out providers when a specific [kind](#DocumentDropOrPasteEditKind) of edit is requested.

### DocumentDropOrPasteEditKind

Identifies a [DocumentDropEdit](#DocumentDropEdit) or [DocumentPasteEdit](#DocumentPasteEdit)

#### Static

Empty: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)

Text: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)

The root kind for basic text edits.

This kind should be used for edits that insert basic text into the document. A good example of this is an edit that pastes the clipboard text while also updating imports in the file based on the pasted text. For this we could use a kind such as `text.updateImports.someLanguageId`.

Even though most drop/paste edits ultimately insert text, you should not use [Text](#DocumentDropOrPasteEditKind.Text) as the base kind for every edit as this is redundant. Instead a more specific kind that describes the type of content being inserted should be used instead. For example, if the edit adds a Markdown link, use `markdown.link` since even though the content being inserted is text, it's more important to know that the edit inserts Markdown syntax.

TextUpdateImports: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)

Root kind for edits that update imports in a document in addition to inserting text.

#### Constructors

new DocumentDropOrPasteEditKind(value: string): [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)

Use [DocumentDropOrPasteEditKind.Empty](#DocumentDropOrPasteEditKind.Empty) instead.

| Parameter | Description |
| --- | --- |
| value: string |     |
| Returns | Description |
| [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind) |     |

#### Properties

value: string

The raw string value of the kind.

#### Methods

append(...parts: string\[\]): [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)

Create a new kind by appending additional scopes to the current kind.

Does not modify the current kind.

| Parameter | Description |
| --- | --- |
| ...parts: string\[\] |     |
| Returns | Description |
| [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind) |     |

contains(other: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)): boolean

Checks if `other` is a sub-kind of this `DocumentDropOrPasteEditKind`.

The kind `"text.plain"` for example contains `"text.plain"` and `"text.plain.list"`, but not `"text"` or `"unicorn.text.plain"`.

| Parameter | Description |
| --- | --- |
| other: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind) | Kind to check. |
| Returns | Description |
| boolean |     |

intersects(other: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)): boolean

Checks if this kind intersects `other`.

The kind `"text.plain"` for example intersects `text`, `"text.plain"` and `"text.plain.list"`, but not `"unicorn"`, or `"textUnicorn.plain"`.

| Parameter | Description |
| --- | --- |
| other: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind) | Kind to check. |
| Returns | Description |
| boolean |     |

### DocumentFilter

A document filter denotes a document by different properties like the [language](#TextDocument.languageId), the [scheme](#Uri.scheme) of its resource, or a glob-pattern that is applied to the [path](#TextDocument.fileName).

**Example** A language filter that applies to typescript files on disk

```
{ language: 'typescript', scheme: 'file' }
```

**Example** A language filter that applies to all package.json paths

```
{ language: 'json', pattern: '**/package.json' }
```

#### Properties

language?: string

A language id, like `typescript`.

notebookType?: string

The [type](#NotebookDocument.notebookType) of a notebook, like `jupyter-notebook`. This allows to narrow down on the type of a notebook that a [cell document](#NotebookCell.document) belongs to.

_Note_ that setting the `notebookType`\-property changes how `scheme` and `pattern` are interpreted. When set they are evaluated against the [notebook uri](#NotebookDocument.uri), not the document uri.

**Example** Match python document inside jupyter notebook that aren't stored yet (`untitled`)

```
{ language: 'python', notebookType: 'jupyter-notebook', scheme: 'untitled' }
```

pattern?: [GlobPattern](#GlobPattern)

A [glob pattern](#GlobPattern) that is matched on the absolute path of the document. Use a [relative pattern](#RelativePattern) to filter documents to a [workspace folder](#WorkspaceFolder).

scheme?: string

A Uri [scheme](#Uri.scheme), like `file` or `untitled`.

### DocumentFormattingEditProvider

The document formatting provider interface defines the contract between extensions and the formatting-feature.

#### Methods

provideDocumentFormattingEdits(document: [TextDocument](#TextDocument), options: [FormattingOptions](#FormattingOptions), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[TextEdit](#TextEdit)\[\]>

Provide formatting edits for a whole document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| options: [FormattingOptions](#FormattingOptions) | Options controlling formatting. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[TextEdit](#TextEdit)\[\]> | A set of text edits or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

### DocumentHighlight

A document highlight is a range inside a text document which deserves special attention. Usually a document highlight is visualized by changing the background color of its range.

#### Constructors

new DocumentHighlight(range: [Range](#Range), kind?: [DocumentHighlightKind](#DocumentHighlightKind)): [DocumentHighlight](#DocumentHighlight)

Creates a new document highlight object.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The range the highlight applies to. |
| kind?: [DocumentHighlightKind](#DocumentHighlightKind) | The highlight kind, default is [text](#DocumentHighlightKind.Text). |
| Returns | Description |
| [DocumentHighlight](#DocumentHighlight) |     |

#### Properties

kind?: [DocumentHighlightKind](#DocumentHighlightKind)

The highlight kind, default is [text](#DocumentHighlightKind.Text).

range: [Range](#Range)

The range this highlight applies to.

### DocumentHighlightKind

A document highlight kind.

#### Enumeration Members

Text: 0

A textual occurrence.

Read: 1

Read-access of a symbol, like reading a variable.

Write: 2

Write-access of a symbol, like writing to a variable.

### DocumentHighlightProvider

The document highlight provider interface defines the contract between extensions and the word-highlight-feature.

#### Methods

provideDocumentHighlights(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[DocumentHighlight](#DocumentHighlight)\[\]>

Provide a set of document highlights, like all occurrences of a variable or all exit-points of a function.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[DocumentHighlight](#DocumentHighlight)\[\]> | An array of document highlights or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

### DocumentLink

A document link is a range in a text document that links to an internal or external resource, like another text document or a web site.

#### Constructors

new DocumentLink(range: [Range](#Range), target?: [Uri](#Uri)): [DocumentLink](#DocumentLink)

Creates a new document link.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The range the document link applies to. Must not be empty. |
| target?: [Uri](#Uri) | The uri the document link points to. |
| Returns | Description |
| [DocumentLink](#DocumentLink) |     |

#### Properties

range: [Range](#Range)

The range this link applies to.

target?: [Uri](#Uri)

The uri this link points to.

tooltip?: string

The tooltip text when you hover over this link.

If a tooltip is provided, is will be displayed in a string that includes instructions on how to trigger the link, such as `{0} (ctrl + click)`. The specific instructions vary depending on OS, user settings, and localization.

### DocumentLinkProvider<T>

The document link provider defines the contract between extensions and feature of showing links in the editor.

#### Methods

provideDocumentLinks(document: [TextDocument](#TextDocument), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Provide links for the given document. Note that the editor ships with a default provider that detects `http(s)` and `file` links.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | An array of [document links](#DocumentLink) or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

resolveDocumentLink(link: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

Given a link fill in its [target](#DocumentLink.target). This method is called when an incomplete link is selected in the UI. Providers can implement this method and return incomplete links (without target) from the [provideDocumentLinks](#DocumentLinkProvider.provideDocumentLinks) method which often helps to improve performance.

| Parameter | Description |
| --- | --- |
| link: T | The link that is to be resolved. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> |     |

### DocumentPasteEdit

An edit the applies a paste operation.

#### Constructors

new DocumentPasteEdit(insertText: string | [SnippetString](#SnippetString), title: string, kind: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)): [DocumentPasteEdit](#DocumentPasteEdit)

Create a new paste edit.

| Parameter | Description |
| --- | --- |
| insertText: string \| [SnippetString](#SnippetString) | The text or snippet to insert at the pasted locations. |
| title: string | Human readable label that describes the edit. |
| kind: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind) | [Kind](#DocumentDropOrPasteEditKind) of the edit. |
| Returns | Description |
| [DocumentPasteEdit](#DocumentPasteEdit) |     |

#### Properties

additionalEdit?: [WorkspaceEdit](#WorkspaceEdit)

An optional additional edit to apply on paste.

insertText: string | [SnippetString](#SnippetString)

The text or snippet to insert at the pasted locations.

If your edit requires more advanced insertion logic, set this to an empty string and provide an [additional edit](#DocumentPasteEdit.additionalEdit) instead.

kind: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)

[Kind](#DocumentDropOrPasteEditKind) of the edit.

title: string

Human readable label that describes the edit.

yieldTo?: readonly [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)\[\]

Controls ordering when multiple paste edits can potentially be applied.

If this edit yields to another, it will be shown lower in the list of possible paste edits shown to the user.

### DocumentPasteEditContext

Additional information about the paste operation.

#### Properties

only: [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)

Requested kind of paste edits to return.

When a explicit kind if requested by [PasteAs](#DocumentPasteTriggerKind.PasteAs), providers are encourage to be more flexible when generating an edit of the requested kind.

triggerKind: [DocumentPasteTriggerKind](#DocumentPasteTriggerKind)

The reason why paste edits were requested.

### DocumentPasteEditProvider<T>

Provider invoked when the user copies or pastes in a [TextDocument](#TextDocument).

#### Methods

prepareDocumentPaste(document: [TextDocument](#TextDocument), ranges: readonly [Range](#Range)\[\], dataTransfer: [DataTransfer](#DataTransfer), token: [CancellationToken](#CancellationToken)): void | Thenable<void\>

Optional method invoked after the user copies from a [text editor](#TextEditor).

This allows the provider to attach metadata about the copied text to the [DataTransfer](#DataTransfer). This data transfer is then passed back to providers in [provideDocumentPasteEdits](#DocumentPasteEditProvider.provideDocumentPasteEdits).

Note that currently any changes to the [DataTransfer](#DataTransfer) are isolated to the current editor window. This means that any added metadata cannot be seen by other editor windows or by other applications.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | Text document where the copy took place. |
| ranges: readonly [Range](#Range)\[\] | Ranges being copied in [document](#DocumentPasteEditProvider.prepareDocumentPaste.document). |
| dataTransfer: [DataTransfer](#DataTransfer) | The data transfer associated with the copy. You can store additional values on this for later use in [provideDocumentPasteEdits](#DocumentPasteEditProvider.provideDocumentPasteEdits). This object is only valid for the duration of this method. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| void \| Thenable<void\> | Optional thenable that resolves when all changes to the `dataTransfer` are complete. |

provideDocumentPasteEdits(document: [TextDocument](#TextDocument), ranges: readonly [Range](#Range)\[\], dataTransfer: [DataTransfer](#DataTransfer), context: [DocumentPasteEditContext](#DocumentPasteEditContext), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Invoked before the user pastes into a [text editor](#TextEditor).

Returned edits can replace the standard pasting behavior.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | Document being pasted into |
| ranges: readonly [Range](#Range)\[\] | Range in the [document](#DocumentPasteEditProvider.provideDocumentPasteEdits.document) to paste into. |
| dataTransfer: [DataTransfer](#DataTransfer) | The [data transfer](#DataTransfer) associated with the paste. This object is only valid for the duration of the paste operation. |
| context: [DocumentPasteEditContext](#DocumentPasteEditContext) | Additional context for the paste. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | Set of potential [edits](#DocumentPasteEdit) that can apply the paste. Only a single returned [DocumentPasteEdit](#DocumentPasteEdit) is applied at a time. If multiple edits are returned from all providers, then the first is automatically applied and a widget is shown that lets the user switch to the other edits. |

resolveDocumentPasteEdit(pasteEdit: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

Optional method which fills in the [DocumentPasteEdit.additionalEdit](#DocumentPasteEdit.additionalEdit) before the edit is applied.

This is called once per edit and should be used if generating the complete edit may take a long time. Resolve can only be used to change [DocumentPasteEdit.insertText](#DocumentPasteEdit.insertText) or [DocumentPasteEdit.additionalEdit](#DocumentPasteEdit.additionalEdit).

| Parameter | Description |
| --- | --- |
| pasteEdit: T | The [DocumentPasteEdit](#DocumentPasteEdit) to resolve. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | The resolved paste edit or a thenable that resolves to such. It is OK to return the given `pasteEdit`. If no result is returned, the given `pasteEdit` is used. |

### DocumentPasteProviderMetadata

Provides additional metadata about how a [DocumentPasteEditProvider](#DocumentPasteEditProvider) works.

#### Properties

copyMimeTypes?: readonly string\[\]

Mime types that [prepareDocumentPaste](#DocumentPasteEditProvider.prepareDocumentPaste) may add on copy.

pasteMimeTypes?: readonly string\[\]

Mime types that [provideDocumentPasteEdits](#DocumentPasteEditProvider.provideDocumentPasteEdits) should be invoked for.

This can either be an exact mime type such as `image/png`, or a wildcard pattern such as `image/*`.

Use `text/uri-list` for resources dropped from the explorer or other tree views in the workbench.

Use `files` to indicate that the provider should be invoked if any [files](#DataTransferFile) are present in the [DataTransfer](#DataTransfer). Note that [DataTransferFile](#DataTransferFile) entries are only created when pasting content from outside the editor, such as from the operating system.

providedPasteEditKinds: readonly [DocumentDropOrPasteEditKind](#DocumentDropOrPasteEditKind)\[\]

List of [kinds](#DocumentDropOrPasteEditKind) that the provider may return in [provideDocumentPasteEdits](#DocumentPasteEditProvider.provideDocumentPasteEdits).

This is used to filter out providers when a specific [kind](#DocumentDropOrPasteEditKind) of edit is requested.

### DocumentPasteTriggerKind

The reason why paste edits were requested.

#### Enumeration Members

Automatic: 0

Pasting was requested as part of a normal paste operation.

PasteAs: 1

Pasting was requested by the user with the `paste as` command.

### DocumentRangeFormattingEditProvider

The document formatting provider interface defines the contract between extensions and the formatting-feature.

#### Methods

provideDocumentRangeFormattingEdits(document: [TextDocument](#TextDocument), range: [Range](#Range), options: [FormattingOptions](#FormattingOptions), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[TextEdit](#TextEdit)\[\]>

Provide formatting edits for a range in a document.

The given range is a hint and providers can decide to format a smaller or larger range. Often this is done by adjusting the start and end of the range to full syntax nodes.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| range: [Range](#Range) | The range which should be formatted. |
| options: [FormattingOptions](#FormattingOptions) | Options controlling formatting. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[TextEdit](#TextEdit)\[\]> | A set of text edits or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

provideDocumentRangesFormattingEdits(document: [TextDocument](#TextDocument), ranges: [Range](#Range)\[\], options: [FormattingOptions](#FormattingOptions), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[TextEdit](#TextEdit)\[\]>

Provide formatting edits for multiple ranges in a document.

This function is optional but allows a formatter to perform faster when formatting only modified ranges or when formatting a large number of selections.

The given ranges are hints and providers can decide to format a smaller or larger range. Often this is done by adjusting the start and end of the range to full syntax nodes.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| ranges: [Range](#Range)\[\] | The ranges which should be formatted. |
| options: [FormattingOptions](#FormattingOptions) | Options controlling formatting. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[TextEdit](#TextEdit)\[\]> | A set of text edits or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

### DocumentRangeSemanticTokensProvider

The document range semantic tokens provider interface defines the contract between extensions and semantic tokens.

#### Events

onDidChangeSemanticTokens?: [Event](#Event&lt;T&gt;)<void\>

An optional event to signal that the semantic tokens from this provider have changed.

#### Methods

provideDocumentRangeSemanticTokens(document: [TextDocument](#TextDocument), range: [Range](#Range), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[SemanticTokens](#SemanticTokens)\>

_See also_ [provideDocumentSemanticTokens](#DocumentSemanticTokensProvider.provideDocumentSemanticTokens).

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) |     |
| range: [Range](#Range) |     |
| token: [CancellationToken](#CancellationToken) |     |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[SemanticTokens](#SemanticTokens)\> |     |

### DocumentSelector

A language selector is the combination of one or many language identifiers and [language filters](#DocumentFilter).

_Note_ that a document selector that is just a language identifier selects _all_ documents, even those that are not saved on disk. Only use such selectors when a feature works without further context, e.g. without the need to resolve related 'files'.

**Example**

```
let sel: DocumentSelector = { scheme: 'file', language: 'typescript' };
```

DocumentSelector: [DocumentFilter](#DocumentFilter) | string | ReadonlyArray<[DocumentFilter](#DocumentFilter) | string\>

### DocumentSemanticTokensProvider

The document semantic tokens provider interface defines the contract between extensions and semantic tokens.

#### Events

onDidChangeSemanticTokens?: [Event](#Event&lt;T&gt;)<void\>

An optional event to signal that the semantic tokens from this provider have changed.

#### Methods

provideDocumentSemanticTokens(document: [TextDocument](#TextDocument), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[SemanticTokens](#SemanticTokens)\>

Tokens in a file are represented as an array of integers. The position of each token is expressed relative to the token before it, because most tokens remain stable relative to each other when edits are made in a file.

- - -

In short, each token takes 5 integers to represent, so a specific token `i` in the file consists of the following array indices:

*   at index `5*i` - `deltaLine`: token line number, relative to the previous token
*   at index `5*i+1` - `deltaStart`: token start character, relative to the previous token (relative to 0 or the previous token's start if they are on the same line)
*   at index `5*i+2` - `length`: the length of the token. A token cannot be multiline.
*   at index `5*i+3` - `tokenType`: will be looked up in `SemanticTokensLegend.tokenTypes`. We currently ask that `tokenType` < 65536.
*   at index `5*i+4` - `tokenModifiers`: each set bit will be looked up in `SemanticTokensLegend.tokenModifiers`

- - -

### How to encode tokens

Here is an example for encoding a file with 3 tokens in a uint32 array:

```
   { line: 2, startChar:  5, length: 3, tokenType: "property",  tokenModifiers: ["private", "static"] },
   { line: 2, startChar: 10, length: 4, tokenType: "type",      tokenModifiers: [] },
   { line: 5, startChar:  2, length: 7, tokenType: "class",     tokenModifiers: [] }
```

1.  First of all, a legend must be devised. This legend must be provided up-front and capture all possible token types. For this example, we will choose the following legend which must be passed in when registering the provider:

```
   tokenTypes: ['property', 'type', 'class'],
   tokenModifiers: ['private', 'static']
```

2.  The first transformation step is to encode `tokenType` and `tokenModifiers` as integers using the legend. Token types are looked up by index, so a `tokenType` value of `1` means `tokenTypes[1]`. Multiple token modifiers can be set by using bit flags, so a `tokenModifier` value of `3` is first viewed as binary `0b00000011`, which means `[tokenModifiers[0], tokenModifiers[1]]` because bits 0 and 1 are set. Using this legend, the tokens now are:

```
   { line: 2, startChar:  5, length: 3, tokenType: 0, tokenModifiers: 3 },
   { line: 2, startChar: 10, length: 4, tokenType: 1, tokenModifiers: 0 },
   { line: 5, startChar:  2, length: 7, tokenType: 2, tokenModifiers: 0 }
```

3.  The next step is to represent each token relative to the previous token in the file. In this case, the second token is on the same line as the first token, so the `startChar` of the second token is made relative to the `startChar` of the first token, so it will be `10 - 5`. The third token is on a different line than the second token, so the `startChar` of the third token will not be altered:

```
   { deltaLine: 2, deltaStartChar: 5, length: 3, tokenType: 0, tokenModifiers: 3 },
   { deltaLine: 0, deltaStartChar: 5, length: 4, tokenType: 1, tokenModifiers: 0 },
   { deltaLine: 3, deltaStartChar: 2, length: 7, tokenType: 2, tokenModifiers: 0 }
```

4.  Finally, the last step is to inline each of the 5 fields for a token in a single array, which is a memory friendly representation:

```
   // 1st token,  2nd token,  3rd token
   [  2,5,3,0,3,  0,5,4,1,0,  3,2,7,2,0 ]
```

_See also_ [SemanticTokensBuilder](#SemanticTokensBuilder) for a helper to encode tokens as integers. _NOTE_: When doing edits, it is possible that multiple edits occur until the editor decides to invoke the semantic tokens provider. _NOTE_: If the provider cannot temporarily compute semantic tokens, it can indicate this by throwing an error with the message 'Busy'.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) |     |
| token: [CancellationToken](#CancellationToken) |     |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[SemanticTokens](#SemanticTokens)\> |     |

provideDocumentSemanticTokensEdits(document: [TextDocument](#TextDocument), previousResultId: string, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[SemanticTokens](#SemanticTokens) | [SemanticTokensEdits](#SemanticTokensEdits)\>

Instead of always returning all the tokens in a file, it is possible for a `DocumentSemanticTokensProvider` to implement this method (`provideDocumentSemanticTokensEdits`) and then return incremental updates to the previously provided semantic tokens.

- - -

### How tokens change when the document changes

Suppose that `provideDocumentSemanticTokens` has previously returned the following semantic tokens:

```
   // 1st token,  2nd token,  3rd token
   [  2,5,3,0,3,  0,5,4,1,0,  3,2,7,2,0 ]
```

Also suppose that after some edits, the new semantic tokens in a file are:

```
   // 1st token,  2nd token,  3rd token
   [  3,5,3,0,3,  0,5,4,1,0,  3,2,7,2,0 ]
```

It is possible to express these new tokens in terms of an edit applied to the previous tokens:

```
   [  2,5,3,0,3,  0,5,4,1,0,  3,2,7,2,0 ] // old tokens
   [  3,5,3,0,3,  0,5,4,1,0,  3,2,7,2,0 ] // new tokens

   edit: { start:  0, deleteCount: 1, data: [3] } // replace integer at offset 0 with 3
```

_NOTE_: If the provider cannot compute `SemanticTokensEdits`, it can "give up" and return all the tokens in the document again. _NOTE_: All edits in `SemanticTokensEdits` contain indices in the old integers array, so they all refer to the previous result state.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) |     |
| previousResultId: string |     |
| token: [CancellationToken](#CancellationToken) |     |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[SemanticTokens](#SemanticTokens) \| [SemanticTokensEdits](#SemanticTokensEdits)\> |     |

### DocumentSymbol

Represents programming constructs like variables, classes, interfaces etc. that appear in a document. Document symbols can be hierarchical and they have two ranges: one that encloses its definition and one that points to its most interesting range, e.g. the range of an identifier.

#### Constructors

new DocumentSymbol(name: string, detail: string, kind: [SymbolKind](#SymbolKind), range: [Range](#Range), selectionRange: [Range](#Range)): [DocumentSymbol](#DocumentSymbol)

Creates a new document symbol.

| Parameter | Description |
| --- | --- |
| name: string | The name of the symbol. |
| detail: string | Details for the symbol. |
| kind: [SymbolKind](#SymbolKind) | The kind of the symbol. |
| range: [Range](#Range) | The full range of the symbol. |
| selectionRange: [Range](#Range) | The range that should be reveal. |
| Returns | Description |
| [DocumentSymbol](#DocumentSymbol) |     |

#### Properties

children: [DocumentSymbol](#DocumentSymbol)\[\]

Children of this symbol, e.g. properties of a class.

detail: string

More detail for this symbol, e.g. the signature of a function.

kind: [SymbolKind](#SymbolKind)

The kind of this symbol.

name: string

The name of this symbol.

range: [Range](#Range)

The range enclosing this symbol not including leading/trailing whitespace but everything else, e.g. comments and code.

selectionRange: [Range](#Range)

The range that should be selected and reveal when this symbol is being picked, e.g. the name of a function. Must be contained by the [range](#DocumentSymbol.range).

tags?: readonly [SymbolTag](#SymbolTag)\[\]

Tags for this symbol.

### DocumentSymbolProvider

The document symbol provider interface defines the contract between extensions and the [go to symbol](https://code.visualstudio.com/docs/editor/editingevolved#_go-to-symbol)\-feature.

#### Methods

provideDocumentSymbols(document: [TextDocument](#TextDocument), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[DocumentSymbol](#DocumentSymbol)\[\] | [SymbolInformation](#SymbolInformation)\[\]>

Provide symbol information for the given document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[DocumentSymbol](#DocumentSymbol)\[\] \| [SymbolInformation](#SymbolInformation)\[\]> | An array of document highlights or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

### DocumentSymbolProviderMetadata

Metadata about a document symbol provider.

#### Properties

label?: string

A human-readable string that is shown when multiple outlines trees show for one document.

### EndOfLine

Represents an end of line character sequence in a [document](#TextDocument).

#### Enumeration Members

LF: 1

The line feed `\n` character.

CRLF: 2

The carriage return line feed `\r\n` sequence.

### EnterAction

Describes what to do when pressing Enter.

#### Properties

appendText?: string

Describes text to be appended after the new line and after the indentation.

indentAction: [IndentAction](#IndentAction)

Describe what to do with the indentation.

removeText?: number

Describes the number of characters to remove from the new line's indentation.

### EnvironmentVariableCollection

A collection of mutations that an extension can apply to a process environment.

#### Properties

description: string | [MarkdownString](#MarkdownString)

A description for the environment variable collection, this will be used to describe the changes in the UI.

persistent: boolean

Whether the collection should be cached for the workspace and applied to the terminal across window reloads. When true the collection will be active immediately such when the window reloads. Additionally, this API will return the cached version if it exists. The collection will be invalidated when the extension is uninstalled or when the collection is cleared. Defaults to true.

#### Methods

append(variable: string, value: string, options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions)): void

Append a value to an environment variable.

Note that an extension can only make a single change to any one variable, so this will overwrite any previous calls to replace, append or prepend.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to append to. |
| value: string | The value to append to the variable. |
| options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions) | Options applied to the mutator, when no options are provided this will default to `{ applyAtProcessCreation: true }`. |
| Returns | Description |
| void |     |

clear(): void

Clears all mutators from this collection.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

delete(variable: string): void

Deletes this collection's mutator for a variable.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to delete the mutator for. |
| Returns | Description |
| void |     |

forEach(callback: (variable: string, mutator: [EnvironmentVariableMutator](#EnvironmentVariableMutator), collection: [EnvironmentVariableCollection](#EnvironmentVariableCollection)) => any, thisArg?: any): void

Iterate over each mutator in this collection.

| Parameter | Description |
| --- | --- |
| callback: (variable: string, mutator: [EnvironmentVariableMutator](#EnvironmentVariableMutator), collection: [EnvironmentVariableCollection](#EnvironmentVariableCollection)) => any | Function to execute for each entry. |
| thisArg?: any | The `this` context used when invoking the handler function. |
| Returns | Description |
| void |     |

get(variable: string): [EnvironmentVariableMutator](#EnvironmentVariableMutator)

Gets the mutator that this collection applies to a variable, if any.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to get the mutator for. |
| Returns | Description |
| [EnvironmentVariableMutator](#EnvironmentVariableMutator) |     |

prepend(variable: string, value: string, options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions)): void

Prepend a value to an environment variable.

Note that an extension can only make a single change to any one variable, so this will overwrite any previous calls to replace, append or prepend.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to prepend. |
| value: string | The value to prepend to the variable. |
| options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions) | Options applied to the mutator, when no options are provided this will default to `{ applyAtProcessCreation: true }`. |
| Returns | Description |
| void |     |

replace(variable: string, value: string, options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions)): void

Replace an environment variable with a value.

Note that an extension can only make a single change to any one variable, so this will overwrite any previous calls to replace, append or prepend.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to replace. |
| value: string | The value to replace the variable with. |
| options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions) | Options applied to the mutator, when no options are provided this will default to `{ applyAtProcessCreation: true }`. |
| Returns | Description |
| void |     |

### EnvironmentVariableMutator

A type of mutation and its value to be applied to an environment variable.

#### Properties

options: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions)

Options applied to the mutator.

type: [EnvironmentVariableMutatorType](#EnvironmentVariableMutatorType)

The type of mutation that will occur to the variable.

value: string

The value to use for the variable.

### EnvironmentVariableMutatorOptions

Options applied to the mutator.

#### Properties

applyAtProcessCreation?: boolean

Apply to the environment just before the process is created. Defaults to false.

applyAtShellIntegration?: boolean

Apply to the environment in the shell integration script. Note that this _will not_ apply the mutator if shell integration is disabled or not working for some reason. Defaults to false.

### EnvironmentVariableMutatorType

A type of mutation that can be applied to an environment variable.

#### Enumeration Members

Replace: 1

Replace the variable's existing value.

Append: 2

Append to the end of the variable's existing value.

Prepend: 3

Prepend to the start of the variable's existing value.

### EnvironmentVariableScope

The scope object to which the environment variable collection applies.

#### Properties

workspaceFolder?: [WorkspaceFolder](#WorkspaceFolder)

Any specific workspace folder to get collection for.

### EvaluatableExpression

An EvaluatableExpression represents an expression in a document that can be evaluated by an active debugger or runtime. The result of this evaluation is shown in a tooltip-like widget. If only a range is specified, the expression will be extracted from the underlying document. An optional expression can be used to override the extracted expression. In this case the range is still used to highlight the range in the document.

#### Constructors

new EvaluatableExpression(range: [Range](#Range), expression?: string): [EvaluatableExpression](#EvaluatableExpression)

Creates a new evaluatable expression object.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The range in the underlying document from which the evaluatable expression is extracted. |
| expression?: string | If specified overrides the extracted expression. |
| Returns | Description |
| [EvaluatableExpression](#EvaluatableExpression) |     |

#### Properties

expression?: string

If specified the expression overrides the extracted expression.

range: [Range](#Range)

The range is used to extract the evaluatable expression from the underlying document and to highlight it.

### EvaluatableExpressionProvider

The evaluatable expression provider interface defines the contract between extensions and the debug hover. In this contract the provider returns an evaluatable expression for a given position in a document and the editor evaluates this expression in the active debug session and shows the result in a debug hover.

#### Methods

provideEvaluatableExpression(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[EvaluatableExpression](#EvaluatableExpression)\>

Provide an evaluatable expression for the given document and position. The editor will evaluate this expression in the active debug session and will show the result in the debug hover. The expression can be implicitly specified by the range in the underlying document or by explicitly returning an expression.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document for which the debug hover is about to appear. |
| position: [Position](#Position) | The line and character position in the document where the debug hover is about to appear. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[EvaluatableExpression](#EvaluatableExpression)\> | An EvaluatableExpression or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### Event<T>

Represents a typed event.

A function that represents an event to which you subscribe by calling it with a listener function as argument.

**Example**

```
item.onDidChange(function(event) {
  console.log('Event happened: ' + event);
});
```

(listener: (e: T) => any, thisArgs?: any, disposables?: [Disposable](#Disposable)\[\]): [Disposable](#Disposable)

A function that represents an event to which you subscribe by calling it with a listener function as argument.

| Parameter | Description |
| --- | --- |
| listener: (e: T) => any | The listener function will be called when the event happens. |
| thisArgs?: any | The `this`\-argument which will be used when calling the event listener. |
| disposables?: [Disposable](#Disposable)\[\] | An array to which a [Disposable](#Disposable) will be added. |
| Returns | Description |
| [Disposable](#Disposable) | A disposable which unsubscribes the event listener. |

### EventEmitter<T>

An event emitter can be used to create and manage an [Event](#Event) for others to subscribe to. One emitter always owns one event.

Use this class if you want to provide event from within your extension, for instance inside a [TextDocumentContentProvider](#TextDocumentContentProvider) or when providing API to other extensions.

#### Constructors

new EventEmitter<T\>(): [EventEmitter](#EventEmitter&lt;T&gt;)<T\>

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [EventEmitter](#EventEmitter&lt;T&gt;)<T\> |     |

#### Properties

event: [Event](#Event&lt;T&gt;)<T\>

The event listeners can subscribe to.

#### Methods

dispose(): void

Dispose this object and free resources.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

fire(data: T): void

Notify all subscribers of the [event](#EventEmitter.event). Failure of one or more listener will not fail this function call.

| Parameter | Description |
| --- | --- |
| data: T | The event object. |
| Returns | Description |
| void |     |

### Extension<T>

Represents an extension.

To get an instance of an `Extension` use [getExtension](#extensions.getExtension).

#### Properties

exports: T

The public API exported by this extension (return value of `activate`). It is an invalid action to access this field before this extension has been activated.

extensionKind: [ExtensionKind](#ExtensionKind)

The extension kind describes if an extension runs where the UI runs or if an extension runs where the remote extension host runs. The extension kind is defined in the `package.json`\-file of extensions but can also be refined via the `remote.extensionKind`\-setting. When no remote extension host exists, the value is [ExtensionKind.UI](#ExtensionKind.UI).

extensionPath: string

The absolute file path of the directory containing this extension. Shorthand notation for [Extension.extensionUri.fsPath](#Extension.extensionUri) (independent of the uri scheme).

extensionUri: [Uri](#Uri)

The uri of the directory containing the extension.

id: string

The canonical extension identifier in the form of: `publisher.name`.

isActive: boolean

`true` if the extension has been activated.

packageJSON: any

The parsed contents of the extension's package.json.

#### Methods

activate(): Thenable<T\>

Activates this extension and returns its public API.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Thenable<T\> | A promise that will resolve when this extension has been activated. |

### ExtensionContext

An extension context is a collection of utilities private to an extension.

An instance of an `ExtensionContext` is provided as the first parameter to the `activate`\-call of an extension.

#### Properties

environmentVariableCollection: [GlobalEnvironmentVariableCollection](#GlobalEnvironmentVariableCollection)

Gets the extension's global environment variable collection for this workspace, enabling changes to be applied to terminal environment variables.

extension: [Extension](#Extension&lt;T&gt;)<any\>

The current `Extension` instance.

extensionMode: [ExtensionMode](#ExtensionMode)

The mode the extension is running in. See [ExtensionMode](#ExtensionMode) for possible values and scenarios.

extensionPath: string

The absolute file path of the directory containing the extension. Shorthand notation for [ExtensionContext.extensionUri.fsPath](#TextDocument.uri) (independent of the uri scheme).

extensionUri: [Uri](#Uri)

The uri of the directory containing the extension.

globalState: [Memento](#Memento) & {setKeysForSync}

A memento object that stores state independent of the current opened [workspace](#workspace.workspaceFolders).

globalStoragePath: string

An absolute file path in which the extension can store global state. The directory might not exist on disk and creation is up to the extension. However, the parent directory is guaranteed to be existent.

Use [globalState](#ExtensionContext.globalState) to store key value data.

*   _deprecated_ - Use [globalStorageUri](#ExtensionContext.globalStorageUri) instead.

globalStorageUri: [Uri](#Uri)

The uri of a directory in which the extension can store global state. The directory might not exist on disk and creation is up to the extension. However, the parent directory is guaranteed to be existent.

Use [globalState](#ExtensionContext.globalState) to store key value data.

_See also_ [workspace.fs](#FileSystem) for how to read and write files and folders from an uri.

languageModelAccessInformation: [LanguageModelAccessInformation](#LanguageModelAccessInformation)

An object that keeps information about how this extension can use language models.

_See also_ [LanguageModelChat.sendRequest](#LanguageModelChat.sendRequest)

logPath: string

An absolute file path of a directory in which the extension can create log files. The directory might not exist on disk and creation is up to the extension. However, the parent directory is guaranteed to be existent.

*   _deprecated_ - Use [logUri](#ExtensionContext.logUri) instead.

logUri: [Uri](#Uri)

The uri of a directory in which the extension can create log files. The directory might not exist on disk and creation is up to the extension. However, the parent directory is guaranteed to be existent.

_See also_ [workspace.fs](#FileSystem) for how to read and write files and folders from an uri.

secrets: [SecretStorage](#SecretStorage)

A secret storage object that stores state independent of the current opened [workspace](#workspace.workspaceFolders).

storagePath: string

An absolute file path of a workspace specific directory in which the extension can store private state. The directory might not exist on disk and creation is up to the extension. However, the parent directory is guaranteed to be existent.

Use [workspaceState](#ExtensionContext.workspaceState) or [globalState](#ExtensionContext.globalState) to store key value data.

*   _deprecated_ - Use [storageUri](#ExtensionContext.storageUri) instead.

storageUri: [Uri](#Uri)

The uri of a workspace specific directory in which the extension can store private state. The directory might not exist and creation is up to the extension. However, the parent directory is guaranteed to be existent. The value is `undefined` when no workspace nor folder has been opened.

Use [workspaceState](#ExtensionContext.workspaceState) or [globalState](#ExtensionContext.globalState) to store key value data.

_See also_ [workspace.fs](#FileSystem) for how to read and write files and folders from a uri.

subscriptions: Array<{dispose}>

An array to which disposables can be added. When this extension is deactivated the disposables will be disposed.

_Note_ that asynchronous dispose-functions aren't awaited.

workspaceState: [Memento](#Memento)

A memento object that stores state in the context of the currently opened [workspace](#workspace.workspaceFolders).

#### Methods

asAbsolutePath(relativePath: string): string

Get the absolute path of a resource contained in the extension.

_Note_ that an absolute uri can be constructed via [Uri.joinPath](#Uri.joinPath) and [extensionUri](#ExtensionContext.extensionUri), e.g. `vscode.Uri.joinPath(context.extensionUri, relativePath);`

| Parameter | Description |
| --- | --- |
| relativePath: string | A relative path to a resource contained in the extension. |
| Returns | Description |
| string | The absolute path of the resource. |

### ExtensionKind

In a remote window the extension kind describes if an extension runs where the UI (window) runs or if an extension runs remotely.

#### Enumeration Members

UI: 1

Extension runs where the UI runs.

Workspace: 2

Extension runs where the remote extension host runs.

### ExtensionMode

The ExtensionMode is provided on the `ExtensionContext` and indicates the mode the specific extension is running in.

#### Enumeration Members

Production: 1

The extension is installed normally (for example, from the marketplace or VSIX) in the editor.

Development: 2

The extension is running from an `--extensionDevelopmentPath` provided when launching the editor.

Test: 3

The extension is running from an `--extensionTestsPath` and the extension host is running unit tests.

### ExtensionTerminalOptions

Value-object describing what options a virtual process terminal should use.

#### Properties

color?: [ThemeColor](#ThemeColor)

The icon [ThemeColor](#ThemeColor) for the terminal. The standard `terminal.ansi*` theme keys are recommended for the best contrast and consistency across themes.

iconPath?: [IconPath](#IconPath)

The icon path or [ThemeIcon](#ThemeIcon) for the terminal.

isTransient?: boolean

Opt-out of the default terminal persistence on restart and reload. This will only take effect when `terminal.integrated.enablePersistentSessions` is enabled.

location?: [TerminalEditorLocationOptions](#TerminalEditorLocationOptions) | [TerminalSplitLocationOptions](#TerminalSplitLocationOptions) | [TerminalLocation](#TerminalLocation)

The [TerminalLocation](#TerminalLocation) or [TerminalEditorLocationOptions](#TerminalEditorLocationOptions) or [TerminalSplitLocationOptions](#TerminalSplitLocationOptions) for the terminal.

name: string

A human-readable string which will be used to represent the terminal in the UI.

pty: [Pseudoterminal](#Pseudoterminal)

An implementation of [Pseudoterminal](#Pseudoterminal) that allows an extension to control a terminal.

shellIntegrationNonce?: string

The nonce to use to verify shell integration sequences are coming from a trusted source. An example impact of UX of this is if the command line is reported with a nonce, it will not need to verify with the user that the command line is correct before rerunning it via the [shell integration command decoration](https://code.visualstudio.com/docs/terminal/shell-integration#_command-decorations-and-the-overview-ruler).

This should be used if the terminal includes [custom shell integration support](https://code.visualstudio.com/docs/terminal/shell-integration#_supported-escape-sequences). It should be set to a random GUID. Inside the [Pseudoterminal](#Pseudoterminal) implementation, this value can be passed through in the relevant sequences to make them trusted.

### FileChangeEvent

The event filesystem providers must use to signal a file change.

#### Properties

type: [FileChangeType](#FileChangeType)

The type of change.

uri: [Uri](#Uri)

The uri of the file that has changed.

### FileChangeType

Enumeration of file change types.

#### Enumeration Members

Changed: 1

The contents or metadata of a file have changed.

Created: 2

A file has been created.

Deleted: 3

A file has been deleted.

### FileCoverage

Contains coverage metadata for a file.

#### Static

fromDetails(uri: [Uri](#Uri), details: readonly [FileCoverageDetail](#FileCoverageDetail)\[\]): [FileCoverage](#FileCoverage)

Creates a [FileCoverage](#FileCoverage) instance with counts filled in from the coverage details.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | Covered file URI |
| details: readonly [FileCoverageDetail](#FileCoverageDetail)\[\] | Detailed coverage information |
| Returns | Description |
| [FileCoverage](#FileCoverage) |     |

#### Constructors

new FileCoverage(uri: [Uri](#Uri), statementCoverage: [TestCoverageCount](#TestCoverageCount), branchCoverage?: [TestCoverageCount](#TestCoverageCount), declarationCoverage?: [TestCoverageCount](#TestCoverageCount), includesTests?: [TestItem](#TestItem)\[\]): [FileCoverage](#FileCoverage)

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | Covered file URI |
| statementCoverage: [TestCoverageCount](#TestCoverageCount) | Statement coverage information. If the reporter does not provide statement coverage information, this can instead be used to represent line coverage. |
| branchCoverage?: [TestCoverageCount](#TestCoverageCount) | Branch coverage information |
| declarationCoverage?: [TestCoverageCount](#TestCoverageCount) | Declaration coverage information |
| includesTests?: [TestItem](#TestItem)\[\] | Test cases included in this coverage report, see [FileCoverage.includesTests](#FileCoverage.includesTests) |
| Returns | Description |
| [FileCoverage](#FileCoverage) |     |

#### Properties

branchCoverage?: [TestCoverageCount](#TestCoverageCount)

Branch coverage information.

declarationCoverage?: [TestCoverageCount](#TestCoverageCount)

Declaration coverage information. Depending on the reporter and language, this may be types such as functions, methods, or namespaces.

includesTests?: [TestItem](#TestItem)\[\]

A list of [test cases](#TestItem) that generated coverage in this file. If set, then [TestRunProfile.loadDetailedCoverageForTest](#TestRunProfile.loadDetailedCoverageForTest) should also be defined in order to retrieve detailed coverage information.

statementCoverage: [TestCoverageCount](#TestCoverageCount)

Statement coverage information. If the reporter does not provide statement coverage information, this can instead be used to represent line coverage.

uri: [Uri](#Uri)

File URI.

### FileCoverageDetail

Coverage details returned from [TestRunProfile.loadDetailedCoverage](#TestRunProfile.loadDetailedCoverage).

FileCoverageDetail: [StatementCoverage](#StatementCoverage) | [DeclarationCoverage](#DeclarationCoverage)

### FileCreateEvent

An event that is fired after files are created.

#### Properties

files: readonly [Uri](#Uri)\[\]

The files that got created.

### FileDecoration

A file decoration represents metadata that can be rendered with a file.

#### Constructors

new FileDecoration(badge?: string, tooltip?: string, color?: [ThemeColor](#ThemeColor)): [FileDecoration](#FileDecoration)

Creates a new decoration.

| Parameter | Description |
| --- | --- |
| badge?: string | A letter that represents the decoration. |
| tooltip?: string | The tooltip of the decoration. |
| color?: [ThemeColor](#ThemeColor) | The color of the decoration. |
| Returns | Description |
| [FileDecoration](#FileDecoration) |     |

#### Properties

badge?: string

A very short string that represents this decoration.

color?: [ThemeColor](#ThemeColor)

The color of this decoration.

propagate?: boolean

A flag expressing that this decoration should be propagated to its parents.

tooltip?: string

A human-readable tooltip for this decoration.

### FileDecorationProvider

The decoration provider interfaces defines the contract between extensions and file decorations.

#### Events

onDidChangeFileDecorations?: [Event](#Event&lt;T&gt;)<[Uri](#Uri) | [Uri](#Uri)\[\]>

An optional event to signal that decorations for one or many files have changed.

_Note_ that this event should be used to propagate information about children.

_See also_ [EventEmitter](#EventEmitter)

#### Methods

provideFileDecoration(uri: [Uri](#Uri), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[FileDecoration](#FileDecoration)\>

Provide decorations for a given uri.

_Note_ that this function is only called when a file gets rendered in the UI. This means a decoration from a descendent that propagates upwards must be signaled to the editor via the [onDidChangeFileDecorations](#FileDecorationProvider.onDidChangeFileDecorations)\-event.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the file to provide a decoration for. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[FileDecoration](#FileDecoration)\> | A decoration or a thenable that resolves to such. |

### FileDeleteEvent

An event that is fired after files are deleted.

#### Properties

files: readonly [Uri](#Uri)\[\]

The files that got deleted.

### FilePermission

Permissions of a file.

#### Enumeration Members

Readonly: 1

The file is readonly.

_Note:_ All `FileStat` from a `FileSystemProvider` that is registered with the option `isReadonly: true` will be implicitly handled as if `FilePermission.Readonly` is set. As a consequence, it is not possible to have a readonly file system provider registered where some `FileStat` are not readonly.

### FileRenameEvent

An event that is fired after files are renamed.

#### Properties

files: ReadonlyArray<{newUri: [Uri](#Uri), oldUri: [Uri](#Uri)}>

The files that got renamed.

### FileStat

The `FileStat`\-type represents metadata about a file

#### Properties

ctime: number

The creation timestamp in milliseconds elapsed since January 1, 1970 00:00:00 UTC.

mtime: number

The modification timestamp in milliseconds elapsed since January 1, 1970 00:00:00 UTC.

_Note:_ If the file changed, it is important to provide an updated `mtime` that advanced from the previous value. Otherwise there may be optimizations in place that will not show the updated file contents in an editor for example.

permissions?: [FilePermission](#FilePermission)

The permissions of the file, e.g. whether the file is readonly.

_Note:_ This value might be a bitmask, e.g. `FilePermission.Readonly | FilePermission.Other`.

size: number

The size in bytes.

_Note:_ If the file changed, it is important to provide an updated `size`. Otherwise there may be optimizations in place that will not show the updated file contents in an editor for example.

type: [FileType](#FileType)

The type of the file, e.g. is a regular file, a directory, or symbolic link to a file.

_Note:_ This value might be a bitmask, e.g. `FileType.File | FileType.SymbolicLink`.

### FileSystem

The file system interface exposes the editor's built-in and contributed [file system providers](#FileSystemProvider). It allows extensions to work with files from the local disk as well as files from remote places, like the remote extension host or ftp-servers.

_Note_ that an instance of this interface is available as [workspace.fs](#workspace.fs).

#### Methods

copy(source: [Uri](#Uri), target: [Uri](#Uri), options?: {overwrite: boolean}): Thenable<void\>

Copy files or folders.

| Parameter | Description |
| --- | --- |
| source: [Uri](#Uri) | The existing file. |
| target: [Uri](#Uri) | The destination location. |
| options?: {overwrite: boolean} | Defines if existing files should be overwritten. |
| Returns | Description |
| Thenable<void\> |     |

createDirectory(uri: [Uri](#Uri)): Thenable<void\>

Create a new directory (Note, that new files are created via `write`\-calls).

_Note_ that missing directories are created automatically, e.g this call has `mkdirp` semantics.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the new folder. |
| Returns | Description |
| Thenable<void\> |     |

delete(uri: [Uri](#Uri), options?: {recursive: boolean, useTrash: boolean}): Thenable<void\>

Delete a file.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The resource that is to be deleted. |
| options?: {recursive: boolean, useTrash: boolean} | Defines if trash can should be used and if deletion of folders is recursive |
| Returns | Description |
| Thenable<void\> |     |

isWritableFileSystem(scheme: string): boolean

Check if a given file system supports writing files.

Keep in mind that just because a file system supports writing, that does not mean that writes will always succeed. There may be permissions issues or other errors that prevent writing a file.

| Parameter | Description |
| --- | --- |
| scheme: string | The scheme of the filesystem, for example `file` or `git`. |
| Returns | Description |
| boolean | `true` if the file system supports writing, `false` if it does not support writing (i.e. it is readonly), and `undefined` if the editor does not know about the filesystem. |

readDirectory(uri: [Uri](#Uri)): Thenable<Array<\[string, [FileType](#FileType)\]>>

Retrieve all entries of a [directory](#FileType.Directory).

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the folder. |
| Returns | Description |
| Thenable<Array<\[string, [FileType](#FileType)\]>> | An array of name/type-tuples or a thenable that resolves to such. |

readFile(uri: [Uri](#Uri)): Thenable<Uint8Array\>

Read the entire contents of a file.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the file. |
| Returns | Description |
| Thenable<Uint8Array\> | An array of bytes or a thenable that resolves to such. |

rename(source: [Uri](#Uri), target: [Uri](#Uri), options?: {overwrite: boolean}): Thenable<void\>

Rename a file or folder.

| Parameter | Description |
| --- | --- |
| source: [Uri](#Uri) | The existing file. |
| target: [Uri](#Uri) | The new location. |
| options?: {overwrite: boolean} | Defines if existing files should be overwritten. |
| Returns | Description |
| Thenable<void\> |     |

stat(uri: [Uri](#Uri)): Thenable<[FileStat](#FileStat)\>

Retrieve metadata about a file.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the file to retrieve metadata about. |
| Returns | Description |
| Thenable<[FileStat](#FileStat)\> | The file metadata about the file. |

writeFile(uri: [Uri](#Uri), content: Uint8Array): Thenable<void\>

Write data to a file, replacing its entire contents.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the file. |
| content: Uint8Array | The new content of the file. |
| Returns | Description |
| Thenable<void\> |     |

### FileSystemError

A type that filesystem providers should use to signal errors.

This class has factory methods for common error-cases, like `FileNotFound` when a file or folder doesn't exist, use them like so: `throw vscode.FileSystemError.FileNotFound(someUri);`

#### Static

FileExists(messageOrUri?: string | [Uri](#Uri)): [FileSystemError](#FileSystemError)

Create an error to signal that a file or folder already exists, e.g. when creating but not overwriting a file.

| Parameter | Description |
| --- | --- |
| messageOrUri?: string \| [Uri](#Uri) | Message or uri. |
| Returns | Description |
| [FileSystemError](#FileSystemError) |     |

FileIsADirectory(messageOrUri?: string | [Uri](#Uri)): [FileSystemError](#FileSystemError)

Create an error to signal that a file is a folder.

| Parameter | Description |
| --- | --- |
| messageOrUri?: string \| [Uri](#Uri) | Message or uri. |
| Returns | Description |
| [FileSystemError](#FileSystemError) |     |

FileNotADirectory(messageOrUri?: string | [Uri](#Uri)): [FileSystemError](#FileSystemError)

Create an error to signal that a file is not a folder.

| Parameter | Description |
| --- | --- |
| messageOrUri?: string \| [Uri](#Uri) | Message or uri. |
| Returns | Description |
| [FileSystemError](#FileSystemError) |     |

FileNotFound(messageOrUri?: string | [Uri](#Uri)): [FileSystemError](#FileSystemError)

Create an error to signal that a file or folder wasn't found.

| Parameter | Description |
| --- | --- |
| messageOrUri?: string \| [Uri](#Uri) | Message or uri. |
| Returns | Description |
| [FileSystemError](#FileSystemError) |     |

NoPermissions(messageOrUri?: string | [Uri](#Uri)): [FileSystemError](#FileSystemError)

Create an error to signal that an operation lacks required permissions.

| Parameter | Description |
| --- | --- |
| messageOrUri?: string \| [Uri](#Uri) | Message or uri. |
| Returns | Description |
| [FileSystemError](#FileSystemError) |     |

Unavailable(messageOrUri?: string | [Uri](#Uri)): [FileSystemError](#FileSystemError)

Create an error to signal that the file system is unavailable or too busy to complete a request.

| Parameter | Description |
| --- | --- |
| messageOrUri?: string \| [Uri](#Uri) | Message or uri. |
| Returns | Description |
| [FileSystemError](#FileSystemError) |     |

#### Constructors

new FileSystemError(messageOrUri?: string | [Uri](#Uri)): [FileSystemError](#FileSystemError)

Creates a new filesystem error.

| Parameter | Description |
| --- | --- |
| messageOrUri?: string \| [Uri](#Uri) | Message or uri. |
| Returns | Description |
| [FileSystemError](#FileSystemError) |     |

#### Properties

code: string

A code that identifies this error.

Possible values are names of errors, like [FileNotFound](#FileSystemError.FileNotFound), or `Unknown` for unspecified errors.

### FileSystemProvider

The filesystem provider defines what the editor needs to read, write, discover, and to manage files and folders. It allows extensions to serve files from remote places, like ftp-servers, and to seamlessly integrate those into the editor.

*   _Note 1:_ The filesystem provider API works with [uris](#Uri) and assumes hierarchical paths, e.g. `foo:/my/path` is a child of `foo:/my/` and a parent of `foo:/my/path/deeper`.
*   _Note 2:_ There is an activation event `onFileSystem:<scheme>` that fires when a file or folder is being accessed.
*   _Note 3:_ The word 'file' is often used to denote all [kinds](#FileType) of files, e.g. folders, symbolic links, and regular files.

#### Events

onDidChangeFile: [Event](#Event&lt;T&gt;)<[FileChangeEvent](#FileChangeEvent)\[\]>

An event to signal that a resource has been created, changed, or deleted. This event should fire for resources that are being [watched](#FileSystemProvider.watch) by clients of this provider.

_Note:_ It is important that the metadata of the file that changed provides an updated `mtime` that advanced from the previous value in the [stat](#FileStat) and a correct `size` value. Otherwise there may be optimizations in place that will not show the change in an editor for example.

#### Methods

copy(source: [Uri](#Uri), destination: [Uri](#Uri), options: {overwrite: boolean}): void | Thenable<void\>

Copy files or folders. Implementing this function is optional but it will speedup the copy operation.

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when `source` doesn't exist.

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when parent of `destination` doesn't exist, e.g. no mkdirp-logic required.

*   _throws_ - [FileExists](#FileSystemError.FileExists) when `destination` exists and when the `overwrite` option is not `true`.

*   _throws_ - [NoPermissions](#FileSystemError.NoPermissions) when permissions aren't sufficient.

| Parameter | Description |
| --- | --- |
| source: [Uri](#Uri) | The existing file. |
| destination: [Uri](#Uri) | The destination location. |
| options: {overwrite: boolean} | Defines if existing files should be overwritten. |
| Returns | Description |
| void \| Thenable<void\> |     |

createDirectory(uri: [Uri](#Uri)): void | Thenable<void\>

Create a new directory (Note, that new files are created via `write`\-calls).

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when the parent of `uri` doesn't exist, e.g. no mkdirp-logic required.

*   _throws_ - [FileExists](#FileSystemError.FileExists) when `uri` already exists.

*   _throws_ - [NoPermissions](#FileSystemError.NoPermissions) when permissions aren't sufficient.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the new folder. |
| Returns | Description |
| void \| Thenable<void\> |     |

delete(uri: [Uri](#Uri), options: {recursive: boolean}): void | Thenable<void\>

Delete a file.

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when `uri` doesn't exist.

*   _throws_ - [NoPermissions](#FileSystemError.NoPermissions) when permissions aren't sufficient.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The resource that is to be deleted. |
| options: {recursive: boolean} | Defines if deletion of folders is recursive. |
| Returns | Description |
| void \| Thenable<void\> |     |

readDirectory(uri: [Uri](#Uri)): Array<\[string, [FileType](#FileType)\]> | Thenable<Array<\[string, [FileType](#FileType)\]>>

Retrieve all entries of a [directory](#FileType.Directory).

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when `uri` doesn't exist.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the folder. |
| Returns | Description |
| Array<\[string, [FileType](#FileType)\]> \| Thenable<Array<\[string, [FileType](#FileType)\]>> | An array of name/type-tuples or a thenable that resolves to such. |

readFile(uri: [Uri](#Uri)): Uint8Array | Thenable<Uint8Array\>

Read the entire contents of a file.

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when `uri` doesn't exist.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the file. |
| Returns | Description |
| Uint8Array \| Thenable<Uint8Array\> | An array of bytes or a thenable that resolves to such. |

rename(oldUri: [Uri](#Uri), newUri: [Uri](#Uri), options: {overwrite: boolean}): void | Thenable<void\>

Rename a file or folder.

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when `oldUri` doesn't exist.

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when parent of `newUri` doesn't exist, e.g. no mkdirp-logic required.

*   _throws_ - [FileExists](#FileSystemError.FileExists) when `newUri` exists and when the `overwrite` option is not `true`.

*   _throws_ - [NoPermissions](#FileSystemError.NoPermissions) when permissions aren't sufficient.

| Parameter | Description |
| --- | --- |
| oldUri: [Uri](#Uri) | The existing file. |
| newUri: [Uri](#Uri) | The new location. |
| options: {overwrite: boolean} | Defines if existing files should be overwritten. |
| Returns | Description |
| void \| Thenable<void\> |     |

stat(uri: [Uri](#Uri)): [FileStat](#FileStat) | Thenable<[FileStat](#FileStat)\>

Retrieve metadata about a file.

Note that the metadata for symbolic links should be the metadata of the file they refer to. Still, the [SymbolicLink](#FileType.SymbolicLink)\-type must be used in addition to the actual type, e.g. `FileType.SymbolicLink | FileType.Directory`.

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when `uri` doesn't exist.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the file to retrieve metadata about. |
| Returns | Description |
| [FileStat](#FileStat) \| Thenable<[FileStat](#FileStat)\> | The file metadata about the file. |

watch(uri: [Uri](#Uri), options: {excludes: readonly string\[\], recursive: boolean}): [Disposable](#Disposable)

Subscribes to file change events in the file or folder denoted by `uri`. For folders, the option `recursive` indicates whether subfolders, sub-subfolders, etc. should be watched for file changes as well. With `recursive: false`, only changes to the files that are direct children of the folder should trigger an event.

The `excludes` array is used to indicate paths that should be excluded from file watching. It is typically derived from the `files.watcherExclude` setting that is configurable by the user. Each entry can be be:

*   the absolute path to exclude
*   a relative path to exclude (for example `build/output`)
*   a simple glob pattern (for example `**/build`, `output/**`)

_Note_ that case-sensitivity of the [excludes](#excludes) patterns for built-in file system providers will depend on the underlying file system: on Windows and macOS the matching will be case-insensitive and on Linux it will be case-sensitive.

It is the file system provider's job to call [onDidChangeFile](#FileSystemProvider.onDidChangeFile) for every change given these rules. No event should be emitted for files that match any of the provided excludes.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the file or folder to be watched. |
| options: {excludes: readonly string\[\], recursive: boolean} | Configures the watch. |
| Returns | Description |
| [Disposable](#Disposable) | A disposable that tells the provider to stop watching the `uri`. |

writeFile(uri: [Uri](#Uri), content: Uint8Array, options: {create: boolean, overwrite: boolean}): void | Thenable<void\>

Write data to a file, replacing its entire contents.

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when `uri` doesn't exist and `create` is not set.

*   _throws_ - [FileNotFound](#FileSystemError.FileNotFound) when the parent of `uri` doesn't exist and `create` is set, e.g. no mkdirp-logic required.

*   _throws_ - [FileExists](#FileSystemError.FileExists) when `uri` already exists, `create` is set but `overwrite` is not set.

*   _throws_ - [NoPermissions](#FileSystemError.NoPermissions) when permissions aren't sufficient.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the file. |
| content: Uint8Array | The new content of the file. |
| options: {create: boolean, overwrite: boolean} | Defines if missing files should or must be created. |
| Returns | Description |
| void \| Thenable<void\> |     |

### FileSystemWatcher

A file system watcher notifies about changes to files and folders on disk or from other [FileSystemProviders](#FileSystemProvider).

To get an instance of a `FileSystemWatcher` use [createFileSystemWatcher](#workspace.createFileSystemWatcher).

#### Events

onDidChange: [Event](#Event&lt;T&gt;)<[Uri](#Uri)\>

An event which fires on file/folder change.

onDidCreate: [Event](#Event&lt;T&gt;)<[Uri](#Uri)\>

An event which fires on file/folder creation.

onDidDelete: [Event](#Event&lt;T&gt;)<[Uri](#Uri)\>

An event which fires on file/folder deletion.

#### Properties

ignoreChangeEvents: boolean

true if this file system watcher has been created such that it ignores change file system events.

ignoreCreateEvents: boolean

true if this file system watcher has been created such that it ignores creation file system events.

ignoreDeleteEvents: boolean

true if this file system watcher has been created such that it ignores delete file system events.

#### Methods

dispose(): any

Dispose this object.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| any |     |

### FileType

Enumeration of file types. The types `File` and `Directory` can also be a symbolic links, in that case use `FileType.File | FileType.SymbolicLink` and `FileType.Directory | FileType.SymbolicLink`.

#### Enumeration Members

Unknown: 0

The file type is unknown.

File: 1

A regular file.

Directory: 2

A directory.

SymbolicLink: 64

A symbolic link to a file.

### FileWillCreateEvent

An event that is fired when files are going to be created.

To make modifications to the workspace before the files are created, call the [waitUntil](#FileWillCreateEvent.waitUntil)\-function with a thenable that resolves to a [workspace edit](#WorkspaceEdit).

#### Properties

files: readonly [Uri](#Uri)\[\]

The files that are going to be created.

token: [CancellationToken](#CancellationToken)

A cancellation token.

#### Methods

waitUntil(thenable: Thenable<[WorkspaceEdit](#WorkspaceEdit)\>): void

Allows to pause the event and to apply a [workspace edit](#WorkspaceEdit).

_Note:_ This function can only be called during event dispatch and not in an asynchronous manner:

```
workspace.onWillCreateFiles(event => {
  // async, will *throw* an error
  setTimeout(() => event.waitUntil(promise));

  // sync, OK
  event.waitUntil(promise);
});
```

| Parameter | Description |
| --- | --- |
| thenable: Thenable<[WorkspaceEdit](#WorkspaceEdit)\> | A thenable that delays saving. |
| Returns | Description |
| void |     |

waitUntil(thenable: Thenable<any\>): void

Allows to pause the event until the provided thenable resolves.

_Note:_ This function can only be called during event dispatch.

| Parameter | Description |
| --- | --- |
| thenable: Thenable<any\> | A thenable that delays saving. |
| Returns | Description |
| void |     |

### FileWillDeleteEvent

An event that is fired when files are going to be deleted.

To make modifications to the workspace before the files are deleted, call the [`waitUntil`](#FileWillCreateEvent.waitUntil)\-function with a thenable that resolves to a [workspace edit](#WorkspaceEdit).

#### Properties

files: readonly [Uri](#Uri)\[\]

The files that are going to be deleted.

token: [CancellationToken](#CancellationToken)

A cancellation token.

#### Methods

waitUntil(thenable: Thenable<[WorkspaceEdit](#WorkspaceEdit)\>): void

Allows to pause the event and to apply a [workspace edit](#WorkspaceEdit).

_Note:_ This function can only be called during event dispatch and not in an asynchronous manner:

```
workspace.onWillCreateFiles(event => {
  // async, will *throw* an error
  setTimeout(() => event.waitUntil(promise));

  // sync, OK
  event.waitUntil(promise);
});
```

| Parameter | Description |
| --- | --- |
| thenable: Thenable<[WorkspaceEdit](#WorkspaceEdit)\> | A thenable that delays saving. |
| Returns | Description |
| void |     |

waitUntil(thenable: Thenable<any\>): void

Allows to pause the event until the provided thenable resolves.

_Note:_ This function can only be called during event dispatch.

| Parameter | Description |
| --- | --- |
| thenable: Thenable<any\> | A thenable that delays saving. |
| Returns | Description |
| void |     |

### FileWillRenameEvent

An event that is fired when files are going to be renamed.

To make modifications to the workspace before the files are renamed, call the [`waitUntil`](#FileWillCreateEvent.waitUntil)\-function with a thenable that resolves to a [workspace edit](#WorkspaceEdit).

#### Properties

files: ReadonlyArray<{newUri: [Uri](#Uri), oldUri: [Uri](#Uri)}>

The files that are going to be renamed.

token: [CancellationToken](#CancellationToken)

A cancellation token.

#### Methods

waitUntil(thenable: Thenable<[WorkspaceEdit](#WorkspaceEdit)\>): void

Allows to pause the event and to apply a [workspace edit](#WorkspaceEdit).

_Note:_ This function can only be called during event dispatch and not in an asynchronous manner:

```
workspace.onWillCreateFiles(event => {
  // async, will *throw* an error
  setTimeout(() => event.waitUntil(promise));

  // sync, OK
  event.waitUntil(promise);
});
```

| Parameter | Description |
| --- | --- |
| thenable: Thenable<[WorkspaceEdit](#WorkspaceEdit)\> | A thenable that delays saving. |
| Returns | Description |
| void |     |

waitUntil(thenable: Thenable<any\>): void

Allows to pause the event until the provided thenable resolves.

_Note:_ This function can only be called during event dispatch.

| Parameter | Description |
| --- | --- |
| thenable: Thenable<any\> | A thenable that delays saving. |
| Returns | Description |
| void |     |

### FoldingContext

Folding context (for future use)

### FoldingRange

A line based folding range. To be valid, start and end line must be bigger than zero and smaller than the number of lines in the document. Invalid ranges will be ignored.

#### Constructors

new FoldingRange(start: number, end: number, kind?: [FoldingRangeKind](#FoldingRangeKind)): [FoldingRange](#FoldingRange)

Creates a new folding range.

| Parameter | Description |
| --- | --- |
| start: number | The start line of the folded range. |
| end: number | The end line of the folded range. |
| kind?: [FoldingRangeKind](#FoldingRangeKind) | The kind of the folding range. |
| Returns | Description |
| [FoldingRange](#FoldingRange) |     |

#### Properties

end: number

The zero-based end line of the range to fold. The folded area ends with the line's last character. To be valid, the end must be zero or larger and smaller than the number of lines in the document.

kind?: [FoldingRangeKind](#FoldingRangeKind)

Describes the [Kind](#FoldingRangeKind) of the folding range such as [Comment](#FoldingRangeKind.Comment) or [Region](#FoldingRangeKind.Region). The kind is used to categorize folding ranges and used by commands like 'Fold all comments'. See [FoldingRangeKind](#FoldingRangeKind) for an enumeration of all kinds. If not set, the range is originated from a syntax element.

start: number

The zero-based start line of the range to fold. The folded area starts after the line's last character. To be valid, the end must be zero or larger and smaller than the number of lines in the document.

### FoldingRangeKind

An enumeration of specific folding range kinds. The kind is an optional field of a [FoldingRange](#FoldingRange) and is used to distinguish specific folding ranges such as ranges originated from comments. The kind is used by commands like `Fold all comments` or `Fold all regions`. If the kind is not set on the range, the range originated from a syntax element other than comments, imports or region markers.

#### Enumeration Members

Comment: 1

Kind for folding range representing a comment.

Imports: 2

Kind for folding range representing a import.

Region: 3

Kind for folding range representing regions originating from folding markers like `#region` and `#endregion`.

### FoldingRangeProvider

The folding range provider interface defines the contract between extensions and [Folding](https://code.visualstudio.com/docs/editor/codebasics#_folding) in the editor.

#### Events

onDidChangeFoldingRanges?: [Event](#Event&lt;T&gt;)<void\>

An optional event to signal that the folding ranges from this provider have changed.

#### Methods

provideFoldingRanges(document: [TextDocument](#TextDocument), context: [FoldingContext](#FoldingContext), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[FoldingRange](#FoldingRange)\[\]>

Returns a list of folding ranges or null and undefined if the provider does not want to participate or was cancelled.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| context: [FoldingContext](#FoldingContext) | Additional context information (for future use) |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[FoldingRange](#FoldingRange)\[\]> |     |

### FormattingOptions

Value-object describing what options formatting should use.

#### Properties

insertSpaces: boolean

Prefer spaces over tabs.

tabSize: number

Size of a tab in spaces.

### FunctionBreakpoint

A breakpoint specified by a function name.

#### Constructors

new FunctionBreakpoint(functionName: string, enabled?: boolean, condition?: string, hitCondition?: string, logMessage?: string): [FunctionBreakpoint](#FunctionBreakpoint)

Create a new function breakpoint.

| Parameter | Description |
| --- | --- |
| functionName: string |     |
| enabled?: boolean |     |
| condition?: string |     |
| hitCondition?: string |     |
| logMessage?: string |     |
| Returns | Description |
| [FunctionBreakpoint](#FunctionBreakpoint) |     |

#### Properties

condition?: string

An optional expression for conditional breakpoints.

enabled: boolean

Is breakpoint enabled.

functionName: string

The name of the function to which this breakpoint is attached.

hitCondition?: string

An optional expression that controls how many hits of the breakpoint are ignored.

id: string

The unique ID of the breakpoint.

logMessage?: string

An optional message that gets logged when this breakpoint is hit. Embedded expressions within {} are interpolated by the debug adapter.

### GlobalEnvironmentVariableCollection

A collection of mutations that an extension can apply to a process environment. Applies to all scopes.

#### Properties

description: string | [MarkdownString](#MarkdownString)

A description for the environment variable collection, this will be used to describe the changes in the UI.

persistent: boolean

Whether the collection should be cached for the workspace and applied to the terminal across window reloads. When true the collection will be active immediately such when the window reloads. Additionally, this API will return the cached version if it exists. The collection will be invalidated when the extension is uninstalled or when the collection is cleared. Defaults to true.

#### Methods

append(variable: string, value: string, options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions)): void

Append a value to an environment variable.

Note that an extension can only make a single change to any one variable, so this will overwrite any previous calls to replace, append or prepend.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to append to. |
| value: string | The value to append to the variable. |
| options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions) | Options applied to the mutator, when no options are provided this will default to `{ applyAtProcessCreation: true }`. |
| Returns | Description |
| void |     |

clear(): void

Clears all mutators from this collection.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

delete(variable: string): void

Deletes this collection's mutator for a variable.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to delete the mutator for. |
| Returns | Description |
| void |     |

forEach(callback: (variable: string, mutator: [EnvironmentVariableMutator](#EnvironmentVariableMutator), collection: [EnvironmentVariableCollection](#EnvironmentVariableCollection)) => any, thisArg?: any): void

Iterate over each mutator in this collection.

| Parameter | Description |
| --- | --- |
| callback: (variable: string, mutator: [EnvironmentVariableMutator](#EnvironmentVariableMutator), collection: [EnvironmentVariableCollection](#EnvironmentVariableCollection)) => any | Function to execute for each entry. |
| thisArg?: any | The `this` context used when invoking the handler function. |
| Returns | Description |
| void |     |

get(variable: string): [EnvironmentVariableMutator](#EnvironmentVariableMutator)

Gets the mutator that this collection applies to a variable, if any.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to get the mutator for. |
| Returns | Description |
| [EnvironmentVariableMutator](#EnvironmentVariableMutator) |     |

getScoped(scope: [EnvironmentVariableScope](#EnvironmentVariableScope)): [EnvironmentVariableCollection](#EnvironmentVariableCollection)

Gets scope-specific environment variable collection for the extension. This enables alterations to terminal environment variables solely within the designated scope, and is applied in addition to (and after) the global collection.

Each object obtained through this method is isolated and does not impact objects for other scopes, including the global collection.

| Parameter | Description |
| --- | --- |
| scope: [EnvironmentVariableScope](#EnvironmentVariableScope) | The scope to which the environment variable collection applies to.<br><br>If a scope parameter is omitted, collection applicable to all relevant scopes for that parameter is returned. For instance, if the 'workspaceFolder' parameter is not specified, the collection that applies across all workspace folders will be returned. |
| Returns | Description |
| [EnvironmentVariableCollection](#EnvironmentVariableCollection) | Environment variable collection for the passed in scope. |

prepend(variable: string, value: string, options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions)): void

Prepend a value to an environment variable.

Note that an extension can only make a single change to any one variable, so this will overwrite any previous calls to replace, append or prepend.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to prepend. |
| value: string | The value to prepend to the variable. |
| options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions) | Options applied to the mutator, when no options are provided this will default to `{ applyAtProcessCreation: true }`. |
| Returns | Description |
| void |     |

replace(variable: string, value: string, options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions)): void

Replace an environment variable with a value.

Note that an extension can only make a single change to any one variable, so this will overwrite any previous calls to replace, append or prepend.

| Parameter | Description |
| --- | --- |
| variable: string | The variable to replace. |
| value: string | The value to replace the variable with. |
| options?: [EnvironmentVariableMutatorOptions](#EnvironmentVariableMutatorOptions) | Options applied to the mutator, when no options are provided this will default to `{ applyAtProcessCreation: true }`. |
| Returns | Description |
| void |     |

### GlobPattern

A file glob pattern to match file paths against. This can either be a glob pattern string (like `**/*.{ts,js}` or `*.{ts,js}`) or a [relative pattern](#RelativePattern).

Glob patterns can have the following syntax:

*   `*` to match zero or more characters in a path segment
*   `?` to match on one character in a path segment
*   `**` to match any number of path segments, including none
*   `{}` to group conditions (e.g. `**/*.{ts,js}` matches all TypeScript and JavaScript files)
*   `[]` to declare a range of characters to match in a path segment (e.g., `example.[0-9]` to match on `example.0`, `example.1`, …)
*   `[!...]` to negate a range of characters to match in a path segment (e.g., `example.[!0-9]` to match on `example.a`, `example.b`, but not `example.0`)

Note: a backslash (\`\`) is not valid within a glob pattern. If you have an existing file path to match against, consider to use the [relative pattern](#RelativePattern) support that takes care of converting any backslash into slash. Otherwise, make sure to convert any backslash to slash when creating the glob pattern.

GlobPattern: string | [RelativePattern](#RelativePattern)

### Hover

A hover represents additional information for a symbol or word. Hovers are rendered in a tooltip-like widget.

#### Constructors

new Hover(contents: [MarkdownString](#MarkdownString) | [MarkedString](#MarkedString) | Array<[MarkdownString](#MarkdownString) | [MarkedString](#MarkedString)\>, range?: [Range](#Range)): [Hover](#Hover)

Creates a new hover object.

| Parameter | Description |
| --- | --- |
| contents: [MarkdownString](#MarkdownString) \| [MarkedString](#MarkedString) \| Array<[MarkdownString](#MarkdownString) \| [MarkedString](#MarkedString)\> | The contents of the hover. |
| range?: [Range](#Range) | The range to which the hover applies. |
| Returns | Description |
| [Hover](#Hover) |     |

#### Properties

contents: Array<[MarkdownString](#MarkdownString) | [MarkedString](#MarkedString)\>

The contents of this hover.

range?: [Range](#Range)

The range to which this hover applies. When missing, the editor will use the range at the current position or the current position itself.

### HoverProvider

The hover provider interface defines the contract between extensions and the [hover](https://code.visualstudio.com/docs/editor/intellisense)\-feature.

#### Methods

provideHover(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[Hover](#Hover)\>

Provide a hover for the given position and document. Multiple hovers at the same position will be merged by the editor. A hover can have a range which defaults to the word range at the position when omitted.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[Hover](#Hover)\> | A hover or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### IconPath

Represents an icon in the UI. This is either an uri, separate uris for the light- and dark-themes, or a [theme icon](#ThemeIcon).

IconPath: [Uri](#Uri) | {dark: [Uri](#Uri), light: [Uri](#Uri)} | [ThemeIcon](#ThemeIcon)

### ImplementationProvider

The implementation provider interface defines the contract between extensions and the go to implementation feature.

#### Methods

provideImplementation(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[Definition](#Definition) | [LocationLink](#LocationLink)\[\]>

Provide the implementations of the symbol at the given position and document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[Definition](#Definition) \| [LocationLink](#LocationLink)\[\]> | A definition or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### IndentAction

Describes what to do with the indentation when pressing Enter.

#### Enumeration Members

None: 0

Insert new line and copy the previous line's indentation.

Indent: 1

Insert new line and indent once (relative to the previous line's indentation).

IndentOutdent: 2

Insert two new lines:

*   the first one indented which will hold the cursor
*   the second one at the same indentation level

Outdent: 3

Insert new line and outdent once (relative to the previous line's indentation).

### IndentationRule

Describes indentation rules for a language.

#### Properties

decreaseIndentPattern: RegExp

If a line matches this pattern, then all the lines after it should be unindented once (until another rule matches).

increaseIndentPattern: RegExp

If a line matches this pattern, then all the lines after it should be indented once (until another rule matches).

indentNextLinePattern?: RegExp

If a line matches this pattern, then **only the next line** after it should be indented once.

unIndentedLinePattern?: RegExp

If a line matches this pattern, then its indentation should not be changed and it should not be evaluated against the other rules.

### InlayHint

Inlay hint information.

#### Constructors

new InlayHint(position: [Position](#Position), label: string | [InlayHintLabelPart](#InlayHintLabelPart)\[\], kind?: [InlayHintKind](#InlayHintKind)): [InlayHint](#InlayHint)

Creates a new inlay hint.

| Parameter | Description |
| --- | --- |
| position: [Position](#Position) | The position of the hint. |
| label: string \| [InlayHintLabelPart](#InlayHintLabelPart)\[\] | The label of the hint. |
| kind?: [InlayHintKind](#InlayHintKind) | The [kind](#InlayHintKind) of the hint. |
| Returns | Description |
| [InlayHint](#InlayHint) |     |

#### Properties

kind?: [InlayHintKind](#InlayHintKind)

The kind of this hint. The inlay hint kind defines the appearance of this inlay hint.

label: string | [InlayHintLabelPart](#InlayHintLabelPart)\[\]

The label of this hint. A human readable string or an array of [label parts](#InlayHintLabelPart).

_Note_ that neither the string nor the label part can be empty.

paddingLeft?: boolean

Render padding before the hint. Padding will use the editor's background color, not the background color of the hint itself. That means padding can be used to visually align/separate an inlay hint.

paddingRight?: boolean

Render padding after the hint. Padding will use the editor's background color, not the background color of the hint itself. That means padding can be used to visually align/separate an inlay hint.

position: [Position](#Position)

The position of this hint.

textEdits?: [TextEdit](#TextEdit)\[\]

Optional [text edits](#TextEdit) that are performed when accepting this inlay hint. The default gesture for accepting an inlay hint is the double click.

_Note_ that edits are expected to change the document so that the inlay hint (or its nearest variant) is now part of the document and the inlay hint itself is now obsolete.

_Note_ that this property can be set late during [resolving](#InlayHintsProvider.resolveInlayHint) of inlay hints.

tooltip?: string | [MarkdownString](#MarkdownString)

The tooltip text when you hover over this item.

_Note_ that this property can be set late during [resolving](#InlayHintsProvider.resolveInlayHint) of inlay hints.

### InlayHintKind

Inlay hint kinds.

The kind of an inline hint defines its appearance, e.g the corresponding foreground and background colors are being used.

#### Enumeration Members

Type: 1

An inlay hint that is for a type annotation.

Parameter: 2

An inlay hint that is for a parameter.

### InlayHintLabelPart

An inlay hint label part allows for interactive and composite labels of inlay hints.

#### Constructors

new InlayHintLabelPart(value: string): [InlayHintLabelPart](#InlayHintLabelPart)

Creates a new inlay hint label part.

| Parameter | Description |
| --- | --- |
| value: string | The value of the part. |
| Returns | Description |
| [InlayHintLabelPart](#InlayHintLabelPart) |     |

#### Properties

command?: [Command](#Command)

An optional command for this label part.

The editor renders parts with commands as clickable links. The command is added to the context menu when a label part defines [location](#InlayHintLabelPart.location) and [command](#InlayHintLabelPart.command) .

_Note_ that this property can be set late during [resolving](#InlayHintsProvider.resolveInlayHint) of inlay hints.

location?: [Location](#Location)

An optional [source code location](#Location) that represents this label part.

The editor will use this location for the hover and for code navigation features: This part will become a clickable link that resolves to the definition of the symbol at the given location (not necessarily the location itself), it shows the hover that shows at the given location, and it shows a context menu with further code navigation commands.

_Note_ that this property can be set late during [resolving](#InlayHintsProvider.resolveInlayHint) of inlay hints.

tooltip?: string | [MarkdownString](#MarkdownString)

The tooltip text when you hover over this label part.

_Note_ that this property can be set late during [resolving](#InlayHintsProvider.resolveInlayHint) of inlay hints.

value: string

The value of this label part.

### InlayHintsProvider<T>

The inlay hints provider interface defines the contract between extensions and the inlay hints feature.

#### Events

onDidChangeInlayHints?: [Event](#Event&lt;T&gt;)<void\>

An optional event to signal that inlay hints from this provider have changed.

#### Methods

provideInlayHints(document: [TextDocument](#TextDocument), range: [Range](#Range), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Provide inlay hints for the given range and document.

_Note_ that inlay hints that are not [contained](#Range.contains) by the given range are ignored.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| range: [Range](#Range) | The range for which inlay hints should be computed. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | An array of inlay hints or a thenable that resolves to such. |

resolveInlayHint(hint: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

Given an inlay hint fill in [tooltip](#InlayHint.tooltip), [text edits](#InlayHint.textEdits), or complete label [parts](#InlayHintLabelPart).

_Note_ that the editor will resolve an inlay hint at most once.

| Parameter | Description |
| --- | --- |
| hint: T | An inlay hint. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | The resolved inlay hint or a thenable that resolves to such. It is OK to return the given `item`. When no result is returned, the given `item` will be used. |

### InlineCompletionContext

Provides information about the context in which an inline completion was requested.

#### Properties

selectedCompletionInfo: [SelectedCompletionInfo](#SelectedCompletionInfo)

Provides information about the currently selected item in the autocomplete widget if it is visible.

If set, provided inline completions must extend the text of the selected item and use the same range, otherwise they are not shown as preview. As an example, if the document text is `console.` and the selected item is `.log` replacing the `.` in the document, the inline completion must also replace `.` and start with `.log`, for example `.log()`.

Inline completion providers are requested again whenever the selected item changes.

triggerKind: [InlineCompletionTriggerKind](#InlineCompletionTriggerKind)

Describes how the inline completion was triggered.

### InlineCompletionItem

An inline completion item represents a text snippet that is proposed inline to complete text that is being typed.

_See also_ [InlineCompletionItemProvider.provideInlineCompletionItems](#InlineCompletionItemProvider.provideInlineCompletionItems)

#### Constructors

new InlineCompletionItem(insertText: string | [SnippetString](#SnippetString), range?: [Range](#Range), command?: [Command](#Command)): [InlineCompletionItem](#InlineCompletionItem)

Creates a new inline completion item.

| Parameter | Description |
| --- | --- |
| insertText: string \| [SnippetString](#SnippetString) | The text to replace the range with. |
| range?: [Range](#Range) | The range to replace. If not set, the word at the requested position will be used. |
| command?: [Command](#Command) | An optional [Command](#Command) that is executed _after_ inserting this completion. |
| Returns | Description |
| [InlineCompletionItem](#InlineCompletionItem) |     |

#### Properties

command?: [Command](#Command)

An optional [Command](#Command) that is executed _after_ inserting this completion.

filterText?: string

A text that is used to decide if this inline completion should be shown. When `falsy` the [InlineCompletionItem.insertText](#InlineCompletionItem.insertText) is used.

An inline completion is shown if the text to replace is a prefix of the filter text.

insertText: string | [SnippetString](#SnippetString)

The text to replace the range with. Must be set. Is used both for the preview and the accept operation.

range?: [Range](#Range)

The range to replace. Must begin and end on the same line.

Prefer replacements over insertions to provide a better experience when the user deletes typed text.

### InlineCompletionItemProvider

The inline completion item provider interface defines the contract between extensions and the inline completion feature.

Providers are asked for completions either explicitly by a user gesture or implicitly when typing.

#### Methods

provideInlineCompletionItems(document: [TextDocument](#TextDocument), position: [Position](#Position), context: [InlineCompletionContext](#InlineCompletionContext), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[InlineCompletionList](#InlineCompletionList) | [InlineCompletionItem](#InlineCompletionItem)\[\]>

Provides inline completion items for the given position and document. If inline completions are enabled, this method will be called whenever the user stopped typing. It will also be called when the user explicitly triggers inline completions or explicitly asks for the next or previous inline completion. In that case, all available inline completions should be returned. `context.triggerKind` can be used to distinguish between these scenarios.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document inline completions are requested for. |
| position: [Position](#Position) | The position inline completions are requested for. |
| context: [InlineCompletionContext](#InlineCompletionContext) | A context object with additional information. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[InlineCompletionList](#InlineCompletionList) \| [InlineCompletionItem](#InlineCompletionItem)\[\]> | An array of completion items or a thenable that resolves to an array of completion items. |

### InlineCompletionList

Represents a collection of [inline completion items](#InlineCompletionItem) to be presented in the editor.

#### Constructors

new InlineCompletionList(items: [InlineCompletionItem](#InlineCompletionItem)\[\]): [InlineCompletionList](#InlineCompletionList)

Creates a new list of inline completion items.

| Parameter | Description |
| --- | --- |
| items: [InlineCompletionItem](#InlineCompletionItem)\[\] |     |
| Returns | Description |
| [InlineCompletionList](#InlineCompletionList) |     |

#### Properties

items: [InlineCompletionItem](#InlineCompletionItem)\[\]

The inline completion items.

### InlineCompletionTriggerKind

Describes how an [inline completion provider](#InlineCompletionItemProvider) was triggered.

#### Enumeration Members

Invoke: 0

Completion was triggered explicitly by a user gesture. Return multiple completion items to enable cycling through them.

Automatic: 1

Completion was triggered automatically while editing. It is sufficient to return a single completion item in this case.

### InlineValue

Inline value information can be provided by different means:

*   directly as a text value (class InlineValueText).
*   as a name to use for a variable lookup (class InlineValueVariableLookup)
*   as an evaluatable expression (class InlineValueEvaluatableExpression) The InlineValue types combines all inline value types into one type.

InlineValue: [InlineValueText](#InlineValueText) | [InlineValueVariableLookup](#InlineValueVariableLookup) | [InlineValueEvaluatableExpression](#InlineValueEvaluatableExpression)

### InlineValueContext

A value-object that contains contextual information when requesting inline values from a InlineValuesProvider.

#### Properties

frameId: number

The stack frame (as a DAP Id) where the execution has stopped.

stoppedLocation: [Range](#Range)

The document range where execution has stopped. Typically the end position of the range denotes the line where the inline values are shown.

### InlineValueEvaluatableExpression

Provide an inline value through an expression evaluation. If only a range is specified, the expression will be extracted from the underlying document. An optional expression can be used to override the extracted expression.

#### Constructors

new InlineValueEvaluatableExpression(range: [Range](#Range), expression?: string): [InlineValueEvaluatableExpression](#InlineValueEvaluatableExpression)

Creates a new InlineValueEvaluatableExpression object.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The range in the underlying document from which the evaluatable expression is extracted. |
| expression?: string | If specified overrides the extracted expression. |
| Returns | Description |
| [InlineValueEvaluatableExpression](#InlineValueEvaluatableExpression) |     |

#### Properties

expression?: string

If specified the expression overrides the extracted expression.

range: [Range](#Range)

The document range for which the inline value applies. The range is used to extract the evaluatable expression from the underlying document.

### InlineValuesProvider

The inline values provider interface defines the contract between extensions and the editor's debugger inline values feature. In this contract the provider returns inline value information for a given document range and the editor shows this information in the editor at the end of lines.

#### Events

onDidChangeInlineValues?: [Event](#Event&lt;T&gt;)<void\>

An optional event to signal that inline values have changed.

_See also_ [EventEmitter](#EventEmitter)

#### Methods

provideInlineValues(document: [TextDocument](#TextDocument), viewPort: [Range](#Range), context: [InlineValueContext](#InlineValueContext), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[InlineValue](#InlineValue)\[\]>

Provide "inline value" information for a given document and range. The editor calls this method whenever debugging stops in the given document. The returned inline values information is rendered in the editor at the end of lines.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document for which the inline values information is needed. |
| viewPort: [Range](#Range) | The visible document range for which inline values should be computed. |
| context: [InlineValueContext](#InlineValueContext) | A bag containing contextual information like the current location. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[InlineValue](#InlineValue)\[\]> | An array of InlineValueDescriptors or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### InlineValueText

Provide inline value as text.

#### Constructors

new InlineValueText(range: [Range](#Range), text: string): [InlineValueText](#InlineValueText)

Creates a new InlineValueText object.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The document line where to show the inline value. |
| text: string | The value to be shown for the line. |
| Returns | Description |
| [InlineValueText](#InlineValueText) |     |

#### Properties

range: [Range](#Range)

The document range for which the inline value applies.

text: string

The text of the inline value.

### InlineValueVariableLookup

Provide inline value through a variable lookup. If only a range is specified, the variable name will be extracted from the underlying document. An optional variable name can be used to override the extracted name.

#### Constructors

new InlineValueVariableLookup(range: [Range](#Range), variableName?: string, caseSensitiveLookup?: boolean): [InlineValueVariableLookup](#InlineValueVariableLookup)

Creates a new InlineValueVariableLookup object.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The document line where to show the inline value. |
| variableName?: string | The name of the variable to look up. |
| caseSensitiveLookup?: boolean | How to perform the lookup. If missing lookup is case sensitive. |
| Returns | Description |
| [InlineValueVariableLookup](#InlineValueVariableLookup) |     |

#### Properties

caseSensitiveLookup: boolean

How to perform the lookup.

range: [Range](#Range)

The document range for which the inline value applies. The range is used to extract the variable name from the underlying document.

variableName?: string

If specified the name of the variable to look up.

### InputBox

A concrete [QuickInput](#QuickInput) to let the user input a text value.

Note that in many cases the more convenient [window.showInputBox](#window.showInputBox) is easier to use. [window.createInputBox](#window.createInputBox) should be used when [window.showInputBox](#window.showInputBox) does not offer the required flexibility.

#### Events

onDidAccept: [Event](#Event&lt;T&gt;)<void\>

An event signaling when the user indicated acceptance of the input value.

onDidChangeValue: [Event](#Event&lt;T&gt;)<string\>

An event signaling when the value has changed.

onDidHide: [Event](#Event&lt;T&gt;)<void\>

An event signaling when this input UI is hidden.

There are several reasons why this UI might have to be hidden and the extension will be notified through [onDidHide](#QuickInput.onDidHide). Examples include: an explicit call to [hide](#QuickInput.hide), the user pressing Esc, some other input UI opening, etc.

onDidTriggerButton: [Event](#Event&lt;T&gt;)<[QuickInputButton](#QuickInputButton)\>

An event signaling when a button was triggered.

#### Properties

busy: boolean

Determines if the UI should show a progress indicator. Defaults to `false`.

Change this to `true`, for example, while loading more data or validating user input.

buttons: readonly [QuickInputButton](#QuickInputButton)\[\]

Buttons for actions in the UI.

enabled: boolean

Determines if the UI should allow for user input. Defaults to `true`.

Change this to `false`, for example, while validating user input or loading data for the next step in user input.

ignoreFocusOut: boolean

Determines if the UI should stay open even when losing UI focus. Defaults to `false`. This setting is ignored on iPad and is always `false`.

password: boolean

Determines if the input value should be hidden. Defaults to `false`.

placeholder: string

Optional placeholder text shown when no value has been input.

prompt: string

An optional prompt text providing some ask or explanation to the user.

step: number

An optional current step count for multi-step input flows.

title: string

An optional title for the input UI.

totalSteps: number

An optional total step count for multi-step input flows.

validationMessage: string | [InputBoxValidationMessage](#InputBoxValidationMessage)

An optional validation message indicating a problem with the current input value.

By setting a string, the InputBox will use a default [InputBoxValidationSeverity](#InputBoxValidationSeverity) of Error. Returning `undefined` clears the validation message.

value: string

The current input value.

valueSelection: readonly \[number, number\]

Selection range in the input value.

Defined as tuple of two numbers where the first is the inclusive start index and the second the exclusive end index. When `undefined` the whole pre-filled value will be selected, when empty (start equals end) only the cursor will be set, otherwise the defined range will be selected.

This property does not get updated when the user types or makes a selection, but it can be updated by the extension.

#### Methods

dispose(): void

Dispose of this input UI and any associated resources.

If it is still visible, it is first hidden. After this call the input UI is no longer functional and no additional methods or properties on it should be accessed. Instead a new input UI should be created.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

hide(): void

Hides this input UI.

This will also fire an [onDidHide](#QuickInput.onDidHide) event.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

show(): void

Makes the input UI visible in its current configuration.

Any other input UI will first fire an [onDidHide](#QuickInput.onDidHide) event.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### InputBoxOptions

Options to configure the behavior of the input box UI.

#### Properties

ignoreFocusOut?: boolean

Set to `true` to keep the input box open when focus moves to another part of the editor or to another window. This setting is ignored on iPad and is always false.

password?: boolean

Controls if a password input is shown. Password input hides the typed text.

placeHolder?: string

An optional string to show as placeholder in the input box to guide the user what to type.

prompt?: string

The text to display underneath the input box.

title?: string

An optional string that represents the title of the input box.

value?: string

The value to pre-fill in the input box.

valueSelection?: \[number, number\]

Selection of the pre-filled [value](#InputBoxOptions.value). Defined as tuple of two number where the first is the inclusive start index and the second the exclusive end index. When `undefined` the whole pre-filled value will be selected, when empty (start equals end) only the cursor will be set, otherwise the defined range will be selected.

#### Methods

validateInput(value: string): string | [InputBoxValidationMessage](#InputBoxValidationMessage) | Thenable<string | [InputBoxValidationMessage](#InputBoxValidationMessage)\>

An optional function that will be called to validate input and to give a hint to the user.

| Parameter | Description |
| --- | --- |
| value: string | The current value of the input box. |
| Returns | Description |
| string \| [InputBoxValidationMessage](#InputBoxValidationMessage) \| Thenable<string \| [InputBoxValidationMessage](#InputBoxValidationMessage)\> | Either a human-readable string which is presented as an error message or an [InputBoxValidationMessage](#InputBoxValidationMessage) which can provide a specific message severity. Return `undefined`, `null`, or the empty string when 'value' is valid. |

### InputBoxValidationMessage

Represents a validation message for an [InputBox](#InputBox).

#### Properties

message: string

The validation message to display to the user.

severity: [InputBoxValidationSeverity](#InputBoxValidationSeverity)

The severity level of the validation message.

**Note:** When using [InputBoxValidationSeverity.Error](#InputBoxValidationSeverity.Error), the user will not be able to accept the input (e.g., by pressing Enter). [Info](#InputBoxValidationSeverity.Info) and [Warning](#InputBoxValidationSeverity.Warning) severities will still allow the input to be accepted.

### InputBoxValidationSeverity

Severity levels for input box validation messages.

#### Enumeration Members

Info: 1

Indicates an informational message that does not prevent input acceptance.

Warning: 2

Indicates a warning message that does not prevent input acceptance.

Error: 3

Indicates an error message that prevents the user from accepting the input.

### LanguageConfiguration

The language configuration interfaces defines the contract between extensions and various editor features, like automatic bracket insertion, automatic indentation etc.

#### Properties

\_\_characterPairSupport?: {autoClosingPairs: Array<{close: string, notIn: string\[\], open: string}>}

**Deprecated** Do not use.

*   _deprecated_ - \* Use the autoClosingPairs property in the language configuration file instead.

| Parameter | Description |
| --- | --- |
| autoClosingPairs: Array<{close: string, notIn: string\[\], open: string}> | *   _deprecated_ |

\_\_electricCharacterSupport?: {brackets: any, docComment: {close: string, lineStart: string, open: string, scope: string}}

**Deprecated** Do not use.

*   _deprecated_ - Will be replaced by a better API soon.

| Parameter | Description |
| --- | --- |
| brackets: any | This property is deprecated and will be **ignored** from the editor.<br><br>*   _deprecated_ |
| docComment: {close: string, lineStart: string, open: string, scope: string} | This property is deprecated and not fully supported anymore by the editor (scope and lineStart are ignored). Use the autoClosingPairs property in the language configuration file instead.<br><br>*   _deprecated_ |

autoClosingPairs?: [AutoClosingPair](#AutoClosingPair)\[\]

The language's auto closing pairs.

brackets?: [CharacterPair](#CharacterPair)\[\]

The language's brackets. This configuration implicitly affects pressing Enter around these brackets.

comments?: [CommentRule](#CommentRule)

The language's comment settings.

indentationRules?: [IndentationRule](#IndentationRule)

The language's indentation settings.

onEnterRules?: [OnEnterRule](#OnEnterRule)\[\]

The language's rules to be evaluated when pressing Enter.

wordPattern?: RegExp

The language's word definition. If the language supports Unicode identifiers (e.g. JavaScript), it is preferable to provide a word definition that uses exclusion of known separators. e.g.: A regex that matches anything except known separators (and dot is allowed to occur in a floating point number):

```
/(-?\d*\.\d\w*)|([^\`\~\!\\#\%\^\&\*\(\)\-\=\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>/\?\s]+)/g
```

### LanguageModelAccessInformation

Represents extension specific information about the access to language models.

#### Events

onDidChange: [Event](#Event&lt;T&gt;)<void\>

An event that fires when access information changes.

#### Methods

canSendRequest(chat: [LanguageModelChat](#LanguageModelChat)): boolean

Checks if a request can be made to a language model.

_Note_ that calling this function will not trigger a consent UI but just checks for a persisted state.

| Parameter | Description |
| --- | --- |
| chat: [LanguageModelChat](#LanguageModelChat) | A language model chat object. |
| Returns | Description |
| boolean | `true` if a request can be made, `false` if not, `undefined` if the language model does not exist or consent hasn't been asked for. |

### LanguageModelChat

Represents a language model for making chat requests.

_See also_ [lm.selectChatModels](#lm.selectChatModels)

#### Properties

family: string

Opaque family-name of the language model. Values might be `gpt-3.5-turbo`, `gpt4`, `phi2`, or `llama` but they are defined by extensions contributing languages and subject to change.

id: string

Opaque identifier of the language model.

maxInputTokens: number

The maximum number of tokens that can be sent to the model in a single request.

name: string

Human-readable name of the language model.

vendor: string

A well-known identifier of the vendor of the language model. An example is `copilot`, but values are defined by extensions contributing chat models and need to be looked up with them.

version: string

Opaque version string of the model. This is defined by the extension contributing the language model and subject to change.

#### Methods

countTokens(text: string | [LanguageModelChatMessage](#LanguageModelChatMessage), token?: [CancellationToken](#CancellationToken)): Thenable<number\>

Count the number of tokens in a message using the model specific tokenizer-logic.

| Parameter | Description |
| --- | --- |
| text: string \| [LanguageModelChatMessage](#LanguageModelChatMessage) | A string or a message instance. |
| token?: [CancellationToken](#CancellationToken) | Optional cancellation token. See [CancellationTokenSource](#CancellationTokenSource) for how to create one. |
| Returns | Description |
| Thenable<number\> | A thenable that resolves to the number of tokens. |

sendRequest(messages: [LanguageModelChatMessage](#LanguageModelChatMessage)\[\], options?: [LanguageModelChatRequestOptions](#LanguageModelChatRequestOptions), token?: [CancellationToken](#CancellationToken)): Thenable<[LanguageModelChatResponse](#LanguageModelChatResponse)\>

Make a chat request using a language model.

_Note_ that language model use may be subject to access restrictions and user consent. Calling this function for the first time (for an extension) will show a consent dialog to the user and because of that this function must _only be called in response to a user action!_ Extensions can use [LanguageModelAccessInformation.canSendRequest](#LanguageModelAccessInformation.canSendRequest) to check if they have the necessary permissions to make a request.

This function will return a rejected promise if making a request to the language model is not possible. Reasons for this can be:

*   user consent not given, see [`NoPermissions`](#LanguageModelError.NoPermissions)
*   model does not exist anymore, see [`NotFound`](#LanguageModelError.NotFound)
*   quota limits exceeded, see [`Blocked`](#LanguageModelError.Blocked)
*   other issues in which case extension must check \[LanguageModelError.cause `LanguageModelError.cause`\](#\_LanguageModelError.cause `LanguageModelError.cause`)

An extension can make use of language model tool calling by passing a set of tools to [LanguageModelChatRequestOptions.tools](#LanguageModelChatRequestOptions.tools). The language model will return a [LanguageModelToolCallPart](#LanguageModelToolCallPart) and the extension can invoke the tool and make another request with the result.

| Parameter | Description |
| --- | --- |
| messages: [LanguageModelChatMessage](#LanguageModelChatMessage)\[\] | An array of message instances. |
| options?: [LanguageModelChatRequestOptions](#LanguageModelChatRequestOptions) | Options that control the request. |
| token?: [CancellationToken](#CancellationToken) | A cancellation token which controls the request. See [CancellationTokenSource](#CancellationTokenSource) for how to create one. |
| Returns | Description |
| Thenable<[LanguageModelChatResponse](#LanguageModelChatResponse)\> | A thenable that resolves to a [LanguageModelChatResponse](#LanguageModelChatResponse). The promise will reject when the request couldn't be made. |

### LanguageModelChatCapabilities

Various features that the [LanguageModelChatInformation](#LanguageModelChatInformation) supports such as tool calling or image input.

#### Properties

imageInput?: boolean

Whether image input is supported by the model. Common supported images are jpg and png, but each model will vary in supported mimetypes.

toolCalling?: number | boolean

Whether tool calling is supported by the model. If a number is provided, that is the maximum number of tools that can be provided in a request to the model.

### LanguageModelChatInformation

Represents a language model provided by a [LanguageModelChatProvider](#LanguageModelChatProvider).

#### Properties

capabilities: [LanguageModelChatCapabilities](#LanguageModelChatCapabilities)

Various features that the model supports such as tool calling or image input.

detail?: string

An optional, human-readable string which will be rendered alongside the model. Useful for distinguishing models of the same name in the UI.

family: string

Opaque family-name of the language model. Values might be `gpt-3.5-turbo`, `gpt4`, `phi2`, or `llama`

id: string

Unique identifier for the language model. Must be unique per provider, but not required to be globally unique.

maxInputTokens: number

The maximum number of tokens the model can accept as input.

maxOutputTokens: number

The maximum number of tokens the model is capable of producing.

name: string

Human-readable name of the language model.

tooltip?: string

The tooltip to render when hovering the model. Used to provide more information about the model.

version: string

Opaque version string of the model. This is used as a lookup value in [LanguageModelChatSelector.version](#LanguageModelChatSelector.version) An example is how GPT 4o has multiple versions like 2024-11-20 and 2024-08-06

### LanguageModelChatMessage

Represents a message in a chat. Can assume different roles, like user or assistant.

#### Static

Assistant(content: string | Array<[LanguageModelTextPart](#LanguageModelTextPart) | [LanguageModelDataPart](#LanguageModelDataPart) | [LanguageModelToolCallPart](#LanguageModelToolCallPart)\>, name?: string): [LanguageModelChatMessage](#LanguageModelChatMessage)

Utility to create a new assistant message.

| Parameter | Description |
| --- | --- |
| content: string \| Array<[LanguageModelTextPart](#LanguageModelTextPart) \| [LanguageModelDataPart](#LanguageModelDataPart) \| [LanguageModelToolCallPart](#LanguageModelToolCallPart)\> | The content of the message. |
| name?: string | The optional name of a user for the message. |
| Returns | Description |
| [LanguageModelChatMessage](#LanguageModelChatMessage) |     |

User(content: string | Array<[LanguageModelTextPart](#LanguageModelTextPart) | [LanguageModelToolResultPart](#LanguageModelToolResultPart) | [LanguageModelDataPart](#LanguageModelDataPart)\>, name?: string): [LanguageModelChatMessage](#LanguageModelChatMessage)

Utility to create a new user message.

| Parameter | Description |
| --- | --- |
| content: string \| Array<[LanguageModelTextPart](#LanguageModelTextPart) \| [LanguageModelToolResultPart](#LanguageModelToolResultPart) \| [LanguageModelDataPart](#LanguageModelDataPart)\> | The content of the message. |
| name?: string | The optional name of a user for the message. |
| Returns | Description |
| [LanguageModelChatMessage](#LanguageModelChatMessage) |     |

#### Constructors

new LanguageModelChatMessage(role: [LanguageModelChatMessageRole](#LanguageModelChatMessageRole), content: string | [LanguageModelInputPart](#LanguageModelInputPart)\[\], name?: string): [LanguageModelChatMessage](#LanguageModelChatMessage)

Create a new user message.

| Parameter | Description |
| --- | --- |
| role: [LanguageModelChatMessageRole](#LanguageModelChatMessageRole) | The role of the message. |
| content: string \| [LanguageModelInputPart](#LanguageModelInputPart)\[\] | The content of the message. |
| name?: string | The optional name of a user for the message. |
| Returns | Description |
| [LanguageModelChatMessage](#LanguageModelChatMessage) |     |

#### Properties

content: [LanguageModelInputPart](#LanguageModelInputPart)\[\]

A string or heterogeneous array of things that a message can contain as content. Some parts may be message-type specific for some models.

name: string

The optional name of a user for this message.

role: [LanguageModelChatMessageRole](#LanguageModelChatMessageRole)

The role of this message.

### LanguageModelChatMessageRole

Represents the role of a chat message. This is either the user or the assistant.

#### Enumeration Members

User: 1

The user role, e.g the human interacting with a language model.

Assistant: 2

The assistant role, e.g. the language model generating responses.

### LanguageModelChatProvider<T>

A LanguageModelChatProvider implements access to language models, which users can then use through the chat view, or through extension API by acquiring a LanguageModelChat. An example of this would be an OpenAI provider that provides models like gpt-5, o3, etc.

#### Events

onDidChangeLanguageModelChatInformation?: [Event](#Event&lt;T&gt;)<void\>

An optional event fired when the available set of language models changes.

#### Methods

provideLanguageModelChatInformation(options: [PrepareLanguageModelChatModelOptions](#PrepareLanguageModelChatModelOptions), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Get the list of available language models provided by this provider

| Parameter | Description |
| --- | --- |
| options: [PrepareLanguageModelChatModelOptions](#PrepareLanguageModelChatModelOptions) | Options which specify the calling context of this function |
| token: [CancellationToken](#CancellationToken) | A cancellation token |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | The list of available language models |

provideLanguageModelChatResponse(model: T, messages: readonly [LanguageModelChatRequestMessage](#LanguageModelChatRequestMessage)\[\], options: [ProvideLanguageModelChatResponseOptions](#ProvideLanguageModelChatResponseOptions), progress: [Progress](#Progress&lt;T&gt;)<[LanguageModelResponsePart](#LanguageModelResponsePart)\>, token: [CancellationToken](#CancellationToken)): Thenable<void\>

Returns the response for a chat request, passing the results to the progress callback. The [LanguageModelChatProvider](#LanguageModelChatProvider) must emit the response parts to the progress callback as they are received from the language model.

| Parameter | Description |
| --- | --- |
| model: T | The language model to use |
| messages: readonly [LanguageModelChatRequestMessage](#LanguageModelChatRequestMessage)\[\] | The messages to include in the request |
| options: [ProvideLanguageModelChatResponseOptions](#ProvideLanguageModelChatResponseOptions) | Options for the request |
| progress: [Progress](#Progress&lt;T&gt;)<[LanguageModelResponsePart](#LanguageModelResponsePart)\> | The progress to emit the streamed response chunks to |
| token: [CancellationToken](#CancellationToken) | A cancellation token |
| Returns | Description |
| Thenable<void\> | A promise that resolves when the response is complete. Results are actually passed to the progress callback. |

provideTokenCount(model: T, text: string | [LanguageModelChatRequestMessage](#LanguageModelChatRequestMessage), token: [CancellationToken](#CancellationToken)): Thenable<number\>

Returns the number of tokens for a given text using the model-specific tokenizer logic

| Parameter | Description |
| --- | --- |
| model: T | The language model to use |
| text: string \| [LanguageModelChatRequestMessage](#LanguageModelChatRequestMessage) | The text to count tokens for |
| token: [CancellationToken](#CancellationToken) | A cancellation token |
| Returns | Description |
| Thenable<number\> | The number of tokens |

### LanguageModelChatRequestMessage

The provider version of [LanguageModelChatMessage](#LanguageModelChatMessage).

#### Properties

content: readonly unknown\[\]

A heterogeneous array of things that a message can contain as content. Some parts may be message-type specific for some models.

name: string

The optional name of a user for this message.

role: [LanguageModelChatMessageRole](#LanguageModelChatMessageRole)

The role of this message.

### LanguageModelChatRequestOptions

Options for making a chat request using a language model.

_See also_ [LanguageModelChat.sendRequest](#LanguageModelChat.sendRequest)

#### Properties

justification?: string

A human-readable message that explains why access to a language model is needed and what feature is enabled by it.

modelOptions?:

A set of options that control the behavior of the language model. These options are specific to the language model and need to be looked up in the respective documentation.

toolMode?: [LanguageModelChatToolMode](#LanguageModelChatToolMode)

The tool-selecting mode to use. [LanguageModelChatToolMode.Auto](#LanguageModelChatToolMode.Auto) by default.

tools?: [LanguageModelChatTool](#LanguageModelChatTool)\[\]

An optional list of tools that are available to the language model. These could be registered tools available via [lm.tools](#lm.tools), or private tools that are just implemented within the calling extension.

If the LLM requests to call one of these tools, it will return a [LanguageModelToolCallPart](#LanguageModelToolCallPart) in [LanguageModelChatResponse.stream](#LanguageModelChatResponse.stream). It's the caller's responsibility to invoke the tool. If it's a tool registered in [lm.tools](#lm.tools), that means calling [lm.invokeTool](#lm.invokeTool).

Then, the tool result can be provided to the LLM by creating an Assistant-type [LanguageModelChatMessage](#LanguageModelChatMessage) with a [LanguageModelToolCallPart](#LanguageModelToolCallPart), followed by a User-type message with a [LanguageModelToolResultPart](#LanguageModelToolResultPart).

### LanguageModelChatResponse

Represents a language model response.

_See also_ [ChatRequest](#ChatRequest)

#### Properties

stream: AsyncIterable<unknown\>

An async iterable that is a stream of text and tool-call parts forming the overall response. A [LanguageModelTextPart](#LanguageModelTextPart) is part of the assistant's response to be shown to the user. A [LanguageModelToolCallPart](#LanguageModelToolCallPart) is a request from the language model to call a tool. The latter will only be returned if tools were passed in the request via [LanguageModelChatRequestOptions.tools](#LanguageModelChatRequestOptions.tools). The `unknown`\-type is used as a placeholder for future parts, like image data parts.

_Note_ that this stream will error when during data receiving an error occurs. Consumers of the stream should handle the errors accordingly.

To cancel the stream, the consumer can [cancel](#CancellationTokenSource.cancel) the token that was used to make the request or break from the for-loop.

**Example**

```
try {
  // consume stream
  for await (const chunk of response.stream) {
    if (chunk instanceof LanguageModelTextPart) {
      console.log('TEXT', chunk);
    } else if (chunk instanceof LanguageModelToolCallPart) {
      console.log('TOOL CALL', chunk);
    }
  }
} catch (e) {
  // stream ended with an error
  console.error(e);
}
```

text: AsyncIterable<string\>

This is equivalent to filtering everything except for text parts from a [LanguageModelChatResponse.stream](#LanguageModelChatResponse.stream).

_See also_ [LanguageModelChatResponse.stream](#LanguageModelChatResponse.stream)

### LanguageModelChatSelector

Describes how to select language models for chat requests.

_See also_ [lm.selectChatModels](#lm.selectChatModels)

#### Properties

family?: string

A family of language models.

_See also_ [LanguageModelChat.family](#LanguageModelChat.family)

id?: string

The identifier of a language model.

_See also_ [LanguageModelChat.id](#LanguageModelChat.id)

vendor?: string

A vendor of language models.

_See also_ [LanguageModelChat.vendor](#LanguageModelChat.vendor)

version?: string

The version of a language model.

_See also_ [LanguageModelChat.version](#LanguageModelChat.version)

### LanguageModelChatTool

A tool that is available to the language model via [LanguageModelChatRequestOptions](#LanguageModelChatRequestOptions). A language model uses all the properties of this interface to decide which tool to call, and how to call it.

#### Properties

description: string

The description of the tool.

inputSchema?: object

A JSON schema for the input this tool accepts.

name: string

The name of the tool.

### LanguageModelChatToolMode

A tool-calling mode for the language model to use.

#### Enumeration Members

Auto: 1

The language model can choose to call a tool or generate a message. Is the default.

Required: 2

The language model must call one of the provided tools. Note- some models only support a single tool when using this mode.

### LanguageModelDataPart

A language model response part containing arbitrary data. Can be used in [responses](#LanguageModelChatResponse), [chat messages](#LanguageModelChatMessage), [tool results](#LanguageModelToolResult), and other language model interactions.

#### Static

image(data: Uint8Array, mime: string): [LanguageModelDataPart](#LanguageModelDataPart)

Create a new [LanguageModelDataPart](#LanguageModelDataPart) for an image.

| Parameter | Description |
| --- | --- |
| data: Uint8Array | Binary image data |
| mime: string | The MIME type of the image. Common values are `image/png` and `image/jpeg`. |
| Returns | Description |
| [LanguageModelDataPart](#LanguageModelDataPart) |     |

json(value: any, mime?: string): [LanguageModelDataPart](#LanguageModelDataPart)

Create a new [LanguageModelDataPart](#LanguageModelDataPart) for a json.

_Note_ that this function is not expecting "stringified JSON" but an object that can be stringified. This function will throw an error when the passed value cannot be JSON-stringified.

| Parameter | Description |
| --- | --- |
| value: any | A JSON-stringifyable value. |
| mime?: string | Optional MIME type, defaults to `application/json` |
| Returns | Description |
| [LanguageModelDataPart](#LanguageModelDataPart) |     |

text(value: string, mime?: string): [LanguageModelDataPart](#LanguageModelDataPart)

Create a new [LanguageModelDataPart](#LanguageModelDataPart) for text.

_Note_ that an UTF-8 encoder is used to create bytes for the string.

| Parameter | Description |
| --- | --- |
| value: string | Text data |
| mime?: string | The MIME type if any. Common values are `text/plain` and `text/markdown`. |
| Returns | Description |
| [LanguageModelDataPart](#LanguageModelDataPart) |     |

#### Constructors

new LanguageModelDataPart(data: Uint8Array, mimeType: string): [LanguageModelDataPart](#LanguageModelDataPart)

Construct a generic data part with the given content.

| Parameter | Description |
| --- | --- |
| data: Uint8Array | The byte data for this part. |
| mimeType: string | The mime type of the data. |
| Returns | Description |
| [LanguageModelDataPart](#LanguageModelDataPart) |     |

#### Properties

data: Uint8Array

The byte data for this part.

mimeType: string

The mime type which determines how the data property is interpreted.

### LanguageModelError

An error type for language model specific errors.

Consumers of language models should check the code property to determine specific failure causes, like `if(someError.code === vscode.LanguageModelError.NotFound.name) {...}` for the case of referring to an unknown language model. For unspecified errors the `cause`\-property will contain the actual error.

#### Static

Blocked(message?: string): [LanguageModelError](#LanguageModelError)

The requestor is blocked from using this language model.

| Parameter | Description |
| --- | --- |
| message?: string |     |
| Returns | Description |
| [LanguageModelError](#LanguageModelError) |     |

NoPermissions(message?: string): [LanguageModelError](#LanguageModelError)

The requestor does not have permissions to use this language model

| Parameter | Description |
| --- | --- |
| message?: string |     |
| Returns | Description |
| [LanguageModelError](#LanguageModelError) |     |

NotFound(message?: string): [LanguageModelError](#LanguageModelError)

The language model does not exist.

| Parameter | Description |
| --- | --- |
| message?: string |     |
| Returns | Description |
| [LanguageModelError](#LanguageModelError) |     |

#### Constructors

new LanguageModelError(message?: string): [LanguageModelError](#LanguageModelError)

| Parameter | Description |
| --- | --- |
| message?: string |     |
| Returns | Description |
| [LanguageModelError](#LanguageModelError) |     |

#### Properties

code: string

A code that identifies this error.

Possible values are names of errors, like [NotFound](#LanguageModelError.NotFound), or `Unknown` for unspecified errors from the language model itself. In the latter case the `cause`\-property will contain the actual error.

### LanguageModelInputPart

The various message types which can be sent via [LanguageModelChat.sendRequest](#LanguageModelChat.sendRequest) and processed by a [LanguageModelChatProvider](#LanguageModelChatProvider)

LanguageModelInputPart: [LanguageModelTextPart](#LanguageModelTextPart) | [LanguageModelToolResultPart](#LanguageModelToolResultPart) | [LanguageModelToolCallPart](#LanguageModelToolCallPart) | [LanguageModelDataPart](#LanguageModelDataPart)

### LanguageModelPromptTsxPart

A language model response part containing a PromptElementJSON from `vscode/prompt-tsx`.

_See also_ [LanguageModelToolResult](#LanguageModelToolResult)

#### Constructors

new LanguageModelPromptTsxPart(value: unknown): [LanguageModelPromptTsxPart](#LanguageModelPromptTsxPart)

Construct a prompt-tsx part with the given content.

| Parameter | Description |
| --- | --- |
| value: unknown | The value of the part, the result of `renderElementJSON` from `vscode/prompt-tsx`. |
| Returns | Description |
| [LanguageModelPromptTsxPart](#LanguageModelPromptTsxPart) |     |

#### Properties

value: unknown

The value of the part.

### LanguageModelResponsePart

The various message types which a [LanguageModelChatProvider](#LanguageModelChatProvider) can emit in the chat response stream

LanguageModelResponsePart: [LanguageModelTextPart](#LanguageModelTextPart) | [LanguageModelToolResultPart](#LanguageModelToolResultPart) | [LanguageModelToolCallPart](#LanguageModelToolCallPart) | [LanguageModelDataPart](#LanguageModelDataPart)

### LanguageModelTextPart

A language model response part containing a piece of text, returned from a [LanguageModelChatResponse](#LanguageModelChatResponse).

#### Constructors

new LanguageModelTextPart(value: string): [LanguageModelTextPart](#LanguageModelTextPart)

Construct a text part with the given content.

| Parameter | Description |
| --- | --- |
| value: string | The text content of the part. |
| Returns | Description |
| [LanguageModelTextPart](#LanguageModelTextPart) |     |

#### Properties

value: string

The text content of the part.

### LanguageModelTool<T>

A tool that can be invoked by a call to a [LanguageModelChat](#LanguageModelChat).

#### Methods

invoke(options: [LanguageModelToolInvocationOptions](#LanguageModelToolInvocationOptions&lt;T&gt;)<T\>, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[LanguageModelToolResult](#LanguageModelToolResult)\>

Invoke the tool with the given input and return a result.

The provided [LanguageModelToolInvocationOptions.input](#LanguageModelToolInvocationOptions.input) has been validated against the declared schema.

| Parameter | Description |
| --- | --- |
| options: [LanguageModelToolInvocationOptions](#LanguageModelToolInvocationOptions&lt;T&gt;)<T\> |     |
| token: [CancellationToken](#CancellationToken) |     |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[LanguageModelToolResult](#LanguageModelToolResult)\> |     |

prepareInvocation(options: [LanguageModelToolInvocationPrepareOptions](#LanguageModelToolInvocationPrepareOptions&lt;T&gt;)<T\>, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[PreparedToolInvocation](#PreparedToolInvocation)\>

Called once before a tool is invoked. It's recommended to implement this to customize the progress message that appears while the tool is running, and to provide a more useful message with context from the invocation input. Can also signal that a tool needs user confirmation before running, if appropriate.

*   _Note 1:_ Must be free of side-effects.
*   _Note 2:_ A call to `prepareInvocation` is not necessarily followed by a call to `invoke`.

| Parameter | Description |
| --- | --- |
| options: [LanguageModelToolInvocationPrepareOptions](#LanguageModelToolInvocationPrepareOptions&lt;T&gt;)<T\> |     |
| token: [CancellationToken](#CancellationToken) |     |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[PreparedToolInvocation](#PreparedToolInvocation)\> |     |

### LanguageModelToolCallPart

A language model response part indicating a tool call, returned from a [LanguageModelChatResponse](#LanguageModelChatResponse), and also can be included as a content part on a [LanguageModelChatMessage](#LanguageModelChatMessage), to represent a previous tool call in a chat request.

#### Constructors

new LanguageModelToolCallPart(callId: string, name: string, input: object): [LanguageModelToolCallPart](#LanguageModelToolCallPart)

Create a new LanguageModelToolCallPart.

| Parameter | Description |
| --- | --- |
| callId: string | The ID of the tool call. |
| name: string | The name of the tool to call. |
| input: object | The input with which to call the tool. |
| Returns | Description |
| [LanguageModelToolCallPart](#LanguageModelToolCallPart) |     |

#### Properties

callId: string

The ID of the tool call. This is a unique identifier for the tool call within the chat request.

input: object

The input with which to call the tool.

name: string

The name of the tool to call.

### LanguageModelToolConfirmationMessages

When this is returned in [PreparedToolInvocation](#PreparedToolInvocation), the user will be asked to confirm before running the tool. These messages will be shown with buttons that say "Continue" and "Cancel".

#### Properties

message: string | [MarkdownString](#MarkdownString)

The body of the confirmation message.

title: string

The title of the confirmation message.

### LanguageModelToolInformation

Information about a registered tool available in [lm.tools](#lm.tools).

#### Properties

description: string

A description of this tool that may be passed to a language model.

inputSchema: object

A JSON schema for the input this tool accepts.

name: string

A unique name for the tool.

tags: readonly string\[\]

A set of tags, declared by the tool, that roughly describe the tool's capabilities. A tool user may use these to filter the set of tools to just ones that are relevant for the task at hand.

### LanguageModelToolInvocationOptions<T>

Options provided for tool invocation.

#### Properties

input: T

The input with which to invoke the tool. The input must match the schema defined in [LanguageModelToolInformation.inputSchema](#LanguageModelToolInformation.inputSchema)

tokenizationOptions?: [LanguageModelToolTokenizationOptions](#LanguageModelToolTokenizationOptions)

Options to hint at how many tokens the tool should return in its response, and enable the tool to count tokens accurately.

toolInvocationToken: undefined

An opaque object that ties a tool invocation to a chat request from a [chat participant](#ChatParticipant).

The _only_ way to get a valid tool invocation token is using the provided [toolInvocationToken](#ChatRequest.toolInvocationToken) from a chat request. In that case, a progress bar will be automatically shown for the tool invocation in the chat response view, and if the tool requires user confirmation, it will show up inline in the chat view.

If the tool is being invoked outside of a chat request, `undefined` should be passed instead, and no special UI except for confirmations will be shown.

_Note_ that a tool that invokes another tool during its invocation, can pass along the `toolInvocationToken` that it received.

### LanguageModelToolInvocationPrepareOptions<T>

Options for [LanguageModelTool.prepareInvocation](#LanguageModelTool.prepareInvocation).

#### Properties

input: T

The input that the tool is being invoked with.

### LanguageModelToolResult

A result returned from a tool invocation. If using `vscode/prompt-tsx`, this result may be rendered using a `ToolResult`.

#### Constructors

new LanguageModelToolResult(content: unknown\[\]): [LanguageModelToolResult](#LanguageModelToolResult)

Create a LanguageModelToolResult

| Parameter | Description |
| --- | --- |
| content: unknown\[\] | A list of tool result content parts |
| Returns | Description |
| [LanguageModelToolResult](#LanguageModelToolResult) |     |

#### Properties

content: unknown\[\]

A list of tool result content parts. Includes `unknown` because this list may be extended with new content types in the future.

_See also_ [lm.invokeTool](#lm.invokeTool).

### LanguageModelToolResultPart

The result of a tool call. This is the counterpart of a [tool call](#LanguageModelToolCallPart) and it can only be included in the content of a User message

#### Constructors

new LanguageModelToolResultPart(callId: string, content: unknown\[\]): [LanguageModelToolResultPart](#LanguageModelToolResultPart)

| Parameter | Description |
| --- | --- |
| callId: string | The ID of the tool call. |
| content: unknown\[\] | The content of the tool result. |
| Returns | Description |
| [LanguageModelToolResultPart](#LanguageModelToolResultPart) |     |

#### Properties

callId: string

The ID of the tool call.

_Note_ that this should match the [callId](#LanguageModelToolCallPart.callId) of a tool call part.

content: unknown\[\]

The value of the tool result.

### LanguageModelToolTokenizationOptions

Options related to tokenization for a tool invocation.

#### Properties

tokenBudget: number

If known, the maximum number of tokens the tool should emit in its result.

#### Methods

countTokens(text: string, token?: [CancellationToken](#CancellationToken)): Thenable<number\>

Count the number of tokens in a message using the model specific tokenizer-logic.

| Parameter | Description |
| --- | --- |
| text: string | A string. |
| token?: [CancellationToken](#CancellationToken) | Optional cancellation token. See [CancellationTokenSource](#CancellationTokenSource) for how to create one. |
| Returns | Description |
| Thenable<number\> | A thenable that resolves to the number of tokens. |

### LanguageStatusItem

A language status item is the preferred way to present language status reports for the active text editors, such as selected linter or notifying about a configuration problem.

#### Properties

accessibilityInformation?: [AccessibilityInformation](#AccessibilityInformation)

Accessibility information used when a screen reader interacts with this item

busy: boolean

Controls whether the item is shown as "busy". Defaults to `false`.

command: [Command](#Command)

A [command](#Command) for this item.

detail?: string

Optional, human-readable details for this item.

id: string

The identifier of this item.

name: string

The short name of this item, like 'Java Language Status', etc.

selector: [DocumentSelector](#DocumentSelector)

A [selector](#DocumentSelector) that defines for what editors this item shows.

severity: [LanguageStatusSeverity](#LanguageStatusSeverity)

The severity of this item.

Defaults to [information](#LanguageStatusSeverity.Information). You can use this property to signal to users that there is a problem that needs attention, like a missing executable or an invalid configuration.

text: string

The text to show for the entry. You can embed icons in the text by leveraging the syntax:

`My text $(icon-name) contains icons like $(icon-name) this one.`

Where the icon-name is taken from the ThemeIcon [icon set](https://code.visualstudio.com/api/references/icons-in-labels#icon-listing), e.g. `light-bulb`, `thumbsup`, `zap` etc.

#### Methods

dispose(): void

Dispose and free associated resources.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### LanguageStatusSeverity

Represents the severity level of a language status.

#### Enumeration Members

Information: 0

Informational severity level.

Warning: 1

Warning severity level.

Error: 2

Error severity level.

### LinkedEditingRangeProvider

The linked editing range provider interface defines the contract between extensions and the linked editing feature.

#### Methods

provideLinkedEditingRanges(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[LinkedEditingRanges](#LinkedEditingRanges)\>

For a given position in a document, returns the range of the symbol at the position and all ranges that have the same content. A change to one of the ranges can be applied to all other ranges if the new content is valid. An optional word pattern can be returned with the result to describe valid contents. If no result-specific word pattern is provided, the word pattern from the language configuration is used.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the provider was invoked. |
| position: [Position](#Position) | The position at which the provider was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[LinkedEditingRanges](#LinkedEditingRanges)\> | A list of ranges that can be edited together |

### LinkedEditingRanges

Represents a list of ranges that can be edited together along with a word pattern to describe valid range contents.

#### Constructors

new LinkedEditingRanges(ranges: [Range](#Range)\[\], wordPattern?: RegExp): [LinkedEditingRanges](#LinkedEditingRanges)

Create a new linked editing ranges object.

| Parameter | Description |
| --- | --- |
| ranges: [Range](#Range)\[\] | A list of ranges that can be edited together |
| wordPattern?: RegExp | An optional word pattern that describes valid contents for the given ranges |
| Returns | Description |
| [LinkedEditingRanges](#LinkedEditingRanges) |     |

#### Properties

ranges: [Range](#Range)\[\]

A list of ranges that can be edited together. The ranges must have identical length and text content. The ranges cannot overlap.

wordPattern: RegExp

An optional word pattern that describes valid contents for the given ranges. If no pattern is provided, the language configuration's word pattern will be used.

### Location

Represents a location inside a resource, such as a line inside a text file.

#### Constructors

new Location(uri: [Uri](#Uri), rangeOrPosition: [Range](#Range) | [Position](#Position)): [Location](#Location)

Creates a new location object.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The resource identifier. |
| rangeOrPosition: [Range](#Range) \| [Position](#Position) | The range or position. Positions will be converted to an empty range. |
| Returns | Description |
| [Location](#Location) |     |

#### Properties

range: [Range](#Range)

The document range of this location.

uri: [Uri](#Uri)

The resource identifier of this location.

### LocationLink

Represents the connection of two locations. Provides additional metadata over normal [locations](#Location), including an origin range.

#### Properties

originSelectionRange?: [Range](#Range)

Span of the origin of this link.

Used as the underlined span for mouse definition hover. Defaults to the word range at the definition position.

targetRange: [Range](#Range)

The full target range of this link.

targetSelectionRange?: [Range](#Range)

The span of this link.

targetUri: [Uri](#Uri)

The target resource identifier of this link.

### LogLevel

Log levels

#### Enumeration Members

Off: 0

No messages are logged with this level.

Trace: 1

All messages are logged with this level.

Debug: 2

Messages with debug and higher log level are logged with this level.

Info: 3

Messages with info and higher log level are logged with this level.

Warning: 4

Messages with warning and higher log level are logged with this level.

Error: 5

Only error messages are logged with this level.

### LogOutputChannel

A channel for containing log output.

To get an instance of a `LogOutputChannel` use [createOutputChannel](#window.createOutputChannel).

#### Events

onDidChangeLogLevel: [Event](#Event&lt;T&gt;)<[LogLevel](#LogLevel)\>

An [Event](#Event) which fires when the log level of the channel changes.

#### Properties

logLevel: [LogLevel](#LogLevel)

The current log level of the channel. Defaults to [editor log level](#env.logLevel).

name: string

The human-readable name of this output channel.

#### Methods

append(value: string): void

Append the given value to the channel.

| Parameter | Description |
| --- | --- |
| value: string | A string, falsy values will not be printed. |
| Returns | Description |
| void |     |

appendLine(value: string): void

Append the given value and a line feed character to the channel.

| Parameter | Description |
| --- | --- |
| value: string | A string, falsy values will be printed. |
| Returns | Description |
| void |     |

clear(): void

Removes all output from the channel.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

debug(message: string, ...args: any\[\]): void

Outputs the given debug message to the channel.

The message is only logged if the channel is configured to display [debug](#LogLevel.Debug) log level or lower.

| Parameter | Description |
| --- | --- |
| message: string | debug message to log |
| ...args: any\[\] |     |
| Returns | Description |
| void |     |

dispose(): void

Dispose and free associated resources.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

error(error: string | Error, ...args: any\[\]): void

Outputs the given error or error message to the channel.

The message is only logged if the channel is configured to display [error](#LogLevel.Error) log level or lower.

| Parameter | Description |
| --- | --- |
| error: string \| Error | Error or error message to log |
| ...args: any\[\] |     |
| Returns | Description |
| void |     |

hide(): void

Hide this channel from the UI.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

info(message: string, ...args: any\[\]): void

Outputs the given information message to the channel.

The message is only logged if the channel is configured to display [info](#LogLevel.Info) log level or lower.

| Parameter | Description |
| --- | --- |
| message: string | info message to log |
| ...args: any\[\] |     |
| Returns | Description |
| void |     |

replace(value: string): void

Replaces all output from the channel with the given value.

| Parameter | Description |
| --- | --- |
| value: string | A string, falsy values will not be printed. |
| Returns | Description |
| void |     |

show(preserveFocus?: boolean): void

Reveal this channel in the UI.

| Parameter | Description |
| --- | --- |
| preserveFocus?: boolean | When `true` the channel will not take focus. |
| Returns | Description |
| void |     |

show(column?: [ViewColumn](#ViewColumn), preserveFocus?: boolean): void

Reveal this channel in the UI.

*   _deprecated_ - Use the overload with just one parameter (`show(preserveFocus?: boolean): void`).

| Parameter | Description |
| --- | --- |
| column?: [ViewColumn](#ViewColumn) | This argument is **deprecated** and will be ignored. |
| preserveFocus?: boolean | When `true` the channel will not take focus. |
| Returns | Description |
| void |     |

trace(message: string, ...args: any\[\]): void

Outputs the given trace message to the channel. Use this method to log verbose information.

The message is only logged if the channel is configured to display [trace](#LogLevel.Trace) log level.

| Parameter | Description |
| --- | --- |
| message: string | trace message to log |
| ...args: any\[\] |     |
| Returns | Description |
| void |     |

warn(message: string, ...args: any\[\]): void

Outputs the given warning message to the channel.

The message is only logged if the channel is configured to display [warning](#LogLevel.Warning) log level or lower.

| Parameter | Description |
| --- | --- |
| message: string | warning message to log |
| ...args: any\[\] |     |
| Returns | Description |
| void |     |

### MarkdownString

Human-readable text that supports formatting via the [markdown syntax](https://commonmark.org).

Rendering of [theme icons](#ThemeIcon) via the `$(<name>)`\-syntax is supported when the [supportThemeIcons](#MarkdownString.supportThemeIcons) is set to `true`.

Rendering of embedded html is supported when [supportHtml](#MarkdownString.supportHtml) is set to `true`.

#### Constructors

new MarkdownString(value?: string, supportThemeIcons?: boolean): [MarkdownString](#MarkdownString)

Creates a new markdown string with the given value.

| Parameter | Description |
| --- | --- |
| value?: string | Optional, initial value. |
| supportThemeIcons?: boolean | Optional, Specifies whether [ThemeIcons](#ThemeIcon) are supported within the [MarkdownString](#MarkdownString). |
| Returns | Description |
| [MarkdownString](#MarkdownString) |     |

#### Properties

baseUri?: [Uri](#Uri)

Uri that relative paths are resolved relative to.

If the `baseUri` ends with `/`, it is considered a directory and relative paths in the markdown are resolved relative to that directory:

```
const md = new vscode.MarkdownString(`[link](./file.js)`);
md.baseUri = vscode.Uri.file('/path/to/dir/');
// Here 'link' in the rendered markdown resolves to '/path/to/dir/file.js'
```

If the `baseUri` is a file, relative paths in the markdown are resolved relative to the parent dir of that file:

```
const md = new vscode.MarkdownString(`[link](./file.js)`);
md.baseUri = vscode.Uri.file('/path/to/otherFile.js');
// Here 'link' in the rendered markdown resolves to '/path/to/file.js'
```

isTrusted?: boolean | {enabledCommands: readonly string\[\]}

Indicates that this markdown string is from a trusted source. Only _trusted_ markdown supports links that execute commands, e.g. `[Run it](command:myCommandId)`.

Defaults to `false` (commands are disabled).

supportHtml?: boolean

Indicates that this markdown string can contain raw html tags. Defaults to `false`.

When `supportHtml` is false, the markdown renderer will strip out any raw html tags that appear in the markdown text. This means you can only use markdown syntax for rendering.

When `supportHtml` is true, the markdown render will also allow a safe subset of html tags and attributes to be rendered. See [https://github.com/microsoft/vscode/blob/6d2920473c6f13759c978dd89104c4270a83422d/src/vs/base/browser/markdownRenderer.ts#L296](https://github.com/microsoft/vscode/blob/6d2920473c6f13759c978dd89104c4270a83422d/src/vs/base/browser/markdownRenderer.ts#L296) for a list of all supported tags and attributes.

supportThemeIcons?: boolean

Indicates that this markdown string can contain [ThemeIcons](#ThemeIcon), e.g. `$(zap)`.

value: string

The markdown string.

#### Methods

appendCodeblock(value: string, language?: string): [MarkdownString](#MarkdownString)

Appends the given string as codeblock using the provided language.

| Parameter | Description |
| --- | --- |
| value: string | A code snippet. |
| language?: string | An optional [language identifier](#languages.getLanguages). |
| Returns | Description |
| [MarkdownString](#MarkdownString) |     |

appendMarkdown(value: string): [MarkdownString](#MarkdownString)

Appends the given string 'as is' to this markdown string. When [supportThemeIcons](#MarkdownString.supportThemeIcons) is `true`, [ThemeIcons](#ThemeIcon) in the `value` will be iconified.

| Parameter | Description |
| --- | --- |
| value: string | Markdown string. |
| Returns | Description |
| [MarkdownString](#MarkdownString) |     |

appendText(value: string): [MarkdownString](#MarkdownString)

Appends and escapes the given string to this markdown string.

| Parameter | Description |
| --- | --- |
| value: string | Plain text. |
| Returns | Description |
| [MarkdownString](#MarkdownString) |     |

### MarkedString

MarkedString can be used to render human-readable text. It is either a markdown string or a code-block that provides a language and a code snippet. Note that markdown strings will be sanitized - that means html will be escaped.

*   _deprecated_ - This type is deprecated, please use [MarkdownString](#MarkdownString) instead.

MarkedString: string | {language: string, value: string}

### McpHttpServerDefinition

McpHttpServerDefinition represents an MCP server available using the Streamable HTTP transport.

#### Constructors

new McpHttpServerDefinition(label: string, uri: [Uri](#Uri), headers?: Record<string, string\>, version?: string): [McpHttpServerDefinition](#McpHttpServerDefinition)

| Parameter | Description |
| --- | --- |
| label: string | The human-readable name of the server. |
| uri: [Uri](#Uri) | The URI of the server. |
| headers?: Record<string, string\> | Optional additional heads included with each request to the server. |
| version?: string |     |
| Returns | Description |
| [McpHttpServerDefinition](#McpHttpServerDefinition) |     |

#### Properties

headers: Record<string, string\>

Optional additional heads included with each request to the server.

label: string

The human-readable name of the server.

uri: [Uri](#Uri)

The URI of the server. The editor will make a POST request to this URI to begin each session.

version?: string

Optional version identification for the server. If this changes, the editor will indicate that tools have changed and prompt to refresh them.

### McpServerDefinition

Definitions that describe different types of Model Context Protocol servers, which can be returned from the [McpServerDefinitionProvider](#McpServerDefinitionProvider).

McpServerDefinition: [McpStdioServerDefinition](#McpStdioServerDefinition) | [McpHttpServerDefinition](#McpHttpServerDefinition)

### McpServerDefinitionProvider<T>

A type that can provide Model Context Protocol server definitions. This should be registered using [lm.registerMcpServerDefinitionProvider](#lm.registerMcpServerDefinitionProvider) during extension activation.

#### Events

onDidChangeMcpServerDefinitions?: [Event](#Event&lt;T&gt;)<void\>

Optional event fired to signal that the set of available servers has changed.

#### Methods

provideMcpServerDefinitions(token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Provides available MCP servers. The editor will call this method eagerly to ensure the availability of servers for the language model, and so extensions should not take actions which would require user interaction, such as authentication.

| Parameter | Description |
| --- | --- |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | An array of MCP available MCP servers |

resolveMcpServerDefinition(server: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

This function will be called when the editor needs to start a MCP server. At this point, the extension may take any actions which may require user interaction, such as authentication. Any non-`readonly` property of the server may be modified, and the extension should return the resolved server.

The extension may return undefined to indicate that the server should not be started, or throw an error. If there is a pending tool call, the editor will cancel it and return an error message to the language model.

| Parameter | Description |
| --- | --- |
| server: T | The MCP server to resolve |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | The resolved server or thenable that resolves to such. This may be the given `server` definition with non-readonly properties filled in. |

### McpStdioServerDefinition

McpStdioServerDefinition represents an MCP server available by running a local process and operating on its stdin and stdout streams. The process will be spawned as a child process of the extension host and by default will not run in a shell environment.

#### Constructors

new McpStdioServerDefinition(label: string, command: string, args?: string\[\], env?: Record<string, string | number\>, version?: string): [McpStdioServerDefinition](#McpStdioServerDefinition)

| Parameter | Description |
| --- | --- |
| label: string | The human-readable name of the server. |
| command: string | The command used to start the server. |
| args?: string\[\] | Additional command-line arguments passed to the server. |
| env?: Record<string, string \| number\> | Optional additional environment information for the server. |
| version?: string | Optional version identification for the server. |
| Returns | Description |
| [McpStdioServerDefinition](#McpStdioServerDefinition) |     |

#### Properties

args: string\[\]

Additional command-line arguments passed to the server.

command: string

The command used to start the server. Node.js-based servers may use `process.execPath` to use the editor's version of Node.js to run the script.

cwd?: [Uri](#Uri)

The working directory used to start the server.

env: Record<string, string | number\>

Optional additional environment information for the server. Variables in this environment will overwrite or remove (if null) the default environment variables of the editor's extension host.

label: string

The human-readable name of the server.

version?: string

Optional version identification for the server. If this changes, the editor will indicate that tools have changed and prompt to refresh them.

### Memento

A memento represents a storage utility. It can store and retrieve values.

#### Methods

get<T\>(key: string): T

Return a value.

| Parameter | Description |
| --- | --- |
| key: string | A string. |
| Returns | Description |
| T   | The stored value or `undefined`. |

get<T\>(key: string, defaultValue: T): T

Return a value.

| Parameter | Description |
| --- | --- |
| key: string | A string. |
| defaultValue: T | A value that should be returned when there is no value (`undefined`) with the given key. |
| Returns | Description |
| T   | The stored value or the defaultValue. |

keys(): readonly string\[\]

Returns the stored keys.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| readonly string\[\] | The stored keys. |

update(key: string, value: any): Thenable<void\>

Store a value. The value must be JSON-stringifyable.

_Note_ that using `undefined` as value removes the key from the underlying storage.

| Parameter | Description |
| --- | --- |
| key: string | A string. |
| value: any | A value. MUST not contain cyclic references. |
| Returns | Description |
| Thenable<void\> |     |

### MessageItem

Represents an action that is shown with an information, warning, or error message.

_See also_

*   [showInformationMessage](#window.showInformationMessage)
*   [showWarningMessage](#window.showWarningMessage)
*   [showErrorMessage](#window.showErrorMessage)

#### Properties

isCloseAffordance?: boolean

A hint for modal dialogs that the item should be triggered when the user cancels the dialog (e.g. by pressing the ESC key).

Note: this option is ignored for non-modal messages.

title: string

A short title like 'Retry', 'Open Log' etc.

### MessageOptions

Options to configure the behavior of the message.

_See also_

*   [showInformationMessage](#window.showInformationMessage)
*   [showWarningMessage](#window.showWarningMessage)
*   [showErrorMessage](#window.showErrorMessage)

#### Properties

detail?: string

Human-readable detail message that is rendered less prominent. _Note_ that detail is only shown for [modal](#MessageOptions.modal) messages.

modal?: boolean

Indicates that this message should be modal.

### NotebookCell

Represents a cell of a [notebook](#NotebookDocument), either a [code](#NotebookCellKind.Code)\-cell or [markup](#NotebookCellKind.Markup)\-cell.

NotebookCell instances are immutable and are kept in sync for as long as they are part of their notebook.

#### Properties

document: [TextDocument](#TextDocument)

The [text](#TextDocument) of this cell, represented as text document.

executionSummary: [NotebookCellExecutionSummary](#NotebookCellExecutionSummary)

The most recent [execution summary](#NotebookCellExecutionSummary) for this cell.

index: number

The index of this cell in its [containing notebook](#NotebookDocument.cellAt). The index is updated when a cell is moved within its notebook. The index is `-1` when the cell has been removed from its notebook.

kind: [NotebookCellKind](#NotebookCellKind)

The kind of this cell.

metadata:

The metadata of this cell. Can be anything but must be JSON-stringifyable.

notebook: [NotebookDocument](#NotebookDocument)

The [notebook](#NotebookDocument) that contains this cell.

outputs: readonly [NotebookCellOutput](#NotebookCellOutput)\[\]

The outputs of this cell.

### NotebookCellData

NotebookCellData is the raw representation of notebook cells. Its is part of [NotebookData](#NotebookData).

#### Constructors

new NotebookCellData(kind: [NotebookCellKind](#NotebookCellKind), value: string, languageId: string): [NotebookCellData](#NotebookCellData)

Create new cell data. Minimal cell data specifies its kind, its source value, and the language identifier of its source.

| Parameter | Description |
| --- | --- |
| kind: [NotebookCellKind](#NotebookCellKind) | The kind. |
| value: string | The source value. |
| languageId: string | The language identifier of the source value. |
| Returns | Description |
| [NotebookCellData](#NotebookCellData) |     |

#### Properties

executionSummary?: [NotebookCellExecutionSummary](#NotebookCellExecutionSummary)

The execution summary of this cell data.

kind: [NotebookCellKind](#NotebookCellKind)

The [kind](#NotebookCellKind) of this cell data.

languageId: string

The language identifier of the source value of this cell data. Any value from [getLanguages](#languages.getLanguages) is possible.

metadata?:

Arbitrary metadata of this cell data. Can be anything but must be JSON-stringifyable.

outputs?: [NotebookCellOutput](#NotebookCellOutput)\[\]

The outputs of this cell data.

value: string

The source value of this cell data - either source code or formatted text.

### NotebookCellExecution

A NotebookCellExecution is how [notebook controller](#NotebookController) modify a notebook cell as it is executing.

When a cell execution object is created, the cell enters the \[NotebookCellExecutionState.Pending Pending\](#\_NotebookCellExecutionState.Pending Pending) state. When [start(...)](#NotebookCellExecution.start) is called on the execution task, it enters the \[NotebookCellExecutionState.Executing Executing\](#\_NotebookCellExecutionState.Executing Executing) state. When [end(...)](#NotebookCellExecution.end) is called, it enters the \[NotebookCellExecutionState.Idle Idle\](#\_NotebookCellExecutionState.Idle Idle) state.

#### Properties

cell: [NotebookCell](#NotebookCell)

The [cell](#NotebookCell) for which this execution has been created.

executionOrder: number

Set and unset the order of this cell execution.

token: [CancellationToken](#CancellationToken)

A cancellation token which will be triggered when the cell execution is canceled from the UI.

_Note_ that the cancellation token will not be triggered when the [controller](#NotebookController) that created this execution uses an [interrupt-handler](#NotebookController.interruptHandler).

#### Methods

appendOutput(out: [NotebookCellOutput](#NotebookCellOutput) | readonly [NotebookCellOutput](#NotebookCellOutput)\[\], cell?: [NotebookCell](#NotebookCell)): Thenable<void\>

Append to the output of the cell that is executing or to another cell that is affected by this execution.

| Parameter | Description |
| --- | --- |
| out: [NotebookCellOutput](#NotebookCellOutput) \| readonly [NotebookCellOutput](#NotebookCellOutput)\[\] | Output that is appended to the current output. |
| cell?: [NotebookCell](#NotebookCell) | Cell for which output is cleared. Defaults to the [cell](#NotebookCellExecution.cell) of this execution. |
| Returns | Description |
| Thenable<void\> | A thenable that resolves when the operation finished. |

appendOutputItems(items: [NotebookCellOutputItem](#NotebookCellOutputItem) | readonly [NotebookCellOutputItem](#NotebookCellOutputItem)\[\], output: [NotebookCellOutput](#NotebookCellOutput)): Thenable<void\>

Append output items to existing cell output.

| Parameter | Description |
| --- | --- |
| items: [NotebookCellOutputItem](#NotebookCellOutputItem) \| readonly [NotebookCellOutputItem](#NotebookCellOutputItem)\[\] | Output items that are append to existing output. |
| output: [NotebookCellOutput](#NotebookCellOutput) | Output object that already exists. |
| Returns | Description |
| Thenable<void\> | A thenable that resolves when the operation finished. |

clearOutput(cell?: [NotebookCell](#NotebookCell)): Thenable<void\>

Clears the output of the cell that is executing or of another cell that is affected by this execution.

| Parameter | Description |
| --- | --- |
| cell?: [NotebookCell](#NotebookCell) | Cell for which output is cleared. Defaults to the [cell](#NotebookCellExecution.cell) of this execution. |
| Returns | Description |
| Thenable<void\> | A thenable that resolves when the operation finished. |

end(success: boolean, endTime?: number): void

Signal that execution has ended.

| Parameter | Description |
| --- | --- |
| success: boolean | If true, a green check is shown on the cell status bar. If false, a red X is shown. If undefined, no check or X icon is shown. |
| endTime?: number | The time that execution finished, in milliseconds in the Unix epoch. |
| Returns | Description |
| void |     |

replaceOutput(out: [NotebookCellOutput](#NotebookCellOutput) | readonly [NotebookCellOutput](#NotebookCellOutput)\[\], cell?: [NotebookCell](#NotebookCell)): Thenable<void\>

Replace the output of the cell that is executing or of another cell that is affected by this execution.

| Parameter | Description |
| --- | --- |
| out: [NotebookCellOutput](#NotebookCellOutput) \| readonly [NotebookCellOutput](#NotebookCellOutput)\[\] | Output that replaces the current output. |
| cell?: [NotebookCell](#NotebookCell) | Cell for which output is cleared. Defaults to the [cell](#NotebookCellExecution.cell) of this execution. |
| Returns | Description |
| Thenable<void\> | A thenable that resolves when the operation finished. |

replaceOutputItems(items: [NotebookCellOutputItem](#NotebookCellOutputItem) | readonly [NotebookCellOutputItem](#NotebookCellOutputItem)\[\], output: [NotebookCellOutput](#NotebookCellOutput)): Thenable<void\>

Replace all output items of existing cell output.

| Parameter | Description |
| --- | --- |
| items: [NotebookCellOutputItem](#NotebookCellOutputItem) \| readonly [NotebookCellOutputItem](#NotebookCellOutputItem)\[\] | Output items that replace the items of existing output. |
| output: [NotebookCellOutput](#NotebookCellOutput) | Output object that already exists. |
| Returns | Description |
| Thenable<void\> | A thenable that resolves when the operation finished. |

start(startTime?: number): void

Signal that the execution has begun.

| Parameter | Description |
| --- | --- |
| startTime?: number | The time that execution began, in milliseconds in the Unix epoch. Used to drive the clock that shows for how long a cell has been running. If not given, the clock won't be shown. |
| Returns | Description |
| void |     |

### NotebookCellExecutionSummary

The summary of a notebook cell execution.

#### Properties

executionOrder?: number

The order in which the execution happened.

success?: boolean

If the execution finished successfully.

timing?: {endTime: number, startTime: number}

The times at which execution started and ended, as unix timestamps

| Parameter | Description |
| --- | --- |
| endTime: number | Execution end time. |
| startTime: number | Execution start time. |

### NotebookCellKind

A notebook cell kind.

#### Enumeration Members

Markup: 1

A markup-cell is formatted source that is used for display.

Code: 2

A code-cell is source that can be [executed](#NotebookController) and that produces [output](#NotebookCellOutput).

### NotebookCellOutput

Notebook cell output represents a result of executing a cell. It is a container type for multiple [output items](#NotebookCellOutputItem) where contained items represent the same result but use different MIME types.

#### Constructors

new NotebookCellOutput(items: [NotebookCellOutputItem](#NotebookCellOutputItem)\[\], metadata?: ): [NotebookCellOutput](#NotebookCellOutput)

Create new notebook output.

| Parameter | Description |
| --- | --- |
| items: [NotebookCellOutputItem](#NotebookCellOutputItem)\[\] | Notebook output items. |
| metadata?: | Optional metadata. |
| Returns | Description |
| [NotebookCellOutput](#NotebookCellOutput) |     |

#### Properties

items: [NotebookCellOutputItem](#NotebookCellOutputItem)\[\]

The output items of this output. Each item must represent the same result. _Note_ that repeated MIME types per output is invalid and that the editor will just pick one of them.

```
new vscode.NotebookCellOutput([
  vscode.NotebookCellOutputItem.text('Hello', 'text/plain'),
  vscode.NotebookCellOutputItem.text('<i>Hello</i>', 'text/html'),
  vscode.NotebookCellOutputItem.text('_Hello_', 'text/markdown'),
  vscode.NotebookCellOutputItem.text('Hey', 'text/plain') // INVALID: repeated type, editor will pick just one
]);
```

metadata?:

Arbitrary metadata for this cell output. Can be anything but must be JSON-stringifyable.

### NotebookCellOutputItem

One representation of a [notebook output](#NotebookCellOutput), defined by MIME type and data.

#### Static

error(value: Error): [NotebookCellOutputItem](#NotebookCellOutputItem)

Factory function to create a `NotebookCellOutputItem` that uses uses the `application/vnd.code.notebook.error` mime type.

| Parameter | Description |
| --- | --- |
| value: Error | An error object. |
| Returns | Description |
| [NotebookCellOutputItem](#NotebookCellOutputItem) | A new output item object. |

json(value: any, mime?: string): [NotebookCellOutputItem](#NotebookCellOutputItem)

Factory function to create a `NotebookCellOutputItem` from a JSON object.

_Note_ that this function is not expecting "stringified JSON" but an object that can be stringified. This function will throw an error when the passed value cannot be JSON-stringified.

| Parameter | Description |
| --- | --- |
| value: any | A JSON-stringifyable value. |
| mime?: string | Optional MIME type, defaults to `application/json` |
| Returns | Description |
| [NotebookCellOutputItem](#NotebookCellOutputItem) | A new output item object. |

stderr(value: string): [NotebookCellOutputItem](#NotebookCellOutputItem)

Factory function to create a `NotebookCellOutputItem` that uses uses the `application/vnd.code.notebook.stderr` mime type.

| Parameter | Description |
| --- | --- |
| value: string | A string. |
| Returns | Description |
| [NotebookCellOutputItem](#NotebookCellOutputItem) | A new output item object. |

stdout(value: string): [NotebookCellOutputItem](#NotebookCellOutputItem)

Factory function to create a `NotebookCellOutputItem` that uses uses the `application/vnd.code.notebook.stdout` mime type.

| Parameter | Description |
| --- | --- |
| value: string | A string. |
| Returns | Description |
| [NotebookCellOutputItem](#NotebookCellOutputItem) | A new output item object. |

text(value: string, mime?: string): [NotebookCellOutputItem](#NotebookCellOutputItem)

Factory function to create a `NotebookCellOutputItem` from a string.

_Note_ that an UTF-8 encoder is used to create bytes for the string.

| Parameter | Description |
| --- | --- |
| value: string | A string. |
| mime?: string | Optional MIME type, defaults to `text/plain`. |
| Returns | Description |
| [NotebookCellOutputItem](#NotebookCellOutputItem) | A new output item object. |

#### Constructors

new NotebookCellOutputItem(data: Uint8Array, mime: string): [NotebookCellOutputItem](#NotebookCellOutputItem)

Create a new notebook cell output item.

| Parameter | Description |
| --- | --- |
| data: Uint8Array | The value of the output item. |
| mime: string | The mime type of the output item. |
| Returns | Description |
| [NotebookCellOutputItem](#NotebookCellOutputItem) |     |

#### Properties

data: Uint8Array

The data of this output item. Must always be an array of unsigned 8-bit integers.

mime: string

The mime type which determines how the [data](#NotebookCellOutputItem.data)\-property is interpreted.

Notebooks have built-in support for certain mime-types, extensions can add support for new types and override existing types.

### NotebookCellStatusBarAlignment

Represents the alignment of status bar items.

#### Enumeration Members

Left: 1

Aligned to the left side.

Right: 2

Aligned to the right side.

### NotebookCellStatusBarItem

A contribution to a cell's status bar

#### Constructors

new NotebookCellStatusBarItem(text: string, alignment: [NotebookCellStatusBarAlignment](#NotebookCellStatusBarAlignment)): [NotebookCellStatusBarItem](#NotebookCellStatusBarItem)

Creates a new NotebookCellStatusBarItem.

| Parameter | Description |
| --- | --- |
| text: string | The text to show for the item. |
| alignment: [NotebookCellStatusBarAlignment](#NotebookCellStatusBarAlignment) | Whether the item is aligned to the left or right. |
| Returns | Description |
| [NotebookCellStatusBarItem](#NotebookCellStatusBarItem) |     |

#### Properties

accessibilityInformation?: [AccessibilityInformation](#AccessibilityInformation)

Accessibility information used when a screen reader interacts with this item.

alignment: [NotebookCellStatusBarAlignment](#NotebookCellStatusBarAlignment)

Whether the item is aligned to the left or right.

command?: string | [Command](#Command)

An optional [Command](#Command) or identifier of a command to run on click.

The command must be [known](#commands.getCommands).

Note that if this is a [Command](#Command) object, only the [command](#Command.command) and [arguments](#Command.arguments) are used by the editor.

priority?: number

The priority of the item. A higher value item will be shown more to the left.

text: string

The text to show for the item.

tooltip?: string

A tooltip to show when the item is hovered.

### NotebookCellStatusBarItemProvider

A provider that can contribute items to the status bar that appears below a cell's editor.

#### Events

onDidChangeCellStatusBarItems?: [Event](#Event&lt;T&gt;)<void\>

An optional event to signal that statusbar items have changed. The provide method will be called again.

#### Methods

provideCellStatusBarItems(cell: [NotebookCell](#NotebookCell), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[NotebookCellStatusBarItem](#NotebookCellStatusBarItem) | [NotebookCellStatusBarItem](#NotebookCellStatusBarItem)\[\]>

The provider will be called when the cell scrolls into view, when its content, outputs, language, or metadata change, and when it changes execution state.

| Parameter | Description |
| --- | --- |
| cell: [NotebookCell](#NotebookCell) | The cell for which to return items. |
| token: [CancellationToken](#CancellationToken) | A token triggered if this request should be cancelled. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[NotebookCellStatusBarItem](#NotebookCellStatusBarItem) \| [NotebookCellStatusBarItem](#NotebookCellStatusBarItem)\[\]> | One or more [cell statusbar items](#NotebookCellStatusBarItem) |

### NotebookController

A notebook controller represents an entity that can execute notebook cells. This is often referred to as a kernel.

There can be multiple controllers and the editor will let users choose which controller to use for a certain notebook. The [notebookType](#NotebookController.notebookType)\-property defines for what kind of notebooks a controller is for and the [updateNotebookAffinity](#NotebookController.updateNotebookAffinity)\-function allows controllers to set a preference for specific notebook documents. When a controller has been selected its [onDidChangeSelectedNotebooks](#NotebookController.onDidChangeSelectedNotebooks)\-event fires.

When a cell is being run the editor will invoke the [executeHandler](#NotebookController.executeHandler) and a controller is expected to create and finalize a [notebook cell execution](#NotebookCellExecution). However, controllers are also free to create executions by themselves.

#### Events

onDidChangeSelectedNotebooks: [Event](#Event&lt;T&gt;)<{notebook: [NotebookDocument](#NotebookDocument), selected: boolean}>

An event that fires whenever a controller has been selected or un-selected for a notebook document.

There can be multiple controllers for a notebook and in that case a controllers needs to be _selected_. This is a user gesture and happens either explicitly or implicitly when interacting with a notebook for which a controller was _suggested_. When possible, the editor _suggests_ a controller that is most likely to be _selected_.

_Note_ that controller selection is persisted (by the controllers [id](#NotebookController.id)) and restored as soon as a controller is re-created or as a notebook is [opened](#workspace.onDidOpenNotebookDocument).

#### Properties

description?: string

The human-readable description which is rendered less prominent.

detail?: string

The human-readable detail which is rendered less prominent.

executeHandler: (cells: [NotebookCell](#NotebookCell)\[\], notebook: [NotebookDocument](#NotebookDocument), controller: [NotebookController](#NotebookController)) => void | Thenable<void\>

The execute handler is invoked when the run gestures in the UI are selected, e.g Run Cell, Run All, Run Selection etc. The execute handler is responsible for creating and managing [execution](#NotebookCellExecution)\-objects.

| Parameter | Description |
| --- | --- |
| cells: [NotebookCell](#NotebookCell)\[\] |     |
| notebook: [NotebookDocument](#NotebookDocument) |     |
| controller: [NotebookController](#NotebookController) |     |
| Returns | Description |
| void \| Thenable<void\> |     |

id: string

The identifier of this notebook controller.

_Note_ that controllers are remembered by their identifier and that extensions should use stable identifiers across sessions.

interruptHandler?: (notebook: [NotebookDocument](#NotebookDocument)) => void | Thenable<void\>

Optional interrupt handler.

By default cell execution is canceled via [tokens](#NotebookCellExecution.token). Cancellation tokens require that a controller can keep track of its execution so that it can cancel a specific execution at a later point. Not all scenarios allow for that, eg. REPL-style controllers often work by interrupting whatever is currently running. For those cases the interrupt handler exists - it can be thought of as the equivalent of `SIGINT` or `Control+C` in terminals.

_Note_ that supporting [cancellation tokens](#NotebookCellExecution.token) is preferred and that interrupt handlers should only be used when tokens cannot be supported.

| Parameter | Description |
| --- | --- |
| notebook: [NotebookDocument](#NotebookDocument) |     |
| Returns | Description |
| void \| Thenable<void\> |     |

label: string

The human-readable label of this notebook controller.

notebookType: string

The notebook type this controller is for.

supportedLanguages?: string\[\]

An array of language identifiers that are supported by this controller. Any language identifier from [getLanguages](#languages.getLanguages) is possible. When falsy all languages are supported.

Samples:

```
// support JavaScript and TypeScript
myController.supportedLanguages = ['javascript', 'typescript'];

// support all languages
myController.supportedLanguages = undefined; // falsy
myController.supportedLanguages = []; // falsy
```

supportsExecutionOrder?: boolean

Whether this controller supports execution order so that the editor can render placeholders for them.

#### Methods

createNotebookCellExecution(cell: [NotebookCell](#NotebookCell)): [NotebookCellExecution](#NotebookCellExecution)

Create a cell execution task.

_Note_ that there can only be one execution per cell at a time and that an error is thrown if a cell execution is created while another is still active.

This should be used in response to the [execution handler](#NotebookController.executeHandler) being called or when cell execution has been started else, e.g when a cell was already executing or when cell execution was triggered from another source.

| Parameter | Description |
| --- | --- |
| cell: [NotebookCell](#NotebookCell) | The notebook cell for which to create the execution. |
| Returns | Description |
| [NotebookCellExecution](#NotebookCellExecution) | A notebook cell execution. |

dispose(): void

Dispose and free associated resources.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

updateNotebookAffinity(notebook: [NotebookDocument](#NotebookDocument), affinity: [NotebookControllerAffinity](#NotebookControllerAffinity)): void

A controller can set affinities for specific notebook documents. This allows a controller to be presented more prominent for some notebooks.

| Parameter | Description |
| --- | --- |
| notebook: [NotebookDocument](#NotebookDocument) | The notebook for which a priority is set. |
| affinity: [NotebookControllerAffinity](#NotebookControllerAffinity) | A controller affinity |
| Returns | Description |
| void |     |

### NotebookControllerAffinity

Notebook controller affinity for notebook documents.

_See also_ [NotebookController.updateNotebookAffinity](#NotebookController.updateNotebookAffinity)

#### Enumeration Members

Default: 1

Default affinity.

Preferred: 2

A controller is preferred for a notebook.

### NotebookData

Raw representation of a notebook.

Extensions are responsible for creating [NotebookData](#NotebookData) so that the editor can create a [NotebookDocument](#NotebookDocument).

_See also_ [NotebookSerializer](#NotebookSerializer)

#### Constructors

new NotebookData(cells: [NotebookCellData](#NotebookCellData)\[\]): [NotebookData](#NotebookData)

Create new notebook data.

| Parameter | Description |
| --- | --- |
| cells: [NotebookCellData](#NotebookCellData)\[\] | An array of cell data. |
| Returns | Description |
| [NotebookData](#NotebookData) |     |

#### Properties

cells: [NotebookCellData](#NotebookCellData)\[\]

The cell data of this notebook data.

metadata?:

Arbitrary metadata of notebook data.

### NotebookDocument

Represents a notebook which itself is a sequence of [code or markup cells](#NotebookCell). Notebook documents are created from [notebook data](#NotebookData).

#### Properties

cellCount: number

The number of cells in the notebook.

isClosed: boolean

`true` if the notebook has been closed. A closed notebook isn't synchronized anymore and won't be re-used when the same resource is opened again.

isDirty: boolean

`true` if there are unpersisted changes.

isUntitled: boolean

Is this notebook representing an untitled file which has not been saved yet.

metadata:

Arbitrary metadata for this notebook. Can be anything but must be JSON-stringifyable.

notebookType: string

The type of notebook.

uri: [Uri](#Uri)

The associated uri for this notebook.

_Note_ that most notebooks use the `file`\-scheme, which means they are files on disk. However, **not** all notebooks are saved on disk and therefore the `scheme` must be checked before trying to access the underlying file or siblings on disk.

_See also_ [FileSystemProvider](#FileSystemProvider)

version: number

The version number of this notebook (it will strictly increase after each change, including undo/redo).

#### Methods

cellAt(index: number): [NotebookCell](#NotebookCell)

Return the cell at the specified index. The index will be adjusted to the notebook.

| Parameter | Description |
| --- | --- |
| index: number | The index of the cell to retrieve. |
| Returns | Description |
| [NotebookCell](#NotebookCell) | A [cell](#NotebookCell). |

getCells(range?: [NotebookRange](#NotebookRange)): [NotebookCell](#NotebookCell)\[\]

Get the cells of this notebook. A subset can be retrieved by providing a range. The range will be adjusted to the notebook.

| Parameter | Description |
| --- | --- |
| range?: [NotebookRange](#NotebookRange) | A notebook range. |
| Returns | Description |
| [NotebookCell](#NotebookCell)\[\] | The cells contained by the range or all cells. |

save(): Thenable<boolean\>

Save the document. The saving will be handled by the corresponding [serializer](#NotebookSerializer).

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Thenable<boolean\> | A promise that will resolve to true when the document has been saved. Will return false if the file was not dirty or when save failed. |

### NotebookDocumentCellChange

Describes a change to a notebook cell.

_See also_ [NotebookDocumentChangeEvent](#NotebookDocumentChangeEvent)

#### Properties

cell: [NotebookCell](#NotebookCell)

The affected cell.

document: [TextDocument](#TextDocument)

The document of the cell or `undefined` when it did not change.

_Note_ that you should use the [onDidChangeTextDocument](#workspace.onDidChangeTextDocument)\-event for detailed change information, like what edits have been performed.

executionSummary: [NotebookCellExecutionSummary](#NotebookCellExecutionSummary)

The new execution summary of the cell or `undefined` when it did not change.

metadata:

The new metadata of the cell or `undefined` when it did not change.

outputs: readonly [NotebookCellOutput](#NotebookCellOutput)\[\]

The new outputs of the cell or `undefined` when they did not change.

### NotebookDocumentChangeEvent

An event describing a transactional [notebook](#NotebookDocument) change.

#### Properties

cellChanges: readonly [NotebookDocumentCellChange](#NotebookDocumentCellChange)\[\]

An array of [cell changes](#NotebookDocumentCellChange).

contentChanges: readonly [NotebookDocumentContentChange](#NotebookDocumentContentChange)\[\]

An array of content changes describing added or removed [cells](#NotebookCell).

metadata:

The new metadata of the notebook or `undefined` when it did not change.

notebook: [NotebookDocument](#NotebookDocument)

The affected notebook.

### NotebookDocumentContentChange

Describes a structural change to a notebook document, e.g newly added and removed cells.

_See also_ [NotebookDocumentChangeEvent](#NotebookDocumentChangeEvent)

#### Properties

addedCells: readonly [NotebookCell](#NotebookCell)\[\]

Cells that have been added to the document.

range: [NotebookRange](#NotebookRange)

The range at which cells have been either added or removed.

Note that no cells have been [removed](#NotebookDocumentContentChange.removedCells) when this range is [empty](#NotebookRange.isEmpty).

removedCells: readonly [NotebookCell](#NotebookCell)\[\]

Cells that have been removed from the document.

### NotebookDocumentContentOptions

Notebook content options define what parts of a notebook are persisted. Note

For instance, a notebook serializer can opt-out of saving outputs and in that case the editor doesn't mark a notebooks as [dirty](#NotebookDocument.isDirty) when its output has changed.

#### Properties

transientCellMetadata?:

Controls if a cell metadata property change event will trigger notebook document content change events and if it will be used in the diff editor, defaults to false. If the content provider doesn't persist a metadata property in the file document, it should be set to true.

transientDocumentMetadata?:

Controls if a document metadata property change event will trigger notebook document content change event and if it will be used in the diff editor, defaults to false. If the content provider doesn't persist a metadata property in the file document, it should be set to true.

transientOutputs?: boolean

Controls if output change events will trigger notebook document content change events and if it will be used in the diff editor, defaults to false. If the content provider doesn't persist the outputs in the file document, this should be set to true.

### NotebookDocumentShowOptions

Represents options to configure the behavior of showing a [notebook document](#NotebookDocument) in an [notebook editor](#NotebookEditor).

#### Properties

preserveFocus?: boolean

An optional flag that when `true` will stop the [notebook editor](#NotebookEditor) from taking focus.

preview?: boolean

An optional flag that controls if an [notebook editor](#NotebookEditor)\-tab shows as preview. Preview tabs will be replaced and reused until set to stay - either explicitly or through editing. The default behaviour depends on the `workbench.editor.enablePreview`\-setting.

selections?: readonly [NotebookRange](#NotebookRange)\[\]

An optional selection to apply for the document in the [notebook editor](#NotebookEditor).

viewColumn?: [ViewColumn](#ViewColumn)

An optional view column in which the [notebook editor](#NotebookEditor) should be shown. The default is the [active](#ViewColumn.Active). Columns that do not exist will be created as needed up to the maximum of [ViewColumn.Nine](#ViewColumn.Nine). Use [ViewColumn.Beside](#ViewColumn.Beside) to open the editor to the side of the currently active one.

### NotebookDocumentWillSaveEvent

An event that is fired when a [notebook document](#NotebookDocument) will be saved.

To make modifications to the document before it is being saved, call the [waitUntil](#NotebookDocumentWillSaveEvent.waitUntil)\-function with a thenable that resolves to a [workspace edit](#WorkspaceEdit).

#### Properties

notebook: [NotebookDocument](#NotebookDocument)

The [notebook document](#NotebookDocument) that will be saved.

reason: [TextDocumentSaveReason](#TextDocumentSaveReason)

The reason why save was triggered.

token: [CancellationToken](#CancellationToken)

A cancellation token.

#### Methods

waitUntil(thenable: Thenable<[WorkspaceEdit](#WorkspaceEdit)\>): void

Allows to pause the event loop and to apply [workspace edit](#WorkspaceEdit). Edits of subsequent calls to this function will be applied in order. The edits will be _ignored_ if concurrent modifications of the notebook document happened.

_Note:_ This function can only be called during event dispatch and not in an asynchronous manner:

```
workspace.onWillSaveNotebookDocument(event => {
  // async, will *throw* an error
  setTimeout(() => event.waitUntil(promise));

  // sync, OK
  event.waitUntil(promise);
});
```

| Parameter | Description |
| --- | --- |
| thenable: Thenable<[WorkspaceEdit](#WorkspaceEdit)\> | A thenable that resolves to [workspace edit](#WorkspaceEdit). |
| Returns | Description |
| void |     |

waitUntil(thenable: Thenable<any\>): void

Allows to pause the event loop until the provided thenable resolved.

_Note:_ This function can only be called during event dispatch.

| Parameter | Description |
| --- | --- |
| thenable: Thenable<any\> | A thenable that delays saving. |
| Returns | Description |
| void |     |

### NotebookEdit

A notebook edit represents edits that should be applied to the contents of a notebook.

#### Static

deleteCells(range: [NotebookRange](#NotebookRange)): [NotebookEdit](#NotebookEdit)

Utility to create an edit that deletes cells in a notebook.

| Parameter | Description |
| --- | --- |
| range: [NotebookRange](#NotebookRange) | The range of cells to delete. |
| Returns | Description |
| [NotebookEdit](#NotebookEdit) |     |

insertCells(index: number, newCells: [NotebookCellData](#NotebookCellData)\[\]): [NotebookEdit](#NotebookEdit)

Utility to create an edit that replaces cells in a notebook.

| Parameter | Description |
| --- | --- |
| index: number | The index to insert cells at. |
| newCells: [NotebookCellData](#NotebookCellData)\[\] | The new notebook cells. |
| Returns | Description |
| [NotebookEdit](#NotebookEdit) |     |

replaceCells(range: [NotebookRange](#NotebookRange), newCells: [NotebookCellData](#NotebookCellData)\[\]): [NotebookEdit](#NotebookEdit)

Utility to create a edit that replaces cells in a notebook.

| Parameter | Description |
| --- | --- |
| range: [NotebookRange](#NotebookRange) | The range of cells to replace |
| newCells: [NotebookCellData](#NotebookCellData)\[\] | The new notebook cells. |
| Returns | Description |
| [NotebookEdit](#NotebookEdit) |     |

updateCellMetadata(index: number, newCellMetadata: ): [NotebookEdit](#NotebookEdit)

Utility to create an edit that update a cell's metadata.

| Parameter | Description |
| --- | --- |
| index: number | The index of the cell to update. |
| newCellMetadata: | The new metadata for the cell. |
| Returns | Description |
| [NotebookEdit](#NotebookEdit) |     |

updateNotebookMetadata(newNotebookMetadata: ): [NotebookEdit](#NotebookEdit)

Utility to create an edit that updates the notebook's metadata.

| Parameter | Description |
| --- | --- |
| newNotebookMetadata: | The new metadata for the notebook. |
| Returns | Description |
| [NotebookEdit](#NotebookEdit) |     |

#### Constructors

new NotebookEdit(range: [NotebookRange](#NotebookRange), newCells: [NotebookCellData](#NotebookCellData)\[\]): [NotebookEdit](#NotebookEdit)

Create a new notebook edit.

| Parameter | Description |
| --- | --- |
| range: [NotebookRange](#NotebookRange) | A notebook range. |
| newCells: [NotebookCellData](#NotebookCellData)\[\] | An array of new cell data. |
| Returns | Description |
| [NotebookEdit](#NotebookEdit) |     |

#### Properties

newCellMetadata?:

Optional new metadata for the cells.

newCells: [NotebookCellData](#NotebookCellData)\[\]

New cells being inserted. May be empty.

newNotebookMetadata?:

Optional new metadata for the notebook.

range: [NotebookRange](#NotebookRange)

Range of the cells being edited. May be empty.

### NotebookEditor

Represents a notebook editor that is attached to a [notebook](#NotebookDocument). Additional properties of the NotebookEditor are available in the proposed API, which will be finalized later.

#### Properties

notebook: [NotebookDocument](#NotebookDocument)

The [notebook document](#NotebookDocument) associated with this notebook editor.

selection: [NotebookRange](#NotebookRange)

The primary selection in this notebook editor.

selections: readonly [NotebookRange](#NotebookRange)\[\]

All selections in this notebook editor.

The primary selection (or focused range) is `selections[0]`. When the document has no cells, the primary selection is empty `{ start: 0, end: 0 }`;

viewColumn?: [ViewColumn](#ViewColumn)

The column in which this editor shows.

visibleRanges: readonly [NotebookRange](#NotebookRange)\[\]

The current visible ranges in the editor (vertically).

#### Methods

revealRange(range: [NotebookRange](#NotebookRange), revealType?: [NotebookEditorRevealType](#NotebookEditorRevealType)): void

Scroll as indicated by `revealType` in order to reveal the given range.

| Parameter | Description |
| --- | --- |
| range: [NotebookRange](#NotebookRange) | A range. |
| revealType?: [NotebookEditorRevealType](#NotebookEditorRevealType) | The scrolling strategy for revealing `range`. |
| Returns | Description |
| void |     |

### NotebookEditorRevealType

Represents a notebook editor that is attached to a [notebook](#NotebookDocument).

#### Enumeration Members

Default: 0

The range will be revealed with as little scrolling as possible.

InCenter: 1

The range will always be revealed in the center of the viewport.

InCenterIfOutsideViewport: 2

If the range is outside the viewport, it will be revealed in the center of the viewport. Otherwise, it will be revealed with as little scrolling as possible.

AtTop: 3

The range will always be revealed at the top of the viewport.

### NotebookEditorSelectionChangeEvent

Represents an event describing the change in a [notebook editor's selections](#NotebookEditor.selections).

#### Properties

notebookEditor: [NotebookEditor](#NotebookEditor)

The [notebook editor](#NotebookEditor) for which the selections have changed.

selections: readonly [NotebookRange](#NotebookRange)\[\]

The new value for the [notebook editor's selections](#NotebookEditor.selections).

### NotebookEditorVisibleRangesChangeEvent

Represents an event describing the change in a [notebook editor's visibleRanges](#NotebookEditor.visibleRanges).

#### Properties

notebookEditor: [NotebookEditor](#NotebookEditor)

The [notebook editor](#NotebookEditor) for which the visible ranges have changed.

visibleRanges: readonly [NotebookRange](#NotebookRange)\[\]

The new value for the [notebook editor's visibleRanges](#NotebookEditor.visibleRanges).

### NotebookRange

A notebook range represents an ordered pair of two cell indices. It is guaranteed that start is less than or equal to end.

#### Constructors

new NotebookRange(start: number, end: number): [NotebookRange](#NotebookRange)

Create a new notebook range. If `start` is not before or equal to `end`, the values will be swapped.

| Parameter | Description |
| --- | --- |
| start: number | start index |
| end: number | end index. |
| Returns | Description |
| [NotebookRange](#NotebookRange) |     |

#### Properties

end: number

The exclusive end index of this range (zero-based).

isEmpty: boolean

`true` if `start` and `end` are equal.

start: number

The zero-based start index of this range.

#### Methods

with(change: {end: number, start: number}): [NotebookRange](#NotebookRange)

Derive a new range for this range.

| Parameter | Description |
| --- | --- |
| change: {end: number, start: number} | An object that describes a change to this range. |
| Returns | Description |
| [NotebookRange](#NotebookRange) | A range that reflects the given change. Will return `this` range if the change is not changing anything. |

### NotebookRendererMessaging

Renderer messaging is used to communicate with a single renderer. It's returned from [notebooks.createRendererMessaging](#notebooks.createRendererMessaging).

#### Events

onDidReceiveMessage: [Event](#Event&lt;T&gt;)<{editor: [NotebookEditor](#NotebookEditor), message: any}>

An event that fires when a message is received from a renderer.

#### Methods

postMessage(message: any, editor?: [NotebookEditor](#NotebookEditor)): Thenable<boolean\>

Send a message to one or all renderer.

| Parameter | Description |
| --- | --- |
| message: any | Message to send |
| editor?: [NotebookEditor](#NotebookEditor) | Editor to target with the message. If not provided, the message is sent to all renderers. |
| Returns | Description |
| Thenable<boolean\> | a boolean indicating whether the message was successfully delivered to any renderer. |

### NotebookSerializer

The notebook serializer enables the editor to open notebook files.

At its core the editor only knows a [notebook data structure](#NotebookData) but not how that data structure is written to a file, nor how it is read from a file. The notebook serializer bridges this gap by deserializing bytes into notebook data and vice versa.

#### Methods

deserializeNotebook(content: Uint8Array, token: [CancellationToken](#CancellationToken)): [NotebookData](#NotebookData) | Thenable<[NotebookData](#NotebookData)\>

Deserialize contents of a notebook file into the notebook data structure.

| Parameter | Description |
| --- | --- |
| content: Uint8Array | Contents of a notebook file. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [NotebookData](#NotebookData) \| Thenable<[NotebookData](#NotebookData)\> | Notebook data or a thenable that resolves to such. |

serializeNotebook(data: [NotebookData](#NotebookData), token: [CancellationToken](#CancellationToken)): Uint8Array | Thenable<Uint8Array\>

Serialize notebook data into file contents.

| Parameter | Description |
| --- | --- |
| data: [NotebookData](#NotebookData) | A notebook data structure. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| Uint8Array \| Thenable<Uint8Array\> | An array of bytes or a thenable that resolves to such. |

### OnEnterRule

Describes a rule to be evaluated when pressing Enter.

#### Properties

action: [EnterAction](#EnterAction)

The action to execute.

afterText?: RegExp

This rule will only execute if the text after the cursor matches this regular expression.

beforeText: RegExp

This rule will only execute if the text before the cursor matches this regular expression.

previousLineText?: RegExp

This rule will only execute if the text above the current line matches this regular expression.

### OnTypeFormattingEditProvider

The document formatting provider interface defines the contract between extensions and the formatting-feature.

#### Methods

provideOnTypeFormattingEdits(document: [TextDocument](#TextDocument), position: [Position](#Position), ch: string, options: [FormattingOptions](#FormattingOptions), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[TextEdit](#TextEdit)\[\]>

Provide formatting edits after a character has been typed.

The given position and character should hint to the provider what range the position to expand to, like find the matching `{` when `}` has been entered.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| ch: string | The character that has been typed. |
| options: [FormattingOptions](#FormattingOptions) | Options controlling formatting. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[TextEdit](#TextEdit)\[\]> | A set of text edits or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

### OpenDialogOptions

Options to configure the behavior of a file open dialog.

*   Note 1: On Windows and Linux, a file dialog cannot be both a file selector and a folder selector, so if you set both `canSelectFiles` and `canSelectFolders` to `true` on these platforms, a folder selector will be shown.
*   Note 2: Explicitly setting `canSelectFiles` and `canSelectFolders` to `false` is futile and the editor then silently adjusts the options to select files.

#### Properties

canSelectFiles?: boolean

Allow to select files, defaults to `true`.

canSelectFolders?: boolean

Allow to select folders, defaults to `false`.

canSelectMany?: boolean

Allow to select many files or folders.

defaultUri?: [Uri](#Uri)

The resource the dialog shows when opened.

filters?:

A set of file filters that are used by the dialog. Each entry is a human-readable label, like "TypeScript", and an array of extensions, for example:

```
{
    'Images': ['png', 'jpg'],
    'TypeScript': ['ts', 'tsx']
}
```

openLabel?: string

A human-readable string for the open button.

title?: string

Dialog title.

This parameter might be ignored, as not all operating systems display a title on open dialogs (for example, macOS).

### OutputChannel

An output channel is a container for readonly textual information.

To get an instance of an `OutputChannel` use [createOutputChannel](#window.createOutputChannel).

#### Properties

name: string

The human-readable name of this output channel.

#### Methods

append(value: string): void

Append the given value to the channel.

| Parameter | Description |
| --- | --- |
| value: string | A string, falsy values will not be printed. |
| Returns | Description |
| void |     |

appendLine(value: string): void

Append the given value and a line feed character to the channel.

| Parameter | Description |
| --- | --- |
| value: string | A string, falsy values will be printed. |
| Returns | Description |
| void |     |

clear(): void

Removes all output from the channel.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

dispose(): void

Dispose and free associated resources.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

hide(): void

Hide this channel from the UI.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

replace(value: string): void

Replaces all output from the channel with the given value.

| Parameter | Description |
| --- | --- |
| value: string | A string, falsy values will not be printed. |
| Returns | Description |
| void |     |

show(preserveFocus?: boolean): void

Reveal this channel in the UI.

| Parameter | Description |
| --- | --- |
| preserveFocus?: boolean | When `true` the channel will not take focus. |
| Returns | Description |
| void |     |

show(column?: [ViewColumn](#ViewColumn), preserveFocus?: boolean): void

Reveal this channel in the UI.

*   _deprecated_ - Use the overload with just one parameter (`show(preserveFocus?: boolean): void`).

| Parameter | Description |
| --- | --- |
| column?: [ViewColumn](#ViewColumn) | This argument is **deprecated** and will be ignored. |
| preserveFocus?: boolean | When `true` the channel will not take focus. |
| Returns | Description |
| void |     |

### OverviewRulerLane

Represents different positions for rendering a decoration in an [overview ruler](#DecorationRenderOptions.overviewRulerLane). The overview ruler supports three lanes.

#### Enumeration Members

Left: 1

The left lane of the overview ruler.

Center: 2

The center lane of the overview ruler.

Right: 4

The right lane of the overview ruler.

Full: 7

All lanes of the overview ruler.

### ParameterInformation

Represents a parameter of a callable-signature. A parameter can have a label and a doc-comment.

#### Constructors

new ParameterInformation(label: string | \[number, number\], documentation?: string | [MarkdownString](#MarkdownString)): [ParameterInformation](#ParameterInformation)

Creates a new parameter information object.

| Parameter | Description |
| --- | --- |
| label: string \| \[number, number\] | A label string or inclusive start and exclusive end offsets within its containing signature label. |
| documentation?: string \| [MarkdownString](#MarkdownString) | A doc string. |
| Returns | Description |
| [ParameterInformation](#ParameterInformation) |     |

#### Properties

documentation?: string | [MarkdownString](#MarkdownString)

The human-readable doc-comment of this signature. Will be shown in the UI but can be omitted.

label: string | \[number, number\]

The label of this signature.

Either a string or inclusive start and exclusive end offsets within its containing [signature label](#SignatureInformation.label). _Note_: A label of type string must be a substring of its containing signature information's [label](#SignatureInformation.label).

### Position

Represents a line and character position, such as the position of the cursor.

Position objects are **immutable**. Use the [with](#Position.with) or [translate](#Position.translate) methods to derive new positions from an existing position.

#### Constructors

new Position(line: number, character: number): [Position](#Position)

| Parameter | Description |
| --- | --- |
| line: number | A zero-based line value. |
| character: number | A zero-based character value. |
| Returns | Description |
| [Position](#Position) |     |

#### Properties

character: number

The zero-based character value.

Character offsets are expressed using UTF-16 [code units](https://developer.mozilla.org/en-US/docs/Glossary/Code_unit).

line: number

The zero-based line value.

#### Methods

compareTo(other: [Position](#Position)): number

Compare this to `other`.

| Parameter | Description |
| --- | --- |
| other: [Position](#Position) | A position. |
| Returns | Description |
| number | A number smaller than zero if this position is before the given position, a number greater than zero if this position is after the given position, or zero when this and the given position are equal. |

isAfter(other: [Position](#Position)): boolean

Check if this position is after `other`.

| Parameter | Description |
| --- | --- |
| other: [Position](#Position) | A position. |
| Returns | Description |
| boolean | `true` if position is on a greater line or on the same line on a greater character. |

isAfterOrEqual(other: [Position](#Position)): boolean

Check if this position is after or equal to `other`.

| Parameter | Description |
| --- | --- |
| other: [Position](#Position) | A position. |
| Returns | Description |
| boolean | `true` if position is on a greater line or on the same line on a greater or equal character. |

isBefore(other: [Position](#Position)): boolean

Check if this position is before `other`.

| Parameter | Description |
| --- | --- |
| other: [Position](#Position) | A position. |
| Returns | Description |
| boolean | `true` if position is on a smaller line or on the same line on a smaller character. |

isBeforeOrEqual(other: [Position](#Position)): boolean

Check if this position is before or equal to `other`.

| Parameter | Description |
| --- | --- |
| other: [Position](#Position) | A position. |
| Returns | Description |
| boolean | `true` if position is on a smaller line or on the same line on a smaller or equal character. |

isEqual(other: [Position](#Position)): boolean

Check if this position is equal to `other`.

| Parameter | Description |
| --- | --- |
| other: [Position](#Position) | A position. |
| Returns | Description |
| boolean | `true` if the line and character of the given position are equal to the line and character of this position. |

translate(lineDelta?: number, characterDelta?: number): [Position](#Position)

Create a new position relative to this position.

| Parameter | Description |
| --- | --- |
| lineDelta?: number | Delta value for the line value, default is `0`. |
| characterDelta?: number | Delta value for the character value, default is `0`. |
| Returns | Description |
| [Position](#Position) | A position which line and character is the sum of the current line and character and the corresponding deltas. |

translate(change: {characterDelta: number, lineDelta: number}): [Position](#Position)

Derived a new position relative to this position.

| Parameter | Description |
| --- | --- |
| change: {characterDelta: number, lineDelta: number} | An object that describes a delta to this position. |
| Returns | Description |
| [Position](#Position) | A position that reflects the given delta. Will return `this` position if the change is not changing anything. |

with(line?: number, character?: number): [Position](#Position)

Create a new position derived from this position.

| Parameter | Description |
| --- | --- |
| line?: number | Value that should be used as line value, default is the [existing value](#Position.line) |
| character?: number | Value that should be used as character value, default is the [existing value](#Position.character) |
| Returns | Description |
| [Position](#Position) | A position where line and character are replaced by the given values. |

with(change: {character: number, line: number}): [Position](#Position)

Derived a new position from this position.

| Parameter | Description |
| --- | --- |
| change: {character: number, line: number} | An object that describes a change to this position. |
| Returns | Description |
| [Position](#Position) | A position that reflects the given change. Will return `this` position if the change is not changing anything. |

### PreparedToolInvocation

The result of a call to [LanguageModelTool.prepareInvocation](#LanguageModelTool.prepareInvocation).

#### Properties

confirmationMessages?: [LanguageModelToolConfirmationMessages](#LanguageModelToolConfirmationMessages)

The presence of this property indicates that the user should be asked to confirm before running the tool. The user should be asked for confirmation for any tool that has a side-effect or may potentially be dangerous.

invocationMessage?: string | [MarkdownString](#MarkdownString)

A customized progress message to show while the tool runs.

### PrepareLanguageModelChatModelOptions

The list of options passed into [LanguageModelChatProvider.provideLanguageModelChatInformation](#LanguageModelChatProvider.provideLanguageModelChatInformation)

#### Properties

silent: boolean

Whether or not the user should be prompted via some UI flow, or if models should be attempted to be resolved silently. If silent is true, all models may not be resolved due to lack of info such as API keys.

### ProcessExecution

The execution of a task happens as an external process without shell interaction.

#### Constructors

new ProcessExecution(process: string, options?: [ProcessExecutionOptions](#ProcessExecutionOptions)): [ProcessExecution](#ProcessExecution)

Creates a process execution.

| Parameter | Description |
| --- | --- |
| process: string | The process to start. |
| options?: [ProcessExecutionOptions](#ProcessExecutionOptions) | Optional options for the started process. |
| Returns | Description |
| [ProcessExecution](#ProcessExecution) |     |

new ProcessExecution(process: string, args: string\[\], options?: [ProcessExecutionOptions](#ProcessExecutionOptions)): [ProcessExecution](#ProcessExecution)

Creates a process execution.

| Parameter | Description |
| --- | --- |
| process: string | The process to start. |
| args: string\[\] | Arguments to be passed to the process. |
| options?: [ProcessExecutionOptions](#ProcessExecutionOptions) | Optional options for the started process. |
| Returns | Description |
| [ProcessExecution](#ProcessExecution) |     |

#### Properties

args: string\[\]

The arguments passed to the process. Defaults to an empty array.

options?: [ProcessExecutionOptions](#ProcessExecutionOptions)

The process options used when the process is executed. Defaults to undefined.

process: string

The process to be executed.

### ProcessExecutionOptions

Options for a process execution

#### Properties

cwd?: string

The current working directory of the executed program or shell. If omitted the tools current workspace root is used.

env?:

The additional environment of the executed program or shell. If omitted the parent process' environment is used. If provided it is merged with the parent process' environment.

### Progress<T>

Defines a generalized way of reporting progress updates.

#### Methods

report(value: T): void

Report a progress update.

| Parameter | Description |
| --- | --- |
| value: T | A progress item, like a message and/or an report on how much work finished |
| Returns | Description |
| void |     |

### ProgressLocation

A location in the editor at which progress information can be shown. It depends on the location how progress is visually represented.

#### Enumeration Members

SourceControl: 1

Show progress for the source control viewlet, as overlay for the icon and as progress bar inside the viewlet (when visible). Neither supports cancellation nor discrete progress nor a label to describe the operation.

Window: 10

Show progress in the status bar of the editor. Neither supports cancellation nor discrete progress. Supports rendering of [theme icons](#ThemeIcon) via the `$(<name>)`\-syntax in the progress label.

Notification: 15

Show progress as notification with an optional cancel button. Supports to show infinite and discrete progress but does not support rendering of icons.

### ProgressOptions

Value-object describing where and how progress should show.

#### Properties

cancellable?: boolean

Controls if a cancel button should show to allow the user to cancel the long running operation. Note that currently only `ProgressLocation.Notification` is supporting to show a cancel button.

location: [ProgressLocation](#ProgressLocation) | {viewId: string}

The location at which progress should show.

title?: string

A human-readable string which will be used to describe the operation.

### ProvideLanguageModelChatResponseOptions

The provider version of [LanguageModelChatRequestOptions](#LanguageModelChatRequestOptions)

#### Properties

modelOptions?:

A set of options that control the behavior of the language model. These options are specific to the language model.

toolMode: [LanguageModelChatToolMode](#LanguageModelChatToolMode)

The tool-selecting mode to use. The provider must implement respecting this.

tools?: readonly [LanguageModelChatTool](#LanguageModelChatTool)\[\]

An optional list of tools that are available to the language model. These could be registered tools available via [lm.tools](#lm.tools), or private tools that are just implemented within the calling extension.

If the LLM requests to call one of these tools, it will return a [LanguageModelToolCallPart](#LanguageModelToolCallPart) in [LanguageModelChatResponse.stream](#LanguageModelChatResponse.stream). It's the caller's responsibility to invoke the tool. If it's a tool registered in [lm.tools](#lm.tools), that means calling [lm.invokeTool](#lm.invokeTool).

Then, the tool result can be provided to the LLM by creating an Assistant-type [LanguageModelChatMessage](#LanguageModelChatMessage) with a [LanguageModelToolCallPart](#LanguageModelToolCallPart), followed by a User-type message with a [LanguageModelToolResultPart](#LanguageModelToolResultPart).

### ProviderResult<T>

A provider result represents the values a provider, like the [HoverProvider](#HoverProvider), may return. For once this is the actual result type `T`, like `Hover`, or a thenable that resolves to that type `T`. In addition, `null` and `undefined` can be returned - either directly or from a thenable.

The snippets below are all valid implementations of the [HoverProvider](#HoverProvider):

```
let a: HoverProvider = {
  provideHover(doc, pos, token): ProviderResult<Hover> {
    return new Hover('Hello World');
  }
};

let b: HoverProvider = {
  provideHover(doc, pos, token): ProviderResult<Hover> {
    return new Promise(resolve => {
      resolve(new Hover('Hello World'));
    });
  }
};

let c: HoverProvider = {
  provideHover(doc, pos, token): ProviderResult<Hover> {
    return; // undefined
  }
};
```

ProviderResult: T | undefined | null | Thenable<T | undefined | null\>

### Pseudoterminal

Defines the interface of a terminal pty, enabling extensions to control a terminal.

#### Events

onDidChangeName?: [Event](#Event&lt;T&gt;)<string\>

An event that when fired allows changing the name of the terminal.

Events fired before [Pseudoterminal.open](#Pseudoterminal.open) is called will be be ignored.

**Example:** Change the terminal name to "My new terminal".

```
const writeEmitter = new vscode.EventEmitter<string>();
const changeNameEmitter = new vscode.EventEmitter<string>();
const pty: vscode.Pseudoterminal = {
  onDidWrite: writeEmitter.event,
  onDidChangeName: changeNameEmitter.event,
  open: () => changeNameEmitter.fire('My new terminal'),
  close: () => {}
};
vscode.window.createTerminal({ name: 'My terminal', pty });
```

onDidClose?: [Event](#Event&lt;T&gt;)<number | void\>

An event that when fired will signal that the pty is closed and dispose of the terminal.

Events fired before [Pseudoterminal.open](#Pseudoterminal.open) is called will be be ignored.

A number can be used to provide an exit code for the terminal. Exit codes must be positive and a non-zero exit codes signals failure which shows a notification for a regular terminal and allows dependent tasks to proceed when used with the `CustomExecution` API.

**Example:** Exit the terminal when "y" is pressed, otherwise show a notification.

```
const writeEmitter = new vscode.EventEmitter<string>();
const closeEmitter = new vscode.EventEmitter<void>();
const pty: vscode.Pseudoterminal = {
  onDidWrite: writeEmitter.event,
  onDidClose: closeEmitter.event,
  open: () => writeEmitter.fire('Press y to exit successfully'),
  close: () => {},
  handleInput: data => {
    if (data !== 'y') {
      vscode.window.showInformationMessage('Something went wrong');
    }
    closeEmitter.fire();
  }
};
const terminal = vscode.window.createTerminal({ name: 'Exit example', pty });
terminal.show(true);
```

onDidOverrideDimensions?: [Event](#Event&lt;T&gt;)<[TerminalDimensions](#TerminalDimensions)\>

An event that when fired allows overriding the [dimensions](#Pseudoterminal.setDimensions) of the terminal. Note that when set, the overridden dimensions will only take effect when they are lower than the actual dimensions of the terminal (ie. there will never be a scroll bar). Set to `undefined` for the terminal to go back to the regular dimensions (fit to the size of the panel).

Events fired before [Pseudoterminal.open](#Pseudoterminal.open) is called will be be ignored.

**Example:** Override the dimensions of a terminal to 20 columns and 10 rows

```
const dimensionsEmitter = new vscode.EventEmitter<vscode.TerminalDimensions>();
const pty: vscode.Pseudoterminal = {
  onDidWrite: writeEmitter.event,
  onDidOverrideDimensions: dimensionsEmitter.event,
  open: () => {
    dimensionsEmitter.fire({
      columns: 20,
      rows: 10
    });
  },
  close: () => {}
};
vscode.window.createTerminal({ name: 'My terminal', pty });
```

onDidWrite: [Event](#Event&lt;T&gt;)<string\>

An event that when fired will write data to the terminal. Unlike [Terminal.sendText](#Terminal.sendText) which sends text to the underlying child pseudo-device (the child), this will write the text to parent pseudo-device (the _terminal_ itself).

Note writing `\n` will just move the cursor down 1 row, you need to write `\r` as well to move the cursor to the left-most cell.

Events fired before [Pseudoterminal.open](#Pseudoterminal.open) is called will be be ignored.

**Example:** Write red text to the terminal

```
const writeEmitter = new vscode.EventEmitter<string>();
const pty: vscode.Pseudoterminal = {
  onDidWrite: writeEmitter.event,
  open: () => writeEmitter.fire('\x1b[31mHello world\x1b[0m'),
  close: () => {}
};
vscode.window.createTerminal({ name: 'My terminal', pty });
```

**Example:** Move the cursor to the 10th row and 20th column and write an asterisk

```
writeEmitter.fire('\x1b[10;20H*');
```

#### Methods

close(): void

Implement to handle when the terminal is closed by an act of the user.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

handleInput(data: string): void

Implement to handle incoming keystrokes in the terminal or when an extension calls [Terminal.sendText](#Terminal.sendText). `data` contains the keystrokes/text serialized into their corresponding VT sequence representation.

| Parameter | Description |
| --- | --- |
| data: string | The incoming data.<br><br>**Example:** Echo input in the terminal. The sequence for enter (`\r`) is translated to CRLF to go to a new line and move the cursor to the start of the line.<br><br>```<br>const writeEmitter = new vscode.EventEmitter<string>();<br>const pty: vscode.Pseudoterminal = {<br>  onDidWrite: writeEmitter.event,<br>  open: () => {},<br>  close: () => {},<br>  handleInput: data => writeEmitter.fire(data === '\r' ? '\r\n' : data)<br>};<br>vscode.window.createTerminal({ name: 'Local echo', pty });<br>``` |
| Returns | Description |
| void |     |

open(initialDimensions: [TerminalDimensions](#TerminalDimensions)): void

Implement to handle when the pty is open and ready to start firing events.

| Parameter | Description |
| --- | --- |
| initialDimensions: [TerminalDimensions](#TerminalDimensions) | The dimensions of the terminal, this will be undefined if the terminal panel has not been opened before this is called. |
| Returns | Description |
| void |     |

setDimensions(dimensions: [TerminalDimensions](#TerminalDimensions)): void

Implement to handle when the number of rows and columns that fit into the terminal panel changes, for example when font size changes or when the panel is resized. The initial state of a terminal's dimensions should be treated as `undefined` until this is triggered as the size of a terminal isn't known until it shows up in the user interface.

When dimensions are overridden by [onDidOverrideDimensions](#Pseudoterminal.onDidOverrideDimensions), `setDimensions` will continue to be called with the regular panel dimensions, allowing the extension continue to react dimension changes.

| Parameter | Description |
| --- | --- |
| dimensions: [TerminalDimensions](#TerminalDimensions) | The new dimensions. |
| Returns | Description |
| void |     |

### QuickDiffProvider

A quick diff provider provides a [uri](#Uri) to the original state of a modified resource. The editor will use this information to render ad'hoc diffs within the text.

#### Methods

provideOriginalResource(uri: [Uri](#Uri), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[Uri](#Uri)\>

Provide a [Uri](#Uri) to the original resource of any given resource uri.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the resource open in a text editor. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[Uri](#Uri)\> | A thenable that resolves to uri of the matching original resource. |

### QuickInput

The base interface for all quick input types.

Quick input provides a unified way for extensions to interact with users through simple UI elements. A quick input UI is initially not visible. After configuring it through its properties the extension can make it visible by calling [show](#QuickInput.show).

There are several reasons why this UI might have to be hidden and the extension will be notified through [onDidHide](#QuickInput.onDidHide). Examples include: an explicit call to [hide](#QuickInput.hide), the user pressing Esc, some other input UI opening, etc.

A user pressing Enter or some other gesture implying acceptance of the current state does not automatically hide this UI component. It is up to the extension to decide whether to accept the user's input and if the UI should indeed be hidden through a call to [hide](#QuickInput.hide).

When the extension no longer needs this input UI, it should [dispose](#QuickInput.dispose) it to allow for freeing up any resources associated with it.

See [QuickPick](#QuickPick) and [InputBox](#InputBox) for concrete UIs.

#### Events

onDidHide: [Event](#Event&lt;T&gt;)<void\>

An event signaling when this input UI is hidden.

There are several reasons why this UI might have to be hidden and the extension will be notified through [onDidHide](#QuickInput.onDidHide). Examples include: an explicit call to [hide](#QuickInput.hide), the user pressing Esc, some other input UI opening, etc.

#### Properties

busy: boolean

Determines if the UI should show a progress indicator. Defaults to `false`.

Change this to `true`, for example, while loading more data or validating user input.

enabled: boolean

Determines if the UI should allow for user input. Defaults to `true`.

Change this to `false`, for example, while validating user input or loading data for the next step in user input.

ignoreFocusOut: boolean

Determines if the UI should stay open even when losing UI focus. Defaults to `false`. This setting is ignored on iPad and is always `false`.

step: number

An optional current step count for multi-step input flows.

title: string

An optional title for the input UI.

totalSteps: number

An optional total step count for multi-step input flows.

#### Methods

dispose(): void

Dispose of this input UI and any associated resources.

If it is still visible, it is first hidden. After this call the input UI is no longer functional and no additional methods or properties on it should be accessed. Instead a new input UI should be created.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

hide(): void

Hides this input UI.

This will also fire an [onDidHide](#QuickInput.onDidHide) event.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

show(): void

Makes the input UI visible in its current configuration.

Any other input UI will first fire an [onDidHide](#QuickInput.onDidHide) event.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### QuickInputButton

A button for an action in a [QuickPick](#QuickPick) or [InputBox](#InputBox).

#### Properties

iconPath: [IconPath](#IconPath)

The icon for the button.

location?: [QuickInputButtonLocation](#QuickInputButtonLocation)

The location where the button should be rendered.

Defaults to [QuickInputButtonLocation.Title](#QuickInputButtonLocation.Title).

**Note:** This property is ignored if the button was added to a [QuickPickItem](#QuickPickItem).

toggle?: {checked: boolean}

When present, indicates that the button is a toggle button that can be checked or unchecked.

| Parameter | Description |
| --- | --- |
| checked: boolean | Indicates whether the toggle button is currently checked. This property will be updated when the button is toggled. |

tooltip?: string

An optional tooltip displayed when hovering over the button.

### QuickInputButtonLocation

Specifies the location where a [QuickInputButton](#QuickInputButton) should be rendered.

#### Enumeration Members

Title: 1

The button is rendered in the title bar.

Inline: 2

The button is rendered inline to the right of the input box.

Input: 3

The button is rendered at the far end inside the input box.

### QuickInputButtons

Predefined buttons for [QuickPick](#QuickPick) and [InputBox](#InputBox).

#### Static

Back: [QuickInputButton](#QuickInputButton)

A predefined back button for [QuickPick](#QuickPick) and [InputBox](#InputBox).

This button should be used for consistency when a navigation back button is needed. It comes with a predefined icon, tooltip, and location.

### QuickPick<T>

A concrete [QuickInput](#QuickInput) to let the user pick an item from a list of items of type `T`.

The items can be filtered through a filter text field and there is an option [canSelectMany](#QuickPick.canSelectMany) to allow for selecting multiple items.

Note that in many cases the more convenient [window.showQuickPick](#window.showQuickPick) is easier to use. [window.createQuickPick](#window.createQuickPick) should be used when [window.showQuickPick](#window.showQuickPick) does not offer the required flexibility.

#### Events

onDidAccept: [Event](#Event&lt;T&gt;)<void\>

An event signaling when the user indicated acceptance of the selected item(s).

onDidChangeActive: [Event](#Event&lt;T&gt;)<readonly T\[\]>

An event signaling when the active items have changed.

onDidChangeSelection: [Event](#Event&lt;T&gt;)<readonly T\[\]>

An event signaling when the selected items have changed.

onDidChangeValue: [Event](#Event&lt;T&gt;)<string\>

An event signaling when the value of the filter text has changed.

onDidHide: [Event](#Event&lt;T&gt;)<void\>

An event signaling when this input UI is hidden.

There are several reasons why this UI might have to be hidden and the extension will be notified through [onDidHide](#QuickInput.onDidHide). Examples include: an explicit call to [hide](#QuickInput.hide), the user pressing Esc, some other input UI opening, etc.

onDidTriggerButton: [Event](#Event&lt;T&gt;)<[QuickInputButton](#QuickInputButton)\>

An event signaling when a button was triggered.

This event fires for buttons stored in the [buttons](#QuickPick.buttons) array. This event does not fire for buttons on a [QuickPickItem](#QuickPickItem).

onDidTriggerItemButton: [Event](#Event&lt;T&gt;)<[QuickPickItemButtonEvent](#QuickPickItemButtonEvent&lt;T&gt;)<T\>>

An event signaling when a button in a particular [QuickPickItem](#QuickPickItem) was triggered.

This event does not fire for buttons in the title bar which are part of [buttons](#QuickPick.buttons).

#### Properties

activeItems: readonly T\[\]

Active items. This can be read and updated by the extension.

busy: boolean

Determines if the UI should show a progress indicator. Defaults to `false`.

Change this to `true`, for example, while loading more data or validating user input.

buttons: readonly [QuickInputButton](#QuickInputButton)\[\]

Buttons for actions in the UI.

canSelectMany: boolean

Determines if multiple items can be selected at the same time. Defaults to `false`.

enabled: boolean

Determines if the UI should allow for user input. Defaults to `true`.

Change this to `false`, for example, while validating user input or loading data for the next step in user input.

ignoreFocusOut: boolean

Determines if the UI should stay open even when losing UI focus. Defaults to `false`. This setting is ignored on iPad and is always `false`.

items: readonly T\[\]

Items to pick from. This can be read and updated by the extension.

keepScrollPosition?: boolean

Determines if the scroll position is maintained when the quick pick items are updated. Defaults to `false`.

matchOnDescription: boolean

Determines if the filter text should also be matched against the [description](#QuickPickItem.description) of the items. Defaults to `false`.

matchOnDetail: boolean

Determines if the filter text should also be matched against the [detail](#QuickPickItem.detail) of the items. Defaults to `false`.

placeholder: string

Optional placeholder text displayed in the filter text box when no value has been entered.

prompt: string

Optional text that provides instructions or context to the user.

The prompt is displayed below the input box and above the list of items.

selectedItems: readonly T\[\]

Selected items. This can be read and updated by the extension.

step: number

An optional current step count for multi-step input flows.

title: string

An optional title for the input UI.

totalSteps: number

An optional total step count for multi-step input flows.

value: string

The current value of the filter text.

#### Methods

dispose(): void

Dispose of this input UI and any associated resources.

If it is still visible, it is first hidden. After this call the input UI is no longer functional and no additional methods or properties on it should be accessed. Instead a new input UI should be created.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

hide(): void

Hides this input UI.

This will also fire an [onDidHide](#QuickInput.onDidHide) event.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

show(): void

Makes the input UI visible in its current configuration.

Any other input UI will first fire an [onDidHide](#QuickInput.onDidHide) event.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### QuickPickItem

Represents an item that can be selected from a list of items.

#### Properties

alwaysShow?: boolean

Determines if this item is always shown, even when filtered out by the user's input.

**Note:** This property is ignored when [kind](#QuickPickItem.kind) is set to [QuickPickItemKind.Separator](#QuickPickItemKind.Separator).

buttons?: readonly [QuickInputButton](#QuickInputButton)\[\]

Optional buttons that will be rendered on this particular item.

These buttons will trigger an [QuickPickItemButtonEvent](#QuickPickItemButtonEvent) when pressed. Buttons are only rendered when using a quick pick created by the [createQuickPick](#window.createQuickPick) API. Buttons are not rendered when using the [showQuickPick](#window.showQuickPick) API.

**Note:** This property is ignored when [kind](#QuickPickItem.kind) is set to [QuickPickItemKind.Separator](#QuickPickItemKind.Separator).

description?: string

A human-readable string which is rendered less prominently in the same line.

Supports rendering of [theme icons](#ThemeIcon) via the `$(<name>)`\-syntax.

**Note:** This property is ignored when [kind](#QuickPickItem.kind) is set to [QuickPickItemKind.Separator](#QuickPickItemKind.Separator).

detail?: string

A human-readable string which is rendered less prominently in a separate line.

Supports rendering of [theme icons](#ThemeIcon) via the `$(<name>)`\-syntax.

**Note:** This property is ignored when [kind](#QuickPickItem.kind) is set to [QuickPickItemKind.Separator](#QuickPickItemKind.Separator).

iconPath?: [IconPath](#IconPath)

The icon for the item.

kind?: [QuickPickItemKind](#QuickPickItemKind)

The kind of this item that determines how it is rendered in the quick pick.

When not specified, the default is [QuickPickItemKind.Default](#QuickPickItemKind.Default).

label: string

A human-readable string which is rendered prominently.

Supports rendering of [theme icons](#ThemeIcon) via the `$(<name>)`\-syntax.

**Note:** When [kind](#QuickPickItem.kind) is set to [QuickPickItemKind.Default](#QuickPickItemKind.Default) (so a regular item instead of a separator), it supports rendering of [theme icons](#ThemeIcon) via the `$(<name>)`\-syntax.

picked?: boolean

Optional flag indicating if this item is initially selected.

This is only honored when using the [showQuickPick](#window.showQuickPick) API. To do the same thing with the [createQuickPick](#window.createQuickPick) API, simply set the [selectedItems](#QuickPick.selectedItems) to the items you want selected initially.

**Note:** This is only honored when the picker allows multiple selections.

_See also_ [QuickPickOptions.canPickMany](#QuickPickOptions.canPickMany)

**Note:** This property is ignored when [kind](#QuickPickItem.kind) is set to [QuickPickItemKind.Separator](#QuickPickItemKind.Separator).

resourceUri?: [Uri](#Uri)

A [Uri](#Uri) representing the resource associated with this item.

When set, this property is used to automatically derive several item properties if they are not explicitly provided:

*   **Label**: Derived from the resource's file name when [label](#QuickPickItem.label) is not provided or is empty.
*   **Description**: Derived from the resource's path when [description](#QuickPickItem.description) is not provided or is empty.
*   **Icon**: Derived from the current file icon theme when [iconPath](#QuickPickItem.iconPath) is set to [ThemeIcon.File](#ThemeIcon.File) or [ThemeIcon.Folder](#ThemeIcon.Folder).

### QuickPickItemButtonEvent<T>

An event describing a button that was pressed on a [QuickPickItem](#QuickPickItem).

#### Properties

button: [QuickInputButton](#QuickInputButton)

The button that was pressed.

item: T

The item that the button belongs to.

### QuickPickItemKind

Defines the kind of [quick pick item](#QuickPickItem).

#### Enumeration Members

Separator: \-1

A separator item that provides a visual grouping.

When a [QuickPickItem](#QuickPickItem) has a kind of [Separator](#QuickPickItemKind.Separator), the item is just a visual separator and does not represent a selectable item. The only property that applies is [label](#QuickPickItem.label). All other properties on [QuickPickItem](#QuickPickItem) will be ignored and have no effect.

Default: 0

The default kind for an item that can be selected in the quick pick.

### QuickPickOptions

Options to configure the behavior of the quick pick UI.

#### Events

onDidSelectItem(item: string | [QuickPickItem](#QuickPickItem)): any

An optional function that is invoked whenever an item is selected.

| Parameter | Description |
| --- | --- |
| item: string \| [QuickPickItem](#QuickPickItem) |     |
| Returns | Description |
| any |     |

#### Properties

canPickMany?: boolean

Determines if the picker allows multiple selections. When `true`, the result is an array of picks.

ignoreFocusOut?: boolean

Set to `true` to keep the picker open when focus moves to another part of the editor or to another window. This setting is ignored on iPad and is always `false`.

matchOnDescription?: boolean

Determines if the [description](#QuickPickItem.description) should be included when filtering items. Defaults to `false`.

matchOnDetail?: boolean

Determines if the [detail](#QuickPickItem.detail) should be included when filtering items. Defaults to `false`.

placeHolder?: string

An optional string to show as placeholder in the input box to guide the user.

prompt?: string

Optional text that provides instructions or context to the user.

The prompt is displayed below the input box and above the list of items.

title?: string

An optional title for the quick pick.

### Range

A range represents an ordered pair of two positions. It is guaranteed that [start](#Range.start).isBeforeOrEqual([end](#Range.end))

Range objects are **immutable**. Use the [with](#Range.with), [intersection](#Range.intersection), or [union](#Range.union) methods to derive new ranges from an existing range.

#### Constructors

new Range(start: [Position](#Position), end: [Position](#Position)): [Range](#Range)

Create a new range from two positions. If `start` is not before or equal to `end`, the values will be swapped.

| Parameter | Description |
| --- | --- |
| start: [Position](#Position) | A position. |
| end: [Position](#Position) | A position. |
| Returns | Description |
| [Range](#Range) |     |

new Range(startLine: number, startCharacter: number, endLine: number, endCharacter: number): [Range](#Range)

Create a new range from number coordinates. It is a shorter equivalent of using `new Range(new Position(startLine, startCharacter), new Position(endLine, endCharacter))`

| Parameter | Description |
| --- | --- |
| startLine: number | A zero-based line value. |
| startCharacter: number | A zero-based character value. |
| endLine: number | A zero-based line value. |
| endCharacter: number | A zero-based character value. |
| Returns | Description |
| [Range](#Range) |     |

#### Properties

end: [Position](#Position)

The end position. It is after or equal to [start](#Range.start).

isEmpty: boolean

`true` if `start` and `end` are equal.

isSingleLine: boolean

`true` if `start.line` and `end.line` are equal.

start: [Position](#Position)

The start position. It is before or equal to [end](#Range.end).

#### Methods

contains(positionOrRange: [Range](#Range) | [Position](#Position)): boolean

Check if a position or a range is contained in this range.

| Parameter | Description |
| --- | --- |
| positionOrRange: [Range](#Range) \| [Position](#Position) | A position or a range. |
| Returns | Description |
| boolean | `true` if the position or range is inside or equal to this range. |

intersection(range: [Range](#Range)): [Range](#Range)

Intersect `range` with this range and returns a new range or `undefined` if the ranges have no overlap.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | A range. |
| Returns | Description |
| [Range](#Range) | A range of the greater start and smaller end positions. Will return undefined when there is no overlap. |

isEqual(other: [Range](#Range)): boolean

Check if `other` equals this range.

| Parameter | Description |
| --- | --- |
| other: [Range](#Range) | A range. |
| Returns | Description |
| boolean | `true` when start and end are [equal](#Position.isEqual) to start and end of this range. |

union(other: [Range](#Range)): [Range](#Range)

Compute the union of `other` with this range.

| Parameter | Description |
| --- | --- |
| other: [Range](#Range) | A range. |
| Returns | Description |
| [Range](#Range) | A range of smaller start position and the greater end position. |

with(start?: [Position](#Position), end?: [Position](#Position)): [Range](#Range)

Derived a new range from this range.

| Parameter | Description |
| --- | --- |
| start?: [Position](#Position) | A position that should be used as start. The default value is the [current start](#Range.start). |
| end?: [Position](#Position) | A position that should be used as end. The default value is the [current end](#Range.end). |
| Returns | Description |
| [Range](#Range) | A range derived from this range with the given start and end position. If start and end are not different `this` range will be returned. |

with(change: {end: [Position](#Position), start: [Position](#Position)}): [Range](#Range)

Derived a new range from this range.

| Parameter | Description |
| --- | --- |
| change: {end: [Position](#Position), start: [Position](#Position)} | An object that describes a change to this range. |
| Returns | Description |
| [Range](#Range) | A range that reflects the given change. Will return `this` range if the change is not changing anything. |

### ReferenceContext

Value-object that contains additional information when requesting references.

#### Properties

includeDeclaration: boolean

Include the declaration of the current symbol.

### ReferenceProvider

The reference provider interface defines the contract between extensions and the [find references](https://code.visualstudio.com/docs/editor/editingevolved#_peek)\-feature.

#### Methods

provideReferences(document: [TextDocument](#TextDocument), position: [Position](#Position), context: [ReferenceContext](#ReferenceContext), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[Location](#Location)\[\]>

Provide a set of project-wide references for the given position and document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| context: [ReferenceContext](#ReferenceContext) | Additional information about the references request. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[Location](#Location)\[\]> | An array of locations or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

### RelativePattern

A relative pattern is a helper to construct glob patterns that are matched relatively to a base file path. The base path can either be an absolute file path as string or uri or a [workspace folder](#WorkspaceFolder), which is the preferred way of creating the relative pattern.

#### Constructors

new RelativePattern(base: string | [Uri](#Uri) | [WorkspaceFolder](#WorkspaceFolder), pattern: string): [RelativePattern](#RelativePattern)

Creates a new relative pattern object with a base file path and pattern to match. This pattern will be matched on file paths relative to the base.

Example:

```
const folder = vscode.workspace.workspaceFolders?.[0];
if (folder) {
  // Match any TypeScript file in the root of this workspace folder
  const pattern1 = new vscode.RelativePattern(folder, '*.ts');

  // Match any TypeScript file in `someFolder` inside this workspace folder
  const pattern2 = new vscode.RelativePattern(folder, 'someFolder/*.ts');
}
```

| Parameter | Description |
| --- | --- |
| base: string \| [Uri](#Uri) \| [WorkspaceFolder](#WorkspaceFolder) | A base to which this pattern will be matched against relatively. It is recommended to pass in a [workspace folder](#WorkspaceFolder) if the pattern should match inside the workspace. Otherwise, a uri or string should only be used if the pattern is for a file path outside the workspace. |
| pattern: string | A file glob pattern like `*.{ts,js}` that will be matched on paths relative to the base. |
| Returns | Description |
| [RelativePattern](#RelativePattern) |     |

#### Properties

base: string

A base file path to which this pattern will be matched against relatively.

This matches the `fsPath` value of [RelativePattern.baseUri](#RelativePattern.baseUri).

_Note:_ updating this value will update [RelativePattern.baseUri](#RelativePattern.baseUri) to be a uri with `file` scheme.

*   _deprecated_ - This property is deprecated, please use [RelativePattern.baseUri](#RelativePattern.baseUri) instead.

baseUri: [Uri](#Uri)

A base file path to which this pattern will be matched against relatively. The file path must be absolute, should not have any trailing path separators and not include any relative segments (`.` or `..`).

pattern: string

A file glob pattern like `*.{ts,js}` that will be matched on file paths relative to the base path.

Example: Given a base of `/home/work/folder` and a file path of `/home/work/folder/index.js`, the file glob pattern will match on `index.js`.

### RenameProvider

The rename provider interface defines the contract between extensions and the [rename](https://code.visualstudio.com/docs/editor/editingevolved#_rename-symbol)\-feature.

#### Methods

prepareRename(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[Range](#Range) | {placeholder: string, range: [Range](#Range)}>

Optional function for resolving and validating a position _before_ running rename. The result can be a range or a range and a placeholder text. The placeholder text should be the identifier of the symbol which is being renamed - when omitted the text in the returned range is used.

_Note:_ This function should throw an error or return a rejected thenable when the provided location doesn't allow for a rename.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which rename will be invoked. |
| position: [Position](#Position) | The position at which rename will be invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[Range](#Range) \| {placeholder: string, range: [Range](#Range)}> | The range or range and placeholder text of the identifier that is to be renamed. The lack of a result can signaled by returning `undefined` or `null`. |

provideRenameEdits(document: [TextDocument](#TextDocument), position: [Position](#Position), newName: string, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[WorkspaceEdit](#WorkspaceEdit)\>

Provide an edit that describes changes that have to be made to one or many resources to rename a symbol to a different name.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| newName: string | The new name of the symbol. If the given name is not valid, the provider must return a rejected promise. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[WorkspaceEdit](#WorkspaceEdit)\> | A workspace edit or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### RunOptions

Run options for a task.

#### Properties

reevaluateOnRerun?: boolean

Controls whether task variables are re-evaluated on rerun.

### SaveDialogOptions

Options to configure the behaviour of a file save dialog.

#### Properties

defaultUri?: [Uri](#Uri)

The resource the dialog shows when opened.

filters?:

A set of file filters that are used by the dialog. Each entry is a human-readable label, like "TypeScript", and an array of extensions, for example:

```
{
    'Images': ['png', 'jpg'],
    'TypeScript': ['ts', 'tsx']
}
```

saveLabel?: string

A human-readable string for the save button.

title?: string

Dialog title.

This parameter might be ignored, as not all operating systems display a title on save dialogs (for example, macOS).

### SecretStorage

Represents a storage utility for secrets (or any information that is sensitive) that will be stored encrypted. The implementation of the secret storage will be different on each platform and the secrets will not be synced across machines.

#### Events

onDidChange: [Event](#Event&lt;T&gt;)<[SecretStorageChangeEvent](#SecretStorageChangeEvent)\>

Fires when a secret is stored or deleted.

#### Methods

delete(key: string): Thenable<void\>

Remove a secret from storage.

| Parameter | Description |
| --- | --- |
| key: string | The key the secret was stored under. |
| Returns | Description |
| Thenable<void\> |     |

get(key: string): Thenable<string\>

Retrieve a secret that was stored with key. Returns undefined if there is no password matching that key.

| Parameter | Description |
| --- | --- |
| key: string | The key the secret was stored under. |
| Returns | Description |
| Thenable<string\> | The stored value or `undefined`. |

keys(): Thenable<string\[\]>

Retrieve the keys of all the secrets stored by this extension.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Thenable<string\[\]> |     |

store(key: string, value: string): Thenable<void\>

Store a secret under a given key.

| Parameter | Description |
| --- | --- |
| key: string | The key to store the secret under. |
| value: string | The secret. |
| Returns | Description |
| Thenable<void\> |     |

### SecretStorageChangeEvent

The event data that is fired when a secret is added or removed.

#### Properties

key: string

The key of the secret that has changed.

### SelectedCompletionInfo

Describes the currently selected completion item.

#### Properties

range: [Range](#Range)

The range that will be replaced if this completion item is accepted.

text: string

The text the range will be replaced with if this completion is accepted.

### Selection

Represents a text selection in an editor.

#### Constructors

new Selection(anchor: [Position](#Position), active: [Position](#Position)): [Selection](#Selection)

Create a selection from two positions.

| Parameter | Description |
| --- | --- |
| anchor: [Position](#Position) | A position. |
| active: [Position](#Position) | A position. |
| Returns | Description |
| [Selection](#Selection) |     |

new Selection(anchorLine: number, anchorCharacter: number, activeLine: number, activeCharacter: number): [Selection](#Selection)

Create a selection from four coordinates.

| Parameter | Description |
| --- | --- |
| anchorLine: number | A zero-based line value. |
| anchorCharacter: number | A zero-based character value. |
| activeLine: number | A zero-based line value. |
| activeCharacter: number | A zero-based character value. |
| Returns | Description |
| [Selection](#Selection) |     |

#### Properties

active: [Position](#Position)

The position of the cursor. This position might be before or after [anchor](#Selection.anchor).

anchor: [Position](#Position)

The position at which the selection starts. This position might be before or after [active](#Selection.active).

end: [Position](#Position)

The end position. It is after or equal to [start](#Range.start).

isEmpty: boolean

`true` if `start` and `end` are equal.

isReversed: boolean

A selection is reversed if its [anchor](#Selection.anchor) is the [end](#Range.end) position.

isSingleLine: boolean

`true` if `start.line` and `end.line` are equal.

start: [Position](#Position)

The start position. It is before or equal to [end](#Range.end).

#### Methods

contains(positionOrRange: [Range](#Range) | [Position](#Position)): boolean

Check if a position or a range is contained in this range.

| Parameter | Description |
| --- | --- |
| positionOrRange: [Range](#Range) \| [Position](#Position) | A position or a range. |
| Returns | Description |
| boolean | `true` if the position or range is inside or equal to this range. |

intersection(range: [Range](#Range)): [Range](#Range)

Intersect `range` with this range and returns a new range or `undefined` if the ranges have no overlap.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | A range. |
| Returns | Description |
| [Range](#Range) | A range of the greater start and smaller end positions. Will return undefined when there is no overlap. |

isEqual(other: [Range](#Range)): boolean

Check if `other` equals this range.

| Parameter | Description |
| --- | --- |
| other: [Range](#Range) | A range. |
| Returns | Description |
| boolean | `true` when start and end are [equal](#Position.isEqual) to start and end of this range. |

union(other: [Range](#Range)): [Range](#Range)

Compute the union of `other` with this range.

| Parameter | Description |
| --- | --- |
| other: [Range](#Range) | A range. |
| Returns | Description |
| [Range](#Range) | A range of smaller start position and the greater end position. |

with(start?: [Position](#Position), end?: [Position](#Position)): [Range](#Range)

Derived a new range from this range.

| Parameter | Description |
| --- | --- |
| start?: [Position](#Position) | A position that should be used as start. The default value is the [current start](#Range.start). |
| end?: [Position](#Position) | A position that should be used as end. The default value is the [current end](#Range.end). |
| Returns | Description |
| [Range](#Range) | A range derived from this range with the given start and end position. If start and end are not different `this` range will be returned. |

with(change: {end: [Position](#Position), start: [Position](#Position)}): [Range](#Range)

Derived a new range from this range.

| Parameter | Description |
| --- | --- |
| change: {end: [Position](#Position), start: [Position](#Position)} | An object that describes a change to this range. |
| Returns | Description |
| [Range](#Range) | A range that reflects the given change. Will return `this` range if the change is not changing anything. |

### SelectionRange

A selection range represents a part of a selection hierarchy. A selection range may have a parent selection range that contains it.

#### Constructors

new SelectionRange(range: [Range](#Range), parent?: [SelectionRange](#SelectionRange)): [SelectionRange](#SelectionRange)

Creates a new selection range.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The range of the selection range. |
| parent?: [SelectionRange](#SelectionRange) | The parent of the selection range. |
| Returns | Description |
| [SelectionRange](#SelectionRange) |     |

#### Properties

parent?: [SelectionRange](#SelectionRange)

The parent selection range containing this range.

range: [Range](#Range)

The [Range](#Range) of this selection range.

### SelectionRangeProvider

The selection range provider interface defines the contract between extensions and the "Expand and Shrink Selection" feature.

#### Methods

provideSelectionRanges(document: [TextDocument](#TextDocument), positions: readonly [Position](#Position)\[\], token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[SelectionRange](#SelectionRange)\[\]>

Provide selection ranges for the given positions.

Selection ranges should be computed individually and independent for each position. The editor will merge and deduplicate ranges but providers must return hierarchies of selection ranges so that a range is [contained](#Range.contains) by its parent.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| positions: readonly [Position](#Position)\[\] | The positions at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[SelectionRange](#SelectionRange)\[\]> | Selection ranges or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### SemanticTokens

Represents semantic tokens, either in a range or in an entire document.

_See also_

*   [provideDocumentSemanticTokens](#DocumentSemanticTokensProvider.provideDocumentSemanticTokens) for an explanation of the format.
*   [SemanticTokensBuilder](#SemanticTokensBuilder) for a helper to create an instance.

#### Constructors

new SemanticTokens(data: Uint32Array, resultId?: string): [SemanticTokens](#SemanticTokens)

Create new semantic tokens.

| Parameter | Description |
| --- | --- |
| data: Uint32Array | Token data. |
| resultId?: string | Result identifier. |
| Returns | Description |
| [SemanticTokens](#SemanticTokens) |     |

#### Properties

data: Uint32Array

The actual tokens data.

_See also_ [provideDocumentSemanticTokens](#DocumentSemanticTokensProvider.provideDocumentSemanticTokens) for an explanation of the format.

resultId: string

The result id of the tokens.

This is the id that will be passed to `DocumentSemanticTokensProvider.provideDocumentSemanticTokensEdits` (if implemented).

### SemanticTokensBuilder

A semantic tokens builder can help with creating a `SemanticTokens` instance which contains delta encoded semantic tokens.

#### Constructors

new SemanticTokensBuilder(legend?: [SemanticTokensLegend](#SemanticTokensLegend)): [SemanticTokensBuilder](#SemanticTokensBuilder)

Creates a semantic tokens builder.

| Parameter | Description |
| --- | --- |
| legend?: [SemanticTokensLegend](#SemanticTokensLegend) | A semantic tokens legend. |
| Returns | Description |
| [SemanticTokensBuilder](#SemanticTokensBuilder) |     |

#### Methods

build(resultId?: string): [SemanticTokens](#SemanticTokens)

Finish and create a `SemanticTokens` instance.

| Parameter | Description |
| --- | --- |
| resultId?: string |     |
| Returns | Description |
| [SemanticTokens](#SemanticTokens) |     |

push(line: number, char: number, length: number, tokenType: number, tokenModifiers?: number): void

Add another token.

| Parameter | Description |
| --- | --- |
| line: number | The token start line number (absolute value). |
| char: number | The token start character (absolute value). |
| length: number | The token length in characters. |
| tokenType: number | The encoded token type. |
| tokenModifiers?: number | The encoded token modifiers. |
| Returns | Description |
| void |     |

push(range: [Range](#Range), tokenType: string, tokenModifiers?: readonly string\[\]): void

Add another token. Use only when providing a legend.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | The range of the token. Must be single-line. |
| tokenType: string | The token type. |
| tokenModifiers?: readonly string\[\] | The token modifiers. |
| Returns | Description |
| void |     |

### SemanticTokensEdit

Represents an edit to semantic tokens.

_See also_ [provideDocumentSemanticTokensEdits](#DocumentSemanticTokensProvider.provideDocumentSemanticTokensEdits) for an explanation of the format.

#### Constructors

new SemanticTokensEdit(start: number, deleteCount: number, data?: Uint32Array): [SemanticTokensEdit](#SemanticTokensEdit)

Create a semantic token edit.

| Parameter | Description |
| --- | --- |
| start: number | Start offset |
| deleteCount: number | Number of elements to remove. |
| data?: Uint32Array | Elements to insert |
| Returns | Description |
| [SemanticTokensEdit](#SemanticTokensEdit) |     |

#### Properties

data: Uint32Array

The elements to insert.

deleteCount: number

The count of elements to remove.

start: number

The start offset of the edit.

### SemanticTokensEdits

Represents edits to semantic tokens.

_See also_ [provideDocumentSemanticTokensEdits](#DocumentSemanticTokensProvider.provideDocumentSemanticTokensEdits) for an explanation of the format.

#### Constructors

new SemanticTokensEdits(edits: [SemanticTokensEdit](#SemanticTokensEdit)\[\], resultId?: string): [SemanticTokensEdits](#SemanticTokensEdits)

Create new semantic tokens edits.

| Parameter | Description |
| --- | --- |
| edits: [SemanticTokensEdit](#SemanticTokensEdit)\[\] | An array of semantic token edits |
| resultId?: string | Result identifier. |
| Returns | Description |
| [SemanticTokensEdits](#SemanticTokensEdits) |     |

#### Properties

edits: [SemanticTokensEdit](#SemanticTokensEdit)\[\]

The edits to the tokens data. All edits refer to the initial data state.

resultId: string

The result id of the tokens.

This is the id that will be passed to `DocumentSemanticTokensProvider.provideDocumentSemanticTokensEdits` (if implemented).

### SemanticTokensLegend

A semantic tokens legend contains the needed information to decipher the integer encoded representation of semantic tokens.

#### Constructors

new SemanticTokensLegend(tokenTypes: string\[\], tokenModifiers?: string\[\]): [SemanticTokensLegend](#SemanticTokensLegend)

Creates a semantic tokens legend.

| Parameter | Description |
| --- | --- |
| tokenTypes: string\[\] | An array of token types. |
| tokenModifiers?: string\[\] | An array of token modifiers. |
| Returns | Description |
| [SemanticTokensLegend](#SemanticTokensLegend) |     |

#### Properties

tokenModifiers: string\[\]

The possible token modifiers.

tokenTypes: string\[\]

The possible token types.

### ShellExecution

Represents a task execution that happens inside a shell.

#### Constructors

new ShellExecution(commandLine: string, options?: [ShellExecutionOptions](#ShellExecutionOptions)): [ShellExecution](#ShellExecution)

Creates a shell execution with a full command line.

| Parameter | Description |
| --- | --- |
| commandLine: string | The command line to execute. |
| options?: [ShellExecutionOptions](#ShellExecutionOptions) | Optional options for the started the shell. |
| Returns | Description |
| [ShellExecution](#ShellExecution) |     |

new ShellExecution(command: string | [ShellQuotedString](#ShellQuotedString), args: Array<string | [ShellQuotedString](#ShellQuotedString)\>, options?: [ShellExecutionOptions](#ShellExecutionOptions)): [ShellExecution](#ShellExecution)

Creates a shell execution with a command and arguments. For the real execution the editor will construct a command line from the command and the arguments. This is subject to interpretation especially when it comes to quoting. If full control over the command line is needed please use the constructor that creates a `ShellExecution` with the full command line.

| Parameter | Description |
| --- | --- |
| command: string \| [ShellQuotedString](#ShellQuotedString) | The command to execute. |
| args: Array<string \| [ShellQuotedString](#ShellQuotedString)\> | The command arguments. |
| options?: [ShellExecutionOptions](#ShellExecutionOptions) | Optional options for the started the shell. |
| Returns | Description |
| [ShellExecution](#ShellExecution) |     |

#### Properties

args: Array<string | [ShellQuotedString](#ShellQuotedString)\>

The shell args. Is `undefined` if created with a full command line.

command: string | [ShellQuotedString](#ShellQuotedString)

The shell command. Is `undefined` if created with a full command line.

commandLine: string

The shell command line. Is `undefined` if created with a command and arguments.

options?: [ShellExecutionOptions](#ShellExecutionOptions)

The shell options used when the command line is executed in a shell. Defaults to undefined.

### ShellExecutionOptions

Options for a shell execution

#### Properties

cwd?: string

The current working directory of the executed shell. If omitted the tools current workspace root is used.

env?:

The additional environment of the executed shell. If omitted the parent process' environment is used. If provided it is merged with the parent process' environment.

executable?: string

The shell executable.

shellArgs?: string\[\]

The arguments to be passed to the shell executable used to run the task. Most shells require special arguments to execute a command. For example `bash` requires the `-c` argument to execute a command, `PowerShell` requires `-Command` and `cmd` requires both `/d` and `/c`.

shellQuoting?: [ShellQuotingOptions](#ShellQuotingOptions)

The shell quotes supported by this shell.

### ShellQuotedString

A string that will be quoted depending on the used shell.

#### Properties

quoting: [ShellQuoting](#ShellQuoting)

The quoting style to use.

value: string

The actual string value.

### ShellQuoting

Defines how an argument should be quoted if it contains spaces or unsupported characters.

#### Enumeration Members

Escape: 1

Character escaping should be used. This for example uses \\ on bash and \` on PowerShell.

Strong: 2

Strong string quoting should be used. This for example uses " for Windows cmd and ' for bash and PowerShell. Strong quoting treats arguments as literal strings. Under PowerShell echo 'The value is $(2 \* 3)' will print `The value is $(2 * 3)`

Weak: 3

Weak string quoting should be used. This for example uses " for Windows cmd, bash and PowerShell. Weak quoting still performs some kind of evaluation inside the quoted string. Under PowerShell echo "The value is $(2 \* 3)" will print `The value is 6`

### ShellQuotingOptions

The shell quoting options.

#### Properties

escape?: string | {charsToEscape: string, escapeChar: string}

The character used to do character escaping. If a string is provided only spaces are escaped. If a `{ escapeChar, charsToEscape }` literal is provide all characters in `charsToEscape` are escaped using the `escapeChar`.

strong?: string

The character used for strong quoting. The string's length must be 1.

weak?: string

The character used for weak quoting. The string's length must be 1.

### SignatureHelp

Signature help represents the signature of something callable. There can be multiple signatures but only one active and only one active parameter.

#### Constructors

new SignatureHelp(): [SignatureHelp](#SignatureHelp)

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [SignatureHelp](#SignatureHelp) |     |

#### Properties

activeParameter: number

The active parameter of the active signature.

activeSignature: number

The active signature.

signatures: [SignatureInformation](#SignatureInformation)\[\]

One or more signatures.

### SignatureHelpContext

Additional information about the context in which a [SignatureHelpProvider](#SignatureHelpProvider.provideSignatureHelp) was triggered.

#### Properties

activeSignatureHelp: [SignatureHelp](#SignatureHelp)

The currently active [SignatureHelp](#SignatureHelp).

The `activeSignatureHelp` has its [activeSignature](#SignatureHelp.activeSignature) field updated based on the user arrowing through available signatures.

isRetrigger: boolean

`true` if signature help was already showing when it was triggered.

Retriggers occur when the signature help is already active and can be caused by actions such as typing a trigger character, a cursor move, or document content changes.

triggerCharacter: string

Character that caused signature help to be triggered.

This is `undefined` when signature help is not triggered by typing, such as when manually invoking signature help or when moving the cursor.

triggerKind: [SignatureHelpTriggerKind](#SignatureHelpTriggerKind)

Action that caused signature help to be triggered.

### SignatureHelpProvider

The signature help provider interface defines the contract between extensions and the [parameter hints](https://code.visualstudio.com/docs/editor/intellisense)\-feature.

#### Methods

provideSignatureHelp(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken), context: [SignatureHelpContext](#SignatureHelpContext)): [ProviderResult](#ProviderResult&lt;T&gt;)<[SignatureHelp](#SignatureHelp)\>

Provide help for the signature at the given position and document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| context: [SignatureHelpContext](#SignatureHelpContext) | Information about how signature help was triggered. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[SignatureHelp](#SignatureHelp)\> | Signature help or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### SignatureHelpProviderMetadata

Metadata about a registered [SignatureHelpProvider](#SignatureHelpProvider).

#### Properties

retriggerCharacters: readonly string\[\]

List of characters that re-trigger signature help.

These trigger characters are only active when signature help is already showing. All trigger characters are also counted as re-trigger characters.

triggerCharacters: readonly string\[\]

List of characters that trigger signature help.

### SignatureHelpTriggerKind

How a [SignatureHelpProvider](#SignatureHelpProvider) was triggered.

#### Enumeration Members

Invoke: 1

Signature help was invoked manually by the user or by a command.

TriggerCharacter: 2

Signature help was triggered by a trigger character.

ContentChange: 3

Signature help was triggered by the cursor moving or by the document content changing.

### SignatureInformation

Represents the signature of something callable. A signature can have a label, like a function-name, a doc-comment, and a set of parameters.

#### Constructors

new SignatureInformation(label: string, documentation?: string | [MarkdownString](#MarkdownString)): [SignatureInformation](#SignatureInformation)

Creates a new signature information object.

| Parameter | Description |
| --- | --- |
| label: string | A label string. |
| documentation?: string \| [MarkdownString](#MarkdownString) | A doc string. |
| Returns | Description |
| [SignatureInformation](#SignatureInformation) |     |

#### Properties

activeParameter?: number

The index of the active parameter.

If provided, this is used in place of [SignatureHelp.activeParameter](#SignatureHelp.activeParameter).

documentation?: string | [MarkdownString](#MarkdownString)

The human-readable doc-comment of this signature. Will be shown in the UI but can be omitted.

label: string

The label of this signature. Will be shown in the UI.

parameters: [ParameterInformation](#ParameterInformation)\[\]

The parameters of this signature.

### SnippetString

A snippet string is a template which allows to insert text and to control the editor cursor when insertion happens.

A snippet can define tab stops and placeholders with `$1`, `$2` and `${3:foo}`. `$0` defines the final tab stop, it defaults to the end of the snippet. Variables are defined with `$name` and `${name:default value}`. Also see [the full snippet syntax](https://code.visualstudio.com/docs/editor/userdefinedsnippets#_create-your-own-snippets).

#### Constructors

new SnippetString(value?: string): [SnippetString](#SnippetString)

Create a new snippet string.

| Parameter | Description |
| --- | --- |
| value?: string | A snippet string. |
| Returns | Description |
| [SnippetString](#SnippetString) |     |

#### Properties

value: string

The snippet string.

#### Methods

appendChoice(values: readonly string\[\], number?: number): [SnippetString](#SnippetString)

Builder-function that appends a choice (`${1|a,b,c|}`) to the [value](#SnippetString.value) of this snippet string.

| Parameter | Description |
| --- | --- |
| values: readonly string\[\] | The values for choices - the array of strings |
| number?: number | The number of this tabstop, defaults to an auto-increment value starting at 1. |
| Returns | Description |
| [SnippetString](#SnippetString) | This snippet string. |

appendPlaceholder(value: string | (snippet: [SnippetString](#SnippetString)) => any, number?: number): [SnippetString](#SnippetString)

Builder-function that appends a placeholder (`${1:value}`) to the [value](#SnippetString.value) of this snippet string.

| Parameter | Description |
| --- | --- |
| value: string \| (snippet: [SnippetString](#SnippetString)) => any | The value of this placeholder - either a string or a function with which a nested snippet can be created. |
| number?: number | The number of this tabstop, defaults to an auto-increment value starting at 1. |
| Returns | Description |
| [SnippetString](#SnippetString) | This snippet string. |

appendTabstop(number?: number): [SnippetString](#SnippetString)

Builder-function that appends a tabstop (`$1`, `$2` etc) to the [value](#SnippetString.value) of this snippet string.

| Parameter | Description |
| --- | --- |
| number?: number | The number of this tabstop, defaults to an auto-increment value starting at 1. |
| Returns | Description |
| [SnippetString](#SnippetString) | This snippet string. |

appendText(string: string): [SnippetString](#SnippetString)

Builder-function that appends the given string to the [value](#SnippetString.value) of this snippet string.

| Parameter | Description |
| --- | --- |
| string: string | A value to append 'as given'. The string will be escaped. |
| Returns | Description |
| [SnippetString](#SnippetString) | This snippet string. |

appendVariable(name: string, defaultValue: string | (snippet: [SnippetString](#SnippetString)) => any): [SnippetString](#SnippetString)

Builder-function that appends a variable (`${VAR}`) to the [value](#SnippetString.value) of this snippet string.

| Parameter | Description |
| --- | --- |
| name: string | The name of the variable - excluding the `$`. |
| defaultValue: string \| (snippet: [SnippetString](#SnippetString)) => any | The default value which is used when the variable name cannot be resolved - either a string or a function with which a nested snippet can be created. |
| Returns | Description |
| [SnippetString](#SnippetString) | This snippet string. |

### SnippetTextEdit

A snippet edit represents an interactive edit that is performed by the editor.

_Note_ that a snippet edit can always be performed as a normal [text edit](#TextEdit). This will happen when no matching editor is open or when a [workspace edit](#WorkspaceEdit) contains snippet edits for multiple files. In that case only those that match the active editor will be performed as snippet edits and the others as normal text edits.

#### Static

insert(position: [Position](#Position), snippet: [SnippetString](#SnippetString)): [SnippetTextEdit](#SnippetTextEdit)

Utility to create an insert snippet edit.

| Parameter | Description |
| --- | --- |
| position: [Position](#Position) | A position, will become an empty range. |
| snippet: [SnippetString](#SnippetString) | A snippet string. |
| Returns | Description |
| [SnippetTextEdit](#SnippetTextEdit) | A new snippet edit object. |

replace(range: [Range](#Range), snippet: [SnippetString](#SnippetString)): [SnippetTextEdit](#SnippetTextEdit)

Utility to create a replace snippet edit.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | A range. |
| snippet: [SnippetString](#SnippetString) | A snippet string. |
| Returns | Description |
| [SnippetTextEdit](#SnippetTextEdit) | A new snippet edit object. |

#### Constructors

new SnippetTextEdit(range: [Range](#Range), snippet: [SnippetString](#SnippetString)): [SnippetTextEdit](#SnippetTextEdit)

Create a new snippet edit.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | A range. |
| snippet: [SnippetString](#SnippetString) | A snippet string. |
| Returns | Description |
| [SnippetTextEdit](#SnippetTextEdit) |     |

#### Properties

keepWhitespace?: boolean

Whether the snippet edit should be applied with existing whitespace preserved.

range: [Range](#Range)

The range this edit applies to.

snippet: [SnippetString](#SnippetString)

The [snippet](#SnippetString) this edit will perform.

### SourceBreakpoint

A breakpoint specified by a source location.

#### Constructors

new SourceBreakpoint(location: [Location](#Location), enabled?: boolean, condition?: string, hitCondition?: string, logMessage?: string): [SourceBreakpoint](#SourceBreakpoint)

Create a new breakpoint for a source location.

| Parameter | Description |
| --- | --- |
| location: [Location](#Location) |     |
| enabled?: boolean |     |
| condition?: string |     |
| hitCondition?: string |     |
| logMessage?: string |     |
| Returns | Description |
| [SourceBreakpoint](#SourceBreakpoint) |     |

#### Properties

condition?: string

An optional expression for conditional breakpoints.

enabled: boolean

Is breakpoint enabled.

hitCondition?: string

An optional expression that controls how many hits of the breakpoint are ignored.

id: string

The unique ID of the breakpoint.

location: [Location](#Location)

The source and line position of this breakpoint.

logMessage?: string

An optional message that gets logged when this breakpoint is hit. Embedded expressions within {} are interpolated by the debug adapter.

### SourceControl

An source control is able to provide [resource states](#SourceControlResourceState) to the editor and interact with the editor in several source control related ways.

#### Properties

acceptInputCommand?: [Command](#Command)

Optional accept input command.

This command will be invoked when the user accepts the value in the Source Control input.

commitTemplate?: string

Optional commit template string.

The Source Control viewlet will populate the Source Control input with this value when appropriate.

count?: number

The UI-visible count of [resource states](#SourceControlResourceState) of this source control.

If undefined, this source control will

*   display its UI-visible count as zero, and
*   contribute the count of its [resource states](#SourceControlResourceState) to the UI-visible aggregated count for all source controls

id: string

The id of this source control.

inputBox: [SourceControlInputBox](#SourceControlInputBox)

The [input box](#SourceControlInputBox) for this source control.

label: string

The human-readable label of this source control.

quickDiffProvider?: [QuickDiffProvider](#QuickDiffProvider)

An optional [quick diff provider](#QuickDiffProvider).

rootUri: [Uri](#Uri)

The (optional) Uri of the root of this source control.

statusBarCommands?: [Command](#Command)\[\]

Optional status bar commands.

These commands will be displayed in the editor's status bar.

#### Methods

createResourceGroup(id: string, label: string): [SourceControlResourceGroup](#SourceControlResourceGroup)

Create a new [resource group](#SourceControlResourceGroup).

| Parameter | Description |
| --- | --- |
| id: string |     |
| label: string |     |
| Returns | Description |
| [SourceControlResourceGroup](#SourceControlResourceGroup) |     |

dispose(): void

Dispose this source control.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### SourceControlInputBox

Represents the input box in the Source Control viewlet.

#### Properties

enabled: boolean

Controls whether the input box is enabled (default is `true`).

placeholder: string

A string to show as placeholder in the input box to guide the user.

value: string

Setter and getter for the contents of the input box.

visible: boolean

Controls whether the input box is visible (default is `true`).

### SourceControlResourceDecorations

The decorations for a [source control resource state](#SourceControlResourceState). Can be independently specified for light and dark themes.

#### Properties

dark?: [SourceControlResourceThemableDecorations](#SourceControlResourceThemableDecorations)

The dark theme decorations.

faded?: boolean

Whether the [source control resource state](#SourceControlResourceState) should be faded in the UI.

iconPath?: string | [Uri](#Uri) | [ThemeIcon](#ThemeIcon)

The icon path for a specific [source control resource state](#SourceControlResourceState).

light?: [SourceControlResourceThemableDecorations](#SourceControlResourceThemableDecorations)

The light theme decorations.

strikeThrough?: boolean

Whether the [source control resource state](#SourceControlResourceState) should be striked-through in the UI.

tooltip?: string

The title for a specific [source control resource state](#SourceControlResourceState).

### SourceControlResourceGroup

A source control resource group is a collection of [source control resource states](#SourceControlResourceState).

#### Properties

contextValue?: string

Context value of the resource group. This can be used to contribute resource group specific actions. For example, if a resource group is given a context value of `exportable`, when contributing actions to `scm/resourceGroup/context` using `menus` extension point, you can specify context value for key `scmResourceGroupState` in `when` expressions, like `scmResourceGroupState == exportable`.

```
"contributes": {
  "menus": {
    "scm/resourceGroup/context": [
      {
        "command": "extension.export",
        "when": "scmResourceGroupState == exportable"
      }
    ]
  }
}
```

This will show action `extension.export` only for resource groups with `contextValue` equal to `exportable`.

hideWhenEmpty?: boolean

Whether this source control resource group is hidden when it contains no [source control resource states](#SourceControlResourceState).

id: string

The id of this source control resource group.

label: string

The label of this source control resource group.

resourceStates: [SourceControlResourceState](#SourceControlResourceState)\[\]

This group's collection of [source control resource states](#SourceControlResourceState).

#### Methods

dispose(): void

Dispose this source control resource group.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### SourceControlResourceState

An source control resource state represents the state of an underlying workspace resource within a certain [source control group](#SourceControlResourceGroup).

#### Properties

command?: [Command](#Command)

The [Command](#Command) which should be run when the resource state is open in the Source Control viewlet.

contextValue?: string

Context value of the resource state. This can be used to contribute resource specific actions. For example, if a resource is given a context value as `diffable`. When contributing actions to `scm/resourceState/context` using `menus` extension point, you can specify context value for key `scmResourceState` in `when` expressions, like `scmResourceState == diffable`.

```
"contributes": {
  "menus": {
    "scm/resourceState/context": [
      {
        "command": "extension.diff",
        "when": "scmResourceState == diffable"
      }
    ]
  }
}
```

This will show action `extension.diff` only for resources with `contextValue` is `diffable`.

decorations?: [SourceControlResourceDecorations](#SourceControlResourceDecorations)

The [decorations](#SourceControlResourceDecorations) for this source control resource state.

resourceUri: [Uri](#Uri)

The [Uri](#Uri) of the underlying resource inside the workspace.

### SourceControlResourceThemableDecorations

The theme-aware decorations for a [source control resource state](#SourceControlResourceState).

#### Properties

iconPath?: string | [Uri](#Uri) | [ThemeIcon](#ThemeIcon)

The icon path for a specific [source control resource state](#SourceControlResourceState).

### StatementCoverage

Contains coverage information for a single statement or line.

#### Constructors

new StatementCoverage(executed: number | boolean, location: [Range](#Range) | [Position](#Position), branches?: [BranchCoverage](#BranchCoverage)\[\]): [StatementCoverage](#StatementCoverage)

| Parameter | Description |
| --- | --- |
| executed: number \| boolean | The number of times this statement was executed, or a boolean indicating whether it was executed if the exact count is unknown. If zero or false, the statement will be marked as un-covered. |
| location: [Range](#Range) \| [Position](#Position) | The statement position. |
| branches?: [BranchCoverage](#BranchCoverage)\[\] | Coverage from branches of this line. If it's not a conditional, this should be omitted. |
| Returns | Description |
| [StatementCoverage](#StatementCoverage) |     |

#### Properties

branches: [BranchCoverage](#BranchCoverage)\[\]

Coverage from branches of this line or statement. If it's not a conditional, this will be empty.

executed: number | boolean

The number of times this statement was executed, or a boolean indicating whether it was executed if the exact count is unknown. If zero or false, the statement will be marked as un-covered.

location: [Range](#Range) | [Position](#Position)

Statement location.

### StatusBarAlignment

Represents the alignment of status bar items.

#### Enumeration Members

Left: 1

Aligned to the left side.

Right: 2

Aligned to the right side.

### StatusBarItem

A status bar item is a status bar contribution that can show text and icons and run a command on click.

#### Properties

accessibilityInformation: [AccessibilityInformation](#AccessibilityInformation)

Accessibility information used when a screen reader interacts with this StatusBar item

alignment: [StatusBarAlignment](#StatusBarAlignment)

The alignment of this item.

backgroundColor: [ThemeColor](#ThemeColor)

The background color for this entry.

_Note_: only the following colors are supported:

*   `new ThemeColor('statusBarItem.errorBackground')`
*   `new ThemeColor('statusBarItem.warningBackground')`

More background colors may be supported in the future.

_Note_: when a background color is set, the statusbar may override the `color` choice to ensure the entry is readable in all themes.

color: string | [ThemeColor](#ThemeColor)

The foreground color for this entry.

command: string | [Command](#Command)

[Command](#Command) or identifier of a command to run on click.

The command must be [known](#commands.getCommands).

Note that if this is a [Command](#Command) object, only the [command](#Command.command) and [arguments](#Command.arguments) are used by the editor.

id: string

The identifier of this item.

_Note_: if no identifier was provided by the [window.createStatusBarItem](#window.createStatusBarItem) method, the identifier will match the [extension identifier](#Extension.id).

name: string

The name of the entry, like 'Python Language Indicator', 'Git Status' etc. Try to keep the length of the name short, yet descriptive enough that users can understand what the status bar item is about.

priority: number

The priority of this item. Higher value means the item should be shown more to the left.

text: string

The text to show for the entry. You can embed icons in the text by leveraging the syntax:

`My text $(icon-name) contains icons like $(icon-name) this one.`

Where the icon-name is taken from the ThemeIcon [icon set](https://code.visualstudio.com/api/references/icons-in-labels#icon-listing), e.g. `light-bulb`, `thumbsup`, `zap` etc.

tooltip: string | [MarkdownString](#MarkdownString)

The tooltip text when you hover over this entry.

#### Methods

dispose(): void

Dispose and free associated resources. Call [hide](#StatusBarItem.hide).

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

hide(): void

Hide the entry in the status bar.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

show(): void

Shows the entry in the status bar.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### SymbolInformation

Represents information about programming constructs like variables, classes, interfaces etc.

#### Constructors

new SymbolInformation(name: string, kind: [SymbolKind](#SymbolKind), containerName: string, location: [Location](#Location)): [SymbolInformation](#SymbolInformation)

Creates a new symbol information object.

| Parameter | Description |
| --- | --- |
| name: string | The name of the symbol. |
| kind: [SymbolKind](#SymbolKind) | The kind of the symbol. |
| containerName: string | The name of the symbol containing the symbol. |
| location: [Location](#Location) | The location of the symbol. |
| Returns | Description |
| [SymbolInformation](#SymbolInformation) |     |

new SymbolInformation(name: string, kind: [SymbolKind](#SymbolKind), range: [Range](#Range), uri?: [Uri](#Uri), containerName?: string): [SymbolInformation](#SymbolInformation)

Creates a new symbol information object.

*   _deprecated_ - Please use the constructor taking a [Location](#Location) object.

| Parameter | Description |
| --- | --- |
| name: string | The name of the symbol. |
| kind: [SymbolKind](#SymbolKind) | The kind of the symbol. |
| range: [Range](#Range) | The range of the location of the symbol. |
| uri?: [Uri](#Uri) | The resource of the location of symbol, defaults to the current document. |
| containerName?: string | The name of the symbol containing the symbol. |
| Returns | Description |
| [SymbolInformation](#SymbolInformation) |     |

#### Properties

containerName: string

The name of the symbol containing this symbol.

kind: [SymbolKind](#SymbolKind)

The kind of this symbol.

location: [Location](#Location)

The location of this symbol.

name: string

The name of this symbol.

tags?: readonly [SymbolTag](#SymbolTag)\[\]

Tags for this symbol.

### SymbolKind

A symbol kind.

#### Enumeration Members

File: 0

The `File` symbol kind.

Module: 1

The `Module` symbol kind.

Namespace: 2

The `Namespace` symbol kind.

Package: 3

The `Package` symbol kind.

Class: 4

The `Class` symbol kind.

Method: 5

The `Method` symbol kind.

Property: 6

The `Property` symbol kind.

Field: 7

The `Field` symbol kind.

Constructor: 8

The `Constructor` symbol kind.

Enum: 9

The `Enum` symbol kind.

Interface: 10

The `Interface` symbol kind.

Function: 11

The `Function` symbol kind.

Variable: 12

The `Variable` symbol kind.

Constant: 13

The `Constant` symbol kind.

String: 14

The `String` symbol kind.

Number: 15

The `Number` symbol kind.

Boolean: 16

The `Boolean` symbol kind.

Array: 17

The `Array` symbol kind.

Object: 18

The `Object` symbol kind.

Key: 19

The `Key` symbol kind.

Null: 20

The `Null` symbol kind.

EnumMember: 21

The `EnumMember` symbol kind.

Struct: 22

The `Struct` symbol kind.

Event: 23

The `Event` symbol kind.

Operator: 24

The `Operator` symbol kind.

TypeParameter: 25

The `TypeParameter` symbol kind.

### SymbolTag

Symbol tags are extra annotations that tweak the rendering of a symbol.

#### Enumeration Members

Deprecated: 1

Render a symbol as obsolete, usually using a strike-out.

### SyntaxTokenType

Enumeration of commonly encountered syntax token types.

#### Enumeration Members

Other: 0

Everything except tokens that are part of comments, string literals and regular expressions.

Comment: 1

A comment.

String: 2

A string literal.

RegEx: 3

A regular expression.

### Tab

Represents a tab within a [group of tabs](#TabGroup). Tabs are merely the graphical representation within the editor area. A backing editor is not a guarantee.

#### Properties

group: [TabGroup](#TabGroup)

The group which the tab belongs to.

input: unknown

Defines the structure of the tab i.e. text, notebook, custom, etc. Resource and other useful properties are defined on the tab kind.

isActive: boolean

Whether or not the tab is currently active. This is dictated by being the selected tab in the group.

isDirty: boolean

Whether or not the dirty indicator is present on the tab.

isPinned: boolean

Whether or not the tab is pinned (pin icon is present).

isPreview: boolean

Whether or not the tab is in preview mode.

label: string

The text displayed on the tab.

### TabChangeEvent

An event describing change to tabs.

#### Properties

changed: readonly [Tab](#Tab)\[\]

Tabs that have changed, e.g have changed their [active](#Tab.isActive) state.

closed: readonly [Tab](#Tab)\[\]

The tabs that have been closed.

opened: readonly [Tab](#Tab)\[\]

The tabs that have been opened.

### TabGroup

Represents a group of tabs. A tab group itself consists of multiple tabs.

#### Properties

activeTab: [Tab](#Tab)

The active [tab](#Tab) in the group. This is the tab whose contents are currently being rendered.

_Note_ that there can be one active tab per group but there can only be one [active group](#TabGroups.activeTabGroup).

isActive: boolean

Whether or not the group is currently active.

_Note_ that only one tab group is active at a time, but that multiple tab groups can have an [active tab](#TabGroup.activeTab).

_See also_ [Tab.isActive](#Tab.isActive)

tabs: readonly [Tab](#Tab)\[\]

The list of tabs contained within the group. This can be empty if the group has no tabs open.

viewColumn: [ViewColumn](#ViewColumn)

The view column of the group.

### TabGroupChangeEvent

An event describing changes to tab groups.

#### Properties

changed: readonly [TabGroup](#TabGroup)\[\]

Tab groups that have changed, e.g have changed their [active](#TabGroup.isActive) state.

closed: readonly [TabGroup](#TabGroup)\[\]

Tab groups that have been closed.

opened: readonly [TabGroup](#TabGroup)\[\]

Tab groups that have been opened.

### TabGroups

Represents the main editor area which consists of multiple groups which contain tabs.

#### Events

onDidChangeTabGroups: [Event](#Event&lt;T&gt;)<[TabGroupChangeEvent](#TabGroupChangeEvent)\>

An [event](#Event) which fires when [tab groups](#TabGroup) have changed.

onDidChangeTabs: [Event](#Event&lt;T&gt;)<[TabChangeEvent](#TabChangeEvent)\>

An [event](#Event) which fires when [tabs](#Tab) have changed.

#### Properties

activeTabGroup: [TabGroup](#TabGroup)

The currently active group.

all: readonly [TabGroup](#TabGroup)\[\]

All the groups within the group container.

#### Methods

close(tab: [Tab](#Tab) | readonly [Tab](#Tab)\[\], preserveFocus?: boolean): Thenable<boolean\>

Closes the tab. This makes the tab object invalid and the tab should no longer be used for further actions. Note: In the case of a dirty tab, a confirmation dialog will be shown which may be cancelled. If cancelled the tab is still valid

| Parameter | Description |
| --- | --- |
| tab: [Tab](#Tab) \| readonly [Tab](#Tab)\[\] | The tab to close. |
| preserveFocus?: boolean | When `true` focus will remain in its current position. If `false` it will jump to the next tab. |
| Returns | Description |
| Thenable<boolean\> | A promise that resolves to `true` when all tabs have been closed. |

close(tabGroup: [TabGroup](#TabGroup) | readonly [TabGroup](#TabGroup)\[\], preserveFocus?: boolean): Thenable<boolean\>

Closes the tab group. This makes the tab group object invalid and the tab group should no longer be used for further actions.

| Parameter | Description |
| --- | --- |
| tabGroup: [TabGroup](#TabGroup) \| readonly [TabGroup](#TabGroup)\[\] | The tab group to close. |
| preserveFocus?: boolean | When `true` focus will remain in its current position. |
| Returns | Description |
| Thenable<boolean\> | A promise that resolves to `true` when all tab groups have been closed. |

### TabInputCustom

The tab represents a custom editor.

#### Constructors

new TabInputCustom(uri: [Uri](#Uri), viewType: string): [TabInputCustom](#TabInputCustom)

Constructs a custom editor tab input.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the tab. |
| viewType: string | The viewtype of the custom editor. |
| Returns | Description |
| [TabInputCustom](#TabInputCustom) |     |

#### Properties

uri: [Uri](#Uri)

The uri that the tab is representing.

viewType: string

The type of custom editor.

### TabInputNotebook

The tab represents a notebook.

#### Constructors

new TabInputNotebook(uri: [Uri](#Uri), notebookType: string): [TabInputNotebook](#TabInputNotebook)

Constructs a new tab input for a notebook.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the notebook. |
| notebookType: string | The type of notebook. Maps to [NotebookDocuments's notebookType](#NotebookDocument.notebookType) |
| Returns | Description |
| [TabInputNotebook](#TabInputNotebook) |     |

#### Properties

notebookType: string

The type of notebook. Maps to [NotebookDocuments's notebookType](#NotebookDocument.notebookType)

uri: [Uri](#Uri)

The uri that the tab is representing.

### TabInputNotebookDiff

The tabs represents two notebooks in a diff configuration.

#### Constructors

new TabInputNotebookDiff(original: [Uri](#Uri), modified: [Uri](#Uri), notebookType: string): [TabInputNotebookDiff](#TabInputNotebookDiff)

Constructs a notebook diff tab input.

| Parameter | Description |
| --- | --- |
| original: [Uri](#Uri) | The uri of the original unmodified notebook. |
| modified: [Uri](#Uri) | The uri of the modified notebook. |
| notebookType: string | The type of notebook. Maps to [NotebookDocuments's notebookType](#NotebookDocument.notebookType) |
| Returns | Description |
| [TabInputNotebookDiff](#TabInputNotebookDiff) |     |

#### Properties

modified: [Uri](#Uri)

The uri of the modified notebook.

notebookType: string

The type of notebook. Maps to [NotebookDocuments's notebookType](#NotebookDocument.notebookType)

original: [Uri](#Uri)

The uri of the original notebook.

### TabInputTerminal

The tab represents a terminal in the editor area.

#### Constructors

new TabInputTerminal(): [TabInputTerminal](#TabInputTerminal)

Constructs a terminal tab input.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [TabInputTerminal](#TabInputTerminal) |     |

### TabInputText

The tab represents a single text based resource.

#### Constructors

new TabInputText(uri: [Uri](#Uri)): [TabInputText](#TabInputText)

Constructs a text tab input with the given URI.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The URI of the tab. |
| Returns | Description |
| [TabInputText](#TabInputText) |     |

#### Properties

uri: [Uri](#Uri)

The uri represented by the tab.

### TabInputTextDiff

The tab represents two text based resources being rendered as a diff.

#### Constructors

new TabInputTextDiff(original: [Uri](#Uri), modified: [Uri](#Uri)): [TabInputTextDiff](#TabInputTextDiff)

Constructs a new text diff tab input with the given URIs.

| Parameter | Description |
| --- | --- |
| original: [Uri](#Uri) | The uri of the original text resource. |
| modified: [Uri](#Uri) | The uri of the modified text resource. |
| Returns | Description |
| [TabInputTextDiff](#TabInputTextDiff) |     |

#### Properties

modified: [Uri](#Uri)

The uri of the modified text resource.

original: [Uri](#Uri)

The uri of the original text resource.

### TabInputWebview

The tab represents a webview.

#### Constructors

new TabInputWebview(viewType: string): [TabInputWebview](#TabInputWebview)

Constructs a webview tab input with the given view type.

| Parameter | Description |
| --- | --- |
| viewType: string | The type of webview. Maps to [WebviewPanel's viewType](#WebviewPanel.viewType) |
| Returns | Description |
| [TabInputWebview](#TabInputWebview) |     |

#### Properties

viewType: string

The type of webview. Maps to [WebviewPanel's viewType](#WebviewPanel.viewType)

### Task

A task to execute

#### Constructors

new Task(taskDefinition: [TaskDefinition](#TaskDefinition), scope: [WorkspaceFolder](#WorkspaceFolder) | [Global](#Global) | [Workspace](#Workspace), name: string, source: string, execution?: [ProcessExecution](#ProcessExecution) | [ShellExecution](#ShellExecution) | [CustomExecution](#CustomExecution), problemMatchers?: string | string\[\]): [Task](#Task)

Creates a new task.

| Parameter | Description |
| --- | --- |
| taskDefinition: [TaskDefinition](#TaskDefinition) | The task definition as defined in the taskDefinitions extension point. |
| scope: [WorkspaceFolder](#WorkspaceFolder) \| [Global](#Global) \| [Workspace](#Workspace) | Specifies the task's scope. It is either a global or a workspace task or a task for a specific workspace folder. Global tasks are currently not supported. |
| name: string | The task's name. Is presented in the user interface. |
| source: string | The task's source (e.g. 'gulp', 'npm', ...). Is presented in the user interface. |
| execution?: [ProcessExecution](#ProcessExecution) \| [ShellExecution](#ShellExecution) \| [CustomExecution](#CustomExecution) | The process or shell execution. |
| problemMatchers?: string \| string\[\] | the names of problem matchers to use, like '$tsc' or '$eslint'. Problem matchers can be contributed by an extension using the `problemMatchers` extension point. |
| Returns | Description |
| [Task](#Task) |     |

new Task(taskDefinition: [TaskDefinition](#TaskDefinition), name: string, source: string, execution?: [ProcessExecution](#ProcessExecution) | [ShellExecution](#ShellExecution), problemMatchers?: string | string\[\]): [Task](#Task)

Creates a new task.

*   _deprecated_ - Use the new constructors that allow specifying a scope for the task.

| Parameter | Description |
| --- | --- |
| taskDefinition: [TaskDefinition](#TaskDefinition) | The task definition as defined in the taskDefinitions extension point. |
| name: string | The task's name. Is presented in the user interface. |
| source: string | The task's source (e.g. 'gulp', 'npm', ...). Is presented in the user interface. |
| execution?: [ProcessExecution](#ProcessExecution) \| [ShellExecution](#ShellExecution) | The process or shell execution. |
| problemMatchers?: string \| string\[\] | the names of problem matchers to use, like '$tsc' or '$eslint'. Problem matchers can be contributed by an extension using the `problemMatchers` extension point. |
| Returns | Description |
| [Task](#Task) |     |

#### Properties

definition: [TaskDefinition](#TaskDefinition)

The task's definition.

detail?: string

A human-readable string which is rendered less prominently on a separate line in places where the task's name is displayed. Supports rendering of [theme icons](#ThemeIcon) via the `$(<name>)`\-syntax.

execution?: [ProcessExecution](#ProcessExecution) | [ShellExecution](#ShellExecution) | [CustomExecution](#CustomExecution)

The task's execution engine

group?: [TaskGroup](#TaskGroup)

The task group this tasks belongs to. See TaskGroup for a predefined set of available groups. Defaults to undefined meaning that the task doesn't belong to any special group.

isBackground: boolean

Whether the task is a background task or not.

name: string

The task's name

presentationOptions: [TaskPresentationOptions](#TaskPresentationOptions)

The presentation options. Defaults to an empty literal.

problemMatchers: string\[\]

The problem matchers attached to the task. Defaults to an empty array.

runOptions: [RunOptions](#RunOptions)

Run options for the task

scope: [WorkspaceFolder](#WorkspaceFolder) | [Global](#Global) | [Workspace](#Workspace)

The task's scope.

source: string

A human-readable string describing the source of this shell task, e.g. 'gulp' or 'npm'. Supports rendering of [theme icons](#ThemeIcon) via the `$(<name>)`\-syntax.

### TaskDefinition

A structure that defines a task kind in the system. The value must be JSON-stringifyable.

#### Properties

type: string

The task definition describing the task provided by an extension. Usually a task provider defines more properties to identify a task. They need to be defined in the package.json of the extension under the 'taskDefinitions' extension point. The npm task definition for example looks like this

```
interface NpmTaskDefinition extends TaskDefinition {
  script: string;
}
```

Note that type identifier starting with a '$' are reserved for internal usages and shouldn't be used by extensions.

### TaskEndEvent

An event signaling the end of an executed task.

This interface is not intended to be implemented.

#### Properties

execution: [TaskExecution](#TaskExecution)

The task item representing the task that finished.

### TaskExecution

An object representing an executed Task. It can be used to terminate a task.

This interface is not intended to be implemented.

#### Properties

task: [Task](#Task)

The task that got started.

#### Methods

terminate(): void

Terminates the task execution.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### TaskFilter

A task filter denotes tasks by their version and types

#### Properties

type?: string

The task type to return;

version?: string

The task version as used in the tasks.json file. The string support the package.json semver notation.

### TaskGroup

A grouping for tasks. The editor by default supports the 'Clean', 'Build', 'RebuildAll' and 'Test' group.

#### Static

Build: [TaskGroup](#TaskGroup)

The build task group;

Clean: [TaskGroup](#TaskGroup)

The clean task group;

Rebuild: [TaskGroup](#TaskGroup)

The rebuild all task group;

Test: [TaskGroup](#TaskGroup)

The test all task group;

#### Constructors

new TaskGroup(id: string, label: string): [TaskGroup](#TaskGroup)

Private constructor

| Parameter | Description |
| --- | --- |
| id: string | Identifier of a task group. |
| label: string | The human-readable name of a task group. |
| Returns | Description |
| [TaskGroup](#TaskGroup) |     |

#### Properties

id: string

The ID of the task group. Is one of TaskGroup.Clean.id, TaskGroup.Build.id, TaskGroup.Rebuild.id, or TaskGroup.Test.id.

isDefault: boolean

Whether the task that is part of this group is the default for the group. This property cannot be set through API, and is controlled by a user's task configurations.

### TaskPanelKind

Controls how the task channel is used between tasks

#### Enumeration Members

Shared: 1

Shares a panel with other tasks. This is the default.

Dedicated: 2

Uses a dedicated panel for this tasks. The panel is not shared with other tasks.

New: 3

Creates a new panel whenever this task is executed.

### TaskPresentationOptions

Controls how the task is presented in the UI.

#### Properties

clear?: boolean

Controls whether the terminal is cleared before executing the task.

close?: boolean

Controls whether the terminal is closed after executing the task.

echo?: boolean

Controls whether the command associated with the task is echoed in the user interface.

focus?: boolean

Controls whether the panel showing the task output is taking focus.

panel?: [TaskPanelKind](#TaskPanelKind)

Controls if the task panel is used for this task only (dedicated), shared between tasks (shared) or if a new panel is created on every task execution (new). Defaults to `TaskInstanceKind.Shared`

reveal?: [TaskRevealKind](#TaskRevealKind)

Controls whether the task output is reveal in the user interface. Defaults to `RevealKind.Always`.

showReuseMessage?: boolean

Controls whether to show the "Terminal will be reused by tasks, press any key to close it" message.

### TaskProcessEndEvent

An event signaling the end of a process execution triggered through a task

#### Properties

execution: [TaskExecution](#TaskExecution)

The task execution for which the process got started.

exitCode: number

The process's exit code. Will be `undefined` when the task is terminated.

### TaskProcessStartEvent

An event signaling the start of a process execution triggered through a task

#### Properties

execution: [TaskExecution](#TaskExecution)

The task execution for which the process got started.

processId: number

The underlying process id.

### TaskProvider<T>

A task provider allows to add tasks to the task service. A task provider is registered via [tasks.registerTaskProvider](#tasks.registerTaskProvider).

#### Methods

provideTasks(token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Provides tasks.

| Parameter | Description |
| --- | --- |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | an array of tasks |

resolveTask(task: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

Resolves a task that has no [execution](#Task.execution) set. Tasks are often created from information found in the `tasks.json`\-file. Such tasks miss the information on how to execute them and a task provider must fill in the missing information in the `resolveTask`\-method. This method will not be called for tasks returned from the above `provideTasks` method since those tasks are always fully resolved. A valid default implementation for the `resolveTask` method is to return `undefined`.

Note that when filling in the properties of `task`, you _must_ be sure to use the exact same `TaskDefinition` and not create a new one. Other properties may be changed.

| Parameter | Description |
| --- | --- |
| task: T | The task to resolve. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | The resolved task |

### TaskRevealKind

Controls the behaviour of the terminal's visibility.

#### Enumeration Members

Always: 1

Always brings the terminal to front if the task is executed.

Silent: 2

Only brings the terminal to front if a problem is detected executing the task (e.g. the task couldn't be started because).

Never: 3

The terminal never comes to front when the task is executed.

### TaskScope

The scope of a task.

#### Enumeration Members

Global: 1

The task is a global task. Global tasks are currently not supported.

Workspace: 2

The task is a workspace task

### TaskStartEvent

An event signaling the start of a task execution.

This interface is not intended to be implemented.

#### Properties

execution: [TaskExecution](#TaskExecution)

The task item representing the task that got started.

### TelemetryLogger

A telemetry logger which can be used by extensions to log usage and error telemetry.

A logger wraps around an [sender](#TelemetrySender) but it guarantees that

*   user settings to disable or tweak telemetry are respected, and that
*   potential sensitive data is removed

It also enables an "echo UI" that prints whatever data is send and it allows the editor to forward unhandled errors to the respective extensions.

To get an instance of a `TelemetryLogger`, use [`createTelemetryLogger`](#env.createTelemetryLogger).

#### Events

onDidChangeEnableStates: [Event](#Event&lt;T&gt;)<[TelemetryLogger](#TelemetryLogger)\>

An [Event](#Event) which fires when the enablement state of usage or error telemetry changes.

#### Properties

isErrorsEnabled: boolean

Whether or not error telemetry is enabled for this logger.

isUsageEnabled: boolean

Whether or not usage telemetry is enabled for this logger.

#### Methods

dispose(): void

Dispose this object and free resources.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

logError(eventName: string, data?: Record<string, any\>): void

Log an error event.

After completing cleaning, telemetry setting checks, and data mix-in calls `TelemetrySender.sendEventData` to log the event. Differs from `logUsage` in that it will log the event if the telemetry setting is Error+. Automatically supports echoing to extension telemetry output channel.

| Parameter | Description |
| --- | --- |
| eventName: string | The event name to log |
| data?: Record<string, any\> | The data to log |
| Returns | Description |
| void |     |

logError(error: Error, data?: Record<string, any\>): void

Log an error event.

Calls `TelemetrySender.sendErrorData`. Does cleaning, telemetry checks, and data mix-in. Automatically supports echoing to extension telemetry output channel. Will also automatically log any exceptions thrown within the extension host process.

| Parameter | Description |
| --- | --- |
| error: Error | The error object which contains the stack trace cleaned of PII |
| data?: Record<string, any\> | Additional data to log alongside the stack trace |
| Returns | Description |
| void |     |

logUsage(eventName: string, data?: Record<string, any\>): void

Log a usage event.

After completing cleaning, telemetry setting checks, and data mix-in calls `TelemetrySender.sendEventData` to log the event. Automatically supports echoing to extension telemetry output channel.

| Parameter | Description |
| --- | --- |
| eventName: string | The event name to log |
| data?: Record<string, any\> | The data to log |
| Returns | Description |
| void |     |

### TelemetryLoggerOptions

Options for creating a [TelemetryLogger](#TelemetryLogger)

#### Properties

additionalCommonProperties?: Record<string, any\>

Any additional common properties which should be injected into the data object.

ignoreBuiltInCommonProperties?: boolean

Whether or not you want to avoid having the built-in common properties such as os, extension name, etc injected into the data object. Defaults to `false` if not defined.

ignoreUnhandledErrors?: boolean

Whether or not unhandled errors on the extension host caused by your extension should be logged to your sender. Defaults to `false` if not defined.

### TelemetrySender

The telemetry sender is the contract between a telemetry logger and some telemetry service. **Note** that extensions must NOT call the methods of their sender directly as the logger provides extra guards and cleaning.

```
const sender: vscode.TelemetrySender = {...};
const logger = vscode.env.createTelemetryLogger(sender);

// GOOD - uses the logger
logger.logUsage('myEvent', { myData: 'myValue' });

// BAD - uses the sender directly: no data cleansing, ignores user settings, no echoing to the telemetry output channel etc
sender.logEvent('myEvent', { myData: 'myValue' });
```

#### Methods

flush(): void | Thenable<void\>

Optional flush function which will give this sender a chance to send any remaining events as its [TelemetryLogger](#TelemetryLogger) is being disposed

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void \| Thenable<void\> |     |

sendErrorData(error: Error, data?: Record<string, any\>): void

Function to send an error. Used within a [TelemetryLogger](#TelemetryLogger)

| Parameter | Description |
| --- | --- |
| error: Error | The error being logged |
| data?: Record<string, any\> | Any additional data to be collected with the exception |
| Returns | Description |
| void |     |

sendEventData(eventName: string, data?: Record<string, any\>): void

Function to send event data without a stacktrace. Used within a [TelemetryLogger](#TelemetryLogger)

| Parameter | Description |
| --- | --- |
| eventName: string | The name of the event which you are logging |
| data?: Record<string, any\> | A serializable key value pair that is being logged |
| Returns | Description |
| void |     |

### TelemetryTrustedValue<T>

A special value wrapper denoting a value that is safe to not clean. This is to be used when you can guarantee no identifiable information is contained in the value and the cleaning is improperly redacting it.

#### Constructors

new TelemetryTrustedValue<T\>(value: T): [TelemetryTrustedValue](#TelemetryTrustedValue&lt;T&gt;)<T\>

Creates a new telemetry trusted value.

| Parameter | Description |
| --- | --- |
| value: T | A value to trust |
| Returns | Description |
| [TelemetryTrustedValue](#TelemetryTrustedValue&lt;T&gt;)<T\> |     |

#### Properties

value: T

The value that is trusted to not contain PII.

### Terminal

An individual terminal instance within the integrated terminal.

#### Properties

creationOptions: Readonly<[TerminalOptions](#TerminalOptions) | [ExtensionTerminalOptions](#ExtensionTerminalOptions)\>

The object used to initialize the terminal, this is useful for example to detecting the shell type of when the terminal was not launched by this extension or for detecting what folder the shell was launched in.

exitStatus: [TerminalExitStatus](#TerminalExitStatus)

The exit status of the terminal, this will be undefined while the terminal is active.

**Example:** Show a notification with the exit code when the terminal exits with a non-zero exit code.

```
window.onDidCloseTerminal(t => {
  if (t.exitStatus && t.exitStatus.code) {
    vscode.window.showInformationMessage(`Exit code: ${t.exitStatus.code}`);
  }
});
```

name: string

The name of the terminal.

processId: Thenable<number\>

The process ID of the shell process.

shellIntegration: [TerminalShellIntegration](#TerminalShellIntegration)

An object that contains [shell integration](https://code.visualstudio.com/docs/terminal/shell-integration)\-powered features for the terminal. This will always be `undefined` immediately after the terminal is created. Listen to [window.onDidChangeTerminalShellIntegration](#window.onDidChangeTerminalShellIntegration) to be notified when shell integration is activated for a terminal.

Note that this object may remain undefined if shell integration never activates. For example Command Prompt does not support shell integration and a user's shell setup could conflict with the automatic shell integration activation.

state: [TerminalState](#TerminalState)

The current state of the [Terminal](#Terminal).

#### Methods

dispose(): void

Dispose and free associated resources.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

hide(): void

Hide the terminal panel if this terminal is currently showing.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

sendText(text: string, shouldExecute?: boolean): void

Send text to the terminal. The text is written to the stdin of the underlying pty process (shell) of the terminal.

| Parameter | Description |
| --- | --- |
| text: string | The text to send. |
| shouldExecute?: boolean | Indicates that the text being sent should be executed rather than just inserted in the terminal. The character(s) added are `\n` or `\r\n`, depending on the platform. This defaults to `true`. |
| Returns | Description |
| void |     |

show(preserveFocus?: boolean): void

Show the terminal panel and reveal this terminal in the UI.

| Parameter | Description |
| --- | --- |
| preserveFocus?: boolean | When `true` the terminal will not take focus. |
| Returns | Description |
| void |     |

### TerminalDimensions

Represents the dimensions of a terminal.

#### Properties

columns: number

The number of columns in the terminal.

rows: number

The number of rows in the terminal.

### TerminalEditorLocationOptions

Assumes a [TerminalLocation](#TerminalLocation) of editor and allows specifying a [ViewColumn](#ViewColumn) and [preserveFocus](#TerminalEditorLocationOptions.preserveFocus) property

#### Properties

preserveFocus?: boolean

An optional flag that when `true` will stop the [Terminal](#Terminal) from taking focus.

viewColumn: [ViewColumn](#ViewColumn)

A view column in which the [terminal](#Terminal) should be shown in the editor area. The default is the [active](#ViewColumn.Active). Columns that do not exist will be created as needed up to the maximum of [ViewColumn.Nine](#ViewColumn.Nine). Use [ViewColumn.Beside](#ViewColumn.Beside) to open the editor to the side of the currently active one.

### TerminalExitReason

Terminal exit reason kind.

#### Enumeration Members

Unknown: 0

Unknown reason.

Shutdown: 1

The window closed/reloaded.

Process: 2

The shell process exited.

User: 3

The user closed the terminal.

Extension: 4

An extension disposed the terminal.

### TerminalExitStatus

Represents how a terminal exited.

#### Properties

code: number

The exit code that a terminal exited with, it can have the following values:

*   Zero: the terminal process or custom execution succeeded.
*   Non-zero: the terminal process or custom execution failed.
*   `undefined`: the user forcibly closed the terminal or a custom execution exited without providing an exit code.

reason: [TerminalExitReason](#TerminalExitReason)

The reason that triggered the exit of a terminal.

### TerminalLink

A link on a terminal line.

#### Constructors

new TerminalLink(startIndex: number, length: number, tooltip?: string): [TerminalLink](#TerminalLink)

Creates a new terminal link.

| Parameter | Description |
| --- | --- |
| startIndex: number | The start index of the link on [TerminalLinkContext.line](#TerminalLinkContext.line). |
| length: number | The length of the link on [TerminalLinkContext.line](#TerminalLinkContext.line). |
| tooltip?: string | The tooltip text when you hover over this link.<br><br>If a tooltip is provided, is will be displayed in a string that includes instructions on how to trigger the link, such as `{0} (ctrl + click)`. The specific instructions vary depending on OS, user settings, and localization. |
| Returns | Description |
| [TerminalLink](#TerminalLink) |     |

#### Properties

length: number

The length of the link on [TerminalLinkContext.line](#TerminalLinkContext.line).

startIndex: number

The start index of the link on [TerminalLinkContext.line](#TerminalLinkContext.line).

tooltip?: string

The tooltip text when you hover over this link.

If a tooltip is provided, is will be displayed in a string that includes instructions on how to trigger the link, such as `{0} (ctrl + click)`. The specific instructions vary depending on OS, user settings, and localization.

### TerminalLinkContext

Provides information on a line in a terminal in order to provide links for it.

#### Properties

line: string

This is the text from the unwrapped line in the terminal.

terminal: [Terminal](#Terminal)

The terminal the link belongs to.

### TerminalLinkProvider<T>

A provider that enables detection and handling of links within terminals.

#### Methods

handleTerminalLink(link: T): [ProviderResult](#ProviderResult&lt;T&gt;)<void\>

Handle an activated terminal link.

| Parameter | Description |
| --- | --- |
| link: T | The link to handle. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<void\> |     |

provideTerminalLinks(context: [TerminalLinkContext](#TerminalLinkContext), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Provide terminal links for the given context. Note that this can be called multiple times even before previous calls resolve, make sure to not share global objects (eg. `RegExp`) that could have problems when asynchronous usage may overlap.

| Parameter | Description |
| --- | --- |
| context: [TerminalLinkContext](#TerminalLinkContext) | Information about what links are being provided for. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | A list of terminal links for the given line. |

### TerminalLocation

The location of the terminal.

#### Enumeration Members

Panel: 1

In the terminal view

Editor: 2

In the editor area

### TerminalOptions

Value-object describing what options a terminal should use.

#### Properties

color?: [ThemeColor](#ThemeColor)

The icon [ThemeColor](#ThemeColor) for the terminal. The `terminal.ansi*` theme keys are recommended for the best contrast and consistency across themes.

cwd?: string | [Uri](#Uri)

A path or Uri for the current working directory to be used for the terminal.

env?:

Object with environment variables that will be added to the editor process.

hideFromUser?: boolean

When enabled the terminal will run the process as normal but not be surfaced to the user until `Terminal.show` is called. The typical usage for this is when you need to run something that may need interactivity but only want to tell the user about it when interaction is needed. Note that the terminals will still be exposed to all extensions as normal. The hidden terminals will not be restored when the workspace is next opened.

iconPath?: [IconPath](#IconPath)

The icon path or [ThemeIcon](#ThemeIcon) for the terminal.

isTransient?: boolean

Opt-out of the default terminal persistence on restart and reload. This will only take effect when `terminal.integrated.enablePersistentSessions` is enabled.

location?: [TerminalEditorLocationOptions](#TerminalEditorLocationOptions) | [TerminalSplitLocationOptions](#TerminalSplitLocationOptions) | [TerminalLocation](#TerminalLocation)

The [TerminalLocation](#TerminalLocation) or [TerminalEditorLocationOptions](#TerminalEditorLocationOptions) or [TerminalSplitLocationOptions](#TerminalSplitLocationOptions) for the terminal.

message?: string

A message to write to the terminal on first launch, note that this is not sent to the process but, rather written directly to the terminal. This supports escape sequences such a setting text style.

name?: string

A human-readable string which will be used to represent the terminal in the UI.

shellArgs?: string | string\[\]

Args for the custom shell executable. A string can be used on Windows only which allows specifying shell args in [command-line format](https://msdn.microsoft.com/en-au/08dfcab2-eb6e-49a4-80eb-87d4076c98c6).

shellIntegrationNonce?: string

The nonce to use to verify shell integration sequences are coming from a trusted source. An example impact of UX of this is if the command line is reported with a nonce, it will not need to verify with the user that the command line is correct before rerunning it via the [shell integration command decoration](https://code.visualstudio.com/docs/terminal/shell-integration#_command-decorations-and-the-overview-ruler).

This should be used if the terminal includes [custom shell integration support](https://code.visualstudio.com/docs/terminal/shell-integration#_supported-escape-sequences). It should be set to a random GUID which will then set the `VSCODE_NONCE` environment variable. Inside the shell, this should then be removed from the environment so as to protect it from general access. Once that is done it can be passed through in the relevant sequences to make them trusted.

shellPath?: string

A path to a custom shell executable to be used in the terminal.

strictEnv?: boolean

Whether the terminal process environment should be exactly as provided in `TerminalOptions.env`. When this is false (default), the environment will be based on the window's environment and also apply configured platform settings like `terminal.integrated.env.windows` on top. When this is true, the complete environment must be provided as nothing will be inherited from the process or any configuration.

### TerminalProfile

A terminal profile defines how a terminal will be launched.

#### Constructors

new TerminalProfile(options: [TerminalOptions](#TerminalOptions) | [ExtensionTerminalOptions](#ExtensionTerminalOptions)): [TerminalProfile](#TerminalProfile)

Creates a new terminal profile.

| Parameter | Description |
| --- | --- |
| options: [TerminalOptions](#TerminalOptions) \| [ExtensionTerminalOptions](#ExtensionTerminalOptions) | The options that the terminal will launch with. |
| Returns | Description |
| [TerminalProfile](#TerminalProfile) |     |

#### Properties

options: [TerminalOptions](#TerminalOptions) | [ExtensionTerminalOptions](#ExtensionTerminalOptions)

The options that the terminal will launch with.

### TerminalProfileProvider

Provides a terminal profile for the contributed terminal profile when launched via the UI or command.

#### Methods

provideTerminalProfile(token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[TerminalProfile](#TerminalProfile)\>

Provide the terminal profile.

| Parameter | Description |
| --- | --- |
| token: [CancellationToken](#CancellationToken) | A cancellation token that indicates the result is no longer needed. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[TerminalProfile](#TerminalProfile)\> | The terminal profile. |

### TerminalShellExecution

A command that was executed in a terminal.

#### Properties

commandLine: [TerminalShellExecutionCommandLine](#TerminalShellExecutionCommandLine)

The command line that was executed. The [confidence](#TerminalShellExecutionCommandLineConfidence) of this value depends on the specific shell's shell integration implementation. This value may become more accurate after [window.onDidEndTerminalShellExecution](#window.onDidEndTerminalShellExecution) is fired.

**Example**

```
// Log the details of the command line on start and end
window.onDidStartTerminalShellExecution(event => {
  const commandLine = event.execution.commandLine;
  console.log(`Command started\n${summarizeCommandLine(commandLine)}`);
});
window.onDidEndTerminalShellExecution(event => {
  const commandLine = event.execution.commandLine;
  console.log(`Command ended\n${summarizeCommandLine(commandLine)}`);
});
function summarizeCommandLine(commandLine: TerminalShellExecutionCommandLine) {
  return [
    `  Command line: ${command.commandLine.value}`,
    `  Confidence: ${command.commandLine.confidence}`,
    `  Trusted: ${command.commandLine.isTrusted}
  ].join('\n');
}
```

cwd: [Uri](#Uri)

The working directory that was reported by the shell when this command executed. This [Uri](#Uri) may represent a file on another machine (eg. ssh into another machine). This requires the shell integration to support working directory reporting.

#### Methods

read(): AsyncIterable<string\>

Creates a stream of raw data (including escape sequences) that is written to the terminal. This will only include data that was written after `read` was called for the first time, ie. you must call `read` immediately after the command is executed via [TerminalShellIntegration.executeCommand](#TerminalShellIntegration.executeCommand) or [window.onDidStartTerminalShellExecution](#window.onDidStartTerminalShellExecution) to not miss any data.

**Example**

```
// Log all data written to the terminal for a command
const command = term.shellIntegration.executeCommand({ commandLine: 'echo "Hello world"' });
const stream = command.read();
for await (const data of stream) {
  console.log(data);
}
```

| Parameter | Description |
| --- | --- |
| Returns | Description |
| AsyncIterable<string\> |     |

### TerminalShellExecutionCommandLine

A command line that was executed in a terminal.

#### Properties

confidence: [TerminalShellExecutionCommandLineConfidence](#TerminalShellExecutionCommandLineConfidence)

The confidence of the command line value which is determined by how the value was obtained. This depends upon the implementation of the shell integration script.

isTrusted: boolean

Whether the command line value came from a trusted source and is therefore safe to execute without user additional confirmation, such as a notification that asks "Do you want to execute (command)?". This verification is likely only needed if you are going to execute the command again.

This is `true` only when the command line was reported explicitly by the shell integration script (ie. [high confidence](#TerminalShellExecutionCommandLineConfidence.High)) and it used a nonce for verification.

value: string

The full command line that was executed, including both the command and its arguments.

### TerminalShellExecutionCommandLineConfidence

The confidence of a [TerminalShellExecutionCommandLine](#TerminalShellExecutionCommandLine) value.

#### Enumeration Members

Low: 0

The command line value confidence is low. This means that the value was read from the terminal buffer using markers reported by the shell integration script. Additionally one of the following conditions will be met:

*   The command started on the very left-most column which is unusual, or
*   The command is multi-line which is more difficult to accurately detect due to line continuation characters and right prompts.
*   Command line markers were not reported by the shell integration script.

Medium: 1

The command line value confidence is medium. This means that the value was read from the terminal buffer using markers reported by the shell integration script. The command is single-line and does not start on the very left-most column (which is unusual).

High: 2

The command line value confidence is high. This means that the value was explicitly sent from the shell integration script or the command was executed via the [TerminalShellIntegration.executeCommand](#TerminalShellIntegration.executeCommand) API.

### TerminalShellExecutionEndEvent

An event signalling that an execution has ended in a terminal.

#### Properties

execution: [TerminalShellExecution](#TerminalShellExecution)

The terminal shell execution that has ended.

exitCode: number

The exit code reported by the shell.

When this is `undefined` it can mean several things:

*   The shell either did not report an exit code (ie. the shell integration script is misbehaving)
*   The shell reported a command started before the command finished (eg. a sub-shell was opened).
*   The user canceled the command via ctrl+c.
*   The user pressed enter when there was no input.

Generally this should not happen. Depending on the use case, it may be best to treat this as a failure.

**Example**

```
const execution = shellIntegration.executeCommand({
  command: 'echo',
  args: ['Hello world']
});
window.onDidEndTerminalShellExecution(event => {
  if (event.execution === execution) {
    if (event.exitCode === undefined) {
      console.log('Command finished but exit code is unknown');
    } else if (event.exitCode === 0) {
      console.log('Command succeeded');
    } else {
      console.log('Command failed');
    }
  }
});
```

shellIntegration: [TerminalShellIntegration](#TerminalShellIntegration)

The shell integration object.

terminal: [Terminal](#Terminal)

The terminal that shell integration has been activated in.

### TerminalShellExecutionStartEvent

An event signalling that an execution has started in a terminal.

#### Properties

execution: [TerminalShellExecution](#TerminalShellExecution)

The terminal shell execution that has ended.

shellIntegration: [TerminalShellIntegration](#TerminalShellIntegration)

The shell integration object.

terminal: [Terminal](#Terminal)

The terminal that shell integration has been activated in.

### TerminalShellIntegration

[Shell integration](https://code.visualstudio.com/docs/terminal/shell-integration)\-powered capabilities owned by a terminal.

#### Properties

cwd: [Uri](#Uri)

The current working directory of the terminal. This [Uri](#Uri) may represent a file on another machine (eg. ssh into another machine). This requires the shell integration to support working directory reporting.

#### Methods

executeCommand(commandLine: string): [TerminalShellExecution](#TerminalShellExecution)

Execute a command, sending ^C as necessary to interrupt any running command if needed.

*   _throws_ - When run on a terminal doesn't support this API, such as task terminals.

**Example**

```
// Execute a command in a terminal immediately after being created
const myTerm = window.createTerminal();
window.onDidChangeTerminalShellIntegration(async ({ terminal, shellIntegration }) => {
  if (terminal === myTerm) {
    const execution = shellIntegration.executeCommand('echo "Hello world"');
    window.onDidEndTerminalShellExecution(event => {
      if (event.execution === execution) {
        console.log(`Command exited with code ${event.exitCode}`);
      }
    });
  }
}));
// Fallback to sendText if there is no shell integration within 3 seconds of launching
setTimeout(() => {
  if (!myTerm.shellIntegration) {
    myTerm.sendText('echo "Hello world"');
    // Without shell integration, we can't know when the command has finished or what the
    // exit code was.
  }
}, 3000);
```

**Example**

```
// Send command to terminal that has been alive for a while
const commandLine = 'echo "Hello world"';
if (term.shellIntegration) {
  const execution = shellIntegration.executeCommand({ commandLine });
  window.onDidEndTerminalShellExecution(event => {
    if (event.execution === execution) {
      console.log(`Command exited with code ${event.exitCode}`);
    }
  });
} else {
  term.sendText(commandLine);
  // Without shell integration, we can't know when the command has finished or what the
  // exit code was.
}
```

| Parameter | Description |
| --- | --- |
| commandLine: string | The command line to execute, this is the exact text that will be sent to the terminal. |
| Returns | Description |
| [TerminalShellExecution](#TerminalShellExecution) |     |

executeCommand(executable: string, args: string\[\]): [TerminalShellExecution](#TerminalShellExecution)

Execute a command, sending ^C as necessary to interrupt any running command if needed.

_Note_ This is not guaranteed to work as [shell integration](https://code.visualstudio.com/docs/terminal/shell-integration) must be activated. Check whether [TerminalShellExecution.exitCode](#TerminalShellExecution.exitCode) is rejected to verify whether it was successful.

**Example**

```
// Execute a command in a terminal immediately after being created
const myTerm = window.createTerminal();
window.onDidChangeTerminalShellIntegration(async ({ terminal, shellIntegration }) => {
  if (terminal === myTerm) {
    const command = shellIntegration.executeCommand({
      command: 'echo',
      args: ['Hello world']
    });
    const code = await command.exitCode;
    console.log(`Command exited with code ${code}`);
  }
}));
// Fallback to sendText if there is no shell integration within 3 seconds of launching
setTimeout(() => {
  if (!myTerm.shellIntegration) {
    myTerm.sendText('echo "Hello world"');
    // Without shell integration, we can't know when the command has finished or what the
    // exit code was.
  }
}, 3000);
```

**Example**

```
// Send command to terminal that has been alive for a while
const commandLine = 'echo "Hello world"';
if (term.shellIntegration) {
  const command = term.shellIntegration.executeCommand({
    command: 'echo',
    args: ['Hello world']
  });
  const code = await command.exitCode;
  console.log(`Command exited with code ${code}`);
} else {
  term.sendText(commandLine);
  // Without shell integration, we can't know when the command has finished or what the
  // exit code was.
}
```

| Parameter | Description |
| --- | --- |
| executable: string | A command to run. |
| args: string\[\] | Arguments to launch the executable with. The arguments will be escaped such that they are interpreted as single arguments when the argument both contains whitespace and does not include any single quote, double quote or backtick characters.<br><br>Note that this escaping is not intended to be a security measure, be careful when passing untrusted data to this API as strings like `$(...)` can often be used in shells to execute code within a string. |
| Returns | Description |
| [TerminalShellExecution](#TerminalShellExecution) |     |

### TerminalShellIntegrationChangeEvent

An event signalling that a terminal's shell integration has changed.

#### Properties

shellIntegration: [TerminalShellIntegration](#TerminalShellIntegration)

The shell integration object.

terminal: [Terminal](#Terminal)

The terminal that shell integration has been activated in.

### TerminalSplitLocationOptions

Uses the parent [Terminal](#Terminal)'s location for the terminal

#### Properties

parentTerminal: [Terminal](#Terminal)

The parent terminal to split this terminal beside. This works whether the parent terminal is in the panel or the editor area.

### TerminalState

Represents the state of a [Terminal](#Terminal).

#### Properties

isInteractedWith: boolean

Whether the [Terminal](#Terminal) has been interacted with. Interaction means that the terminal has sent data to the process which depending on the terminal's _mode_. By default input is sent when a key is pressed or when a command or extension sends text, but based on the terminal's mode it can also happen on:

*   a pointer click event
*   a pointer scroll event
*   a pointer move event
*   terminal focus in/out

For more information on events that can send data see "DEC Private Mode Set (DECSET)" on [https://invisible-island.net/xterm/ctlseqs/ctlseqs.html](https://invisible-island.net/xterm/ctlseqs/ctlseqs.html)

shell: string

The detected shell type of the [Terminal](#Terminal). This will be `undefined` when there is not a clear signal as to what the shell is, or the shell is not supported yet. This value should change to the shell type of a sub-shell when launched (for example, running `bash` inside `zsh`).

Note that the possible values are currently defined as any of the following: 'bash', 'cmd', 'csh', 'fish', 'gitbash', 'julia', 'ksh', 'node', 'nu', 'pwsh', 'python', 'sh', 'wsl', 'xonsh', 'zsh'.

### TestController

Entry point to discover and execute tests. It contains [TestController.items](#TestController.items) which are used to populate the editor UI, and is associated with [run profiles](#TestController.createRunProfile) to allow for tests to be executed.

#### Properties

id: string

The id of the controller passed in [tests.createTestController](#tests.createTestController). This must be globally unique.

items: [TestItemCollection](#TestItemCollection)

A collection of "top-level" [TestItem](#TestItem) instances, which can in turn have their own [children](#TestItem.children) to form the "test tree."

The extension controls when to add tests. For example, extensions should add tests for a file when [workspace.onDidOpenTextDocument](#workspace.onDidOpenTextDocument) fires in order for decorations for tests within a file to be visible.

However, the editor may sometimes explicitly request children using the [resolveHandler](#TestController.resolveHandler) See the documentation on that method for more details.

label: string

Human-readable label for the test controller.

refreshHandler: (token: [CancellationToken](#CancellationToken)) => void | Thenable<void\>

If this method is present, a refresh button will be present in the UI, and this method will be invoked when it's clicked. When called, the extension should scan the workspace for any new, changed, or removed tests.

It's recommended that extensions try to update tests in realtime, using a [FileSystemWatcher](#FileSystemWatcher) for example, and use this method as a fallback.

| Parameter | Description |
| --- | --- |
| token: [CancellationToken](#CancellationToken) |     |
| Returns | Description |
| void \| Thenable<void\> | A thenable that resolves when tests have been refreshed. |

resolveHandler?: (item: [TestItem](#TestItem)) => void | Thenable<void\>

A function provided by the extension that the editor may call to request children of a test item, if the [TestItem.canResolveChildren](#TestItem.canResolveChildren) is `true`. When called, the item should discover children and call [TestController.createTestItem](#TestController.createTestItem) as children are discovered.

Generally the extension manages the lifecycle of test items, but under certain conditions the editor may request the children of a specific item to be loaded. For example, if the user requests to re-run tests after reloading the editor, the editor may need to call this method to resolve the previously-run tests.

The item in the explorer will automatically be marked as "busy" until the function returns or the returned thenable resolves.

| Parameter | Description |
| --- | --- |
| item: [TestItem](#TestItem) | An unresolved test item for which children are being requested, or `undefined` to resolve the controller's initial [items](#TestController.items). |
| Returns | Description |
| void \| Thenable<void\> |     |

#### Methods

createRunProfile(label: string, kind: [TestRunProfileKind](#TestRunProfileKind), runHandler: (request: [TestRunRequest](#TestRunRequest), token: [CancellationToken](#CancellationToken)) => void | Thenable<void\>, isDefault?: boolean, tag?: [TestTag](#TestTag), supportsContinuousRun?: boolean): [TestRunProfile](#TestRunProfile)

Creates a profile used for running tests. Extensions must create at least one profile in order for tests to be run.

| Parameter | Description |
| --- | --- |
| label: string | A human-readable label for this profile. |
| kind: [TestRunProfileKind](#TestRunProfileKind) | Configures what kind of execution this profile manages. |
| runHandler: (request: [TestRunRequest](#TestRunRequest), token: [CancellationToken](#CancellationToken)) => void \| Thenable<void\> | Function called to start a test run. |
| isDefault?: boolean | Whether this is the default action for its kind. |
| tag?: [TestTag](#TestTag) | Profile test tag. |
| supportsContinuousRun?: boolean | Whether the profile supports continuous running. |
| Returns | Description |
| [TestRunProfile](#TestRunProfile) | An instance of a [TestRunProfile](#TestRunProfile), which is automatically associated with this controller. |

createTestItem(id: string, label: string, uri?: [Uri](#Uri)): [TestItem](#TestItem)

Creates a new managed [TestItem](#TestItem) instance. It can be added into the [TestItem.children](#TestItem.children) of an existing item, or into the [TestController.items](#TestController.items).

| Parameter | Description |
| --- | --- |
| id: string | Identifier for the TestItem. The test item's ID must be unique in the [TestItemCollection](#TestItemCollection) it's added to. |
| label: string | Human-readable label of the test item. |
| uri?: [Uri](#Uri) | URI this TestItem is associated with. May be a file or directory. |
| Returns | Description |
| [TestItem](#TestItem) |     |

createTestRun(request: [TestRunRequest](#TestRunRequest), name?: string, persist?: boolean): [TestRun](#TestRun)

Creates a [TestRun](#TestRun). This should be called by the [TestRunProfile](#TestRunProfile) when a request is made to execute tests, and may also be called if a test run is detected externally. Once created, tests that are included in the request will be moved into the queued state.

All runs created using the same `request` instance will be grouped together. This is useful if, for example, a single suite of tests is run on multiple platforms.

| Parameter | Description |
| --- | --- |
| request: [TestRunRequest](#TestRunRequest) | Test run request. Only tests inside the `include` may be modified, and tests in its `exclude` are ignored. |
| name?: string | The human-readable name of the run. This can be used to disambiguate multiple sets of results in a test run. It is useful if tests are run across multiple platforms, for example. |
| persist?: boolean | Whether the results created by the run should be persisted in the editor. This may be false if the results are coming from a file already saved externally, such as a coverage information file. |
| Returns | Description |
| [TestRun](#TestRun) | An instance of the [TestRun](#TestRun). It will be considered "running" from the moment this method is invoked until [TestRun.end](#TestRun.end) is called. |

dispose(): void

Unregisters the test controller, disposing of its associated tests and unpersisted results.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

invalidateTestResults(items?: [TestItem](#TestItem) | readonly [TestItem](#TestItem)\[\]): void

Marks an item's results as being outdated. This is commonly called when code or configuration changes and previous results should no longer be considered relevant. The same logic used to mark results as outdated may be used to drive [continuous test runs](#TestRunRequest.continuous).

If an item is passed to this method, test results for the item and all of its children will be marked as outdated. If no item is passed, then all test owned by the TestController will be marked as outdated.

Any test runs started before the moment this method is called, including runs which may still be ongoing, will be marked as outdated and deprioritized in the editor's UI.

| Parameter | Description |
| --- | --- |
| items?: [TestItem](#TestItem) \| readonly [TestItem](#TestItem)\[\] | Item to mark as outdated. If undefined, all the controller's items are marked outdated. |
| Returns | Description |
| void |     |

### TestCoverageCount

A class that contains information about a covered resource. A count can be give for lines, branches, and declarations in a file.

#### Constructors

new TestCoverageCount(covered: number, total: number): [TestCoverageCount](#TestCoverageCount)

| Parameter | Description |
| --- | --- |
| covered: number | Value for [TestCoverageCount.covered](#TestCoverageCount.covered) |
| total: number | Value for [TestCoverageCount.total](#TestCoverageCount.total) |
| Returns | Description |
| [TestCoverageCount](#TestCoverageCount) |     |

#### Properties

covered: number

Number of items covered in the file.

total: number

Total number of covered items in the file.

### TestItem

An item shown in the "test explorer" view.

A `TestItem` can represent either a test suite or a test itself, since they both have similar capabilities.

#### Properties

busy: boolean

Controls whether the item is shown as "busy" in the Test Explorer view. This is useful for showing status while discovering children.

Defaults to `false`.

canResolveChildren: boolean

Indicates whether this test item may have children discovered by resolving.

If true, this item is shown as expandable in the Test Explorer view and expanding the item will cause [TestController.resolveHandler](#TestController.resolveHandler) to be invoked with the item.

Default to `false`.

children: [TestItemCollection](#TestItemCollection)

The children of this test item. For a test suite, this may contain the individual test cases or nested suites.

description?: string

Optional description that appears next to the label.

error: string | [MarkdownString](#MarkdownString)

Optional error encountered while loading the test.

Note that this is not a test result and should only be used to represent errors in test discovery, such as syntax errors.

id: string

Identifier for the `TestItem`. This is used to correlate test results and tests in the document with those in the workspace (test explorer). This cannot change for the lifetime of the `TestItem`, and must be unique among its parent's direct children.

label: string

Display name describing the test case.

parent: [TestItem](#TestItem)

The parent of this item. It's set automatically, and is undefined top-level items in the [TestController.items](#TestController.items) and for items that aren't yet included in another item's [children](#TestItem.children).

range: [Range](#Range)

Location of the test item in its [uri](#TestItem.uri).

This is only meaningful if the `uri` points to a file.

sortText?: string

A string that should be used when comparing this item with other items. When `falsy` the [label](#TestItem.label) is used.

tags: readonly [TestTag](#TestTag)\[\]

Tags associated with this test item. May be used in combination with [tags](#TestRunProfile.tag), or simply as an organizational feature.

uri: [Uri](#Uri)

URI this `TestItem` is associated with. May be a file or directory.

### TestItemCollection

Collection of test items, found in [TestItem.children](#TestItem.children) and [TestController.items](#TestController.items).

#### Properties

size: number

Gets the number of items in the collection.

#### Methods

add(item: [TestItem](#TestItem)): void

Adds the test item to the children. If an item with the same ID already exists, it'll be replaced.

| Parameter | Description |
| --- | --- |
| item: [TestItem](#TestItem) | Item to add. |
| Returns | Description |
| void |     |

delete(itemId: string): void

Removes a single test item from the collection.

| Parameter | Description |
| --- | --- |
| itemId: string | Item ID to delete. |
| Returns | Description |
| void |     |

forEach(callback: (item: [TestItem](#TestItem), collection: [TestItemCollection](#TestItemCollection)) => unknown, thisArg?: any): void

Iterate over each entry in this collection.

| Parameter | Description |
| --- | --- |
| callback: (item: [TestItem](#TestItem), collection: [TestItemCollection](#TestItemCollection)) => unknown | Function to execute for each entry. |
| thisArg?: any | The `this` context used when invoking the handler function. |
| Returns | Description |
| void |     |

get(itemId: string): [TestItem](#TestItem)

Efficiently gets a test item by ID, if it exists, in the children.

| Parameter | Description |
| --- | --- |
| itemId: string | Item ID to get. |
| Returns | Description |
| [TestItem](#TestItem) | The found item or undefined if it does not exist. |

replace(items: readonly [TestItem](#TestItem)\[\]): void

Replaces the items stored by the collection.

| Parameter | Description |
| --- | --- |
| items: readonly [TestItem](#TestItem)\[\] | Items to store. |
| Returns | Description |
| void |     |

### TestMessage

Message associated with the test state. Can be linked to a specific source range -- useful for assertion failures, for example.

#### Static

diff(message: string | [MarkdownString](#MarkdownString), expected: string, actual: string): [TestMessage](#TestMessage)

Creates a new TestMessage that will present as a diff in the editor.

| Parameter | Description |
| --- | --- |
| message: string \| [MarkdownString](#MarkdownString) | Message to display to the user. |
| expected: string | Expected output. |
| actual: string | Actual output. |
| Returns | Description |
| [TestMessage](#TestMessage) |     |

#### Constructors

new TestMessage(message: string | [MarkdownString](#MarkdownString)): [TestMessage](#TestMessage)

Creates a new TestMessage instance.

| Parameter | Description |
| --- | --- |
| message: string \| [MarkdownString](#MarkdownString) | The message to show to the user. |
| Returns | Description |
| [TestMessage](#TestMessage) |     |

#### Properties

actualOutput?: string

Actual test output. If given with [expectedOutput](#TestMessage.expectedOutput) , a diff view will be shown.

contextValue?: string

Context value of the test item. This can be used to contribute message- specific actions to the test peek view. The value set here can be found in the `testMessage` property of the following `menus` contribution points:

*   `testing/message/context` - context menu for the message in the results tree
*   `testing/message/content` - a prominent button overlaying editor content where the message is displayed.

For example:

```
"contributes": {
  "menus": {
    "testing/message/content": [
      {
        "command": "extension.deleteCommentThread",
        "when": "testMessage == canApplyRichDiff"
      }
    ]
  }
}
```

The command will be called with an object containing:

*   `test`: the [TestItem](#TestItem) the message is associated with, _if_ it is still present in the [TestController.items](#TestController.items) collection.
*   `message`: the [TestMessage](#TestMessage) instance.

expectedOutput?: string

Expected test output. If given with [actualOutput](#TestMessage.actualOutput) , a diff view will be shown.

location?: [Location](#Location)

Associated file location.

message: string | [MarkdownString](#MarkdownString)

Human-readable message text to display.

stackTrace?: [TestMessageStackFrame](#TestMessageStackFrame)\[\]

The stack trace associated with the message or failure.

### TestMessageStackFrame

A stack frame found in the [TestMessage.stackTrace](#TestMessage.stackTrace).

#### Constructors

new TestMessageStackFrame(label: string, uri?: [Uri](#Uri), position?: [Position](#Position)): [TestMessageStackFrame](#TestMessageStackFrame)

| Parameter | Description |
| --- | --- |
| label: string | The name of the stack frame |
| uri?: [Uri](#Uri) |     |
| position?: [Position](#Position) | The position of the stack frame within the file |
| Returns | Description |
| [TestMessageStackFrame](#TestMessageStackFrame) |     |

#### Properties

label: string

The name of the stack frame, typically a method or function name.

position?: [Position](#Position)

Position of the stack frame within the file.

uri?: [Uri](#Uri)

The location of this stack frame. This should be provided as a URI if the location of the call frame can be accessed by the editor.

### TestRun

A TestRun represents an in-progress or completed test run and provides methods to report the state of individual tests in the run.

#### Events

onDidDispose: [Event](#Event&lt;T&gt;)<void\>

An event fired when the editor is no longer interested in data associated with the test run.

#### Properties

isPersisted: boolean

Whether the test run will be persisted across reloads by the editor.

name: string

The human-readable name of the run. This can be used to disambiguate multiple sets of results in a test run. It is useful if tests are run across multiple platforms, for example.

token: [CancellationToken](#CancellationToken)

A cancellation token which will be triggered when the test run is canceled from the UI.

#### Methods

addCoverage(fileCoverage: [FileCoverage](#FileCoverage)): void

Adds coverage for a file in the run.

| Parameter | Description |
| --- | --- |
| fileCoverage: [FileCoverage](#FileCoverage) |     |
| Returns | Description |
| void |     |

appendOutput(output: string, location?: [Location](#Location), test?: [TestItem](#TestItem)): void

Appends raw output from the test runner. On the user's request, the output will be displayed in a terminal. ANSI escape sequences, such as colors and text styles, are supported. New lines must be given as CRLF (`\r\n`) rather than LF (`\n`).

| Parameter | Description |
| --- | --- |
| output: string | Output text to append. |
| location?: [Location](#Location) | Indicate that the output was logged at the given location. |
| test?: [TestItem](#TestItem) | Test item to associate the output with. |
| Returns | Description |
| void |     |

end(): void

Signals the end of the test run. Any tests included in the run whose states have not been updated will have their state reset.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

enqueued(test: [TestItem](#TestItem)): void

Indicates a test is queued for later execution.

| Parameter | Description |
| --- | --- |
| test: [TestItem](#TestItem) | Test item to update. |
| Returns | Description |
| void |     |

errored(test: [TestItem](#TestItem), message: [TestMessage](#TestMessage) | readonly [TestMessage](#TestMessage)\[\], duration?: number): void

Indicates a test has errored. You should pass one or more [TestMessages](#TestMessage) to describe the failure. This differs from the "failed" state in that it indicates a test that couldn't be executed at all, from a compilation error for example.

| Parameter | Description |
| --- | --- |
| test: [TestItem](#TestItem) | Test item to update. |
| message: [TestMessage](#TestMessage) \| readonly [TestMessage](#TestMessage)\[\] | Messages associated with the test failure. |
| duration?: number | How long the test took to execute, in milliseconds. |
| Returns | Description |
| void |     |

failed(test: [TestItem](#TestItem), message: [TestMessage](#TestMessage) | readonly [TestMessage](#TestMessage)\[\], duration?: number): void

Indicates a test has failed. You should pass one or more [TestMessages](#TestMessage) to describe the failure.

| Parameter | Description |
| --- | --- |
| test: [TestItem](#TestItem) | Test item to update. |
| message: [TestMessage](#TestMessage) \| readonly [TestMessage](#TestMessage)\[\] | Messages associated with the test failure. |
| duration?: number | How long the test took to execute, in milliseconds. |
| Returns | Description |
| void |     |

passed(test: [TestItem](#TestItem), duration?: number): void

Indicates a test has passed.

| Parameter | Description |
| --- | --- |
| test: [TestItem](#TestItem) | Test item to update. |
| duration?: number | How long the test took to execute, in milliseconds. |
| Returns | Description |
| void |     |

skipped(test: [TestItem](#TestItem)): void

Indicates a test has been skipped.

| Parameter | Description |
| --- | --- |
| test: [TestItem](#TestItem) | Test item to update. |
| Returns | Description |
| void |     |

started(test: [TestItem](#TestItem)): void

Indicates a test has started running.

| Parameter | Description |
| --- | --- |
| test: [TestItem](#TestItem) | Test item to update. |
| Returns | Description |
| void |     |

### TestRunProfile

A TestRunProfile describes one way to execute tests in a [TestController](#TestController).

#### Events

onDidChangeDefault: [Event](#Event&lt;T&gt;)<boolean\>

Fired when a user has changed whether this is a default profile. The event contains the new value of [isDefault](#TestRunProfile.isDefault)

#### Properties

configureHandler: () => void

If this method is present, a configuration gear will be present in the UI, and this method will be invoked when it's clicked. When called, you can take other editor actions, such as showing a quick pick or opening a configuration file.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

isDefault: boolean

Controls whether this profile is the default action that will be taken when its kind is actioned. For example, if the user clicks the generic "run all" button, then the default profile for [TestRunProfileKind.Run](#TestRunProfileKind.Run) will be executed, although the user can configure this.

Changes the user makes in their default profiles will be reflected in this property after a [onDidChangeDefault](#TestRunProfile.onDidChangeDefault) event.

kind: [TestRunProfileKind](#TestRunProfileKind)

Configures what kind of execution this profile controls. If there are no profiles for a kind, it will not be available in the UI.

label: string

Label shown to the user in the UI.

Note that the label has some significance if the user requests that tests be re-run in a certain way. For example, if tests were run normally and the user requests to re-run them in debug mode, the editor will attempt use a configuration with the same label of the `Debug` kind. If there is no such configuration, the default will be used.

loadDetailedCoverage?: (testRun: [TestRun](#TestRun), fileCoverage: [FileCoverage](#FileCoverage), token: [CancellationToken](#CancellationToken)) => Thenable<[FileCoverageDetail](#FileCoverageDetail)\[\]>

An extension-provided function that provides detailed statement and function-level coverage for a file. The editor will call this when more detail is needed for a file, such as when it's opened in an editor or expanded in the **Test Coverage** view.

The [FileCoverage](#FileCoverage) object passed to this function is the same instance emitted on [TestRun.addCoverage](#TestRun.addCoverage) calls associated with this profile.

| Parameter | Description |
| --- | --- |
| testRun: [TestRun](#TestRun) |     |
| fileCoverage: [FileCoverage](#FileCoverage) |     |
| token: [CancellationToken](#CancellationToken) |     |
| Returns | Description |
| Thenable<[FileCoverageDetail](#FileCoverageDetail)\[\]> |     |

loadDetailedCoverageForTest?: (testRun: [TestRun](#TestRun), fileCoverage: [FileCoverage](#FileCoverage), fromTestItem: [TestItem](#TestItem), token: [CancellationToken](#CancellationToken)) => Thenable<[FileCoverageDetail](#FileCoverageDetail)\[\]>

An extension-provided function that provides detailed statement and function-level coverage for a single test in a file. This is the per-test sibling of [TestRunProfile.loadDetailedCoverage](#TestRunProfile.loadDetailedCoverage), called only if a test item is provided in [FileCoverage.includesTests](#FileCoverage.includesTests) and only for files where such data is reported.

Often [TestRunProfile.loadDetailedCoverage](#TestRunProfile.loadDetailedCoverage) will be called first when a user opens a file, and then this method will be called if they drill down into specific per-test coverage information. This method should then return coverage data only for statements and declarations executed by the specific test during the run.

The [FileCoverage](#FileCoverage) object passed to this function is the same instance emitted on [TestRun.addCoverage](#TestRun.addCoverage) calls associated with this profile.

| Parameter | Description |
| --- | --- |
| testRun: [TestRun](#TestRun) | The test run that generated the coverage data. |
| fileCoverage: [FileCoverage](#FileCoverage) | The file coverage object to load detailed coverage for. |
| fromTestItem: [TestItem](#TestItem) | The test item to request coverage information for. |
| token: [CancellationToken](#CancellationToken) | A cancellation token that indicates the operation should be cancelled. |
| Returns | Description |
| Thenable<[FileCoverageDetail](#FileCoverageDetail)\[\]> |     |

runHandler: (request: [TestRunRequest](#TestRunRequest), token: [CancellationToken](#CancellationToken)) => void | Thenable<void\>

Handler called to start a test run. When invoked, the function should call [TestController.createTestRun](#TestController.createTestRun) at least once, and all test runs associated with the request should be created before the function returns or the returned promise is resolved.

If [supportsContinuousRun](#TestRunProfile.supportsContinuousRun) is set, then [TestRunRequest.continuous](#TestRunRequest.continuous) may be `true`. In this case, the profile should observe changes to source code and create new test runs by calling [TestController.createTestRun](#TestController.createTestRun), until the cancellation is requested on the `token`.

| Parameter | Description |
| --- | --- |
| request: [TestRunRequest](#TestRunRequest) | Request information for the test run. |
| token: [CancellationToken](#CancellationToken) |     |
| Returns | Description |
| void \| Thenable<void\> |     |

supportsContinuousRun: boolean

Whether this profile supports continuous running of requests. If so, then [TestRunRequest.continuous](#TestRunRequest.continuous) may be set to `true`. Defaults to false.

tag: [TestTag](#TestTag)

Associated tag for the profile. If this is set, only [TestItem](#TestItem) instances with the same tag will be eligible to execute in this profile.

#### Methods

dispose(): void

Deletes the run profile.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### TestRunProfileKind

The kind of executions that [TestRunProfiles](#TestRunProfile) control.

#### Enumeration Members

Run: 1

The `Run` test profile kind.

Debug: 2

The `Debug` test profile kind.

Coverage: 3

The `Coverage` test profile kind.

### TestRunRequest

A TestRunRequest is a precursor to a [TestRun](#TestRun), which in turn is created by passing a request to [TestController.createTestRun](#TestController.createTestRun). The TestRunRequest contains information about which tests should be run, which should not be run, and how they are run (via the [profile](#TestRunRequest.profile)).

In general, TestRunRequests are created by the editor and pass to [TestRunProfile.runHandler](#TestRunProfile.runHandler), however you can also create test requests and runs outside of the `runHandler`.

#### Constructors

new TestRunRequest(include?: readonly [TestItem](#TestItem)\[\], exclude?: readonly [TestItem](#TestItem)\[\], profile?: [TestRunProfile](#TestRunProfile), continuous?: boolean, preserveFocus?: boolean): [TestRunRequest](#TestRunRequest)

| Parameter | Description |
| --- | --- |
| include?: readonly [TestItem](#TestItem)\[\] | Array of specific tests to run, or undefined to run all tests |
| exclude?: readonly [TestItem](#TestItem)\[\] | An array of tests to exclude from the run. |
| profile?: [TestRunProfile](#TestRunProfile) | The run profile used for this request. |
| continuous?: boolean | Whether to run tests continuously as source changes. |
| preserveFocus?: boolean | Whether to preserve the user's focus when the run is started |
| Returns | Description |
| [TestRunRequest](#TestRunRequest) |     |

#### Properties

continuous?: boolean

Whether the profile should run continuously as source code changes. Only relevant for profiles that set [TestRunProfile.supportsContinuousRun](#TestRunProfile.supportsContinuousRun).

exclude: readonly [TestItem](#TestItem)\[\]

An array of tests the user has marked as excluded from the test included in this run; exclusions should apply after inclusions.

May be omitted if no exclusions were requested. Test controllers should not run excluded tests or any children of excluded tests.

include: readonly [TestItem](#TestItem)\[\]

A filter for specific tests to run. If given, the extension should run all of the included tests and all their children, excluding any tests that appear in [TestRunRequest.exclude](#TestRunRequest.exclude). If this property is undefined, then the extension should simply run all tests.

The process of running tests should resolve the children of any test items who have not yet been resolved.

preserveFocus: boolean

Controls how test Test Results view is focused. If true, the editor will keep the maintain the user's focus. If false, the editor will prefer to move focus into the Test Results view, although this may be configured by users.

profile: [TestRunProfile](#TestRunProfile)

The profile used for this request. This will always be defined for requests issued from the editor UI, though extensions may programmatically create requests not associated with any profile.

### TestTag

Tags can be associated with [TestItems](#TestItem) and [TestRunProfiles](#TestRunProfile). A profile with a tag can only execute tests that include that tag in their [TestItem.tags](#TestItem.tags) array.

#### Constructors

new TestTag(id: string): [TestTag](#TestTag)

Creates a new TestTag instance.

| Parameter | Description |
| --- | --- |
| id: string | ID of the test tag. |
| Returns | Description |
| [TestTag](#TestTag) |     |

#### Properties

id: string

ID of the test tag. `TestTag` instances with the same ID are considered to be identical.

### TextDocument

Represents a text document, such as a source file. Text documents have [lines](#TextLine) and knowledge about an underlying resource like a file.

#### Properties

encoding: string

The file encoding of this document that will be used when the document is saved.

Use the [onDidChangeTextDocument](#workspace.onDidChangeTextDocument)\-event to get notified when the document encoding changes.

Note that the possible encoding values are currently defined as any of the following: 'utf8', 'utf8bom', 'utf16le', 'utf16be', 'windows1252', 'iso88591', 'iso88593', 'iso885915', 'macroman', 'cp437', 'windows1256', 'iso88596', 'windows1257', 'iso88594', 'iso885914', 'windows1250', 'iso88592', 'cp852', 'windows1251', 'cp866', 'cp1125', 'iso88595', 'koi8r', 'koi8u', 'iso885913', 'windows1253', 'iso88597', 'windows1255', 'iso88598', 'iso885910', 'iso885916', 'windows1254', 'iso88599', 'windows1258', 'gbk', 'gb18030', 'cp950', 'big5hkscs', 'shiftjis', 'eucjp', 'euckr', 'windows874', 'iso885911', 'koi8ru', 'koi8t', 'gb2312', 'cp865', 'cp850'.

eol: [EndOfLine](#EndOfLine)

The [end of line](#EndOfLine) sequence that is predominately used in this document.

fileName: string

The file system path of the associated resource. Shorthand notation for [TextDocument.uri.fsPath](#TextDocument.uri). Independent of the uri scheme.

isClosed: boolean

`true` if the document has been closed. A closed document isn't synchronized anymore and won't be re-used when the same resource is opened again.

isDirty: boolean

`true` if there are unpersisted changes.

isUntitled: boolean

Is this document representing an untitled file which has never been saved yet. _Note_ that this does not mean the document will be saved to disk, use [Uri.scheme](#Uri.scheme) to figure out where a document will be [saved](#FileSystemProvider), e.g. `file`, `ftp` etc.

languageId: string

The identifier of the language associated with this document.

lineCount: number

The number of lines in this document.

uri: [Uri](#Uri)

The associated uri for this document.

_Note_ that most documents use the `file`\-scheme, which means they are files on disk. However, **not** all documents are saved on disk and therefore the `scheme` must be checked before trying to access the underlying file or siblings on disk.

_See also_

*   [FileSystemProvider](#FileSystemProvider)
*   [TextDocumentContentProvider](#TextDocumentContentProvider)

version: number

The version number of this document (it will strictly increase after each change, including undo/redo).

#### Methods

getText(range?: [Range](#Range)): string

Get the text of this document. A substring can be retrieved by providing a range. The range will be [adjusted](#TextDocument.validateRange).

| Parameter | Description |
| --- | --- |
| range?: [Range](#Range) | Include only the text included by the range. |
| Returns | Description |
| string | The text inside the provided range or the entire text. |

getWordRangeAtPosition(position: [Position](#Position), regex?: RegExp): [Range](#Range)

Get a word-range at the given position. By default words are defined by common separators, like space, -, \_, etc. In addition, per language custom \[word definitions\] can be defined. It is also possible to provide a custom regular expression.

*   _Note 1:_ A custom regular expression must not match the empty string and if it does, it will be ignored.
*   _Note 2:_ A custom regular expression will fail to match multiline strings and in the name of speed regular expressions should not match words with spaces. Use [TextLine.text](#TextLine.text) for more complex, non-wordy, scenarios.

The position will be [adjusted](#TextDocument.validatePosition).

| Parameter | Description |
| --- | --- |
| position: [Position](#Position) | A position. |
| regex?: RegExp | Optional regular expression that describes what a word is. |
| Returns | Description |
| [Range](#Range) | A range spanning a word, or `undefined`. |

lineAt(line: number): [TextLine](#TextLine)

Returns a text line denoted by the line number. Note that the returned object is _not_ live and changes to the document are not reflected.

| Parameter | Description |
| --- | --- |
| line: number | A line number in `[0, lineCount)`. |
| Returns | Description |
| [TextLine](#TextLine) | A [line](#TextLine). |

lineAt(position: [Position](#Position)): [TextLine](#TextLine)

Returns a text line denoted by the position. Note that the returned object is _not_ live and changes to the document are not reflected.

The position will be [adjusted](#TextDocument.validatePosition).

_See also_ [TextDocument.lineAt](#TextDocument.lineAt)

| Parameter | Description |
| --- | --- |
| position: [Position](#Position) | A position. |
| Returns | Description |
| [TextLine](#TextLine) | A [line](#TextLine). |

offsetAt(position: [Position](#Position)): number

Converts the position to a zero-based offset.

The position will be [adjusted](#TextDocument.validatePosition).

| Parameter | Description |
| --- | --- |
| position: [Position](#Position) | A position. |
| Returns | Description |
| number | A valid zero-based offset in UTF-16 [code units](https://developer.mozilla.org/en-US/docs/Glossary/Code_unit). |

positionAt(offset: number): [Position](#Position)

Converts a zero-based offset to a position.

| Parameter | Description |
| --- | --- |
| offset: number | A zero-based offset into the document. This offset is in UTF-16 [code units](https://developer.mozilla.org/en-US/docs/Glossary/Code_unit). |
| Returns | Description |
| [Position](#Position) | A valid [Position](#Position). |

save(): Thenable<boolean\>

Save the underlying file.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Thenable<boolean\> | A promise that will resolve to `true` when the file has been saved. If the save failed, will return `false`. |

validatePosition(position: [Position](#Position)): [Position](#Position)

Ensure a position is contained in the range of this document.

| Parameter | Description |
| --- | --- |
| position: [Position](#Position) | A position. |
| Returns | Description |
| [Position](#Position) | The given position or a new, adjusted position. |

validateRange(range: [Range](#Range)): [Range](#Range)

Ensure a range is completely contained in this document.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | A range. |
| Returns | Description |
| [Range](#Range) | The given range or a new, adjusted range. |

### TextDocumentChangeEvent

An event describing a transactional [document](#TextDocument) change.

#### Properties

contentChanges: readonly [TextDocumentContentChangeEvent](#TextDocumentContentChangeEvent)\[\]

An array of content changes.

document: [TextDocument](#TextDocument)

The affected document.

reason: [TextDocumentChangeReason](#TextDocumentChangeReason)

The reason why the document was changed. Is `undefined` if the reason is not known.

### TextDocumentChangeReason

Reasons for why a text document has changed.

#### Enumeration Members

Undo: 1

The text change is caused by an undo operation.

Redo: 2

The text change is caused by an redo operation.

### TextDocumentContentChangeEvent

An event describing an individual change in the text of a [document](#TextDocument).

#### Properties

range: [Range](#Range)

The range that got replaced.

rangeLength: number

The length of the range that got replaced.

rangeOffset: number

The offset of the range that got replaced.

text: string

The new text for the range.

### TextDocumentContentProvider

A text document content provider allows to add readonly documents to the editor, such as source from a dll or generated html from md.

Content providers are [registered](#workspace.registerTextDocumentContentProvider) for a [uri-scheme](#Uri.scheme). When a uri with that scheme is to be [loaded](#workspace.openTextDocument) the content provider is asked.

#### Events

onDidChange?: [Event](#Event&lt;T&gt;)<[Uri](#Uri)\>

An event to signal a resource has changed.

#### Methods

provideTextDocumentContent(uri: [Uri](#Uri), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<string\>

Provide textual content for a given uri.

The editor will use the returned string-content to create a readonly [document](#TextDocument). Resources allocated should be released when the corresponding document has been [closed](#workspace.onDidCloseTextDocument).

**Note**: The contents of the created [document](#TextDocument) might not be identical to the provided text due to end-of-line-sequence normalization.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | An uri which scheme matches the scheme this provider was [registered](#workspace.registerTextDocumentContentProvider) for. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<string\> | A string or a thenable that resolves to such. |

### TextDocumentSaveReason

Represents reasons why a text document is saved.

#### Enumeration Members

Manual: 1

Manually triggered, e.g. by the user pressing save, by starting debugging, or by an API call.

AfterDelay: 2

Automatic after a delay.

FocusOut: 3

When the editor lost focus.

### TextDocumentShowOptions

Represents options to configure the behavior of showing a [document](#TextDocument) in an [editor](#TextEditor).

#### Properties

preserveFocus?: boolean

An optional flag that when `true` will stop the [editor](#TextEditor) from taking focus.

preview?: boolean

An optional flag that controls if an [editor](#TextEditor)\-tab shows as preview. Preview tabs will be replaced and reused until set to stay - either explicitly or through editing.

_Note_ that the flag is ignored if a user has disabled preview editors in settings.

selection?: [Range](#Range)

An optional selection to apply for the document in the [editor](#TextEditor).

viewColumn?: [ViewColumn](#ViewColumn)

An optional view column in which the [editor](#TextEditor) should be shown. The default is the [active](#ViewColumn.Active). Columns that do not exist will be created as needed up to the maximum of [ViewColumn.Nine](#ViewColumn.Nine). Use [ViewColumn.Beside](#ViewColumn.Beside) to open the editor to the side of the currently active one.

### TextDocumentWillSaveEvent

An event that is fired when a [document](#TextDocument) will be saved.

To make modifications to the document before it is being saved, call the [waitUntil](#TextDocumentWillSaveEvent.waitUntil)\-function with a thenable that resolves to an array of [text edits](#TextEdit).

#### Properties

document: [TextDocument](#TextDocument)

The document that will be saved.

reason: [TextDocumentSaveReason](#TextDocumentSaveReason)

The reason why save was triggered.

#### Methods

waitUntil(thenable: Thenable<readonly [TextEdit](#TextEdit)\[\]>): void

Allows to pause the event loop and to apply [pre-save-edits](#TextEdit). Edits of subsequent calls to this function will be applied in order. The edits will be _ignored_ if concurrent modifications of the document happened.

_Note:_ This function can only be called during event dispatch and not in an asynchronous manner:

```
workspace.onWillSaveTextDocument(event => {
  // async, will *throw* an error
  setTimeout(() => event.waitUntil(promise));

  // sync, OK
  event.waitUntil(promise);
});
```

| Parameter | Description |
| --- | --- |
| thenable: Thenable<readonly [TextEdit](#TextEdit)\[\]> | A thenable that resolves to [pre-save-edits](#TextEdit). |
| Returns | Description |
| void |     |

waitUntil(thenable: Thenable<any\>): void

Allows to pause the event loop until the provided thenable resolved.

_Note:_ This function can only be called during event dispatch.

| Parameter | Description |
| --- | --- |
| thenable: Thenable<any\> | A thenable that delays saving. |
| Returns | Description |
| void |     |

### TextEdit

A text edit represents edits that should be applied to a document.

#### Static

delete(range: [Range](#Range)): [TextEdit](#TextEdit)

Utility to create a delete edit.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | A range. |
| Returns | Description |
| [TextEdit](#TextEdit) | A new text edit object. |

insert(position: [Position](#Position), newText: string): [TextEdit](#TextEdit)

Utility to create an insert edit.

| Parameter | Description |
| --- | --- |
| position: [Position](#Position) | A position, will become an empty range. |
| newText: string | A string. |
| Returns | Description |
| [TextEdit](#TextEdit) | A new text edit object. |

replace(range: [Range](#Range), newText: string): [TextEdit](#TextEdit)

Utility to create a replace edit.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | A range. |
| newText: string | A string. |
| Returns | Description |
| [TextEdit](#TextEdit) | A new text edit object. |

setEndOfLine(eol: [EndOfLine](#EndOfLine)): [TextEdit](#TextEdit)

Utility to create an eol-edit.

| Parameter | Description |
| --- | --- |
| eol: [EndOfLine](#EndOfLine) | An eol-sequence |
| Returns | Description |
| [TextEdit](#TextEdit) | A new text edit object. |

#### Constructors

new TextEdit(range: [Range](#Range), newText: string): [TextEdit](#TextEdit)

Create a new TextEdit.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | A range. |
| newText: string | A string. |
| Returns | Description |
| [TextEdit](#TextEdit) |     |

#### Properties

newEol?: [EndOfLine](#EndOfLine)

The eol-sequence used in the document.

_Note_ that the eol-sequence will be applied to the whole document.

newText: string

The string this edit will insert.

range: [Range](#Range)

The range this edit applies to.

### TextEditor

Represents an editor that is attached to a [document](#TextDocument).

#### Properties

document: [TextDocument](#TextDocument)

The document associated with this text editor. The document will be the same for the entire lifetime of this text editor.

options: [TextEditorOptions](#TextEditorOptions)

Text editor options.

selection: [Selection](#Selection)

The primary selection on this text editor. Shorthand for `TextEditor.selections[0]`.

selections: readonly [Selection](#Selection)\[\]

The selections in this text editor. The primary selection is always at index 0.

viewColumn: [ViewColumn](#ViewColumn)

The column in which this editor shows. Will be `undefined` in case this isn't one of the main editors, e.g. an embedded editor, or when the editor column is larger than three.

visibleRanges: readonly [Range](#Range)\[\]

The current visible ranges in the editor (vertically). This accounts only for vertical scrolling, and not for horizontal scrolling.

#### Methods

edit(callback: (editBuilder: [TextEditorEdit](#TextEditorEdit)) => void, options?: {undoStopAfter: boolean, undoStopBefore: boolean}): Thenable<boolean\>

Perform an edit on the document associated with this text editor.

The given callback-function is invoked with an [edit-builder](#TextEditorEdit) which must be used to make edits. Note that the edit-builder is only valid while the callback executes.

| Parameter | Description |
| --- | --- |
| callback: (editBuilder: [TextEditorEdit](#TextEditorEdit)) => void | A function which can create edits using an [edit-builder](#TextEditorEdit). |
| options?: {undoStopAfter: boolean, undoStopBefore: boolean} | The undo/redo behavior around this edit. By default, undo stops will be created before and after this edit. |
| Returns | Description |
| Thenable<boolean\> | A promise that resolves with a value indicating if the edits could be applied. |

hide(): void

Hide the text editor.

*   _deprecated_ - Use the command `workbench.action.closeActiveEditor` instead. This method shows unexpected behavior and will be removed in the next major update.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

insertSnippet(snippet: [SnippetString](#SnippetString), location?: [Range](#Range) | [Position](#Position) | readonly [Range](#Range)\[\] | readonly [Position](#Position)\[\], options?: {keepWhitespace: boolean, undoStopAfter: boolean, undoStopBefore: boolean}): Thenable<boolean\>

Insert a [snippet](#SnippetString) and put the editor into snippet mode. "Snippet mode" means the editor adds placeholders and additional cursors so that the user can complete or accept the snippet.

| Parameter | Description |
| --- | --- |
| snippet: [SnippetString](#SnippetString) | The snippet to insert in this edit. |
| location?: [Range](#Range) \| [Position](#Position) \| readonly [Range](#Range)\[\] \| readonly [Position](#Position)\[\] | Position or range at which to insert the snippet, defaults to the current editor selection or selections. |
| options?: {keepWhitespace: boolean, undoStopAfter: boolean, undoStopBefore: boolean} | The undo/redo behavior around this edit. By default, undo stops will be created before and after this edit. |
| Returns | Description |
| Thenable<boolean\> | A promise that resolves with a value indicating if the snippet could be inserted. Note that the promise does not signal that the snippet is completely filled-in or accepted. |

revealRange(range: [Range](#Range), revealType?: [TextEditorRevealType](#TextEditorRevealType)): void

Scroll as indicated by `revealType` in order to reveal the given range.

| Parameter | Description |
| --- | --- |
| range: [Range](#Range) | A range. |
| revealType?: [TextEditorRevealType](#TextEditorRevealType) | The scrolling strategy for revealing `range`. |
| Returns | Description |
| void |     |

setDecorations(decorationType: [TextEditorDecorationType](#TextEditorDecorationType), rangesOrOptions: readonly [Range](#Range)\[\] | readonly [DecorationOptions](#DecorationOptions)\[\]): void

Adds a set of decorations to the text editor. If a set of decorations already exists with the given [decoration type](#TextEditorDecorationType), they will be replaced. If `rangesOrOptions` is empty, the existing decorations with the given [decoration type](#TextEditorDecorationType) will be removed.

_See also_ [createTextEditorDecorationType](#window.createTextEditorDecorationType).

| Parameter | Description |
| --- | --- |
| decorationType: [TextEditorDecorationType](#TextEditorDecorationType) | A decoration type. |
| rangesOrOptions: readonly [Range](#Range)\[\] \| readonly [DecorationOptions](#DecorationOptions)\[\] | Either [ranges](#Range) or more detailed [options](#DecorationOptions). |
| Returns | Description |
| void |     |

show(column?: [ViewColumn](#ViewColumn)): void

Show the text editor.

*   _deprecated_ - Use [window.showTextDocument](#window.showTextDocument) instead.

| Parameter | Description |
| --- | --- |
| column?: [ViewColumn](#ViewColumn) | The [column](#ViewColumn) in which to show this editor. This method shows unexpected behavior and will be removed in the next major update. |
| Returns | Description |
| void |     |

### TextEditorCursorStyle

Rendering style of the cursor.

#### Enumeration Members

Line: 1

Render the cursor as a vertical thick line.

Block: 2

Render the cursor as a block filled.

Underline: 3

Render the cursor as a thick horizontal line.

LineThin: 4

Render the cursor as a vertical thin line.

BlockOutline: 5

Render the cursor as a block outlined.

UnderlineThin: 6

Render the cursor as a thin horizontal line.

### TextEditorDecorationType

Represents a handle to a set of decorations sharing the same [styling options](#DecorationRenderOptions) in a [text editor](#TextEditor).

To get an instance of a `TextEditorDecorationType` use [createTextEditorDecorationType](#window.createTextEditorDecorationType).

#### Properties

key: string

Internal representation of the handle.

#### Methods

dispose(): void

Remove this decoration type and all decorations on all text editors using it.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| void |     |

### TextEditorEdit

A complex edit that will be applied in one transaction on a TextEditor. This holds a description of the edits and if the edits are valid (i.e. no overlapping regions, document was not changed in the meantime, etc.) they can be applied on a [document](#TextDocument) associated with a [text editor](#TextEditor).

#### Methods

delete(location: [Range](#Range) | [Selection](#Selection)): void

Delete a certain text region.

| Parameter | Description |
| --- | --- |
| location: [Range](#Range) \| [Selection](#Selection) | The range this operation should remove. |
| Returns | Description |
| void |     |

insert(location: [Position](#Position), value: string): void

Insert text at a location. You can use `\r\n` or `\n` in `value` and they will be normalized to the current [document](#TextDocument). Although the equivalent text edit can be made with [replace](#TextEditorEdit.replace), `insert` will produce a different resulting selection (it will get moved).

| Parameter | Description |
| --- | --- |
| location: [Position](#Position) | The position where the new text should be inserted. |
| value: string | The new text this operation should insert. |
| Returns | Description |
| void |     |

replace(location: [Range](#Range) | [Position](#Position) | [Selection](#Selection), value: string): void

Replace a certain text region with a new value. You can use `\r\n` or `\n` in `value` and they will be normalized to the current [document](#TextDocument).

| Parameter | Description |
| --- | --- |
| location: [Range](#Range) \| [Position](#Position) \| [Selection](#Selection) | The range this operation should remove. |
| value: string | The new text this operation should insert after removing `location`. |
| Returns | Description |
| void |     |

setEndOfLine(endOfLine: [EndOfLine](#EndOfLine)): void

Set the end of line sequence.

| Parameter | Description |
| --- | --- |
| endOfLine: [EndOfLine](#EndOfLine) | The new end of line for the [document](#TextDocument). |
| Returns | Description |
| void |     |

### TextEditorLineNumbersStyle

Rendering style of the line numbers.

#### Enumeration Members

Off: 0

Do not render the line numbers.

On: 1

Render the line numbers.

Relative: 2

Render the line numbers with values relative to the primary cursor location.

Interval: 3

Render the line numbers on every 10th line number.

### TextEditorOptions

Represents a [text editor](#TextEditor)'s [options](#TextEditor.options).

#### Properties

cursorStyle?: [TextEditorCursorStyle](#TextEditorCursorStyle)

The rendering style of the cursor in this editor. When getting a text editor's options, this property will always be present. When setting a text editor's options, this property is optional.

indentSize?: string | number

The number of spaces to insert when [insertSpaces](#TextEditorOptions.insertSpaces) is true.

When getting a text editor's options, this property will always be a number (resolved). When setting a text editor's options, this property is optional and it can be a number or `"tabSize"`.

insertSpaces?: string | boolean

When pressing Tab insert [n](#TextEditorOptions.tabSize) spaces. When getting a text editor's options, this property will always be a boolean (resolved). When setting a text editor's options, this property is optional and it can be a boolean or `"auto"`.

lineNumbers?: [TextEditorLineNumbersStyle](#TextEditorLineNumbersStyle)

Render relative line numbers w.r.t. the current line number. When getting a text editor's options, this property will always be present. When setting a text editor's options, this property is optional.

tabSize?: string | number

The size in spaces a tab takes. This is used for two purposes:

*   the rendering width of a tab character;
*   the number of spaces to insert when [insertSpaces](#TextEditorOptions.insertSpaces) is true and `indentSize` is set to `"tabSize"`.

When getting a text editor's options, this property will always be a number (resolved). When setting a text editor's options, this property is optional and it can be a number or `"auto"`.

### TextEditorOptionsChangeEvent

Represents an event describing the change in a [text editor's options](#TextEditor.options).

#### Properties

options: [TextEditorOptions](#TextEditorOptions)

The new value for the [text editor's options](#TextEditor.options).

textEditor: [TextEditor](#TextEditor)

The [text editor](#TextEditor) for which the options have changed.

### TextEditorRevealType

Represents different [reveal](#TextEditor.revealRange) strategies in a text editor.

#### Enumeration Members

Default: 0

The range will be revealed with as little scrolling as possible.

InCenter: 1

The range will always be revealed in the center of the viewport.

InCenterIfOutsideViewport: 2

If the range is outside the viewport, it will be revealed in the center of the viewport. Otherwise, it will be revealed with as little scrolling as possible.

AtTop: 3

The range will always be revealed at the top of the viewport.

### TextEditorSelectionChangeEvent

Represents an event describing the change in a [text editor's selections](#TextEditor.selections).

#### Properties

kind: [TextEditorSelectionChangeKind](#TextEditorSelectionChangeKind)

The [change kind](#TextEditorSelectionChangeKind) which has triggered this event. Can be `undefined`.

selections: readonly [Selection](#Selection)\[\]

The new value for the [text editor's selections](#TextEditor.selections).

textEditor: [TextEditor](#TextEditor)

The [text editor](#TextEditor) for which the selections have changed.

### TextEditorSelectionChangeKind

Represents sources that can cause [selection change events](#window.onDidChangeTextEditorSelection).

#### Enumeration Members

Keyboard: 1

Selection changed due to typing in the editor.

Mouse: 2

Selection change due to clicking in the editor.

Command: 3

Selection changed because a command ran.

### TextEditorViewColumnChangeEvent

Represents an event describing the change of a [text editor's view column](#TextEditor.viewColumn).

#### Properties

textEditor: [TextEditor](#TextEditor)

The [text editor](#TextEditor) for which the view column has changed.

viewColumn: [ViewColumn](#ViewColumn)

The new value for the [text editor's view column](#TextEditor.viewColumn).

### TextEditorVisibleRangesChangeEvent

Represents an event describing the change in a [text editor's visible ranges](#TextEditor.visibleRanges).

#### Properties

textEditor: [TextEditor](#TextEditor)

The [text editor](#TextEditor) for which the visible ranges have changed.

visibleRanges: readonly [Range](#Range)\[\]

The new value for the [text editor's visible ranges](#TextEditor.visibleRanges).

### TextLine

Represents a line of text, such as a line of source code.

TextLine objects are **immutable**. When a [document](#TextDocument) changes, previously retrieved lines will not represent the latest state.

#### Properties

firstNonWhitespaceCharacterIndex: number

The offset of the first character which is not a whitespace character as defined by `/\s/`. **Note** that if a line is all whitespace the length of the line is returned.

isEmptyOrWhitespace: boolean

Whether this line is whitespace only, shorthand for [TextLine.firstNonWhitespaceCharacterIndex](#TextLine.firstNonWhitespaceCharacterIndex) === [TextLine.text.length](#TextLine.text).

lineNumber: number

The zero-based line number.

range: [Range](#Range)

The range this line covers without the line separator characters.

rangeIncludingLineBreak: [Range](#Range)

The range this line covers with the line separator characters.

text: string

The text of this line without the line separator characters.

### ThemableDecorationAttachmentRenderOptions

Represents theme specific rendering styles for [before](#ThemableDecorationRenderOptions.before) and [after](#ThemableDecorationRenderOptions.after) the content of text decorations.

#### Properties

backgroundColor?: string | [ThemeColor](#ThemeColor)

CSS styling property that will be applied to the decoration attachment.

border?: string

CSS styling property that will be applied to the decoration attachment.

borderColor?: string | [ThemeColor](#ThemeColor)

CSS styling property that will be applied to text enclosed by a decoration.

color?: string | [ThemeColor](#ThemeColor)

CSS styling property that will be applied to the decoration attachment.

contentIconPath?: string | [Uri](#Uri)

An **absolute path** or an URI to an image to be rendered in the attachment. Either an icon or a text can be shown, but not both.

contentText?: string

Defines a text content that is shown in the attachment. Either an icon or a text can be shown, but not both.

fontStyle?: string

CSS styling property that will be applied to the decoration attachment.

fontWeight?: string

CSS styling property that will be applied to the decoration attachment.

height?: string

CSS styling property that will be applied to the decoration attachment.

margin?: string

CSS styling property that will be applied to the decoration attachment.

textDecoration?: string

CSS styling property that will be applied to the decoration attachment.

width?: string

CSS styling property that will be applied to the decoration attachment.

### ThemableDecorationInstanceRenderOptions

Represents themable render options for decoration instances.

#### Properties

after?: [ThemableDecorationAttachmentRenderOptions](#ThemableDecorationAttachmentRenderOptions)

Defines the rendering options of the attachment that is inserted after the decorated text.

before?: [ThemableDecorationAttachmentRenderOptions](#ThemableDecorationAttachmentRenderOptions)

Defines the rendering options of the attachment that is inserted before the decorated text.

### ThemableDecorationRenderOptions

Represents theme specific rendering styles for a [text editor decoration](#TextEditorDecorationType).

#### Properties

after?: [ThemableDecorationAttachmentRenderOptions](#ThemableDecorationAttachmentRenderOptions)

Defines the rendering options of the attachment that is inserted after the decorated text.

backgroundColor?: string | [ThemeColor](#ThemeColor)

Background color of the decoration. Use rgba() and define transparent background colors to play well with other decorations. Alternatively a color from the color registry can be [referenced](#ThemeColor).

before?: [ThemableDecorationAttachmentRenderOptions](#ThemableDecorationAttachmentRenderOptions)

Defines the rendering options of the attachment that is inserted before the decorated text.

border?: string

CSS styling property that will be applied to text enclosed by a decoration.

borderColor?: string | [ThemeColor](#ThemeColor)

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

borderRadius?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

borderSpacing?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

borderStyle?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

borderWidth?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'border' for setting one or more of the individual border properties.

color?: string | [ThemeColor](#ThemeColor)

CSS styling property that will be applied to text enclosed by a decoration.

cursor?: string

CSS styling property that will be applied to text enclosed by a decoration.

fontStyle?: string

CSS styling property that will be applied to text enclosed by a decoration.

fontWeight?: string

CSS styling property that will be applied to text enclosed by a decoration.

gutterIconPath?: string | [Uri](#Uri)

An **absolute path** or an URI to an image to be rendered in the gutter.

gutterIconSize?: string

Specifies the size of the gutter icon. Available values are 'auto', 'contain', 'cover' and any percentage value. For further information: [https://msdn.microsoft.com/en-us/library/jj127316(v=vs.85).aspx](https://msdn.microsoft.com/en-us/library/jj127316(v=vs.85).aspx)

letterSpacing?: string

CSS styling property that will be applied to text enclosed by a decoration.

opacity?: string

CSS styling property that will be applied to text enclosed by a decoration.

outline?: string

CSS styling property that will be applied to text enclosed by a decoration.

outlineColor?: string | [ThemeColor](#ThemeColor)

CSS styling property that will be applied to text enclosed by a decoration. Better use 'outline' for setting one or more of the individual outline properties.

outlineStyle?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'outline' for setting one or more of the individual outline properties.

outlineWidth?: string

CSS styling property that will be applied to text enclosed by a decoration. Better use 'outline' for setting one or more of the individual outline properties.

overviewRulerColor?: string | [ThemeColor](#ThemeColor)

The color of the decoration in the overview ruler. Use rgba() and define transparent colors to play well with other decorations.

textDecoration?: string

CSS styling property that will be applied to text enclosed by a decoration.

### ThemeColor

A reference to one of the workbench colors as defined in [https://code.visualstudio.com/api/references/theme-color](https://code.visualstudio.com/api/references/theme-color). Using a theme color is preferred over a custom color as it gives theme authors and users the possibility to change the color.

#### Constructors

new ThemeColor(id: string): [ThemeColor](#ThemeColor)

Creates a reference to a theme color.

| Parameter | Description |
| --- | --- |
| id: string | of the color. The available colors are listed in [https://code.visualstudio.com/api/references/theme-color](https://code.visualstudio.com/api/references/theme-color). |
| Returns | Description |
| [ThemeColor](#ThemeColor) |     |

#### Properties

id: string

The id of this color.

### ThemeIcon

A reference to a named icon. Currently, [File](#ThemeIcon.File), [Folder](#ThemeIcon.Folder), and [ThemeIcon ids](https://code.visualstudio.com/api/references/icons-in-labels#icon-listing) are supported. Using a theme icon is preferred over a custom icon as it gives product theme authors the possibility to change the icons.

_Note_ that theme icons can also be rendered inside labels and descriptions. Places that support theme icons spell this out and they use the `$(<name>)`\-syntax, for instance `quickPick.label = "Hello World $(globe)"`.

#### Static

File: [ThemeIcon](#ThemeIcon)

Reference to an icon representing a file. The icon is taken from the current file icon theme or a placeholder icon is used.

Folder: [ThemeIcon](#ThemeIcon)

Reference to an icon representing a folder. The icon is taken from the current file icon theme or a placeholder icon is used.

#### Constructors

new ThemeIcon(id: string, color?: [ThemeColor](#ThemeColor)): [ThemeIcon](#ThemeIcon)

Creates a reference to a theme icon.

| Parameter | Description |
| --- | --- |
| id: string | id of the icon. The available icons are listed in [https://code.visualstudio.com/api/references/icons-in-labels#icon-listing](https://code.visualstudio.com/api/references/icons-in-labels#icon-listing). |
| color?: [ThemeColor](#ThemeColor) | optional `ThemeColor` for the icon. The color is currently only used in [TreeItem](#TreeItem). |
| Returns | Description |
| [ThemeIcon](#ThemeIcon) |     |

#### Properties

color?: [ThemeColor](#ThemeColor)

The optional ThemeColor of the icon. The color is currently only used in [TreeItem](#TreeItem).

id: string

The id of the icon. The available icons are listed in [https://code.visualstudio.com/api/references/icons-in-labels#icon-listing](https://code.visualstudio.com/api/references/icons-in-labels#icon-listing).

### TreeCheckboxChangeEvent<T>

An event describing the change in a tree item's checkbox state.

#### Properties

items: ReadonlyArray<\[T, [TreeItemCheckboxState](#TreeItemCheckboxState)\]>

The items that were checked or unchecked.

### TreeDataProvider<T>

A data provider that provides tree data

#### Events

onDidChangeTreeData?: [Event](#Event&lt;T&gt;)<void | T | T\[\]>

An optional event to signal that an element or root has changed. This will trigger the view to update the changed element/root and its children recursively (if shown). To signal that root has changed, do not pass any argument or pass `undefined` or `null`.

#### Methods

getChildren(element?: T): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Get the children of `element` or root if no element is passed.

| Parameter | Description |
| --- | --- |
| element?: T | The element from which the provider gets children. Can be `undefined`. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | Children of `element` or root if no element is passed. |

getParent(element: T): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

Optional method to return the parent of `element`. Return `null` or `undefined` if `element` is a child of root.

**NOTE:** This method should be implemented in order to access [reveal](#TreeView.reveal) API.

| Parameter | Description |
| --- | --- |
| element: T | The element for which the parent has to be returned. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | Parent of `element`. |

getTreeItem(element: T): [TreeItem](#TreeItem) | Thenable<[TreeItem](#TreeItem)\>

Get [TreeItem](#TreeItem) representation of the `element`

| Parameter | Description |
| --- | --- |
| element: T | The element for which [TreeItem](#TreeItem) representation is asked for. |
| Returns | Description |
| [TreeItem](#TreeItem) \| Thenable<[TreeItem](#TreeItem)\> | TreeItem representation of the element. |

resolveTreeItem(item: [TreeItem](#TreeItem), element: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[TreeItem](#TreeItem)\>

Called on hover to resolve the [TreeItem](#TreeItem.tooltip) property if it is undefined. Called on tree item click/open to resolve the [TreeItem](#TreeItem.command) property if it is undefined. Only properties that were undefined can be resolved in `resolveTreeItem`. Functionality may be expanded later to include being called to resolve other missing properties on selection and/or on open.

Will only ever be called once per TreeItem.

onDidChangeTreeData should not be triggered from within resolveTreeItem.

_Note_ that this function is called when tree items are already showing in the UI. Because of that, no property that changes the presentation (label, description, etc.) can be changed.

| Parameter | Description |
| --- | --- |
| item: [TreeItem](#TreeItem) | Undefined properties of `item` should be set then `item` should be returned. |
| element: T | The object associated with the TreeItem. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[TreeItem](#TreeItem)\> | The resolved tree item or a thenable that resolves to such. It is OK to return the given `item`. When no result is returned, the given `item` will be used. |

### TreeDragAndDropController<T>

Provides support for drag and drop in `TreeView`.

#### Properties

dragMimeTypes: readonly string\[\]

The mime types that the [`handleDrag`](#TreeDragAndDropController.handleDrag) method of this `TreeDragAndDropController` may add to the tree data transfer. This could be well-defined, existing, mime types, and also mime types defined by the extension.

The recommended mime type of the tree (`application/vnd.code.tree.<treeidlowercase>`) will be automatically added.

dropMimeTypes: readonly string\[\]

The mime types that the [`handleDrop`](#TreeDragAndDropController.handleDrop) method of this `DragAndDropController` supports. This could be well-defined, existing, mime types, and also mime types defined by the extension.

To support drops from trees, you will need to add the mime type of that tree. This includes drops from within the same tree. The mime type of a tree is recommended to be of the format `application/vnd.code.tree.<treeidlowercase>`.

Use the special `files` mime type to support all types of dropped files [files](#DataTransferFile), regardless of the file's actual mime type.

To learn the mime type of a dragged item:

1.  Set up your `DragAndDropController`
2.  Use the Developer: Set Log Level... command to set the level to "Debug"
3.  Open the developer tools and drag the item with unknown mime type over your tree. The mime types will be logged to the developer console

Note that mime types that cannot be sent to the extension will be omitted.

#### Methods

handleDrag(source: readonly T\[\], dataTransfer: [DataTransfer](#DataTransfer), token: [CancellationToken](#CancellationToken)): void | Thenable<void\>

When the user starts dragging items from this `DragAndDropController`, `handleDrag` will be called. Extensions can use `handleDrag` to add their [`DataTransferItem`](#DataTransferItem) items to the drag and drop.

Mime types added in `handleDrag` won't be available outside the application.

When the items are dropped on **another tree item** in **the same tree**, your `DataTransferItem` objects will be preserved. Use the recommended mime type for the tree (`application/vnd.code.tree.<treeidlowercase>`) to add tree objects in a data transfer. See the documentation for `DataTransferItem` for how best to take advantage of this.

To add a data transfer item that can be dragged into the editor, use the application specific mime type "text/uri-list". The data for "text/uri-list" should be a string with `toString()`ed Uris separated by `\r\n`. To specify a cursor position in the file, set the Uri's fragment to `L3,5`, where 3 is the line number and 5 is the column number.

| Parameter | Description |
| --- | --- |
| source: readonly T\[\] | The source items for the drag and drop operation. |
| dataTransfer: [DataTransfer](#DataTransfer) | The data transfer associated with this drag. |
| token: [CancellationToken](#CancellationToken) | A cancellation token indicating that drag has been cancelled. |
| Returns | Description |
| void \| Thenable<void\> |     |

handleDrop(target: T, dataTransfer: [DataTransfer](#DataTransfer), token: [CancellationToken](#CancellationToken)): void | Thenable<void\>

Called when a drag and drop action results in a drop on the tree that this `DragAndDropController` belongs to.

Extensions should fire [onDidChangeTreeData](#TreeDataProvider.onDidChangeTreeData) for any elements that need to be refreshed.

| Parameter | Description |
| --- | --- |
| target: T | The target tree element that the drop is occurring on. When undefined, the target is the root. |
| dataTransfer: [DataTransfer](#DataTransfer) | The data transfer items of the source of the drag. |
| token: [CancellationToken](#CancellationToken) | A cancellation token indicating that the drop has been cancelled. |
| Returns | Description |
| void \| Thenable<void\> |     |

### TreeItem

A tree item is an UI element of the tree. Tree items are created by the [data provider](#TreeDataProvider).

#### Constructors

new TreeItem(label: string | [TreeItemLabel](#TreeItemLabel), collapsibleState?: [TreeItemCollapsibleState](#TreeItemCollapsibleState)): [TreeItem](#TreeItem)

| Parameter | Description |
| --- | --- |
| label: string \| [TreeItemLabel](#TreeItemLabel) | A human-readable string describing this item |
| collapsibleState?: [TreeItemCollapsibleState](#TreeItemCollapsibleState) | [TreeItemCollapsibleState](#TreeItemCollapsibleState) of the tree item. Default is [TreeItemCollapsibleState.None](#TreeItemCollapsibleState.None) |
| Returns | Description |
| [TreeItem](#TreeItem) |     |

new TreeItem(resourceUri: [Uri](#Uri), collapsibleState?: [TreeItemCollapsibleState](#TreeItemCollapsibleState)): [TreeItem](#TreeItem)

| Parameter | Description |
| --- | --- |
| resourceUri: [Uri](#Uri) | The [Uri](#Uri) of the resource representing this item. |
| collapsibleState?: [TreeItemCollapsibleState](#TreeItemCollapsibleState) | [TreeItemCollapsibleState](#TreeItemCollapsibleState) of the tree item. Default is [TreeItemCollapsibleState.None](#TreeItemCollapsibleState.None) |
| Returns | Description |
| [TreeItem](#TreeItem) |     |

#### Properties

accessibilityInformation?: [AccessibilityInformation](#AccessibilityInformation)

Accessibility information used when screen reader interacts with this tree item. Generally, a TreeItem has no need to set the `role` of the accessibilityInformation; however, there are cases where a TreeItem is not displayed in a tree-like way where setting the `role` may make sense.

checkboxState?: [TreeItemCheckboxState](#TreeItemCheckboxState) | {accessibilityInformation: [AccessibilityInformation](#AccessibilityInformation), state: [TreeItemCheckboxState](#TreeItemCheckboxState), tooltip: string}

[TreeItemCheckboxState](#TreeItemCheckboxState) of the tree item. [onDidChangeTreeData](#TreeDataProvider.onDidChangeTreeData) should be fired when [checkboxState](#TreeItem.checkboxState) changes.

collapsibleState?: [TreeItemCollapsibleState](#TreeItemCollapsibleState)

[TreeItemCollapsibleState](#TreeItemCollapsibleState) of the tree item.

command?: [Command](#Command)

The [Command](#Command) that should be executed when the tree item is selected.

Please use `vscode.open` or `vscode.diff` as command IDs when the tree item is opening something in the editor. Using these commands ensures that the resulting editor will appear consistent with how other built-in trees open editors.

contextValue?: string

Context value of the tree item. This can be used to contribute item specific actions in the tree. For example, a tree item is given a context value as `folder`. When contributing actions to `view/item/context` using `menus` extension point, you can specify context value for key `viewItem` in `when` expression like `viewItem == folder`.

```
"contributes": {
  "menus": {
    "view/item/context": [
      {
        "command": "extension.deleteFolder",
        "when": "viewItem == folder"
      }
    ]
  }
}
```

This will show action `extension.deleteFolder` only for items with `contextValue` is `folder`.

description?: string | boolean

A human-readable string which is rendered less prominent. When `true`, it is derived from [resourceUri](#TreeItem.resourceUri) and when `falsy`, it is not shown.

iconPath?: string | [IconPath](#IconPath)

The icon path or [ThemeIcon](#ThemeIcon) for the tree item. When `falsy`, [Folder Theme Icon](#ThemeIcon.Folder) is assigned, if item is collapsible otherwise [File Theme Icon](#ThemeIcon.File). When a file or folder [ThemeIcon](#ThemeIcon) is specified, icon is derived from the current file icon theme for the specified theme icon using [resourceUri](#TreeItem.resourceUri) (if provided).

id?: string

Optional id for the tree item that has to be unique across tree. The id is used to preserve the selection and expansion state of the tree item.

If not provided, an id is generated using the tree item's label. **Note** that when labels change, ids will change and that selection and expansion state cannot be kept stable anymore.

label?: string | [TreeItemLabel](#TreeItemLabel)

A human-readable string describing this item. When `falsy`, it is derived from [resourceUri](#TreeItem.resourceUri).

resourceUri?: [Uri](#Uri)

A [Uri](#Uri) representing the resource associated with this item.

When set, this property is used to automatically derive several item properties if they are not explicitly provided:

*   **Label**: Derived from the resource's file name when [label](#TreeItem.label) is not provided.
*   **Description**: Derived from the resource's path when [description](#TreeItem.description) is set to `true`.
*   **Icon**: Derived from the current file icon theme when [iconPath](#TreeItem.iconPath) is set to [ThemeIcon.File](#ThemeIcon.File) or [ThemeIcon.Folder](#ThemeIcon.Folder).

tooltip?: string | [MarkdownString](#MarkdownString)

The tooltip text when you hover over this item.

### TreeItemCheckboxState

Checkbox state of the tree item

#### Enumeration Members

Unchecked: 0

Determines an item is unchecked

Checked: 1

Determines an item is checked

### TreeItemCollapsibleState

Collapsible state of the tree item

#### Enumeration Members

None: 0

Determines an item can be neither collapsed nor expanded. Implies it has no children.

Collapsed: 1

Determines an item is collapsed

Expanded: 2

Determines an item is expanded

### TreeItemLabel

Label describing the [Tree item](#TreeItem)

#### Properties

highlights?: Array<\[number, number\]>

Ranges in the label to highlight. A range is defined as a tuple of two number where the first is the inclusive start index and the second the exclusive end index

label: string

A human-readable string describing the [Tree item](#TreeItem).

### TreeView<T>

Represents a Tree view

#### Events

onDidChangeCheckboxState: [Event](#Event&lt;T&gt;)<[TreeCheckboxChangeEvent](#TreeCheckboxChangeEvent&lt;T&gt;)<T\>>

An event to signal that an element or root has either been checked or unchecked.

onDidChangeSelection: [Event](#Event&lt;T&gt;)<[TreeViewSelectionChangeEvent](#TreeViewSelectionChangeEvent&lt;T&gt;)<T\>>

Event that is fired when the [selection](#TreeView.selection) has changed

onDidChangeVisibility: [Event](#Event&lt;T&gt;)<[TreeViewVisibilityChangeEvent](#TreeViewVisibilityChangeEvent)\>

Event that is fired when [visibility](#TreeView.visible) has changed

onDidCollapseElement: [Event](#Event&lt;T&gt;)<[TreeViewExpansionEvent](#TreeViewExpansionEvent&lt;T&gt;)<T\>>

Event that is fired when an element is collapsed

onDidExpandElement: [Event](#Event&lt;T&gt;)<[TreeViewExpansionEvent](#TreeViewExpansionEvent&lt;T&gt;)<T\>>

Event that is fired when an element is expanded

#### Properties

badge?: [ViewBadge](#ViewBadge)

The badge to display for this TreeView. To remove the badge, set to undefined.

description?: string

An optional human-readable description which is rendered less prominently in the title of the view. Setting the title description to null, undefined, or empty string will remove the description from the view.

message?: string

An optional human-readable message that will be rendered in the view. Setting the message to null, undefined, or empty string will remove the message from the view.

selection: readonly T\[\]

Currently selected elements.

title?: string

The tree view title is initially taken from the extension package.json Changes to the title property will be properly reflected in the UI in the title of the view.

visible: boolean

`true` if the [tree view](#TreeView) is visible otherwise `false`.

#### Methods

dispose(): any

Dispose this object.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| any |     |

reveal(element: T, options?: {expand: number | boolean, focus: boolean, select: boolean}): Thenable<void\>

Reveals the given element in the tree view. If the tree view is not visible then the tree view is shown and element is revealed.

By default revealed element is selected. In order to not to select, set the option `select` to `false`. In order to focus, set the option `focus` to `true`. In order to expand the revealed element, set the option `expand` to `true`. To expand recursively set `expand` to the number of levels to expand.

*   _NOTE:_ You can expand only to 3 levels maximum.
*   _NOTE:_ The [TreeDataProvider](#TreeDataProvider) that the `TreeView` [is registered with](#window.createTreeView) with must implement [getParent](#TreeDataProvider.getParent) method to access this API.

| Parameter | Description |
| --- | --- |
| element: T |     |
| options?: {expand: number \| boolean, focus: boolean, select: boolean} |     |
| Returns | Description |
| Thenable<void\> |     |

### TreeViewExpansionEvent<T>

The event that is fired when an element in the [TreeView](#TreeView) is expanded or collapsed

#### Properties

element: T

Element that is expanded or collapsed.

### TreeViewOptions<T>

Options for creating a [TreeView](#TreeView)

#### Properties

canSelectMany?: boolean

Whether the tree supports multi-select. When the tree supports multi-select and a command is executed from the tree, the first argument to the command is the tree item that the command was executed on and the second argument is an array containing all selected tree items.

dragAndDropController?: [TreeDragAndDropController](#TreeDragAndDropController&lt;T&gt;)<T\>

An optional interface to implement drag and drop in the tree view.

manageCheckboxStateManually?: boolean

By default, when the children of a tree item have already been fetched, child checkboxes are automatically managed based on the checked state of the parent tree item. If the tree item is collapsed by default (meaning that the children haven't yet been fetched) then child checkboxes will not be updated. To override this behavior and manage child and parent checkbox state in the extension, set this to `true`.

Examples where [TreeViewOptions.manageCheckboxStateManually](#TreeViewOptions.manageCheckboxStateManually) is false, the default behavior:

1.  A tree item is checked, then its children are fetched. The children will be checked.
    
2.  A tree item's parent is checked. The tree item and all of it's siblings will be checked.
    

*   [ ]  Parent
    *   [ ]  Child 1
    *   [ ]  Child 2 When the user checks Parent, the tree will look like this:
*   [x]  Parent
    *   [x]  Child 1
    *   [x]  Child 2

3.  A tree item and all of it's siblings are checked. The parent will be checked.

*   [ ]  Parent
    *   [ ]  Child 1
    *   [ ]  Child 2 When the user checks Child 1 and Child 2, the tree will look like this:
*   [x]  Parent
    *   [x]  Child 1
    *   [x]  Child 2

4.  A tree item is unchecked. The parent will be unchecked.

*   [x]  Parent
    *   [x]  Child 1
    *   [x]  Child 2 When the user unchecks Child 1, the tree will look like this:
*   [ ]  Parent
    *   [ ]  Child 1
    *   [x]  Child 2

showCollapseAll?: boolean

Whether to show collapse all action or not.

treeDataProvider: [TreeDataProvider](#TreeDataProvider&lt;T&gt;)<T\>

A data provider that provides tree data.

### TreeViewSelectionChangeEvent<T>

The event that is fired when there is a change in [tree view's selection](#TreeView.selection)

#### Properties

selection: readonly T\[\]

Selected elements.

### TreeViewVisibilityChangeEvent

The event that is fired when there is a change in [tree view's visibility](#TreeView.visible)

#### Properties

visible: boolean

`true` if the [tree view](#TreeView) is visible otherwise `false`.

### TypeDefinitionProvider

The type definition provider defines the contract between extensions and the go to type definition feature.

#### Methods

provideTypeDefinition(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[Definition](#Definition) | [LocationLink](#LocationLink)\[\]>

Provide the type definition of the symbol at the given position and document.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[Definition](#Definition) \| [LocationLink](#LocationLink)\[\]> | A definition or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### TypeHierarchyItem

Represents an item of a type hierarchy, like a class or an interface.

#### Constructors

new TypeHierarchyItem(kind: [SymbolKind](#SymbolKind), name: string, detail: string, uri: [Uri](#Uri), range: [Range](#Range), selectionRange: [Range](#Range)): [TypeHierarchyItem](#TypeHierarchyItem)

Creates a new type hierarchy item.

| Parameter | Description |
| --- | --- |
| kind: [SymbolKind](#SymbolKind) | The kind of the item. |
| name: string | The name of the item. |
| detail: string | The details of the item. |
| uri: [Uri](#Uri) | The Uri of the item. |
| range: [Range](#Range) | The whole range of the item. |
| selectionRange: [Range](#Range) | The selection range of the item. |
| Returns | Description |
| [TypeHierarchyItem](#TypeHierarchyItem) |     |

#### Properties

detail?: string

More detail for this item, e.g. the signature of a function.

kind: [SymbolKind](#SymbolKind)

The kind of this item.

name: string

The name of this item.

range: [Range](#Range)

The range enclosing this symbol not including leading/trailing whitespace but everything else, e.g. comments and code.

selectionRange: [Range](#Range)

The range that should be selected and revealed when this symbol is being picked, e.g. the name of a class. Must be contained by the [range](#TypeHierarchyItem.range)\-property.

tags?: readonly [SymbolTag](#SymbolTag)\[\]

Tags for this item.

uri: [Uri](#Uri)

The resource identifier of this item.

### TypeHierarchyProvider

The type hierarchy provider interface describes the contract between extensions and the type hierarchy feature.

#### Methods

prepareTypeHierarchy(document: [TextDocument](#TextDocument), position: [Position](#Position), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[TypeHierarchyItem](#TypeHierarchyItem) | [TypeHierarchyItem](#TypeHierarchyItem)\[\]>

Bootstraps type hierarchy by returning the item that is denoted by the given document and position. This item will be used as entry into the type graph. Providers should return `undefined` or `null` when there is no item at the given location.

| Parameter | Description |
| --- | --- |
| document: [TextDocument](#TextDocument) | The document in which the command was invoked. |
| position: [Position](#Position) | The position at which the command was invoked. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[TypeHierarchyItem](#TypeHierarchyItem) \| [TypeHierarchyItem](#TypeHierarchyItem)\[\]> | One or multiple type hierarchy items or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

provideTypeHierarchySubtypes(item: [TypeHierarchyItem](#TypeHierarchyItem), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[TypeHierarchyItem](#TypeHierarchyItem)\[\]>

Provide all subtypes for an item, e.g all types which are derived/inherited from the given item. In graph terms this describes directed and annotated edges inside the type graph, e.g the given item is the starting node and the result is the nodes that can be reached.

| Parameter | Description |
| --- | --- |
| item: [TypeHierarchyItem](#TypeHierarchyItem) | The hierarchy item for which subtypes should be computed. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[TypeHierarchyItem](#TypeHierarchyItem)\[\]> | A set of direct subtypes or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

provideTypeHierarchySupertypes(item: [TypeHierarchyItem](#TypeHierarchyItem), token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<[TypeHierarchyItem](#TypeHierarchyItem)\[\]>

Provide all supertypes for an item, e.g all types from which a type is derived/inherited. In graph terms this describes directed and annotated edges inside the type graph, e.g the given item is the starting node and the result is the nodes that can be reached.

| Parameter | Description |
| --- | --- |
| item: [TypeHierarchyItem](#TypeHierarchyItem) | The hierarchy item for which super types should be computed. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<[TypeHierarchyItem](#TypeHierarchyItem)\[\]> | A set of direct supertypes or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined` or `null`. |

### UIKind

Possible kinds of UI that can use extensions.

#### Enumeration Members

Desktop: 1

Extensions are accessed from a desktop application.

Web: 2

Extensions are accessed from a web browser.

### Uri

A universal resource identifier representing either a file on disk or another resource, like untitled resources.

#### Static

file(path: string): [Uri](#Uri)

Create an URI from a file system path. The [scheme](#Uri.scheme) will be `file`.

The _difference_ between [Uri.parse](#Uri.parse) and [Uri.file](#Uri.file) is that the latter treats the argument as path, not as stringified-uri. E.g. `Uri.file(path)` is _not_ the same as `Uri.parse('file://' + path)` because the path might contain characters that are interpreted (#\_ and ?). See the following sample:

```
const good = URI.file('/coding/c#/project1');
good.scheme === 'file';
good.path === '/coding/c#/project1';
good.fragment === '';

const bad = URI.parse('file://' + '/coding/c#/project1');
bad.scheme === 'file';
bad.path === '/coding/c'; // path is now broken
bad.fragment === '/project1';
```

| Parameter | Description |
| --- | --- |
| path: string | A file system or UNC path. |
| Returns | Description |
| [Uri](#Uri) | A new Uri instance. |

from(components: {authority: string, fragment: string, path: string, query: string, scheme: string}): [Uri](#Uri)

Create an URI from its component parts

_See also_ [Uri.toString](#Uri.toString)

| Parameter | Description |
| --- | --- |
| components: {authority: string, fragment: string, path: string, query: string, scheme: string} | The component parts of an Uri. |
| Returns | Description |
| [Uri](#Uri) | A new Uri instance. |

joinPath(base: [Uri](#Uri), ...pathSegments: string\[\]): [Uri](#Uri)

Create a new uri which path is the result of joining the path of the base uri with the provided path segments.

*   Note 1: `joinPath` only affects the path component and all other components (scheme, authority, query, and fragment) are left as they are.
*   Note 2: The base uri must have a path; an error is thrown otherwise.

The path segments are normalized in the following ways:

*   sequences of path separators (`/` or `\`) are replaced with a single separator
*   for `file`\-uris on windows, the backslash-character (\`\`) is considered a path-separator
*   the `..`\-segment denotes the parent segment, the `.` denotes the current segment
*   paths have a root which always remains, for instance on windows drive-letters are roots so that is true: `joinPath(Uri.file('file:///c:/root'), '../../other').fsPath === 'c:/other'`

| Parameter | Description |
| --- | --- |
| base: [Uri](#Uri) | An uri. Must have a path. |
| ...pathSegments: string\[\] | One more more path fragments |
| Returns | Description |
| [Uri](#Uri) | A new uri which path is joined with the given fragments |

parse(value: string, strict?: boolean): [Uri](#Uri)

Create an URI from a string, e.g. `http://www.example.com/some/path`, `file:///usr/home`, or `scheme:with/path`.

_Note_ that for a while uris without a `scheme` were accepted. That is not correct as all uris should have a scheme. To avoid breakage of existing code the optional `strict`\-argument has been added. We _strongly_ advise to use it, e.g. `Uri.parse('my:uri', true)`

_See also_ [Uri.toString](#Uri.toString)

| Parameter | Description |
| --- | --- |
| value: string | The string value of an Uri. |
| strict?: boolean | Throw an error when `value` is empty or when no `scheme` can be parsed. |
| Returns | Description |
| [Uri](#Uri) | A new Uri instance. |

#### Constructors

new Uri(scheme: string, authority: string, path: string, query: string, fragment: string): [Uri](#Uri)

Use the `file` and `parse` factory functions to create new `Uri` objects.

| Parameter | Description |
| --- | --- |
| scheme: string |     |
| authority: string |     |
| path: string |     |
| query: string |     |
| fragment: string |     |
| Returns | Description |
| [Uri](#Uri) |     |

#### Properties

authority: string

Authority is the `www.example.com` part of `http://www.example.com/some/path?query#fragment`. The part between the first double slashes and the next slash.

fragment: string

Fragment is the `fragment` part of `http://www.example.com/some/path?query#fragment`.

fsPath: string

The string representing the corresponding file system path of this Uri.

Will handle UNC paths and normalize windows drive letters to lower-case. Also uses the platform specific path separator.

*   Will _not_ validate the path for invalid characters and semantics.
*   Will _not_ look at the scheme of this Uri.
*   The resulting string shall _not_ be used for display purposes but for disk operations, like `readFile` et al.

The _difference_ to the [path](#Uri.path)\-property is the use of the platform specific path separator and the handling of UNC paths. The sample below outlines the difference:

```
const u = URI.parse('file://server/c$/folder/file.txt');
u.authority === 'server';
u.path === '/c$/folder/file.txt';
u.fsPath === '\\serverc$\folder\file.txt';
```

path: string

Path is the `/some/path` part of `http://www.example.com/some/path?query#fragment`.

query: string

Query is the `query` part of `http://www.example.com/some/path?query#fragment`.

scheme: string

Scheme is the `http` part of `http://www.example.com/some/path?query#fragment`. The part before the first colon.

#### Methods

toJSON(): any

Returns a JSON representation of this Uri.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| any | An object. |

toString(skipEncoding?: boolean): string

Returns a string representation of this Uri. The representation and normalization of a URI depends on the scheme.

*   The resulting string can be safely used with [Uri.parse](#Uri.parse).
*   The resulting string shall _not_ be used for display purposes.

_Note_ that the implementation will encode _aggressive_ which often leads to unexpected, but not incorrect, results. For instance, colons are encoded to `%3A` which might be unexpected in file-uri. Also `&` and `=` will be encoded which might be unexpected for http-uris. For stability reasons this cannot be changed anymore. If you suffer from too aggressive encoding you should use the `skipEncoding`\-argument: `uri.toString(true)`.

| Parameter | Description |
| --- | --- |
| skipEncoding?: boolean | Do not percentage-encode the result, defaults to `false`. Note that the `#` and `?` characters occurring in the path will always be encoded. |
| Returns | Description |
| string | A string representation of this Uri. |

with(change: {authority: string, fragment: string, path: string, query: string, scheme: string}): [Uri](#Uri)

Derive a new Uri from this Uri.

```
let file = Uri.parse('before:some/file/path');
let other = file.with({ scheme: 'after' });
assert.ok(other.toString() === 'after:some/file/path');
```

| Parameter | Description |
| --- | --- |
| change: {authority: string, fragment: string, path: string, query: string, scheme: string} | An object that describes a change to this Uri. To unset components use `null` or the empty string. |
| Returns | Description |
| [Uri](#Uri) | A new Uri that reflects the given change. Will return `this` Uri if the change is not changing anything. |

### UriHandler

A uri handler is responsible for handling system-wide [uris](#Uri).

_See also_ [window.registerUriHandler](#window.registerUriHandler).

#### Methods

handleUri(uri: [Uri](#Uri)): [ProviderResult](#ProviderResult&lt;T&gt;)<void\>

Handle the provided system-wide [Uri](#Uri).

_See also_ [window.registerUriHandler](#window.registerUriHandler).

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) |     |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<void\> |     |

### ViewBadge

A badge presenting a value for a view

#### Properties

tooltip: string

A label to present in tooltip for the badge.

value: number

The value to present in the badge.

### ViewColumn

Denotes a location of an editor in the window. Editors can be arranged in a grid and each column represents one editor location in that grid by counting the editors in order of their appearance.

#### Enumeration Members

Beside: \-2

A _symbolic_ editor column representing the column to the side of the active one. This value can be used when opening editors, but the _resolved_ [viewColumn](#TextEditor.viewColumn)\-value of editors will always be `One`, `Two`, `Three`,... or `undefined` but never `Beside`.

Active: \-1

A _symbolic_ editor column representing the currently active column. This value can be used when opening editors, but the _resolved_ [viewColumn](#TextEditor.viewColumn)\-value of editors will always be `One`, `Two`, `Three`,... or `undefined` but never `Active`.

One: 1

The first editor column.

Two: 2

The second editor column.

Three: 3

The third editor column.

Four: 4

The fourth editor column.

Five: 5

The fifth editor column.

Six: 6

The sixth editor column.

Seven: 7

The seventh editor column.

Eight: 8

The eighth editor column.

Nine: 9

The ninth editor column.

### Webview

Displays html content, similarly to an iframe.

#### Events

onDidReceiveMessage: [Event](#Event&lt;T&gt;)<any\>

Fired when the webview content posts a message.

Webview content can post strings or json serializable objects back to an extension. They cannot post `Blob`, `File`, `ImageData` and other DOM specific objects since the extension that receives the message does not run in a browser environment.

#### Properties

cspSource: string

Content security policy source for webview resources.

This is the origin that should be used in a content security policy rule:

```
`img-src https: ${webview.cspSource} ...;`;
```

html: string

HTML contents of the webview.

This should be a complete, valid html document. Changing this property causes the webview to be reloaded.

Webviews are sandboxed from normal extension process, so all communication with the webview must use message passing. To send a message from the extension to the webview, use [postMessage](#Webview.postMessage). To send message from the webview back to an extension, use the `acquireVsCodeApi` function inside the webview to get a handle to the editor's api and then call `.postMessage()`:

```
<script>
    const vscode = acquireVsCodeApi(); // acquireVsCodeApi can only be invoked once
    vscode.postMessage({ message: 'hello!' });
</script>
```

To load a resources from the workspace inside a webview, use the [asWebviewUri](#Webview.asWebviewUri) method and ensure the resource's directory is listed in [WebviewOptions.localResourceRoots](#WebviewOptions.localResourceRoots).

Keep in mind that even though webviews are sandboxed, they still allow running scripts and loading arbitrary content, so extensions must follow all standard web security best practices when working with webviews. This includes properly sanitizing all untrusted input (including content from the workspace) and setting a [content security policy](https://aka.ms/vscode-api-webview-csp).

options: [WebviewOptions](#WebviewOptions)

Content settings for the webview.

#### Methods

asWebviewUri(localResource: [Uri](#Uri)): [Uri](#Uri)

Convert a uri for the local file system to one that can be used inside webviews.

Webviews cannot directly load resources from the workspace or local file system using `file:` uris. The `asWebviewUri` function takes a local `file:` uri and converts it into a uri that can be used inside of a webview to load the same resource:

```
webview.html = `<img src="${webview.asWebviewUri(
  vscode.Uri.file('/Users/codey/workspace/cat.gif')
)}">`;
```

| Parameter | Description |
| --- | --- |
| localResource: [Uri](#Uri) |     |
| Returns | Description |
| [Uri](#Uri) |     |

postMessage(message: any): Thenable<boolean\>

Post a message to the webview content.

Messages are only delivered if the webview is live (either visible or in the background with `retainContextWhenHidden`).

| Parameter | Description |
| --- | --- |
| message: any | Body of the message. This must be a string or other json serializable object.<br><br>For older versions of vscode, if an `ArrayBuffer` is included in `message`, it will not be serialized properly and will not be received by the webview. Similarly any TypedArrays, such as a `Uint8Array`, will be very inefficiently serialized and will also not be recreated as a typed array inside the webview.<br><br>However if your extension targets vscode 1.57+ in the `engines` field of its `package.json`, any `ArrayBuffer` values that appear in `message` will be more efficiently transferred to the webview and will also be correctly recreated inside of the webview. |
| Returns | Description |
| Thenable<boolean\> | A promise that resolves when the message is posted to a webview or when it is dropped because the message was not deliverable.<br><br>Returns `true` if the message was posted to the webview. Messages can only be posted to live webviews (i.e. either visible webviews or hidden webviews that set `retainContextWhenHidden`).<br><br>A response of `true` does not mean that the message was actually received by the webview. For example, no message listeners may be have been hooked up inside the webview or the webview may have been destroyed after the message was posted but before it was received.<br><br>If you want confirm that a message as actually received, you can try having your webview posting a confirmation message back to your extension. |

### WebviewOptions

Content settings for a webview.

#### Properties

enableCommandUris?: boolean | readonly string\[\]

Controls whether command uris are enabled in webview content or not.

Defaults to `false` (command uris are disabled).

If you pass in an array, only the commands in the array are allowed.

enableForms?: boolean

Controls whether forms are enabled in the webview content or not.

Defaults to true if [scripts are enabled](#WebviewOptions.enableScripts). Otherwise defaults to false. Explicitly setting this property to either true or false overrides the default.

enableScripts?: boolean

Controls whether scripts are enabled in the webview content or not.

Defaults to false (scripts-disabled).

localResourceRoots?: readonly [Uri](#Uri)\[\]

Root paths from which the webview can load local (filesystem) resources using uris from `asWebviewUri`

Default to the root folders of the current workspace plus the extension's install directory.

Pass in an empty array to disallow access to any local resources.

portMapping?: readonly [WebviewPortMapping](#WebviewPortMapping)\[\]

Mappings of localhost ports used inside the webview.

Port mapping allow webviews to transparently define how localhost ports are resolved. This can be used to allow using a static localhost port inside the webview that is resolved to random port that a service is running on.

If a webview accesses localhost content, we recommend that you specify port mappings even if the `webviewPort` and `extensionHostPort` ports are the same.

_Note_ that port mappings only work for `http` or `https` urls. Websocket urls (e.g. `ws://localhost:3000`) cannot be mapped to another port.

### WebviewPanel

A panel that contains a [Webview](#Webview).

#### Events

onDidChangeViewState: [Event](#Event&lt;T&gt;)<[WebviewPanelOnDidChangeViewStateEvent](#WebviewPanelOnDidChangeViewStateEvent)\>

Fired when the panel's view state changes.

onDidDispose: [Event](#Event&lt;T&gt;)<void\>

Fired when the panel is disposed.

This may be because the user closed the panel or because [dispose](#WebviewPanel.dispose) was called on it.

Trying to use the panel after it has been disposed throws an exception.

#### Properties

active: boolean

Whether the panel is active (focused by the user).

iconPath?: [IconPath](#IconPath)

Icon for the panel shown in UI.

options: [WebviewPanelOptions](#WebviewPanelOptions)

Content settings for the webview panel.

title: string

Title of the panel shown in UI.

viewColumn: [ViewColumn](#ViewColumn)

Editor position of the panel. This property is only set if the webview is in one of the editor view columns.

viewType: string

Identifies the type of the webview panel, such as `'markdown.preview'`.

visible: boolean

Whether the panel is visible.

webview: [Webview](#Webview)

[Webview](#Webview) belonging to the panel.

#### Methods

dispose(): any

Dispose of the webview panel.

This closes the panel if it showing and disposes of the resources owned by the webview. Webview panels are also disposed when the user closes the webview panel. Both cases fire the [onDidDispose](#WebviewPanel.onDidDispose) event.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| any |     |

reveal(viewColumn?: [ViewColumn](#ViewColumn), preserveFocus?: boolean): void

Show the webview panel in a given column.

A webview panel may only show in a single column at a time. If it is already showing, this method moves it to a new column.

| Parameter | Description |
| --- | --- |
| viewColumn?: [ViewColumn](#ViewColumn) | View column to show the panel in. Shows in the current [WebviewPanel.viewColumn](#WebviewPanel.viewColumn) if undefined. |
| preserveFocus?: boolean | When `true`, the webview will not take focus. |
| Returns | Description |
| void |     |

### WebviewPanelOnDidChangeViewStateEvent

Event fired when a [webview panel's](#WebviewPanel) view state changes.

#### Properties

webviewPanel: [WebviewPanel](#WebviewPanel)

[WebviewPanel](#WebviewPanel) whose view state changed.

### WebviewPanelOptions

Content settings for a webview panel.

#### Properties

enableFindWidget?: boolean

Controls if the find widget is enabled in the panel.

Defaults to `false`.

retainContextWhenHidden?: boolean

Controls if the webview panel's content (iframe) is kept around even when the panel is no longer visible.

Normally the webview panel's html context is created when the panel becomes visible and destroyed when it is hidden. Extensions that have complex state or UI can set the `retainContextWhenHidden` to make the editor keep the webview context around, even when the webview moves to a background tab. When a webview using `retainContextWhenHidden` becomes hidden, its scripts and other dynamic content are suspended. When the panel becomes visible again, the context is automatically restored in the exact same state it was in originally. You cannot send messages to a hidden webview, even with `retainContextWhenHidden` enabled.

`retainContextWhenHidden` has a high memory overhead and should only be used if your panel's context cannot be quickly saved and restored.

### WebviewPanelSerializer<T>

Restore webview panels that have been persisted when vscode shuts down.

There are two types of webview persistence:

*   Persistence within a session.
*   Persistence across sessions (across restarts of the editor).

A `WebviewPanelSerializer` is only required for the second case: persisting a webview across sessions.

Persistence within a session allows a webview to save its state when it becomes hidden and restore its content from this state when it becomes visible again. It is powered entirely by the webview content itself. To save off a persisted state, call `acquireVsCodeApi().setState()` with any json serializable object. To restore the state again, call `getState()`

```
// Within the webview
const vscode = acquireVsCodeApi();

// Get existing state
const oldState = vscode.getState() || { value: 0 };

// Update state
setState({ value: oldState.value + 1 });
```

A `WebviewPanelSerializer` extends this persistence across restarts of the editor. When the editor is shutdown, it will save off the state from `setState` of all webviews that have a serializer. When the webview first becomes visible after the restart, this state is passed to `deserializeWebviewPanel`. The extension can then restore the old `WebviewPanel` from this state.

#### Methods

deserializeWebviewPanel(webviewPanel: [WebviewPanel](#WebviewPanel), state: T): Thenable<void\>

Restore a webview panel from its serialized `state`.

Called when a serialized webview first becomes visible.

| Parameter | Description |
| --- | --- |
| webviewPanel: [WebviewPanel](#WebviewPanel) | Webview panel to restore. The serializer should take ownership of this panel. The serializer must restore the webview's `.html` and hook up all webview events. |
| state: T | Persisted state from the webview content. |
| Returns | Description |
| Thenable<void\> | Thenable indicating that the webview has been fully restored. |

### WebviewPortMapping

Defines a port mapping used for localhost inside the webview.

#### Properties

extensionHostPort: number

Destination port. The `webviewPort` is resolved to this port.

webviewPort: number

Localhost port to remap inside the webview.

### WebviewView

A webview based view.

#### Events

onDidChangeVisibility: [Event](#Event&lt;T&gt;)<void\>

Event fired when the visibility of the view changes.

Actions that trigger a visibility change:

*   The view is collapsed or expanded.
*   The user switches to a different view group in the sidebar or panel.

Note that hiding a view using the context menu instead disposes of the view and fires `onDidDispose`.

onDidDispose: [Event](#Event&lt;T&gt;)<void\>

Event fired when the view is disposed.

Views are disposed when they are explicitly hidden by a user (this happens when a user right clicks in a view and unchecks the webview view).

Trying to use the view after it has been disposed throws an exception.

#### Properties

badge?: [ViewBadge](#ViewBadge)

The badge to display for this webview view. To remove the badge, set to undefined.

description?: string

Human-readable string which is rendered less prominently in the title.

title?: string

View title displayed in the UI.

The view title is initially taken from the extension `package.json` contribution.

viewType: string

Identifies the type of the webview view, such as `'hexEditor.dataView'`.

visible: boolean

Tracks if the webview is currently visible.

Views are visible when they are on the screen and expanded.

webview: [Webview](#Webview)

The underlying webview for the view.

#### Methods

show(preserveFocus?: boolean): void

Reveal the view in the UI.

If the view is collapsed, this will expand it.

| Parameter | Description |
| --- | --- |
| preserveFocus?: boolean | When `true` the view will not take focus. |
| Returns | Description |
| void |     |

### WebviewViewProvider

Provider for creating [WebviewView](#WebviewView) elements.

#### Methods

resolveWebviewView(webviewView: [WebviewView](#WebviewView), context: [WebviewViewResolveContext](#WebviewViewResolveContext&lt;T&gt;)<unknown\>, token: [CancellationToken](#CancellationToken)): void | Thenable<void\>

Resolves a webview view.

`resolveWebviewView` is called when a view first becomes visible. This may happen when the view is first loaded or when the user hides and then shows a view again.

| Parameter | Description |
| --- | --- |
| webviewView: [WebviewView](#WebviewView) | Webview view to restore. The provider should take ownership of this view. The provider must set the webview's `.html` and hook up all webview events it is interested in. |
| context: [WebviewViewResolveContext](#WebviewViewResolveContext&lt;T&gt;)<unknown\> | Additional metadata about the view being resolved. |
| token: [CancellationToken](#CancellationToken) | Cancellation token indicating that the view being provided is no longer needed. |
| Returns | Description |
| void \| Thenable<void\> | Optional thenable indicating that the view has been fully resolved. |

### WebviewViewResolveContext<T>

Additional information the webview view being resolved.

#### Properties

state: T

Persisted state from the webview content.

To save resources, the editor normally deallocates webview documents (the iframe content) that are not visible. For example, when the user collapse a view or switches to another top level activity in the sidebar, the [WebviewView](#WebviewView) itself is kept alive but the webview's underlying document is deallocated. It is recreated when the view becomes visible again.

You can prevent this behavior by setting \[WebviewOptions.retainContextWhenHidden retainContextWhenHidden\](#\_WebviewOptions.retainContextWhenHidden retainContextWhenHidden) in the [WebviewOptions](#WebviewOptions). However this increases resource usage and should be avoided wherever possible. Instead, you can use persisted state to save off a webview's state so that it can be quickly recreated as needed.

To save off a persisted state, inside the webview call `acquireVsCodeApi().setState()` with any json serializable object. To restore the state again, call `getState()`. For example:

```
// Within the webview
const vscode = acquireVsCodeApi();

// Get existing state
const oldState = vscode.getState() || { value: 0 };

// Update state
setState({ value: oldState.value + 1 });
```

The editor ensures that the persisted state is saved correctly when a webview is hidden and across editor restarts.

### WindowState

Represents the state of a window.

#### Properties

active: boolean

Whether the window has been interacted with recently. This will change immediately on activity, or after a short time of user inactivity.

focused: boolean

Whether the current window is focused.

### WorkspaceConfiguration

Represents the configuration. It is a merged view of

*   _Default Settings_
*   _Global (User) Settings_
*   _Workspace settings_
*   _Workspace Folder settings_ - From one of the [Workspace Folders](#workspace.workspaceFolders) under which requested resource belongs to.
*   _Language settings_ - Settings defined under requested language.

The _effective_ value (returned by [get](#WorkspaceConfiguration.get)) is computed by overriding or merging the values in the following order:

1.  `defaultValue` (if defined in `package.json` otherwise derived from the value's type)
2.  `globalValue` (if defined)
3.  `workspaceValue` (if defined)
4.  `workspaceFolderValue` (if defined)
5.  `defaultLanguageValue` (if defined)
6.  `globalLanguageValue` (if defined)
7.  `workspaceLanguageValue` (if defined)
8.  `workspaceFolderLanguageValue` (if defined)

**Note:** Only `object` value types are merged and all other value types are overridden.

Example 1: Overriding

```
defaultValue = 'on';
globalValue = 'relative';
workspaceFolderValue = 'off';
value = 'off';
```

Example 2: Language Values

```
defaultValue = 'on';
globalValue = 'relative';
workspaceFolderValue = 'off';
globalLanguageValue = 'on';
value = 'on';
```

Example 3: Object Values

```
defaultValue = { a: 1, b: 2 };
globalValue = { b: 3, c: 4 };
value = { a: 1, b: 3, c: 4 };
```

_Note:_ Workspace and Workspace Folder configurations contains `launch` and `tasks` settings. Their basename will be part of the section identifier. The following snippets shows how to retrieve all configurations from `launch.json`:

```
// launch.json configuration
const config = workspace.getConfiguration(
  'launch',
  vscode.workspace.workspaceFolders[0].uri
);

// retrieve values
const values = config.get('configurations');
```

Refer to [Settings](https://code.visualstudio.com/docs/getstarted/settings) for more information.

#### Methods

get<T\>(section: string): T

Return a value from this configuration.

| Parameter | Description |
| --- | --- |
| section: string | Configuration name, supports _dotted_ names. |
| Returns | Description |
| T   | The value `section` denotes or `undefined`. |

get<T\>(section: string, defaultValue: T): T

Return a value from this configuration.

| Parameter | Description |
| --- | --- |
| section: string | Configuration name, supports _dotted_ names. |
| defaultValue: T | A value should be returned when no value could be found, is `undefined`. |
| Returns | Description |
| T   | The value `section` denotes or the default. |

has(section: string): boolean

Check if this configuration has a certain value.

| Parameter | Description |
| --- | --- |
| section: string | Configuration name, supports _dotted_ names. |
| Returns | Description |
| boolean | `true` if the section doesn't resolve to `undefined`. |

inspect<T\>(section: string): {defaultLanguageValue: T, defaultValue: T, globalLanguageValue: T, globalValue: T, key: string, languageIds: string\[\], workspaceFolderLanguageValue: T, workspaceFolderValue: T, workspaceLanguageValue: T, workspaceValue: T}

Retrieve all information about a configuration setting. A configuration value often consists of a _default_ value, a global or installation-wide value, a workspace-specific value, folder-specific value and language-specific values (if [WorkspaceConfiguration](#WorkspaceConfiguration) is scoped to a language).

Also provides all language ids under which the given configuration setting is defined.

_Note:_ The configuration name must denote a leaf in the configuration tree (`editor.fontSize` vs `editor`) otherwise no result is returned.

| Parameter | Description |
| --- | --- |
| section: string | Configuration name, supports _dotted_ names. |
| Returns | Description |
| {defaultLanguageValue: T, defaultValue: T, globalLanguageValue: T, globalValue: T, key: string, languageIds: string\[\], workspaceFolderLanguageValue: T, workspaceFolderValue: T, workspaceLanguageValue: T, workspaceValue: T} | Information about a configuration setting or `undefined`. |

update(section: string, value: any, configurationTarget?: boolean | [ConfigurationTarget](#ConfigurationTarget), overrideInLanguage?: boolean): Thenable<void\>

Update a configuration value. The updated configuration values are persisted.

A value can be changed in

*   [Global settings](#ConfigurationTarget.Global): Changes the value for all instances of the editor.
*   [Workspace settings](#ConfigurationTarget.Workspace): Changes the value for current workspace, if available.
*   [Workspace folder settings](#ConfigurationTarget.WorkspaceFolder): Changes the value for settings from one of the [Workspace Folders](#workspace.workspaceFolders) under which the requested resource belongs to.
*   Language settings: Changes the value for the requested languageId.

_Note:_ To remove a configuration value use `undefined`, like so: `config.update('somekey', undefined)`

*   _throws_ - error while updating
    *   configuration which is not registered.
    *   window configuration to workspace folder
    *   configuration to workspace or workspace folder when no workspace is opened.
    *   configuration to workspace folder when there is no workspace folder settings.
    *   configuration to workspace folder when [WorkspaceConfiguration](#WorkspaceConfiguration) is not scoped to a resource.

| Parameter | Description |
| --- | --- |
| section: string | Configuration name, supports _dotted_ names. |
| value: any | The new value. |
| configurationTarget?: boolean \| [ConfigurationTarget](#ConfigurationTarget) | The [configuration target](#ConfigurationTarget) or a boolean value. - If `true` updates [Global settings](#ConfigurationTarget.Global). - If `false` updates [Workspace settings](#ConfigurationTarget.Workspace). - If `undefined` or `null` updates to [Workspace folder settings](#ConfigurationTarget.WorkspaceFolder) if configuration is resource specific, otherwise to [Workspace settings](#ConfigurationTarget.Workspace). |
| overrideInLanguage?: boolean | Whether to update the value in the scope of requested languageId or not. - If `true` updates the value under the requested languageId. - If `undefined` updates the value under the requested languageId only if the configuration is defined for the language. |
| Returns | Description |
| Thenable<void\> |     |

### WorkspaceEdit

A workspace edit is a collection of textual and files changes for multiple resources and documents.

Use the [applyEdit](#workspace.applyEdit)\-function to apply a workspace edit.

#### Constructors

new WorkspaceEdit(): [WorkspaceEdit](#WorkspaceEdit)

| Parameter | Description |
| --- | --- |
| Returns | Description |
| [WorkspaceEdit](#WorkspaceEdit) |     |

#### Properties

size: number

The number of affected resources of textual or resource changes.

#### Methods

createFile(uri: [Uri](#Uri), options?: {contents: Uint8Array | [DataTransferFile](#DataTransferFile), ignoreIfExists: boolean, overwrite: boolean}, metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)): void

Create a regular file.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | Uri of the new file. |
| options?: {contents: Uint8Array \| [DataTransferFile](#DataTransferFile), ignoreIfExists: boolean, overwrite: boolean} | Defines if an existing file should be overwritten or be ignored. When `overwrite` and `ignoreIfExists` are both set `overwrite` wins. When both are unset and when the file already exists then the edit cannot be applied successfully. The `content`\-property allows to set the initial contents the file is being created with. |
| metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata) | Optional metadata for the entry. |
| Returns | Description |
| void |     |

delete(uri: [Uri](#Uri), range: [Range](#Range), metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)): void

Delete the text at the given range.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| range: [Range](#Range) | A range. |
| metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata) | Optional metadata for the entry. |
| Returns | Description |
| void |     |

deleteFile(uri: [Uri](#Uri), options?: {ignoreIfNotExists: boolean, recursive: boolean}, metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)): void

Delete a file or folder.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | The uri of the file that is to be deleted. |
| options?: {ignoreIfNotExists: boolean, recursive: boolean} |     |
| metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata) | Optional metadata for the entry. |
| Returns | Description |
| void |     |

entries(): Array<\[[Uri](#Uri), [TextEdit](#TextEdit)\[\]\]>

Get all text edits grouped by resource.

| Parameter | Description |
| --- | --- |
| Returns | Description |
| Array<\[[Uri](#Uri), [TextEdit](#TextEdit)\[\]\]> | A shallow copy of `[Uri, TextEdit[]]`\-tuples. |

get(uri: [Uri](#Uri)): [TextEdit](#TextEdit)\[\]

Get the text edits for a resource.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| Returns | Description |
| [TextEdit](#TextEdit)\[\] | An array of text edits. |

has(uri: [Uri](#Uri)): boolean

Check if a text edit for a resource exists.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| Returns | Description |
| boolean | `true` if the given resource will be touched by this edit. |

insert(uri: [Uri](#Uri), position: [Position](#Position), newText: string, metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)): void

Insert the given text at the given position.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| position: [Position](#Position) | A position. |
| newText: string | A string. |
| metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata) | Optional metadata for the entry. |
| Returns | Description |
| void |     |

renameFile(oldUri: [Uri](#Uri), newUri: [Uri](#Uri), options?: {ignoreIfExists: boolean, overwrite: boolean}, metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)): void

Rename a file or folder.

| Parameter | Description |
| --- | --- |
| oldUri: [Uri](#Uri) | The existing file. |
| newUri: [Uri](#Uri) | The new location. |
| options?: {ignoreIfExists: boolean, overwrite: boolean} | Defines if existing files should be overwritten or be ignored. When overwrite and ignoreIfExists are both set overwrite wins. |
| metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata) | Optional metadata for the entry. |
| Returns | Description |
| void |     |

replace(uri: [Uri](#Uri), range: [Range](#Range), newText: string, metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)): void

Replace the given range with given text for the given resource.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| range: [Range](#Range) | A range. |
| newText: string | A string. |
| metadata?: [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata) | Optional metadata for the entry. |
| Returns | Description |
| void |     |

set(uri: [Uri](#Uri), edits: ReadonlyArray<[TextEdit](#TextEdit) | [SnippetTextEdit](#SnippetTextEdit)\>): void

Set (and replace) text edits or snippet edits for a resource.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| edits: ReadonlyArray<[TextEdit](#TextEdit) \| [SnippetTextEdit](#SnippetTextEdit)\> | An array of edits. |
| Returns | Description |
| void |     |

set(uri: [Uri](#Uri), edits: ReadonlyArray<\[[TextEdit](#TextEdit) | [SnippetTextEdit](#SnippetTextEdit), [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)\]>): void

Set (and replace) text edits or snippet edits with metadata for a resource.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| edits: ReadonlyArray<\[[TextEdit](#TextEdit) \| [SnippetTextEdit](#SnippetTextEdit), [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)\]> | An array of edits. |
| Returns | Description |
| void |     |

set(uri: [Uri](#Uri), edits: readonly [NotebookEdit](#NotebookEdit)\[\]): void

Set (and replace) notebook edits for a resource.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| edits: readonly [NotebookEdit](#NotebookEdit)\[\] | An array of edits. |
| Returns | Description |
| void |     |

set(uri: [Uri](#Uri), edits: ReadonlyArray<\[[NotebookEdit](#NotebookEdit), [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)\]>): void

Set (and replace) notebook edits with metadata for a resource.

| Parameter | Description |
| --- | --- |
| uri: [Uri](#Uri) | A resource identifier. |
| edits: ReadonlyArray<\[[NotebookEdit](#NotebookEdit), [WorkspaceEditEntryMetadata](#WorkspaceEditEntryMetadata)\]> | An array of edits. |
| Returns | Description |
| void |     |

### WorkspaceEditEntryMetadata

Additional data for entries of a workspace edit. Supports to label entries and marks entries as needing confirmation by the user. The editor groups edits with equal labels into tree nodes, for instance all edits labelled with "Changes in Strings" would be a tree node.

#### Properties

description?: string

A human-readable string which is rendered less prominent on the same line.

iconPath?: [IconPath](#IconPath)

The icon path or [ThemeIcon](#ThemeIcon) for the edit.

label: string

A human-readable string which is rendered prominent.

needsConfirmation: boolean

A flag which indicates that user confirmation is needed.

### WorkspaceEditMetadata

Additional data about a workspace edit.

#### Properties

isRefactoring?: boolean

Signal to the editor that this edit is a refactoring.

### WorkspaceFolder

A workspace folder is one of potentially many roots opened by the editor. All workspace folders are equal which means there is no notion of an active or primary workspace folder.

#### Properties

index: number

The ordinal number of this workspace folder.

name: string

The name of this workspace folder. Defaults to the basename of its [uri-path](#Uri.path)

uri: [Uri](#Uri)

The associated uri for this workspace folder.

_Note:_ The [Uri](#Uri)\-type was intentionally chosen such that future releases of the editor can support workspace folders that are not stored on the local disk, e.g. `ftp://server/workspaces/foo`.

### WorkspaceFolderPickOptions

Options to configure the behavior of the [workspace folder](#WorkspaceFolder) pick UI.

#### Properties

ignoreFocusOut?: boolean

Set to `true` to keep the picker open when focus moves to another part of the editor or to another window. This setting is ignored on iPad and is always `false`.

placeHolder?: string

An optional string to show as placeholder in the input box to guide the user.

### WorkspaceFoldersChangeEvent

An event describing a change to the set of [workspace folders](#workspace.workspaceFolders).

#### Properties

added: readonly [WorkspaceFolder](#WorkspaceFolder)\[\]

Added workspace folders.

removed: readonly [WorkspaceFolder](#WorkspaceFolder)\[\]

Removed workspace folders.

### WorkspaceSymbolProvider<T>

The workspace symbol provider interface defines the contract between extensions and the [symbol search](https://code.visualstudio.com/docs/editor/editingevolved#_open-symbol-by-name)\-feature.

#### Methods

provideWorkspaceSymbols(query: string, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]>

Project-wide search for a symbol matching the given query string.

The `query`\-parameter should be interpreted in a _relaxed way_ as the editor will apply its own highlighting and scoring on the results. A good rule of thumb is to match case-insensitive and to simply check that the characters of _query_ appear in their order in a candidate symbol. Don't use prefix, substring, or similar strict matching.

To improve performance implementors can implement `resolveWorkspaceSymbol` and then provide symbols with partial [location](#SymbolInformation.location)\-objects, without a `range` defined. The editor will then call `resolveWorkspaceSymbol` for selected symbols only, e.g. when opening a workspace symbol.

| Parameter | Description |
| --- | --- |
| query: string | A query string, can be the empty string in which case all symbols should be returned. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\[\]> | An array of document highlights or a thenable that resolves to such. The lack of a result can be signaled by returning `undefined`, `null`, or an empty array. |

resolveWorkspaceSymbol(symbol: T, token: [CancellationToken](#CancellationToken)): [ProviderResult](#ProviderResult&lt;T&gt;)<T\>

Given a symbol fill in its [location](#SymbolInformation.location). This method is called whenever a symbol is selected in the UI. Providers can implement this method and return incomplete symbols from [provideWorkspaceSymbols](#WorkspaceSymbolProvider.provideWorkspaceSymbols) which often helps to improve performance.

| Parameter | Description |
| --- | --- |
| symbol: T | The symbol that is to be resolved. Guaranteed to be an instance of an object returned from an earlier call to `provideWorkspaceSymbols`. |
| token: [CancellationToken](#CancellationToken) | A cancellation token. |
| Returns | Description |
| [ProviderResult](#ProviderResult&lt;T&gt;)<T\> | The resolved symbol or a thenable that resolves to that. When no result is returned, the given `symbol` is used. |

## API Patterns

These are some of the common patterns we use in the VS Code API.

### Promises

The VS Code API represents asynchronous operations with [promises](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Promise). From extensions, **any** type of promise can be returned, like ES6, WinJS, A+, etc.

Being independent of a specific promise library is expressed in the API by the `Thenable`\-type. `Thenable` represents the common denominator which is the [then](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Promise/then) method.

In most cases the use of promises is optional and when VS Code calls into an extension, it can handle the _result type_ as well as a `Thenable` of the _result type_. When the use of a promise is optional, the API indicates this by returning `or`\-types.

```
provideNumber(): number | Thenable<number>
```

### Cancellation Tokens

Often operations are started on volatile state which changes before operations can finish. For instance, computing IntelliSense starts and the user continues to type making the result of that operation obsolete.

APIs that are exposed to such behavior will get passed a `CancellationToken` on which you can check for cancellation (`isCancellationRequested`) or get notified when cancellation occurs (`onCancellationRequested`). The cancellation token is usually the last parameter of a function call and optional.

### Disposables

The VS Code API uses the [dispose pattern](https://en.wikipedia.org/wiki/Dispose_pattern) for resources that are obtained from VS Code. This applies to event listening, commands, interacting with the UI, and various language contributions.

For instance, the `setStatusBarMessage(value: string)` function returns a `Disposable` which upon calling `dispose` removes the message again.

### Events

Events in the VS Code API are exposed as functions which you call with a listener-function to subscribe. Calls to subscribe return a `Disposable` which removes the event listener upon dispose.

```
var listener = function(event) {
  console.log('It happened', event);
};

// start listening
var subscription = fsWatcher.onDidDelete(listener);

// do more stuff

subscription.dispose(); // stop listening
```

Names of events follow the `on[Will|Did]VerbNoun?` pattern. The name signals if the event is going to happen _(onWill)_ or already happened _(onDid)_, what happened _(verb)_, and the context _(noun)_ unless obvious from the context.

An example from the VS Code API is `window.onDidChangeActiveTextEditor` which is an event fired when the active text editor _(noun)_ has been (_onDid_) changed (_verb_).

### Strict null

The VS Code API uses the `undefined` and `null` TypeScript types where appropriate to support [strict null checking](https://github.com/microsoft/TypeScript/pull/7140).
