--[[
Version: 2.1 (Fixed)

C++ Version coming soon (:

!!!	THIS SCRIPT DOES NOT SUPPORT SKIDSPLOITS (Krnl, JJsploit, etc)	!!!
	
1, PUT THIS SCRIPT INTO YOUR AUTOEXEC FOLDER ( This script should log all metamethods. )
2. THIS SCRIPT DUMPS CONSTANTS/UPVALUES AND CALLED METAMETHODS!!!!!
3. Logical operators (if, elseif, else, variable == variable, etc.) cannot be displayed cuz ITS IMPOSSIBLE 
3.1 This script can break your game
3.2 This script can slow down your game. I am working on anti Functions/Metamethods spammer
3,3 This script has been tested on Synapse X, so it may not work with other exploits (keep this in mind!)
3.4 This is the first version of this script, more features coming soon!
3.5 If you dont know how to use this script, then don’t use it.
3,6 For heavens sake, dont try to edit this script, this script was written by a schizophrenic, so the code might hurt your eyes!
3.7 Dont DM me 
3.8 If youre a cute femboy DM me
3.9 I dont know what I should write here, so look at this kaomoji: (⊙﹏⊙)
4. This decompiler decompiles non-decompiled scripts that were compiled by a compiler, but you can decompile this compiled non-decompiled script with my decompiler which decompiles non-decompiled scripts that were compiled by a compiler
5. Credits:
	Lego hacker
	Lego hacker
	and Lego hacker!

]]

--*Settings*--
local NameCallAntiSpam = true
local NewIndexAntiSpam = true
local IndexAntiSpam    = true
local RenvAntiSpam     = false

local NewIndex 		= true
local Index 		= true
local Namecall 		= true
local Renv 		= true

local Functions		= false

local upvalues 		= true
local constants 	= true
--I love protos, DO NOT TOUCH PROTOS >_< (≧▽≦)
local protos 		= true

--*Anti memory check*--
coroutine.resume(coroutine.create(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Legohacker1337/AntiCheat-bypasses/main/Anti-Anti%20dex%20explorer.lua", true))()
end))

--*Clones renv functions to use it in renv hooks*--
local oldRenv = {}
for i,v in pairs(getrenv())  do
	if typeof(v) == "function" then
		oldRenv[i] = clonefunction(v)
	elseif typeof(v) == "table" then
		oldRenv[i] = {}
		for i2,v2 in pairs(v) do
			if typeof(v2) == "function" then
				oldRenv[i][i2] = clonefunction(v2)
			end
		end
	else
		oldRenv[i] = v
	end
end

--Can be called inside __namecall, __newindex, __index and getrenv() or getgenv() hooks :sunglasses: ( I am 4 parallel universes ahead of you, e621 🤓🤓🤓 )
--(Yes, I know I can clone metamethods, shut up please )
local _GetFullName = clonefunction(game.GetFullName)
local _IsDescendantOf = clonefunction(game.IsDescendantOf)
local _GetService = clonefunction(game.GetService)
local _FindFirstChild = clonefunction(game.FindFirstChild)

local tostring = oldRenv.tostring
local pairs = oldRenv.pairs
local split = oldRenv.string.split
local insert = oldRenv.table.insert
local typeof = oldRenv.typeof
local find = oldRenv.table.find
local lower = oldRenv.string.lower
local select = oldRenv.select
local unpack = oldRenv.table.unpack
local print = oldRenv.print
local format = oldRenv.string.format
local rep = oldRenv.string.rep
local info = oldRenv.debug.info
local getinfo = clonefunction(debug.getinfo)
local taskwait = oldRenv.task.wait
local getfenv = oldRenv.getfenv

--*Better (Shitter) GetFullName*--
_NewGetFullName = function(...) 
	local args = {...}
	if args[1] then
		if args[1] ~= game and not _IsDescendantOf(args[1], game) then
			return "nil.".._GetFullName(...)    
		end     
		args[1] = _GetFullName(args[1])
		local split = split(args[1],".")
		if tostring(lower(split[1])) ~= "game" then
			return "game."..args[1]		
		end

	end
	return _GetFullName(...)
end

local function ConvertToString(Value)
	if typeof(Value) == "Instance" then
		return Value:GetFullName()
	elseif typeof(Value) == "string" then
		return '[=['..tostring(Value)..']=]'
	elseif typeof(Value) == "CFrame" then
		return "CFrame.new("..tostring(Value)..")"
	elseif typeof(Value) == "Vector3"  then
		return "Vector3.new("..tostring(Value)..")"
	elseif typeof(Value) == "Vector2"  then
		return "Vector2.new("..tostring(Value)..")"
	else
		return tostring(Value)
	end
end

local old = {}
local RecurseTable;
local RecurseFunction;

RecurseFunction = function(Function,Index)
	local str = format("%s( Name: %s Line: %s Path: %s):\n%s{", tostring(Function), tostring(getinfo(Function).name), tostring(info(Function, "l")), _GetFullName(getfenv(Function).script), string.rep("    ", Index - 1) )
	if constants then
		str = format("%s\n%sConstants: {", str, rep("    ", Index))
		for i, v in pairs(debug.getconstants(Function))	 do
			if typeof(v) == "table" then
				if not find(old, v) then
					insert(old, v)
					taskwait()
					str = format("%s\n%s%s", str, rep("    ", Index + 1), RecurseTable(v, Index + 2))
				end
			elseif typeof(v) == "function" then
				if not find(old, v) then
					insert(old, v)
					taskwait()
					str = format("%s\n%s%s", str, rep("    ", Index + 1), RecurseFunction(v, Index + 2))
				end
			else
				str = format("%s\n%s[%s] = %s", str, rep("    ", Index + 1), ConvertToString(i), ConvertToString(v))
			end

		end
		str = format("%s\n%s}", str, rep("    ", Index))
	end
	if upvalues then
		str = format("%s\n%sUpvalues: {", str, rep("    ", Index))
		for i,v in pairs(debug.getupvalues(Function)) do
			if typeof(v) == "table" then
				if not find(old, v) then
					insert(old, v)
					taskwait()
					str = format("%s\n%s%s", str, rep("    ", Index), RecurseTable(v, Index + 2))
				end
			elseif typeof(v) == "function" then
				if not find(old, v) then
					insert(old, v)
					taskwait()
					str = format("%s\n%s%s", str, rep("    ", Index+1), RecurseFunction(v, Index + 2))
				end
			else
				str = format("%s\n%s[%s] = %s", str, rep("    ", Index + 1), ConvertToString(i), ConvertToString(v))
			end
		end
		str = format("%s\n%s}", str, rep("    ", Index))
	end
	if protos then
		str = format("%s\n%sProtos: {", str, rep("    ", Index))
		for i,v in pairs(debug.getprotos(Function)) do
			if typeof(v) == "function" then
				if not find(old, v) then
					insert(old, v)
					taskwait()
					str = format("%s\n%s%s", str, rep("    ", Index + 1), RecurseFunction(v, Index + 2))
				end
			else
				str = format("%s\n%s[%s] = %s", str, rep("    ", Index + 1), ConvertToString(i), ConvertToString(v))
			end
		end
		str = format("%s\n%s}", str, rep("    ", Index))
	end
	str = format("%s\n%s}", str, rep("    ", Index-1))
	return str
end

RecurseTable = function(Table, Index, AllowFunctions, DisplayName)
	if AllowFunctions == nil  then
		AllowFunctions = true
	end
	if DisplayName == nil then
		DisplayName = true
	end

	local str = format("    %s%s\n%s{", ( DisplayName and tostring(Table)) or "",  ( DisplayName and ":") or "" ,rep("    ", Index-1))
	for i,v in pairs(Table) do
		if typeof(v) == "table" then
			if not find(old, v) then
				insert(old, v)
				str = format("%s\n%s[ %s ] = %s", str, rep("    ", Index), ConvertToString(i) , RecurseTable(v, Index + 1, AllowFunctions, DisplayName))
			end
		elseif typeof(v) == "function" and AllowFunctions then
			if not find(old, v) and Functions then
				insert(old, v)
				str = format("%s\n%s[ %s ] = %s", str, rep("    ", Index), ConvertToString(i) ,RecurseFunction(v, Index + 1))
			end
		else
			str = format("%s\n%s[ %s ] = %s", str, rep("    ", Index + 1), ConvertToString(i), ConvertToString(v))
		end
	end
	str = str.."\n"..rep("    ", Index-1).."}"
	return str
end

local scripts = {}

local function Decompile(Script)
	local Str = "--Decompiled with the Lego hacker's pseudo Luau decompiler.\n\n"
	if Functions then
		for i,v in pairs(getgc()) do
			if getfenv(v).script == Script then
				pcall(function()
					Str = Str..RecurseFunction(v, 1).."\n"
				end)	
			end
		end

		Str = Str.."\n"..RecurseFunction(getscriptclosure(Script),1)
	end

	if scripts[Script] then
		if Index then
			Str = Str.."\n--__index:"
			for i,v in pairs(scripts[Script]["index"]) do
				Str = Str.."\n"..v
			end
		end
		if NewIndex then
			Str = Str.."\n--__newindex:"
			for i,v in pairs(scripts[Script]["newindex"]) do
				Str = Str.."\n"..v
			end
		end
		if Namecall then
			Str = Str.."\n--__namecall:"
			for i,v in pairs(scripts[Script]["namecall"]) do
				Str = Str.."\n"..v
			end
		end
		if Renv then
			Str = Str.."\n--variables:"
			for i,v in pairs(scripts[Script]["variables"]) do
				Str = Str..string.format("\nlocal Variable%s = %s", tostring(i), tostring(v))
			end

			Str = Str.."\n--renv:"
			for i,v in pairs(scripts[Script]["renv"]) do
				Str = Str.."\n"..v
			end
		end
	end

	return Str
end

getgenv().decompile = Decompile

local function CheckTable(Scr,...)
	if not scripts[Scr] then
		oldRenv.rawset(scripts, Scr, {})
		oldRenv.rawset(oldRenv.rawget(scripts, Scr), "index", {})
		oldRenv.rawset(oldRenv.rawget(scripts, Scr), "newindex", {})
		oldRenv.rawset(oldRenv.rawget(scripts, Scr), "namecall", {})
		oldRenv.rawset(oldRenv.rawget(scripts, Scr), "renv", {})
		oldRenv.rawset(oldRenv.rawget(scripts, Scr), "variables", {})
	end
end

if Index then
	local old1; old1 = hookmetamethod(game, "__index", function(self,index,...)
		if not checkcaller() then
			CheckTable(getcallingscript())
			if (not IndexAntiSpam) or (IndexAntiSpam and not table.find(scripts[getcallingscript()]["index"], string.format("%s.%s", _NewGetFullName(self), tostring(index)))) then
				table.insert(scripts[getcallingscript()]["index"], string.format("%s.%s", _NewGetFullName(self), tostring(index)))	
			end
		end

		return old1(self, index, ...)
	end)
end

if NewIndex then
	local old2; old2 = hookmetamethod(game, "__newindex", function(self, index, value)
		if not checkcaller() then
			CheckTable(getcallingscript())
			if (not NewIndexAntiSpam ) or (NewIndexAntiSpam and not table.find(scripts[getcallingscript()]["newindex"], string.format("%s.%s = %s", _NewGetFullName(self), tostring(index), ConvertToString(value)))) then
				table.insert(scripts[getcallingscript()]["newindex"], string.format("%s.%s = %s", _NewGetFullName(self), tostring(index), ConvertToString(value)))	
			end
		end
		return old2(self, index, value)
	end)
end

if Namecall then
	local old3; old3 = hookmetamethod(game, "__namecall", function(self,...)
		if not checkcaller() then
			CheckTable(getcallingscript())

			local args = {...}
			local str = ""
			for i,v in pairs(args) do
				if typeof(v) == "Instance" then
					v = _NewGetFullName(v) 
				elseif typeof(v) == "string" then
					v = '"'..v..'"'
				elseif typeof(v) == "function" then
					v = '"'..tostring(v)..'"'
				end	
				str = str..tostring(v)..((i ~= #{...} and ", ") or (""))
			end
			if (not NameCallAntiSpam) or (NameCallAntiSpam and not table.find(scripts[getcallingscript()]["namecall"],  string.format("%s:%s(%s)",  _NewGetFullName(self), getnamecallmethod(), str))) then
				table.insert(scripts[getcallingscript()]["namecall"], string.format("%s:%s(%s)",  _NewGetFullName(self), getnamecallmethod(), str))	
			end
		end

		return old3(self,...)
	end)
end

if Renv then
	for i,v in pairs(getrenv()) do
		if oldRenv.typeof(v) == "function" and i ~= "pcall" and i ~= "ypcall" then
			local old; old = hookfunction(v, function(...)
				if not checkcaller() and getcallingscript() and getcallingscript() ~= "" then

					CheckTable(getcallingscript())

					local args = {...}
					local str = ""
					for i,v in pairs(args) do
						if typeof(v) == "Instance" then
							v = _NewGetFullName(v)
						elseif typeof(v) == "string" then
							v = "[=["..v.."]=]"
						elseif typeof(v) == "function" then
							v = '"'..tostring(v)..'"'
						elseif typeof(v) == "table" then
							v = RecurseTable(v, 1, false, false)
						end

						local e = find(scripts[getcallingscript()]["variables"],tostring(v)) 
						if not e then
							e = #scripts[getcallingscript()]["variables"] + 1
							insert(scripts[getcallingscript()]["variables"], tostring(v))	
						end

						str = str.."Variable"..tostring(e)..((i ~= #{...} and ", ") or (""))

					end

					if (not RenvAntiSpam) or (RenvAntiSpam and not find(scripts[getcallingscript()]["renv"] , format("%s(%s)",  tostring(i), str)) ) then
						insert(scripts[getcallingscript()]["renv"], format("%s(%s)",  tostring(i), str))	
					end
				end

				return old(...)
			end)
		end
	end
end
