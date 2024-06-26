--===============================================================================================--
--======================================= ИНСТРУКЦИЯ ============================================--
--===============================================================================================--

-- Краткая инструкция к сценарию для G502 HERO

-- Скрипт работает на Logitech G HUB версии 2022.7.290502
-- Перед началом использования проверьте, что в разделе назначения (Logitch G HUB) для
--  следующих кнопок мыши установлены соответствующие назначения:
  -- кнопка G1 - функция мыши 'щелчок основной кнопкой';
  -- кнопка G8 - функция мыши 'щелчок средней кнопкой'.

-- Снижение вертикальной отдачи:
  -- - Для правильной работы скрипта, необходимо в настройках игры режим прицела переключить
  --    на 'удерживать';
  -- - Скрипт снижения вертикальной отдачи работает при одновременном удерживании левой и 
  --    правой кнопок мыши, или при одновременном удерживании кнопки автокликера и правой
  --    кнопки мыши (в случае использования автокликера);
  -- - Для активации скрипта включите Numlock;
  -- - Для более высокого снижения верт.отдачи включите Capslock дополнительно (ко включенной
  --    Numlock).
  
-- Быстрый выбор гранат и аптечек:
  -- - Нажмите на кнопку выбора гранат (или аптечек) - откроется список гранат (или аптечек);
  -- - Левой кнопкой мыши выберите необходимую гранату (или аптечку);
  -- - ВНИМАНИЕ!!! При использовании данной функции, курсор мыши должен быть убран нажатием 
  --    левой кнопки мыши, иначе скрипт развернет вашего персонажа в другую сторону.

--===============================================================================================--
--====================================== НАСТРОЙКИ ==============================================--
--===============================================================================================--

-- Включение/выключение функций (true/false)
ANTI_RECOIL = false -- снижение вертикальной отдачи
AUTOCLICKER = true -- автокликер
GET_GRENADE = true -- быстрый выбор гранат
HEALING = true  -- быстрый выбор аптечки
AUTOSTART = true -- автостарт матча
---------------------------------------------------------------------------------------------------

-- цифровые обозначения основных кнопок мыши, используемые в функции IsMouseButtonPressed()
LEFT_MOUSE_BUTTON = 1 -- левая кнопка мыши
MIDDLE_MOUSE_BUTTON = 2 -- средняя кнопка мыши
RIGHT_MOUSE_BUTTON = 3 -- правая кнопка мыши
BACKWARD_MOUSE_BUTTON = 4 -- кнопка 'назад'
FORWARD_MOUSE_BUTTON = 5 -- кнопка 'вперёд'
---------------------------------------------------------------------------------------------------

-- Режим низкой отдачи
ANTI_RECOIL_BUTTON = 3 -- аргумент события кнопки включения режима низкой отдачи (включение
                       -- Numlook)

-- Чем ниже значение в следующих двух параметрах, тем быстрее будет опускаться 
-- курсор мыши по вертикали при стрельбе через прицел

LOW_RECOIL_DELAY = 47 -- задержка движения мыши вниз по вертикали (в миллисекундах)
HIGH_RECOIL_DELAY = 20 -- задержка движения мыши вниз по вертикали при Capslock (в миллисекундах)

PIXEL_STEP = 1 -- шаг движения мыши вниз (в пикселях)

HIGH_RECOIL_WITH_CAPSLOCK = true -- при значении false отключает переключание кнопкой CAPSLOCK
                                 -- скорости движения мыши
---------------------------------------------------------------------------------------------------

-- Автокликер
AUTOCLICKER_BUTTON = FORWARD_MOUSE_BUTTON
AUTOCLICKER_DELAY = 25 -- задержка (между выстрелами/нажатиями) автокликера (в миллисекундах)
---------------------------------------------------------------------------------------------------

-- hex-коды кнопок клавиатуры
TILDE_BUTTON = 0x29
NUMLOCK_BUTTON = 0x45
LCTRL_BUTTON = 0x1d

CURSOR_BUTTON = TILDE_BUTTON -- определение кнопки отображения курсора мыши
---------------------------------------------------------------------------------------------------

-- строковые значения переключаемых кнопок, используемые в функции IsKeyLockOn()

NUMLOCK = "numlock"
CAPSLOCK = "capslock"
SCROLLLOCK = "scrolllock"
---------------------------------------------------------------------------------------------------

