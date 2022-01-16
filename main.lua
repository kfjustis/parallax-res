local push = require("lib/push/push")

local front1 = love.graphics.newImage("assets/bg/parallax_bg1.png")
local front2 = love.graphics.newImage("assets/bg/parallax_bg1.png")

local mid1 = love.graphics.newImage("assets/bg/parallax_bg2.png")
local mid2 = love.graphics.newImage("assets/bg/parallax_bg2.png")

local back1 = love.graphics.newImage("assets/bg/parallax_bg3.png")
local back2 = love.graphics.newImage("assets/bg/parallax_bg3.png")

local front_speed = 500
local middle_speed = 250
local back_speed = 100

local front1_pos = 0
local front2_pos = 800
local mid1_pos = 0
local mid2_pos = 800
local back1_pos = 0
local back2_pos = 800

function love.load()
   love.graphics.setDefaultFilter("nearest", "nearest", 1.0)

   local game_w, game_h = 400, 300
   --local temp_w, temp_h = love.window.getDesktopDimensions()
   --local window_w = temp_w * 0.8
   --local window_h = temp_h * 0.8
   local window_w = 800
   local window_h = 600

   push:setupScreen(game_w, game_h, window_w, window_h,
      {
         fullscreen = false,
         resizable = true,
         highdpi = true
      })
end

function love.update(dt)
   local speed1 = math.ceil(front_speed * dt)
   local speed2 = math.ceil(middle_speed * dt)
   local speed3 = math.ceil(back_speed * dt)



   front1_pos = updatePos(front1_pos, speed1, -400, 400)
   front2_pos = updatePos(front2_pos, speed1, 0, 800)
   mid1_pos = updatePos(mid1_pos, speed2, -400, 400)
   mid2_pos = updatePos(mid2_pos, speed2, 0, 800)
   back1_pos = updatePos(back1_pos, speed3, -400, 400)
   back2_pos = updatePos(back2_pos, speed3, 0, 800)
end

function updatePos(pos, speed, threshold, start)
   -- use game coordinates, not window
   pos = pos - speed
   if pos <= threshold then
      pos = start
   end
   return pos
end

function love.draw()
   push:start()
   love.graphics.clear()
   love.graphics.draw(back1, back1_pos, 0, 0, 1, 1)
   love.graphics.draw(back2, back2_pos, 0, 0, -1, 1)
   love.graphics.draw(mid1, mid1_pos, 0, 0, 1, 1)
   love.graphics.draw(mid2, mid2_pos, 0, 0, -1, 1)
   love.graphics.draw(front1, front1_pos, 0, 0, 1, 1)
   love.graphics.draw(front2, front2_pos, 0, 0, -1, 1)
   love.graphics.setColor(0,0,1,1)
   love.graphics.rectangle("fill", 25, 25, 100, 50)
   push:finish()
end

function love.resize(w, h)
  push:resize(w, h)
end
