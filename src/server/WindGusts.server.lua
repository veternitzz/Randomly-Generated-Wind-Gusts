-- NOTE: PrintAllValues() does NOT print wind gust speed (yett).

--[[
!metadata

Author: alex_black20101 (veternitzz)
Version: 1.5.1
Description: Modified version of the gust script provided in "Breeze into wind"
Filename: WindGusts.server.lua

-- this relies on total randomness

]]

--[[
!changelog - version: 1.5.1

changed: better randomization. all randomize functions now produce a randomseed first

added: RandomizeGustCycleDelay()
added: RandomizeGustCycleDuration()
added: PrintAllValues() -- (to tidy up and make it easier to see in the console/output) 

]]

local gustCycleDelay = 5 -- Max duration between gust cycles in seconds
local gustCycleDuration = 5 -- Duration of each gust cycle in seconds

-- During each gust cycle, a portion of "gust" will be added to "baseWind" in a ramped fashion
local baseWind = Vector3.new(-3,0,-3) -- Vector3 representing base wind speed and direction
local gust = Vector3.new(math.random(1, 10),math.random(1, 10),math.random(1, 10)) -- Vector3 representing gust speed and direction
local gustIntervals = 100 -- Number of iterations used to calculate each gust interval
local dg = gustCycleDuration/gustIntervals
local dgf = dg/gustCycleDuration

local function RandomizeGustSpeed()
	local ranseed = math.random(1, 1000000000)
	local seed = math.randomseed(ranseed)

	local x = math.random(1, 10)
	local y = math.random(1, 10)
	local z = math.random(1, 10)

	gust = Vector3.new(x, y, z)
	print("Randomized gust speed..")
end

local function RandomizeGustIntervals()
	local ranseed = math.random(1, 1000000000)
	local seed = math.randomseed(ranseed)

	local ran = math.random(1, 100) -- get random intervals, make it ran

	-- update variables
	local gustIntervals = ran
	local dg = gustCycleDuration/gustIntervals
	local dgf = dg/gustCycleDuration
	print("Randomized gust intervals..")
end

local function RandomizeGustCycleDuration()
	local ranseed = math.random(1, 1000000000)
	local seed = math.randomseed(ranseed)

	local ran = math.random(1, 5)
	gustCycleDuration = ran

	print("Randomized Gust Cycle Duration.")
end

local function RandomizeGustCycleDelay()
	local ranseed = math.random(1, 1000000000)
	local seed = math.randomseed(ranseed)

	local ran = math.random(1, 5)
	gustCycleDelay = ran

	print("Randomized Gust Cycle Delay.")
end

local function PrintAllValues()
	print("Next gust cycle delay: "..gustCycleDelay .." Next gust cycle duration: "..gustCycleDuration.." Next number of intervals: "..gustIntervals)
end

local function RunAllFunctions() 
	RandomizeGustCycleDuration()
	RandomizeGustCycleDelay()
	RandomizeGustSpeed()
	RandomizeGustIntervals()
	PrintAllValues()
end

workspace.GlobalWind = baseWind -- Set globalWind to baseWind initially
wait(gustCycleDelay) -- Wait delay amount before starting gusts

while true do
	for i=1,gustIntervals do
		local f = math.sin(math.pi * dgf * i) -- Use sin function to ramp gust
		workspace.GlobalWind = baseWind + f*gust -- Set GlobalWind to baseWind + gust
		print("Gust detected by script.")
		wait(dg)
	end

	workspace.GlobalWind = baseWind -- Reset wind to base wind at end of gust cycle
	wait(math.random()*gustCycleDelay) -- Wait a random fraction of delay before next gust cycle

	RunAllFunctions()
	print("Waiting for next gust..")
end