-- Быстрый выбор гранат и аптечек
GRENADE_BUTTON = 8 -- кнопка удобного выбора гранат
HEALING_BUTTON = 7 -- кнопка удобного выбора аптечек
GRENADE_X, GRENADE_Y = 41698, 58550 -- координаты кнопки открытия списка бросательного припаса
HEAL_LIST_X, HEAL_LIST_Y = 23837, 58550 -- координаты кнопки открытия списка аптечек
HEALING_X, HEALING_Y = 23837, 62377 -- координаты кнопки применения выбранной аптечки
DELAY_BEFORE_SELECT = 20

SHOW_CURSOR_POSITION = false -- понадобится для настройки быстрого выбора гранат и аптечек.
                             -- при значении true выводит в консоль координаты курсора,
                             -- соответсвующие позиции курсора на экране.


LIST_WIDTH, LIST_HEIGHT, MAX_VALUE = 4800, 30000, 65535

HL_LEFT_BORDER = HEALING_X - (LIST_WIDTH / 2)
HL_RIGHT_BORDER = HEALING_X + (LIST_WIDTH / 2)
GL_LEFT_BORDER = GRENADE_X - (LIST_WIDTH / 2)
GL_RIGHT_BORDER = GRENADE_X + (LIST_WIDTH / 2)

TOP_BORDER = MAX_VALUE - LIST_HEIGHT

pre_HL_open_time, pre_GL_open_time, LIST_ACTIVE_TIME = 0, 0, 1500
---------------------------------------------------------------------------------------------------

-- Автостарт матча
AUTOSTART_BUTTON = 9 -- кнопка запуска автостарта матча
AUTOSTART_WITHIN = 14 -- время кликания мыши при автостарте матча (в секундах)
AUTOSTART_DELAY = 0.9 -- задержка перед повторным нажатием (в секундах)

-- настройки вращения курсора при автостарте матча
START_BUTTON_POSITION_X, START_BUTTON_POSITION_Y = 5601, 58522
ANGLE = 0
RADIUS = 2
ROTATION_DELAY = 10

--===============================================================================================--
--========================================== ФУНКЦИИ ============================================--
--===============================================================================================--

-- Функция 'Автостарт матча'
function AutoStart()
  start_time = GetRunningTime()
  MoveMouseTo(START_BUTTON_POSITION_X, START_BUTTON_POSITION_Y)
  Sleep(DELAY_BEFORE_SELECT)

  autostart_within_ = AUTOSTART_WITHIN * 1000
  autostart_delay_ = AUTOSTART_DELAY * 1000
  
  PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
  
  while not (IsMouseButtonPressed(LEFT_MOUSE_BUTTON)
      or IsMouseButtonPressed(RIGHT_MOUSE_BUTTON))
    do
    
    if (GetRunningTime() - start_time) >= autostart_within_ then
      MoveMouseTo(START_BUTTON_POSITION_X, START_BUTTON_POSITION_Y)
      Sleep(DELAY_BEFORE_SELECT)
      
      PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
      Sleep(autostart_delay_)
      
      PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
      start_time = GetRunningTime()
    end
    
    Sleep(ROTATION_DELAY)
    mouse_pos_x, mouse_pos_y = GetMousePosition()
    center_x, center_y = mouse_pos_x, mouse_pos_y + RADIUS
    next_x, next_y = RADIUS * math.cos(ANGLE), RADIUS * math.sin(ANGLE)
    
    if next_x % 1 >= 0.5 then
      next_x = math.ceil(next_x)
    else
      next_x = math.floor(next_x)
    end
      
    if next_y % 1 >= 0.5 then
      next_y = math.ceil(next_y)
    else
      next_y = math.floor(next_y)
    end
    
    x_dif, y_dif = next_x, next_y
    MoveMouseRelative(x_dif, y_dif)
    ANGLE = ANGLE + 0.1
  end
end
---------------------------------------------------------------------------------------------------

-- Функция выбора скорости снижения отдачи для функций LowRecoilShoot и LowRecoilAutoClicker

if HIGH_RECOIL_WITH_CAPSLOCK then

  function GetRecoilDelay()
    if IsKeyLockOn(CAPSLOCK) then
      return HIGH_RECOIL_DELAY
    else
      return LOW_RECOIL_DELAY
    end
  end

else

  function GetRecoilDelay()
    return LOW_RECOIL_DELAY
  end

end
---------------------------------------------------------------------------------------------------

-- Подфункция перемещения мыши вниз для функций LowRecoilShoot и LowRecoilAutoClicker
function MoveMouseDown(before_down_delay, after_down_delay)
  Sleep(before_down_delay)
  MoveMouseRelative(0, PIXEL_STEP)
  Sleep(after_down_delay)
