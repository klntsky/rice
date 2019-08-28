let prelude = ./prelude/package.dhall

let types = ./types/package.dhall

let utils = ./utils/package.dhall

let AbsolutePosition = types.AbsolutePosition

let Bar = types.Bar

let Carrier = types.Carrier

let Color = types.Color

let Configuration = types.Configuration

let Image = types.Image

let Plugin = types.Plugin

let Settings = types.Settings

let Shell = types.Shell

let defaults = utils.defaults

let brightColor = "#fed7ae"

let darkColor = "#202020"

let memory
	: Bar
	=   λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → let text : Text → Bar = cr.text

		let join : List Bar → Bar = cr.join

		let fg : Color → Bar → Bar = cr.fg

		let bg : Color → Bar → Bar = cr.bg

		let i : Image → Bar = cr.i

		let pa : AbsolutePosition → Bar → Bar = cr.pa

		let bash : Natural → Shell → Bar = utils.mkBash Bar cr

		let space = text "   "

		let memoryUsage
			: Bar
			= bash 5000 "./scripts/roman.sh `./scripts/memory-usage.sh`"

		let cpuUsage
			: Bar
			= bash 5000 "./scripts/roman.sh `./scripts/cpu-usage.sh`"

		in     ( fg
				brightColor
				( bg
				  darkColor
				  ( join
					[ pa { x = +436, y = +0 } (i "xbm/centered.xbm")
					, pa
					  { x = +786, y = +4 }
					  (join [ text "MEM", space, memoryUsage ])
					, pa { x = +956, y = +4 } (text "·")
					, pa
					  { x = +1030, y = +4 }
					  (join [ text "ΣΠΥ", space, cpuUsage ])
					, pa { x = +1260, y = +0 } (i "xbm/centered.xbm")
					]
				  )
				)
			  )
			: Bar

in    utils.mkConfigs
	  [ { bar =
			memory
		, settings =
			  defaults.settings
			⫽ { extraArgs =
				  [ "-xs"
				  , "0"
				  , "-bg"
				  , darkColor
				  , "-geometry"
				  , "1920x31+0+0"
				  , "-ta"
				  , "l"
				  ]
			  , font =
				  Some "Times"
			  }
		}
	  ]
	: List Configuration
