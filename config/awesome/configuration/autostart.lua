local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local helpers = require("helpers")

local function autostart_apps()
	--- Compositor
	helpers.run.check_if_running("picom", nil, function()
		awful.spawn("picom --config /home/vespertine/.config/picom/picom.conf" , false)
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
	-- awful.spawn.with_shell("xrandr --output DP-2 --mode 2560x1440 --rate 144")
	-- awful.spawn.with_shell("xrandr --output DP-4 --mode 2560x1440 --rate 144")
	
end

autostart_apps()