end
---------------------------------------------------------------------------------------------------

-- Подфункция Автокликер: используются в основной логике и в функции LowRecoilAutoClicker
function AutoClicker(before_click_delay, after_click_delay)
  Sleep(before_click_delay)
  PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
  Sleep(after_click_delay)
end
---------------------------------------------------------------------------------------------------

-- Функция снижения отдачи при стрельбе в прицеле
function LowRecoilShoot()
  recoil_delay = GetRecoilDelay()
  MoveMouseDown(0, recoil_delay)
end
---------------------------------------------------------------------------------------------------

-- Функция снижения отдачи при Автокликере в прицеле
function LowRecoilAutoClicker(shoot_button, sight_button, is_function_on)
  previous_recoil_delay, sum_autoclicker_delays, sum_mouse_down_delays = 0, 0, 0

  while IsMouseButtonPressed(shoot_button) and
      IsMouseButtonPressed(sight_button) and
      is_function_on
    do

    recoil_delay = GetRecoilDelay()

    if recoil_delay ~= previous_recoil_delay then
      previous_recoil_delay, sum_autoclicker_delays, sum_mouse_down_delays = recoil_delay, 0, 0

      if recoil_delay < AUTOCLICKER_DELAY then
        PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
      end
    end

    if recoil_delay >= AUTOCLICKER_DELAY then
      AutoClicker(0, AUTOCLICKER_DELAY - sum_mouse_down_delays)
      sum_autoclicker_delays = sum_autoclicker_delays + AUTOCLICKER_DELAY - sum_mouse_down_delays

      if (sum_autoclicker_delays + AUTOCLICKER_DELAY) >= recoil_delay then
        MoveMouseDown(recoil_delay - sum_autoclicker_delays, 0)
        sum_mouse_down_delays, sum_autoclicker_delays = recoil_delay - sum_autoclicker_delays, 0

      else
        sum_mouse_down_delays = 0
      end
    else
      MoveMouseDown(0, recoil_delay - sum_autoclicker_delays)
      sum_mouse_down_delays = sum_mouse_down_delays + recoil_delay - sum_autoclicker_delays

      if sum_mouse_down_delays + recoil_delay >= AUTOCLICKER_DELAY then
        AutoClicker(AUTOCLICKER_DELAY - sum_mouse_down_delays, 0)
        sum_autoclicker_delays, sum_mouse_down_delays  = AUTOCLICKER_DELAY - sum_mouse_down_delays, 0

      else
        sum_autoclicker_delays = 0
      end
    end

  end
end
---------------------------------------------------------------------------------------------------

-- Функция для быстрого выбора бросательного припаса
function QuickGrenadeSelection(event_l, arg_l, selection_button)

  -- Открытие списка гранат
  if (event_l == "MOUSE_BUTTON_PRESSED" and arg_l == GRENADE_BUTTON) and GET_GRENADE then
    if (GetRunningTime() - pre_GL_open_time) > LIST_ACTIVE_TIME then
      PressAndReleaseKey(CURSOR_BUTTON)
      Sleep(DELAY_BEFORE_SELECT)

      MoveMouseTo(GRENADE_X, GRENADE_Y)
      Sleep(DELAY_BEFORE_SELECT)
      MoveMouseTo(GRENADE_X, GRENADE_Y)
      Sleep(DELAY_BEFORE_SELECT)
    
      PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
      is_grenade_cursor_show = true
    end
  end
  
  -- Выбор и закрытие списка гранат
  if is_grenade_cursor_show then
    if (event_l == "MOUSE_BUTTON_RELEASED" and arg_l == selection_button) then
      cur_position_X, cur_position_Y = GetMousePosition()

      if cur_position_X > GL_LEFT_BORDER and
        cur_position_X < GL_RIGHT_BORDER and
        cur_position_Y > TOP_BORDER then

        PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
        Sleep(DELAY_BEFORE_SELECT)
      
        PressAndReleaseKey(CURSOR_BUTTON)
        is_grenade_cursor_show = false
      else
        PressAndReleaseKey(CURSOR_BUTTON)
        pre_GL_open_time = GetRunningTime()
        is_grenade_cursor_show = false
      end
    end
  end
  
end
---------------------------------------------------------------------------------------------------

