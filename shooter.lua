local component = require("component")
local event = require("event")
local modem = component.modem
local gpu = component.gpu

-- Настройки сетевого соединения
local serverAddress = "192.168.1.100" -- Адрес сервера
local serverPort = 32456 -- Порт сервера

-- Настройки графики
local screenWidth, screenHeight = gpu.getResolution()
local playerX, playerY = screenWidth / 2, screenHeight / 2

-- Функция отправки данных серверу
local function sendToServer(message)
  modem.send(serverAddress, serverPort, message)
end

-- Функция отрисовки игрока
local function drawPlayer()
  gpu.set(playerX, playerY, "@")
end

-- Функция очистки экрана
local function clearScreen()
  gpu.fill(1, 1, screenWidth, screenHeight, " ")
end

-- Основной цикл игры
while true do
  -- Очищаем экран
  clearScreen()

  -- Отрисовываем игрока
  drawPlayer()

  -- Получаем события с клавиатуры
  local _, _, _, key = event.pull("key_down")
  
  -- Обработка нажатия клавиш
  if key == 200 then -- Вверх
    playerY = playerY - 1
  elseif key == 208 then -- Вниз
    playerY = playerY + 1
  elseif key == 203 then -- Влево
    playerX = playerX - 1
  elseif key == 205 then -- Вправо
    playerX = playerX + 1
  elseif key == 28 then -- Enter
    sendToServer("Выстрел!") -- Пример отправки сообщения о выстреле на сервер
  end
end
