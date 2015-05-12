local pairsBench = {}
-- Example for this question: http://forums.coronalabs.com/topic/48914-how-to-deal-with-arrays-of-a-lot-of-spawned-objects/#entry253053
-- and for Bud's private question.

function pairsBench.run( group )
	local bench = ssk.easyBench
	local round = bench.round
	local mRand = math.random

	local function rcolor()
		return mRand(20,255)/255
	end

	-- Create a list 10,000 randomly chosen display objects
	local myObjects = {}
	for i = 1, 10000 do
		local x = mRand( left+20, right-20)
		local y = mRand( top+20, bottom-20)
		local type = mRand(1,2)
		if(type == 1) then
			tmp = display.newCircle( group, x, y, 20)
		else
			tmp = display.newRect( group, x, y, 40, 40 )
		end

		-- Store references using object indexes
		myObjects[tmp] = tmp
	end


	local function pairsIteration_noWork()
		for k,v in pairs(myObjects) do
			-- Do some work here on 'v'
		end
	end


	local function pairsIteration_withWork()
		for k,v in pairs(myObjects) do
			v:setFillColor(rcolor(),rcolor(),rcolor())
		end
	end

	-- Run each test 10 times to get a good measurement
	--
	local t1 = bench.measureTime(pairsIteration_noWork,10)
	local t2 = bench.measureTime(pairsIteration_withWork,10)

	-- Now let's remove 500 objects from the table and re-run the last test
	local count = 1
	for k,v in pairs( myObjects ) do
		if(k) then
			display.remove(v)
			myObjects[k] = nil
		end
		if( count >= 500 ) then break end
		count = count + 1
	end

	local t3 = bench.measureTime(pairsIteration_withWork,10)

	local results = {}
	results[1] = "'pairs() iteration + No Work         x 10 iterations: " .. t1 .. " ms "
	results[2] = "'pairs() iteration + Work            x 10 iterations: " .. t2 .. " ms "
	results[3] = "'pairs() iteration + Work + Sparse   x 10 iterations: " .. t3 .. " ms "

	return results
end


return pairsBench