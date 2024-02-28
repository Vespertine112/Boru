local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local helpers = require("helpers")

local function autostart_apps()
	--- Compositor [Compfy] 
	helpers.run.check_if_running("compfy", nil, function()
		awful.spawn("compfy -b --config /home/vespertine/.config/compfy/compfy.conf" , false)
	end)
	--- Music Server
	helpers.run.run_once_pgrep("mpd")
	helpers.run.run_once_pgrep("mpDris2")
	--- Polkit Agent
	helpers.run.run_once_ps(
		"polkit-gnome-authentication-agent-1",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
	)
	--- Other stuff
	helpers.run.run_once_grep("blueman-applet")
	helpers.run.run_once_grep("nm-applet")

	-- Set the refreshrate
	awful.spawn.with_shell("xrandr --output DP-2 --mode 2560x1440 -r 143.91")
	awful.spawn.with_shell("xrandr --output DP-4 --mode 2560x1440 -r 143.91")	
end

autostart_apps()
