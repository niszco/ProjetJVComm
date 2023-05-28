_G.love = require("love");

function love.load()
    math.randomseed(os.time())
    love.window.setTitle("Asteroids Attack!")
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    player = {}
    asteroids = {}
    asteroidImages = {}
    player.image = love.graphics.newImage("player.png")
    player.width = player.image:getWidth()
    player.height = player.image:getHeight()
    player.x = (screenWidth / 2) - (player.width / 2)
    player.y = screenHeight - player.height - 10
    player.speed = 500
    player.time = 0
    table.insert(asteroidImages, love.graphics.newImage("asteroid1.png"))
    table.insert(asteroidImages, love.graphics.newImage("asteroid2.png"))
    table.insert(asteroidImages, love.graphics.newImage("asteroid3.png"))
    table.insert(asteroidImages, love.graphics.newImage("asteroid4.png"))
    for i = 1, 4 do
      createAsteroid()
    end
    
    -- chargement de l'image de fond
    background = love.graphics.newImage("background.png")
    -- initialisation des variables de l'image de fond
    backgroundX = 0
    backgroundY = 0
    backgroundSpeed = 15
    
  end
  
  function love.update(dt)
    if love.keyboard.isDown("left") then
      player.x = player.x - player.speed * dt
    elseif love.keyboard.isDown("right") then
      player.x = player.x + player.speed * dt
    end
    if player.x < 0 then
      player.x = 0
    elseif player.x + player.width > screenWidth then
      player.x = screenWidth - player.width
    end
    for i, asteroid in ipairs(asteroids) do
      asteroid.y = asteroid.y + asteroid.speed * dt
      if asteroid.y > screenHeight then
        table.remove(asteroids, i)
        createAsteroid()
      end
      if checkCollision(asteroid, player) then
        love.load()
      end
    end
    
    -- mise à jour de la position de l'image de fond
    backgroundY = backgroundY + backgroundSpeed * dt
    if backgroundY >= screenHeight then
      backgroundY = 0
    end

    -- Incrémente le temps écoulé depuis la dernière mise à jour
  player.time = player.time + dt
  
  -- Met à jour le score en fonction du temps écoulé
  player.score = math.floor(player.time * 10)
    
  end
  
  function love.draw()
    -- dessin de l'image de fond
    love.graphics.draw(background, backgroundX, backgroundY)
    love.graphics.draw(background, backgroundX, backgroundY - screenHeight)
    
    love.graphics.draw(player.image, player.x, player.y)
    love.graphics.print("Score: " .. player.score, 0)
    for i, asteroid in ipairs(asteroids) do
      love.graphics.draw(asteroid.image, asteroid.x, asteroid.y)
    end
  end
  
  function checkCollision(obj1, obj2)
    if obj1.x + obj1.width > obj2.x and obj1.x < obj2.x + obj2.width and
       obj1.y + obj1.height > obj2.y and obj1.y < obj2.y + obj2.height then
      return true
    else
      return false
    end
  end
  
  function createAsteroid()
    local asteroid = {}
    asteroid.image = asteroidImages[math.random(#asteroidImages)]
    asteroid.width = asteroid.image:getWidth()
    asteroid.height = asteroid.image:getHeight()
    asteroid.x = math.random(screenWidth - asteroid.width)
    asteroid.y = -asteroid.height
    asteroid.speed = math.random(100, 400)
    table.insert(asteroids, asteroid)
  end