-- Функция для быстрого выбора аптечки
function QuickHealing(event_l, arg_l, selection_button)
  
  -- Открытие списка аптечек
  if (event_l == "MOUSE_BUTTON_PRESSED" and arg_l == HEALING_BUTTON) and HEALING then
    if (GetRunningTime() - pre_HL_open_time) > LIST_ACTIVE_TIME then
      PressAndReleaseKey(CURSOR_BUTTON)
      Sleep(DELAY_BEFORE_SELECT)

      MoveMouseTo(HEAL_LIST_X, HEAL_LIST_Y)
      Sleep(DELAY_BEFORE_SELECT)
      MoveMouseTo(HEAL_LIST_X, HEAL_LIST_Y)
      Sleep(DELAY_BEFORE_SELECT)

      PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
      is_healing_cursor_show = true
    end
  end
  
  -- Выбор и применение аптечки
  if is_healing_cursor_show then
    if (event_l == "MOUSE_BUTTON_RELEASED" and arg_l == selection_button) then
      cur_position_X, cur_position_Y = GetMousePosition()

      if cur_position_X > HL_LEFT_BORDER and
        cur_position_X < HL_RIGHT_BORDER and
        cur_position_Y > TOP_BORDER then

        PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
        Sleep(DELAY_BEFORE_SELECT)

        MoveMouseTo(HEALING_X, HEALING_Y)
        Sleep(DELAY_BEFORE_SELECT)

        PressAndReleaseMouseButton(LEFT_MOUSE_BUTTON)
        Sleep(DELAY_BEFORE_SELECT)

        PressAndReleaseKey(CURSOR_BUTTON)
        is_healing_cursor_show = false
      else
        PressAndReleaseKey(CURSOR_BUTTON)
        pre_HL_open_time = GetRunningTime()
        is_healing_cursor_show = false
      end

    end
  end
  
end

--===============================================================================================--
--================================ ОСНОВНАЯ ЛОГИКА СЦЕНАРИЯ =====================================--
--===============================================================================================--

EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
  OutputLogMessage("event = "..event..", arg = "..arg.."\n")
---------------------------------------------------------------------------------------------------

  -- Стрельба в прицеле с низкой отдачей
  if IsKeyLockOn(NUMLOCK) and ANTI_RECOIL then
  
    while IsMouseButtonPressed(LEFT_MOUSE_BUTTON) and
        IsMouseButtonPressed(RIGHT_MOUSE_BUTTON)
      do
      LowRecoilShoot()
    end
---------------------------------------------------------------------------------------------------

  -- Автокликер в прицеле с низкой отдачей
  LowRecoilAutoClicker(AUTOCLICKER_BUTTON, RIGHT_MOUSE_BUTTON, AUTOCLICKER)
---------------------------------------------------------------------------------------------------

  -- Автокликер без прицела
    while IsMouseButtonPressed(AUTOCLICKER_BUTTON) and
      not IsMouseButtonPressed(RIGHT_MOUSE_BUTTON) and
      AUTOCLICKER do
      AutoClicker(0, AUTOCLICKER_DELAY)
    end
  else
---------------------------------------------------------------------------------------------------

  -- Автокликер без прицела
    while IsMouseButtonPressed(AUTOCLICKER_BUTTON) and
      AUTOCLICKER do
      AutoClicker(0, AUTOCLICKER_DELAY)
    end
  end
---------------------------------------------------------------------------------------------------

  -- Включение режима низкой вертикальной отдачи кнопкой мыши
  if (event == "MOUSE_BUTTON_PRESSED" and arg == ANTI_RECOIL_BUTTON) and ANTI_RECOIL then
    PressAndReleaseKey(NUMLOCK_BUTTON)
  end
---------------------------------------------------------------------------------------------------

  -- Быстрый выбор гранат
  QuickGrenadeSelection(event, arg, LEFT_MOUSE_BUTTON)
---------------------------------------------------------------------------------------------------

  -- Быстрый выбор аптечек
  QuickHealing(event, arg, LEFT_MOUSE_BUTTON)
---------------------------------------------------------------------------------------------------

  -- Автостарт матча
  if arg == AUTOSTART_BUTTON and AUTOSTART then
    AutoStart()
  end

---------------------------------------------------------------------------------------------------

  -- Вывод координат курсора при включении в настройках SHOW_CURSOR_POSITION
  if SHOW_CURSOR_POSITION then
    x, y = GetMousePosition()
    OutputLogMessage("x = "..x..", y = "..y.."\n" )
  end
---------------------------------------------------------------------------------------------------

end
