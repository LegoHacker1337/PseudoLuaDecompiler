local function check()
	local a,b = pcall(function()
		clonefunction(print)
		for i,v in pairs(getrenv()) do

		end
		for i,v in pairs(getgc(true)) do

		end
		getcallingscript()
		checkcaller()
		getscriptclosure(game:FindFirstChildWhichIsA("LocalScript", true))
		local func = function()

		end
		debug.getprotos(func)
		debug.getupvalues(func)
		debug.getconstants(func)

		local old = clonefunction(getrawmetatable(game).__namecall)
		local old1; old1 = hookmetamethod(game, "__namecall", function(...)
			if getnamecallmethod() == "ThisFunctionDoesNotExist" then
				return true
			end
			return old1(...)
		end)
		
		hookfunction(game.Players.LocalPlayer.Kick, function() return true end)
		
		assert(game:ThisFunctionDoesNotExist("OwO") == true and game.Players.LocalPlayer.Kick() == true, "gamer?")
		
	end)
	if not a then
		( rconsoleprint or print or warn or game.Shutdown or function() while true do end end )("Your exploit does not supports PseudoLuauDecompiler! "..b.."\n")
	end
end
check()
