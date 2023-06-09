local Hooks = script.Parent.Hooks

local useTween = require(Hooks.useTween)
local useSpring = require(Hooks.useSpring)

export type SpringProps = {
	start: number,
	goal: number,
	speed: number,
	damper: number,
}

export type TweenProps = {
	start: number,
	goal: number,
	tweenInfo: TweenInfo,
}

local function Animation(name: string, timeStep: number?, props: SpringProps | TweenProps)
	local update
	local value

	local play, playReverse, stop

	if name == "Tween" then
		assert(props.start, "Tween requires a start value")
		assert(props.goal, "Tween requires a goal value")
		assert(props.tweenInfo, "Tween requires a tweenInfo")

		value, update, stop = useTween(props.start, props.tweenInfo)
		play = function()
			update({
				start = props.start,
				goal = props.goal,
			})
		end

		playReverse = function()
			update({
				start = props.goal,
				goal = props.start,
			})
		end
	elseif name == "Spring" then
		assert(props.start, "Spring requires a start value")
		assert(props.goal, "Spring requires a goal value")

		value, update, stop = useSpring(props.start, props.speed, props.damper)
		play = function()
			update({
				value = props.start,
				goal = props.goal,
				force = props.force,
			})
		end

		playReverse = function()
			update({
				value = props.goal,
				goal = props.start,
				force = props.force,
			})
		end
	else
		assert(false, name .. " is not a valid animation type")
	end

	return {
		timeStep = timeStep,
		start = props.start,
		value = value,
		playReverse = playReverse,
		play = play,
		stop = stop,
	}
end

return Animation
