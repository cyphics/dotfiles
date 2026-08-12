require("full-border"):setup()

-- ~/.config/yazi/init.lua
local MONTHS = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }

function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	else
		local t = os.date("*t", time)
		local month = MONTHS[t.month]
		if t.year == os.date("*t").year then
			time = string.format("%s %02d %02d:%02d", month, t.day, t.hour, t.min)
		else
			time = string.format("%s %02d  %d", month, t.day, t.year)
		end
	end
	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end
