// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
	config: {
		// choose either `'stable'` for receiving highly polished,
		// or `'canary'` for less polished but more frequent updates
		updateChannel: "canary",

		// default font size in pixels for all tabs
		fontSize: 22,

		// font family with optional fallbacks
		// fontFamily: '"VictorMono Nerd Font Mono"',
		// fontFamily: '"BlexMono Nerd Font Mono"',
		// fontFamily: '"NotoMono Nerd Font Mono"',
		// fontFamily: '"Iosevka Nerd Font Mono"',
		// fontFamily: '"JetBrainsMono Nerd Font Mono"',
		// fontFamily: '"ProFontWindows Nerd Font Mono"',
		// fontFamily: '"ShureTechMono Nerd Font Mono"',
		// fontFamily: '"SFMono Nerd Font"',
		// fontFamily: '"OperatorMono Nerd Font"',
		// fontFamily: '"SpaceMono Nerd Font Mono"',
		// fontFamily: '"CamingoCode Nerd Font"',
		fontFamily: '"CartographCF Nerd Font"',

		// default font weight: 'normal' or 'bold'
		fontWeight: "normal",

		// font weight for bold characters: 'normal' or 'bold'
		fontWeightBold: "bold",

		// line height as a relative unit
		lineHeight: 1,

		// letter spacing as a relative unit
		letterSpacing: 0,

		// terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
		// cursorColor: "rgba(248,28,229,0.8)",
		// cursorColor: "#384545",
		cursorColor: "#404040",

		// terminal text color under BLOCK cursor
		// cursorAccentColor: "#00FF00",
		cursorAccentColor: "#FAFAFA",

		// `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
		cursorShape: "BLOCK",

		// set to `true` (without backticks and without quotes) for blinking cursor
		cursorBlink: false,

		// color of the text
		// foregroundColor: "#436644",
		foregroundColor: "#404040",

		// terminal background color
		// opacity is only supported on macOS
		// backgroundColor: "#091013",
		// backgroundColor: "#0E0E0E",
		backgroundColor: "#101010",

		// terminal selection color
		// selectionColor: "rgba(248,28,229,0.3)",
		// selectionColor: "#00FF87",
		selectionColor: "#E6E6E6",

		// border color (window, tabs)
		// borderColor: "#091013",
		borderColor: "#0E0E0E",

		// custom CSS to embed in the main window
		css: "",

		// custom CSS to embed in the terminal window
		termCSS: "",

		// if you're using a Linux setup which show native menus, set to false
		// default: `true` on Linux, `true` on Windows, ignored on macOS
		showHamburgerMenu: "",

		// set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
		// additionally, set to `'left'` if you want them on the left, like in Ubuntu
		// default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
		showWindowControls: "",

		// custom padding (CSS format, i.e.: `top right bottom left`)
		padding: "0px 0px",

		// the full list. if you're going to provide the full color palette,
		// including the 6 x 6 color cubes and the grayscale map, just provide
		// an array here instead of a color map object
// 		colors: {
// 			black: "#091013",
// 			red: "#23755a",
// 			// green: "#82D967",
// 			green: "#81B32C",
// 			yellow: "#FFD700",
// 			blue: "#3f5242",
// 			magenta: "#409931",
// 			cyan: "#50b45a",
// 			white: "#507350",
// 			lightBlack: "#333333",
// 			lightRed: "#afc079",
// 			// lightGreen: "#90D762",
// 			lightGreen: "#81B32C",
// 			lightYellow: "#FAFF00",
// 			lightBlue: "#4f7e7e",
// 			lightMagenta: "#11FF25",
// 			// lightCyan: "#C1FF8A",
// 			// lightCyan: "#90D762",
// 			lightCyan: "#81B32C",
// 			lightWhite: "#678c61",
// 		},

		colors: {
			black: "#0E0E0E",
			red: "#575757",
			// green: "#737373",
			green: "#81B32C",
			// yellow: "#90D762",
			// yellow: "#81B32C",
			yellow: "#B39700",
			blue: "#848484",
			magenta: "#412A4D",
			cyan: "#7F847F",
			white: "#7D7D7D",
			lightBlack: "#333333",
			lightRed: "#666666",
			// lightGreen: "#CACACA",
			lightGreen: "#81B32C",
			// lightYellow: "#ADFFA7",
			// lightYellow: "#90D762",
			lightYellow: "#B39700",
			lightBlue: "#929492",
			lightMagenta: "#644A7F",
			lightCyan: "#9F9F9F",
			lightWhite: "#E6E6E6",
		},

		// the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
		// if left empty, your system's login shell will be used by default
		//
		// Windows
		// - Make sure to use a full path if the binary name doesn't work
		// - Remove `--login` in shellArgs
		//
		// Bash on Windows
		// - Example: `C:\\Windows\\System32\\bash.exe`
		//
		// PowerShell on Windows
		// - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
		shell: "/bin/zsh",

		// for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
		// by default `['--login']` will be used
		shellArgs: ["--login"],

		// for environment variables
		env: {},

		// set to `false` for no bell
		bell: false,

		// if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
		copyOnSelect: true,

		// if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
		defaultSSHApp: true,

		// if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
		// selection is present (`true` by default on Windows and disables the context menu feature)
		quickEdit: true,

		// choose either `'vertical'`, if you want the column mode when Option key is hold during selection (Default)
		// or `'force'`, if you want to force selection regardless of whether the terminal is in mouse events mode
		// (inside tmux or vim with mouse mode enabled for example).
		macOptionSelectionMode: "vertical",

		// URL to custom bell
		// bellSoundURL: 'http://example.com/bell.mp3',

		// Whether to use the WebGL renderer. Set it to false to use canvas-based
		// rendering (slower, but supports transparent backgrounds)
		webGLRenderer: true,

		// for advanced config flags please refer to https://hyper.is/#cfg
		hyperStatusLine: {
			dirtyColor: "salmon",
			aheadColor: "ivory",
			// editor: 'vscode',
		},
		//
		// hyperline: {
		//     plugins: [
		//     "hostname",
		//     "ip",
		//     "cpu",
		//     "memory",
		//     "battery",
		//     "network",
		//     ]
		// },
	},

	// a list of plugins to fetch and install from npm
	// format: [@org/]project[#version]
	// examples:
	//   `hyperpower`
	//   `@company/project`
	//   `project#1.0.1`
	plugins: [
		// installed via npm
		// "hyper-history",
		// "hyperline",
		//
		// "hyperpower",
		// "hyperterm-visor",
		// "hypercwd",
		// "hyperterm-paste",
		// "hyperlinks",
		// "hyper-search",
		// "hypergoogle",
		// "hyper-init",
		// "hyper-dark-scrollbar",
		// "hyper-hide-title",
		// "hyper-tabs-enhanced",
		// "hyperminimal",
		// "hyper-save-windowstate",
		// "hyper-autohide-tabs",
		// "hypersixteen",
		// "hyper-darkmatter",
		// "hyperterm-material-spacegray",
		// "hyper-loved",
		// "hyper-dracula",
		// "hyperterm-material-theme",
		// "hyper-dark-dracula",
		// "hyper-pane",
		// "hyper-fading-scrollbar",
		// "hypergravity",
		// "hyper-savetext",
		// "@j-f/hyper-statusline",
		// "hyper-one-dark",
		// "hyperterm-snazzy",
		// "hyperterm-material-dark",
		// "hyper-hybrid-reduced-contrast",
		// "hyper-keymap",
	],

	// in development, you can create a directory under
	// `~/.hyper_plugins/local/` and include it here
	// to load it and avoid it being `npm install`ed
	localPlugins: [],

	keymaps: {
		// https://github.com/vercel/hyper/blob/master/app/keymaps/darwin.json
		//
		"editor:clearBuffer": "alt+z",
		"pane:next": "alt+j",
		"pane:prev": "alt+k",
		"tab:new": ["alt+t"],
		"tab:next": ["alt+esc", "alt+]"],
		"tab:prev": ["alt+shift+tab", "alt+["],
		"window:close": ["alt+q"],
		"window:new": ["alt+n"],
		"pane:close": ["alt+w"],
		"pane:splitRight": ["alt+d", "alt+enter"],
		"copy": ["alt+c"],
		"paste": ["alt+v"],
	},
};
