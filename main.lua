require('globals');
local DefaultScene = require('scenes/DefaultScene');

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest', 1);

    largeFont = love.graphics.newFont('assets/fonts/font.ttf', 32);

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        -- pixelperfect = true
    });

    push:setBorderColor(0, 0, 0, 1);

    sceneManager = L2DBN.SceneManager({
        --ADD SCENE HERE
        DefaultScene
    });

    love.window.setTitle('__L2DBN__');

    love.keyboard.keysPressed = {};
    love.keyboard.keysReleased = {};
    love.mouse.mx = 0;
    love.mouse.my = 0;
end

function love.resize(w, h)
    push:resize(w, h);
end

function love.mouse.wasClicked()
    if love.mouse.pressed then
        return love.mouse.pressed;
    else
        return false;
    end
end

function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end

function love.keyboard.wasReleased(key)
    if (love.keyboard.keysReleased[key]) then
        return true
    else
        return false
    end
end

function love.mouse.mouseToWorldPos(x, y)
    return x / push._SCALE.x + push._OFFSET.x, y / push._SCALE.y + push._OFFSET.y;
end

function love.mousepressed(x, y, button, istouch)
    x, y = love.mouse.mouseToWorldPos(x, y);
    love.mouse.pressed = { --TODO: FIX
        x,
        y,
        button,
        istouch
    };
end

function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.conf(t)
    t.console = true
end

function love.update(dt)
    sceneManager:update(dt)

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
    love.mouse.mx, love.mouse.my = love.mouse.mouseToWorldPos(love.mouse.getPosition());
    love.mouse.pressed = nil;
end

function love.draw()
    sceneManager:render()
end

function love.quit()
    if SaveData then
        SaveManager:save(SaveData.save_file, SaveData);
    end
end
