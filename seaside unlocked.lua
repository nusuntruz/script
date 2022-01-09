local ffi = require('ffi')
ffi.cdef[[
    typedef int BOOL;
    typedef long LONG;
    typedef unsigned long HWND;
    typedef struct{
        LONG x, y;
    }POINT, *LPPOINT;
    
    typedef unsigned long DWORD, *PDWORD, *LPDWORD;  

    typedef struct _SECURITY_ATTRIBUTES {
        DWORD  nLength;
        void* lpSecurityDescriptor;
        BOOL   bInheritHandle;
    } SECURITY_ATTRIBUTES, *PSECURITY_ATTRIBUTES, *LPSECURITY_ATTRIBUTES;

    typedef struct {
        uint8_t r;
        uint8_t g;
        uint8_t b;
        uint8_t a;
    } color_struct_t;

    typedef void (*console_color_print)(const color_struct_t&, const char*, ...);

    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);

    short GetAsyncKeyState(int vKey);
    BOOL GetCursorPos(LPPOINT);
    HWND GetForegroundWindow();
    BOOL IsChild(HWND hWndParent, HWND hWnd);
    BOOL ScreenToClient(HWND hWnd, LPPOINT lpPoint);
    HWND FindWindowA(const char* lpClassName, const char* lpWindowName );
    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);
    int AddFontResourceA(const char* unnamedParam1);
    bool DeleteUrlCacheEntryA(const char* lpszUrlName);
    BOOL CreateDirectoryA(const char* lpPathName, LPSECURITY_ATTRIBUTES lpSecurityAttributes);

    typedef struct
    {
        float x;
        float y;
        float z;
    } Vector_t;
    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);

    typedef int(__fastcall* clantag_t)(const char*, const char*);
]]
local ffi_helpers = {
    color_print_fn = ffi.cast("console_color_print", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("tier0.dll"), "?ConColorMsg@@YAXABVColor@@PBDZZ")),
    color_print = function(self, text, color)
        local col = ffi.new("color_struct_t")

        col.r = color:r()
        col.g = color:g()
        col.b = color:b()
        col.a = color:a()

        self.color_print_fn(col, text)
    end
}

local function console_print_color(color, text)
    ffi_helpers.color_print(ffi_helpers, text, color)
end

local wininet = ffi.load 'WinInet'
local urlmon = ffi.load 'UrlMon'
local gdi = ffi.load 'Gdi32'

console.execute("clear")
client.add_callback("on_paint", function()
    console.execute("con_filter_enable 3")
    console.execute("con_filter_text  out hajksddsnkjcakhkjash")
    console.execute("con_filter_text  hjkasdhjadskdhasjkasd 1")
end)
    console_print_color(color.new(200,255,0),
    "SeaSide - User identification confirmed..." .. "\n" ..
    "SeaSide - Loading script..." .. "\n" ..
    "SeaSide - Script succesfully loaded..." .. "\n\n\n" ..
    "░██████╗███████╗░█████╗░░██████╗██╗██████╗░███████╗░░░██╗░░░░░██╗░░░██╗░█████╗░" .. "\n" ..
    "██╔════╝██╔════╝██╔══██╗██╔════╝██║██╔══██╗██╔════╝░░░██║░░░░░██║░░░██║██╔══██╗" .. "\n" ..
    "╚█████╗░█████╗░░███████║╚█████╗░██║██║░░██║█████╗░░░░░██║░░░░░██║░░░██║███████║" .. "\n" ..
    "░╚═══██╗██╔══╝░░██╔══██║░╚═══██╗██║██║░░██║██╔══╝░░░░░██║░░░░░██║░░░██║██╔══██║" .. "\n" ..
    "██████╔╝███████╗██║░░██║██████╔╝██║██████╔╝███████╗██╗███████╗╚██████╔╝██║░░██║" .. "\n" ..
    "╚═════╝░╚══════╝╚═╝░░╚═╝╚═════╝░╚═╝╚═════╝░╚══════╝╚═╝╚══════╝░╚═════╝░╚═╝░░╚═╝" .. "\n\n\n"
)
console_print_color(color.new(200,255,0), latestupdates .. "\n")
function install_logo_font()
    local appdataraw = os.getenv("appdata")
    local appdata = string.gsub(appdataraw, "\\", "/")

    ffi.C.CreateDirectoryA(appdata.."/Legendware/Scripts/SeaSide", nil)

    local logo_font_path = appdata.."/Legendware/Scripts/SeaSide/logoFont.ttf"
    local logo_font_download_link = "https://cdn.discordapp.com/attachments/904685006264348682/907354142366916718/DANCINGSCRIPT-VARIABLEFONT_WGHT.TTF"
    --print("" .. logo_font_path)
    wininet.DeleteUrlCacheEntryA(logo_font_download_link)
    urlmon.URLDownloadToFileA(nil, logo_font_download_link, logo_font_path, 0,0)
    gdi.AddFontResourceA(logo_font_path)
end

install_logo_font()

local bUnloadedScript = false

menu.next_line()

local function is_key_down(vKey)
    return ffi.C.GetAsyncKeyState(vKey) < 0
end

local csgo_window = ffi.C.FindWindowA("Valve001", nil)

local function get_mouse_pos()
    local hActiveWindow = ffi.C.GetForegroundWindow()
    if hActiveWindow == 0 then
        return vector.new(0,0,0)
    end

    if hActiveWindow ~= csgo_window and not ffi.C.IsChild(hActiveWindow, csgo_window) then
        return vector.new(0,0,0)
    end

    local ppoint = ffi.new("POINT[1]")
    if ffi.C.GetCursorPos(ppoint) == 0 then
        return vector.new(0,0,0)
        --error("Couldn't get cursor position!", 2)
    end

    if not ffi.C.ScreenToClient(csgo_window, ppoint) then
        return vector.new(0,0,0)
    end

    return vector.new(ppoint[0].x, ppoint[0].y, 0)
end

-- initialize lw's menu objects
menu.add_color_picker("Menu Color")

function LerpColor(a, b, t)
    return color.new(
        math.floor(a:r() + ((b:r() - a:r()) * t)),
        math.floor(a:g() + ((b:g() - a:g()) * t)),
        math.floor(a:b() + ((b:b() - a:b()) * t)),
        math.floor(a:a() + ((b:a() - a:a()) * t))
    )
end

local fonts = {
    menu_height = 30,
    menu = render.create_font("Verdana", 30, 500, false, true, false),
    objects_height = 13,
    objects = render.create_font("Verdana", 13, 500, false, true, false),
    logofont_height = 50,
    logofont = render.create_font("Dancing Script Regular", 50, 700, false, true, false),
    skeet_indicators = render.create_font("calibrib", 25, 600),
    verdana = render.create_font("verdana", 13, 500, false,true,false),
    kbverdana = render.create_font("verdana", 12, 500, false,true,false),
    smallpixel = render.create_font( "Smallest Pixel-7", 18, 500, true, true, false ),
    idealfont = render.create_font("Verdana", 12, 300, false, true, false),
    indismall = render.create_font( "Smallest Pixel-7", 15, 500, true, true, false ),
    arrowsfont = render.create_font( "Verdana", 25, 500, true, true, false ),
    arrow = render.create_font("Arial", 50, 400, false, false, false),
    arrow2 = render.create_font("Arial", 25, 400, false, false, false),
    lefont = render.create_font("verdana", 16, 200, false, false, true),
    font7 = render.create_font( "Verdana", 12, 500, false, true, true ),
    font = render.create_font("Verdana", 12, 500, false, true, false),
    fonttitle = render.create_font("verdana", 18, 100, false, true, true),
    font10 = render.create_font("verdana", 17, 450, false, true, true),
    spectators = render.create_font( "Verdana", 12, 300)
}

function is_hovered(rect)
    local cursor_pos = get_mouse_pos()
    return (cursor_pos.x >= rect.x and cursor_pos.x <= rect.x + rect.w) and (cursor_pos.y >= rect.y and cursor_pos.y <= rect.y + rect.h)
end

local bMenuOpened = true

local MenuClass = {
    pressing_move_key = false,
    can_move = false,
    move_click_offset = {x = 0, y = 0},
    pos = {x = 300, y = 300},
    size = {w = 600, h = 450},
    cursor_pos = {x = 0, y = 0},
    logo_size = {w = 160, h = 150},
    tabs_selector_width = 160, -- logo width and this the same, yes?
    current_selected_var = "",
    last_left_clicked = false,
    spacing = 8,
    main_color = color.new(123, 87, 201, 255),
    rect_color = color.new(60,60,60)
}

-- variable class
CVariable = {type = "none", value_bool = false, value_int = 0}
function CVariable:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function CVariable:get_type()
    return self.type
end

function CVariable:set_type(type)
    self.type = type
end

function CVariable:set_value_bool(value)
    self.value_bool = value
end

function CVariable:get_value_bool()
    return self.value_bool
end

function CVariable:set_value_int(value)
    self.value_int = value
end

function CVariable:get_value_int()
    return self.value_int
end

-- table filled with CVariable
local variables = {}

function save_config(index)
    local appdataraw = os.getenv("appdata")
    local appdata = string.gsub(appdataraw, "\\", "/")

    ffi.C.CreateDirectoryA(appdata.."/Legendware/Scripts/SeaSide", nil)

    local config_path = appdata.."/Legendware/Scripts/SeaSide/" .. tostring(index) .. ".cfg"

    local config_write_data = ""
    for i,v in pairs(variables) do
        if i ~= "_ignore_config_index" then
            config_write_data = config_write_data .. "[" .. v:get_type() .. "]"

            config_write_data = config_write_data .. "{" .. i .. "}"

            config_write_data = config_write_data .. "("

            if v:get_type() == "int" then
                config_write_data = config_write_data .. tostring(v:get_value_int())
            elseif v:get_type() == "bool" then
                config_write_data = config_write_data .. (v:get_value_bool() and "true" or "false")
            else
                -- should never happen
                config_write_data = config_write_data .. "invalid"
            end

            config_write_data = config_write_data .. ")"

            if i ~= #variables then
                config_write_data = config_write_data .. "\n"
            end
        end
    end

    file.write(config_path, config_write_data)
end

-- https://stackoverflow.com/questions/19326368/iterate-over-lines-including-blank-lines
function magiclines(s)
    if s:sub(-1)~="\n" then s=s.."\n" end
    return s:gmatch("(.-)\n")
end

function load_config(index)
    local appdataraw = os.getenv("appdata")
    local appdata = string.gsub(appdataraw, "\\", "/")

    ffi.C.CreateDirectoryA(appdata.."/Legendware/Scripts/SeaSide", nil)

    local config_path = appdata.."/Legendware/Scripts/SeaSide/" .. tostring(index) .. ".cfg"

    local file_data = file.read(config_path)
    if file_data == "" or file_data == nil then
        print("Error Loading config: " .. tostring(index))
        return
    end

    for line in magiclines(file_data) do
        local v1, j = line:find("%[")
        local v2, j = line:find("%]")
        if v1 ~= nil and v2 ~= nil then
            local type = line:sub(v1+1, v2-1)

            local v3, j = line:find("{")
            local v4, j = line:find("}")
            if v3 ~= nil and v4 ~= nil then
                local var_name = line:sub(v3+1, v4-1)

                local v5, j = line:find("%(")
                local v6, j = line:find("%)")
                if v5 ~= nil and v6 ~= nil then
                    local value_string = line:sub(v5+1, v6-1)
                    
                    -- load variable
                    if variables[var_name] == nil then
                        variables[var_name] = CVariable:new()
                    end

                    variables[var_name]:set_type(type)

                    -- here.. it's more complicated
                    if type == "bool" then
                        if value_string == "true" then
                            variables[var_name]:set_value_bool(true)
                        else
                            variables[var_name]:set_value_bool(false)
                        end
                    elseif type == "int" then
                        variables[var_name]:set_value_int(tonumber(value_string))
                    end
                end
            end
        end
    end
end
local developer = globals.get_username() == "Ruzule"
local selected_tab = 0 -- default = config tab
local tabs = {}
if developer then
    tabs = {
        "Rage" , "Anti-Aim" , "Visuals" , "Misc" , "Config", "Debug"
    }
else
    tabs = {
        "Rage" , "Anti-Aim" , "Visuals" , "Misc" , "Config"
    }
end

local tabs_animations = {}
tabs_animations.value = 0.0
tabs_animations.value_background = 0.0
tabs_animations.should_decrease = false
for i=1,#tabs,1 do
    table.insert(tabs_animations, {value = 0.0, value_background = 0.0, should_decrease = false})
end

local combobox_helper_opened_variables = {
    var = "",
    items = {},
    combobox_area = {x = 0, y = 0, w = 0, h = 0},
    current_selected_index = 0 -- selected index but used for input
}

function draw_tab(label, index)
    local tab_estimated_size = {
        w = MenuClass.tabs_selector_width, -- maybe -2 or something, border from window?
        h = fonts.menu_height + 2
    }

    local anim_time = globals.get_frametime() * (1.0 / 0.9)

    local tab_spacing = 10

    local initial_pos = {
        x = MenuClass.pos.x, -- again, border from window?
        y = MenuClass.pos.y + MenuClass.logo_size.h + ((MenuClass.size.h - MenuClass.logo_size.h) / 2) - ((tab_estimated_size.h ) * #tabs)
    }

    initial_pos.y = initial_pos.y + tab_estimated_size.h -- retarded spacing because of logo

    local final_pos = {
        x = initial_pos.x,
        y = initial_pos.y + ((tab_estimated_size.h + tab_spacing) * index)
    }

    -- handle input
    local tab_var_name = label .. "#TabLabel" .. tostring(index)
    local tab_area_hovered = is_hovered({x = final_pos.x, y = final_pos.y, w = tab_estimated_size.w, h = tab_estimated_size.h})
    if is_key_down(1) then
        if not MenuClass.last_left_clicked then
            if tab_area_hovered then
                if MenuClass.current_selected_var == "" and combobox_helper_opened_variables.var == "" then
                    MenuClass.current_selected_var = tab_var_name
                end
            end
        end
    else
        if MenuClass.current_selected_var == tab_var_name then
            if tab_area_hovered then
                selected_tab = index
            end

            MenuClass.current_selected_var = ""
        end
    end

    if selected_tab == index then
        if tabs_animations[index + 1].value_background < 1 then
            tabs_animations[index + 1].value_background = tabs_animations[index + 1].value_background + anim_time
        end
    else
        if tabs_animations[index + 1].value_background > 0 then
            tabs_animations[index + 1].value_background = tabs_animations[index + 1].value_background - anim_time
        end
    end

    -- clamp animation [0, 1]
    if tabs_animations[index + 1].value_background < 0 then
        tabs_animations[index + 1].value_background = 0
    end

    if tabs_animations[index + 1].value_background > 1 then
        tabs_animations[index + 1].value_background = 1
    end

    -- draw background
    local background_alpha = math.floor(20 * tabs_animations[index + 1].value_background)
    render.draw_rect_filled(final_pos.x, final_pos.y, tab_estimated_size.w, tab_estimated_size.h, color.new(100, 100, 100, background_alpha))

    local text_width = render.get_text_width(fonts.menu, label)
    local text_pos = {
        x = final_pos.x + (tab_estimated_size.w / 8), --+ (tab_estimated_size.w / 2) - (text_width / 2),
        y = final_pos.y + (tab_estimated_size.h / 2) - (fonts.menu_height / 2)
    }

    -- handle animations
    local text_move_size = (text_width / 4)
    if selected_tab == index then
        if tabs_animations[index + 1].value >= 1 then
            tabs_animations[index + 1].should_decrease = true
        elseif tabs_animations[index + 1].value <= 0 then
            tabs_animations[index + 1].should_decrease = false
        end
    else
        tabs_animations[index + 1].should_decrease = true
    end

    if tabs_animations[index + 1].should_decrease then
        if tabs_animations[index + 1].value > 0 then
            tabs_animations[index + 1].value = tabs_animations[index + 1].value - anim_time
        end
    else
        if tabs_animations[index + 1].value < 1 then
            tabs_animations[index + 1].value = tabs_animations[index + 1].value + anim_time
        end
    end
    
    -- clamp animation [0, 1]
    if tabs_animations[index + 1].value < 0 then
        tabs_animations[index + 1].value = 0
    end

    if tabs_animations[index + 1].value > 1 then
        tabs_animations[index + 1].value = 1
    end

    -- animate text X position
    text_pos.x = text_pos.x + (text_move_size * tabs_animations[index + 1].value)

    -- draw text
    local text_color = LerpColor(color.new(255, 255, 255, 255), MenuClass.main_color, tabs_animations[index + 1].value_background)
    render.draw_text(fonts.menu, text_pos.x, text_pos.y, text_color, label)
end

function do_checkbox(label, var)
    if variables[var] == nil then
        variables[var] = CVariable:new()
    end

    variables[var]:set_type("bool")

    local draw_pos = {
        x = MenuClass.pos.x + MenuClass.cursor_pos.x,
        y = MenuClass.pos.y + MenuClass.cursor_pos.y
    }

    local label_text_size = {
        w = render.get_text_width(fonts.objects, label),
        h = fonts.objects_height
    }

    local hovered_checkbox = is_hovered({x = draw_pos.x, y = draw_pos.y, w = 20 + label_text_size.w + 4, h = 20})

    if is_key_down(1) then
        if not MenuClass.last_left_clicked then
            if hovered_checkbox then
                if MenuClass.current_selected_var == "" and combobox_helper_opened_variables.var == ""then
                    MenuClass.current_selected_var = var
                end
            end
        end
    else
        if MenuClass.current_selected_var == var then
            if hovered_checkbox then
                variables[var]:set_value_bool(not variables[var]:get_value_bool())
            end

            MenuClass.current_selected_var = ""
        end
    end

    render.draw_rect_filled(draw_pos.x, draw_pos.y, 20, 20, variables[var]:get_value_bool() and MenuClass.main_color or MenuClass.rect_color)
    render.draw_text(fonts.objects, draw_pos.x + 20 + 4, draw_pos.y + (20 / 2) - (label_text_size.h / 2), color.new(255, 255, 255, 255), label)
    
    MenuClass.cursor_pos.y = MenuClass.cursor_pos.y + 20 + MenuClass.spacing
end

function do_button(label)
    local ret = false

    local draw_pos = {
        x = MenuClass.pos.x + MenuClass.cursor_pos.x,
        y = MenuClass.pos.y + MenuClass.cursor_pos.y
    }

    local spaced_remaining_size_width = MenuClass.size.w - MenuClass.cursor_pos.x - MenuClass.spacing

    local button_area = {
        x = draw_pos.x,
        y = draw_pos.y,
        w = spaced_remaining_size_width * ( 3 / 8 ), -- the width would be 3/8 of the full width 
        h = fonts.objects_height + 8
    }

    local label_text_size = {
        w = render.get_text_width(fonts.objects, label),
        h = fonts.objects_height
    }

    local var_name = label .. "##Button"

    if is_key_down(1) then
        if not MenuClass.last_left_clicked then
            if is_hovered(button_area) then
                if MenuClass.current_selected_var == "" and combobox_helper_opened_variables.var == "" then
                    MenuClass.current_selected_var = var_name
                end
            end
        end
    else
        if MenuClass.current_selected_var == var_name then
            if is_hovered(button_area) then
                ret = true
            end

            MenuClass.current_selected_var = ""
        end
    end

    render.draw_rect_filled(button_area.x, button_area.y, button_area.w, button_area.h, MenuClass.current_selected_var == var_name and MenuClass.main_color or MenuClass.rect_color)
    render.draw_text(fonts.objects, button_area.x + (button_area.w / 2) - (label_text_size.w / 2), button_area.y + (button_area.h / 2) - (label_text_size.h / 2), color.new(255, 255, 255, 255), label)
    
    MenuClass.cursor_pos.y = MenuClass.cursor_pos.y + button_area.h + MenuClass.spacing
    return ret
end

local combobox_helper_opened_variables = {
    var = "",
    items = {},
    combobox_area = {x = 0, y = 0, w = 0, h = 0},
    current_selected_index = 0 -- selected index but used for input
}

local combobox_helper_state = {} -- input helper

function do_combobox(label, var, items)
    if variables[var] == nil then
        variables[var] = CVariable:new()
    end

    variables[var]:set_type("int")

    if variables[var]:get_value_int() < 1 then variables[var]:set_value_int(1) end
    if variables[var]:get_value_int() > #items then variables[var]:set_value_int(#items) end

    local draw_pos = {
        x = MenuClass.pos.x + MenuClass.cursor_pos.x,
        y = MenuClass.pos.y + MenuClass.cursor_pos.y
    }

    local label_text_size = {
        w = render.get_text_width(fonts.objects, label),
        h = fonts.objects_height
    }

    local selected_item_text_size = {
        w = render.get_text_width(fonts.objects, items[variables[var]:get_value_int()]),
        h = fonts.objects_height
    }

    local spaced_remaining_size_width = MenuClass.size.w - MenuClass.cursor_pos.x - MenuClass.spacing

    render.draw_text(fonts.objects, draw_pos.x + 1, draw_pos.y, color.new(255, 255, 255, 255), label)

    local combobox_area = {
        x = draw_pos.x,
        y = draw_pos.y + label_text_size.h + 2,
        w = spaced_remaining_size_width * ( 3 / 8 ), -- the width would be 3/8 of the full width 
        h = selected_item_text_size.h + 8
    }

    local hovered_combobox = is_hovered(combobox_area)

    if is_key_down(1) then
        if not MenuClass.last_left_clicked then
            if hovered_combobox then
                if MenuClass.current_selected_var == "" then
                    MenuClass.current_selected_var = var
                    combobox_helper_state[var] = true
                end
            end
        end
    else
        if combobox_helper_state[var] then
            if hovered_combobox then
                if combobox_helper_opened_variables.var == var then
                    combobox_helper_opened_variables.var = ""
                else
                    combobox_helper_opened_variables.var = var
                end
            end
        end

        combobox_helper_state[var] = false
    end

    if combobox_helper_opened_variables.var == var then
        -- update variables
        combobox_helper_opened_variables.items = items
        combobox_helper_opened_variables.combobox_area = {
            x = combobox_area.x,
            y = combobox_area.y,
            w = combobox_area.w,
            h = combobox_area.h
        }

    else
        if MenuClass.current_selected_var == var then
            MenuClass.current_selected_var = ""
        end
    end

    render.draw_rect_filled(combobox_area.x, combobox_area.y, combobox_area.w, combobox_area.h, MenuClass.rect_color)
    render.draw_text(fonts.objects, combobox_area.x + (combobox_area.w / 2) - (selected_item_text_size.w / 2), combobox_area.y + (combobox_area.h / 2) - (selected_item_text_size.h / 2), color.new(255, 255, 255, 255), items[variables[var]:get_value_int()])
   
    MenuClass.cursor_pos.y = MenuClass.cursor_pos.y + label_text_size.h + 2 + combobox_area.h + MenuClass.spacing
end

function draw_tab_objects(index)
    if selected_tab ~= index then
        return
    end

    local draw_pos = {
        x = MenuClass.pos.x + MenuClass.cursor_pos.x,
        y = MenuClass.pos.y + MenuClass.cursor_pos.y
    }
    
    --render.draw_rect_filled(draw_pos.x, draw_pos.y, ((MenuClass.size.w - MenuClass.tabs_selector_width) - (MenuClass.spacing * 2)), MenuClass.size.h - (MenuClass.spacing * 2), color.new(60,60,60,255))

    MenuClass.cursor_pos = {
        x = MenuClass.cursor_pos.x + MenuClass.spacing,
        y = MenuClass.cursor_pos.y + MenuClass.spacing
    }

    if selected_tab == 0 then
        -- Ragebot

        do_checkbox("Resolver", "resolver")
        do_checkbox("Backtrack Improvements", "bt_increse")
        do_checkbox("Lag Compensation", "do_lag_comp")
        do_combobox("DoubleTap Speed","dt_speed", {"Default", "Fast", "Instant"})
    elseif selected_tab == 1 then
        -- AntiAim
        do_checkbox("Enable Anti-Aim", "anti_aim_enable")
        do_combobox("Move State", "move_anti_aim_condition", {"Ideal Yaw", "Ideal Jitter", "Low Delta", "Advence Delta", "Random Jitter", "Switch", "Custom"})
        do_combobox("Slow State", "slow_anti_aim_condition", {"Ideal Yaw", "Ideal Jitter", "Low Delta", "Advence Delta", "Random Jitter", "Switch"})
        if variables["move_anti_aim_condition"]:get_value_int() == 7 then
            do_combobox("Custom Desync Type","custom_desync_type", {"Random", "Half Jitter", "Custom Bruteforce Angle", "Switch Custom Angle", "Safe Head"})
        end
        do_combobox("Fake Lag","fl_condition", {"Random", "Cycle"})
        do_combobox("Anti Brute Force","ab_force", {"Disable", "On Shot", "On Hit"})
        do_combobox("Jitter","jitter_conditions", {"None", "On Move", "In Air"})
        do_combobox("Legit Anti Aim","legit_aa", {"Default", "Jitter"})
        do_checkbox("Leg Breaker","leg_breaker")
        do_checkbox("At Targets In Air","at_in_air")
        do_checkbox("Pitch Zero On Land", "no_pitch")
    elseif selected_tab == 2 then
        -- Visuals
        do_combobox("Watermark", "wt_type", {"None", "SeaSide", "MetaMod"})
        do_combobox("Keybinds", "kb_type", {"None", "SeaSide", "Skeet"})
        do_combobox("Indicators", "indicators_type", {"None", "SeaSide", "Ideal Yaw"})
        do_combobox("Desync Arrows", "desync_arrows", {"None", "SeaSide", "TeamSkeet"})
        if variables["desync_arrows"]:get_value_int() == 2 then
            do_checkbox("Dynamic Desync Arrows", "dynamic_arrows")
        end
        do_combobox("Netgraph", "net_type", {"None", "SeaSide", "Skeet"})
        do_checkbox("Spectator List", "lua_spectator")
        do_checkbox("Holo Panel", "aa_debug")
        do_checkbox("Better Dormant", "bt_dormant")
        do_checkbox("Fog", "fog_enable")
        do_checkbox("Viewmodel On Scope", "vmode_scope")
        do_checkbox("Mindamage Above Crosshair", "dmg_show")
    elseif selected_tab == 3 then
        -- Misc
        do_combobox("Logs", "logs_type", {"None", "Console", "Under Crosshair"})
        do_combobox("Override Auto Peek", "apeek_override", {"On Shot", "Always"})
        do_checkbox("Custom Third Person Distance", "tpdist")
        if variables["tpdist"]:get_value_bool() == true then
            do_checkbox("Disable Camera Collision", "camcolision")
        end
        do_checkbox("Disable Panorama Blur", "no_blur")
        do_checkbox("Clantag", "do_clantag")
    elseif selected_tab == 4 then
        -- Config

        do_combobox("Select Config", "_ignore_config_index", {"1", "2", "3", "4", "5"})

        if do_button("Save Config") then
            save_config(variables["_ignore_config_index"]:get_value_int())
        end

        if do_button("Load Config") then
            load_config(variables["_ignore_config_index"]:get_value_int())
        end

        do_checkbox("Light Mode", "lua_light_mode")
    elseif developer and selected_tab == 5 then
        
    end
end

local function get_int(stringreference)
    if variables[stringreference] == nil then
        return -1
    else
        return variables[stringreference]:get_value_int() - 1
    end
end

local function get_bool(stringreference)
    if variables[stringreference] == nil then
        return false
    else
        return variables[stringreference]:get_value_bool()
    end
end

menuanimation = 0
togglemenu = false
client.add_callback("on_paint", function()
    if bUnloadedScript then
        return
    end

    -- Toggle menu on HOME
    if is_key_down(0x24) then
        last_pressed_home_key = true
    else
        if last_pressed_home_key then
            bMenuOpened = not bMenuOpened
        end

        last_pressed_home_key = false
    end

    if not bMenuOpened then 
        MenuClass.pressing_move_key = false
        MenuClass.can_move = false
        MenuClass.last_left_clicked = false
        combobox_helper_opened_variables.var = ""
        return
    end

    -- Update gui color
    --MenuClass.main_color = menu.get_color("Menu Color")

    -- todo (or maybe not): remove this when release done
    if updated_gui_color_already then
        MenuClass.main_color = menu.get_color("Menu Color")
    else
        local wanted_menu_color = menu.get_color("Menu Color")
        if wanted_menu_color:r() ~= 255 or wanted_menu_color:g() ~= 255 or wanted_menu_color:a() ~= 255 then
            updated_gui_color_already = true
            MenuClass.main_color = wanted_menu_color
        end
    end

    -- Constant 255 alpha for main color
    MenuClass.main_color = color.new(MenuClass.main_color:r(), MenuClass.main_color:g(), MenuClass.main_color:b(), 255)

    if is_key_down(1) then
        local cursor_pos = get_mouse_pos()
        if not MenuClass.pressing_move_key then
            local move_area = {
                x = MenuClass.pos.x,
                y = MenuClass.pos.y,
                w = MenuClass.tabs_selector_width,
                h = MenuClass.logo_size.h
                --h = MenuClass.size.h
            }

            MenuClass.move_click_offset = {
                x = cursor_pos.x - MenuClass.pos.x,
                y = cursor_pos.y - MenuClass.pos.y
            }

            MenuClass.can_move = is_hovered({x = move_area.x, y = move_area.y, w = move_area.w, h = move_area.h})
            MenuClass.pressing_move_key = true
        end

        if MenuClass.can_move then -- todo: when adding tabs, check if no tab is selected
            MenuClass.pos.x = (cursor_pos.x - MenuClass.move_click_offset.x)
            MenuClass.pos.y = (cursor_pos.y - MenuClass.move_click_offset.y)
        end
    else
        MenuClass.pressing_move_key = false
        MenuClass.can_move = false
    end

    local screen_size = vector.new(engine.get_screen_width(), engine.get_screen_height(), 0)

    -- clamp bounds on screen
    if MenuClass.pos.x < 0 then MenuClass.pos.x = 0 end
    if MenuClass.pos.y < 0 then MenuClass.pos.y = 0 end
    if MenuClass.pos.x + MenuClass.size.w > screen_size.x then MenuClass.pos.x = screen_size.x - MenuClass.size.w end
    if MenuClass.pos.y + MenuClass.size.h > screen_size.y then MenuClass.pos.y = screen_size.y - MenuClass.size.h end

    -- draw menu background
    local luamenu_bgcolor = 20
    local luamenu_opacity = 150
    local combobox_color = color.new()
    if get_bool("lua_light_mode") then
        luamenu_bgcolor = 255
        luamenu_opacity = 1
        combobox_color = color.new(100,100,100,255)
        if not updated_gui_color_already then
            MenuClass.rect_color = color.new(150,150,150, 50)
            MenuClass.main_color = color.new(169, 147, 220, 255)
        end 
    else
        luamenu_bgcolor = 20
        luamenu_opacity = 150
        combobox_color = MenuClass.rect_color
        if not updated_gui_color_already then
            MenuClass.rect_color = color.new(60,60,60, 255)
            MenuClass.main_color = color.new(123, 87, 201, 255)
        end
    end
    
    render.draw_rect_filled(MenuClass.pos.x, MenuClass.pos.y, MenuClass.size.w, MenuClass.size.h, color.new(luamenu_bgcolor,luamenu_bgcolor,luamenu_bgcolor,luamenu_opacity))

    -- draw logo (todo in future)
    --render.draw_rect_filled(MenuClass.pos.x, MenuClass.pos.y, MenuClass.logo_size.w, MenuClass.logo_size.h, color.new(100, 30, 30, 120))
    render.draw_text(fonts.logofont, MenuClass.pos.x + (MenuClass.logo_size.w / 2) - (render.get_text_width(fonts.logofont, "SeaSide") / 2), MenuClass.pos.y + (MenuClass.logo_size.h / 2) - (fonts.logofont_height / 2), MenuClass.main_color, "SeaSide" )

    -- handle tabs selector
    for i=1, #tabs, 1 do
        draw_tab(tabs[i], i - 1)
    end

    -- draw separator line between tabs and objects
    render.draw_line(
        MenuClass.pos.x + MenuClass.tabs_selector_width + (MenuClass.spacing / 2), 
        MenuClass.pos.y + MenuClass.spacing, 
        MenuClass.pos.x + MenuClass.tabs_selector_width + (MenuClass.spacing / 2), -- same X
        MenuClass.pos.y + MenuClass.size.h - MenuClass.spacing,
        MenuClass.main_color)

    MenuClass.cursor_pos.x = MenuClass.tabs_selector_width + MenuClass.spacing -- * 2 ???
    MenuClass.cursor_pos.y = MenuClass.spacing

    -- now draw tabs
    for i=1, #tabs, 1 do
        draw_tab_objects(i - 1)
    end

    -- handle comboboxes after every other item to draw it on top
    if combobox_helper_opened_variables.var ~= "" then
        local items_arr_size = #combobox_helper_opened_variables.items

        local select_area_h = (fonts.objects_height + 4) * items_arr_size

        local combobox_select_area = {
            x = combobox_helper_opened_variables.combobox_area.x, 
            y = combobox_helper_opened_variables.combobox_area.y + 4 + combobox_helper_opened_variables.combobox_area.h, 
            w = combobox_helper_opened_variables.combobox_area.w, 
            h = select_area_h
        }

        render.draw_rect_filled(combobox_select_area.x, combobox_select_area.y, combobox_select_area.w, combobox_select_area.h, combobox_color)

        local current_pos = {
            x = combobox_select_area.x,
            y = combobox_select_area.y + 2
        }

        local pressed_click = is_key_down(1)
        
        for i=1,items_arr_size,1 do
            local item_label_text_size = {
                w = render.get_text_width(fonts.objects, combobox_helper_opened_variables.items[i]),
                h = fonts.objects_height
            }

            local item_area = {
                x = current_pos.x,
                y = current_pos.y,
                w = combobox_select_area.w,
                h = item_label_text_size.h
            }

            local text_col = color.new(220, 220, 220, 255)
            if variables[combobox_helper_opened_variables.var]:get_value_int() == i then
                --text_col = color.new(255, 0, 0, 255)
                text_col = MenuClass.main_color
            end

            if pressed_click and not MenuClass.last_left_clicked then
                if is_hovered(item_area) then
                    variables[combobox_helper_opened_variables.var]:set_value_int(i)
                end
            end

            --render.draw_rect_filled(item_area.x, item_area.y, item_area.w, item_area.h, color.new(60, 60, 60, 255))
            render.draw_text(fonts.objects, item_area.x + (item_area.w / 2) - (item_label_text_size.w / 2), item_area.y + (item_area.h / 2) - (item_label_text_size.h / 2), text_col, combobox_helper_opened_variables.items[i])

            current_pos.y = current_pos.y + item_label_text_size.h + 4
        end

        if pressed_click and not MenuClass.last_left_clicked and not is_hovered({x = combobox_select_area.x, y = combobox_helper_opened_variables.combobox_area.y, w = combobox_select_area.w, h = (current_pos.y - combobox_helper_opened_variables.combobox_area.y)}) then
            combobox_helper_opened_variables.var = ""
        end
    end
        
    if is_key_down(1) then
        MenuClass.last_left_clicked = true
    else
        MenuClass.last_left_clicked = false
    end

end)

local screen = {
    w = engine.get_screen_width(),
    h = engine.get_screen_height(),
    half_w = engine.get_screen_width()/2,
    half_h = engine.get_screen_height()/2
}

menu.add_slider_int("Jitter Value", 1,32)
menu.add_slider_int("Minimum Fake Lag Value", 1,16)
menu.add_slider_int("Break Fake Lag Value",16,32)
menu.add_slider_int("Custom Desync Delta",1,60)
menu.add_slider_int("Second Desync Delta",1,60)
menu.add_slider_int("Third Person Distance", 30, 150)
menu.next_line()
menu.add_key_bind("Legit Anti Aim")
menu.next_line()
menu.add_key_bind("Edge Yaw")
menu.next_line()
menu.add_key_bind("Fake Flick")
menu.next_line()
menu.add_color_picker("Main Color")
menu.add_color_picker("Fog Color")
menu.add_slider_float( "Start Distance", 0, 1000 )
menu.add_slider_float( "End Distance", 0, 5000 )
menu.add_slider_float( "Density", 0, 100  )

surface = ffi.cast(ffi.typeof("void***"), utils.create_interface("vguimatsurface.dll", "VGUI_Surface031"))
set_color = ffi.cast(ffi.typeof('void(__thiscall*)(void*, int,int,int,int)'), surface[0][15])
filled_rect = ffi.cast(ffi.typeof('void(__thiscall*)(void*, int,int,int,int)'), surface[0][16])
filled_rect_fade = ffi.cast(ffi.typeof('void(__thiscall*)(void*, int,int,int,int,int,int,bool)'), surface[0][123])

local function gradient_rect(x,y,x1,y1,color,reversed, customalpha)
    if not reversed then
        set_color(surface,0,0,0,color:a())
        filled_rect_fade(surface,x,y,x1+2,y1,120,0,true)
        if customalpha then
            set_color(surface,color:r(),color:g(),color:b(),color:a())
        else
            set_color(surface,color:r(),color:g(),color:b(),35)
        end
        filled_rect_fade(surface,x,y,x1,y1,163,0,true)
    else
        set_color(surface,0,0,0,color:a())
        filled_rect_fade(surface,x-2,y,x1,y1,0,120,true)
        if customalpha then
            set_color(surface,color:r(),color:g(),color:b(),color:a())
        else
            set_color(surface,color:r(),color:g(),color:b(),35)
        end
        filled_rect_fade(surface,x,y,x1,y1,0,163,true)
    end
end

local kb_position_x = 50
local kb_position_y = 400

local drg = 0;
function drag(x, y, w, h)
    local mouse_pos = get_mouse_pos()
    if mouse_pos.x >= x then
        if mouse_pos.x <= x + w then
            if mouse_pos.y <= y + h then
                if mouse_pos.y >= y then
                    if is_key_down(1) and (drg == 0) then
                    drg = 1;
                    memoryx = x - mouse_pos.x
                    memoryy = y - mouse_pos.y
                    end
                end
            end
        end
    end
    if not is_key_down(1) then
        drg = 0
    end
    if (drg == 1) then
        kb_position_x = mouse_pos.x+memoryx
        kb_position_y = mouse_pos.y+memoryy
    end
end


local entity_list_ptr = ffi.cast("void***", utils.create_interface("client.dll", "VClientEntityList003"))
local get_client_entity_fn = ffi.cast("GetClientEntity_4242425_t", entity_list_ptr[0][3])

local ffi_helpers = {
    get_entity_address = function(ent_index)
        local addr = get_client_entity_fn(entity_list_ptr, ent_index)
        return addr
    end
}
local distance,pl_orig,ent,player,e_orig,viewoffset,newang
local function dist(x,y,z,x1,y1,z1)
    return math.sqrt(math.pow((x1-x),2)+math.pow((y1-y),2)+math.pow((z1-z),2))
end


function getoverride(Value)
    return menu.get_int("rage.weapon[" .. Value .. "].force_damage_valueuee")
end

function getdamage(Value)
    return menu.get_int("rage.weapon[" .. Value .. "].minimum_damage  e")
end

eyepos = {0,0,0}

local last_choke = 0
function indicators()
    if not entitylist.get_local_player() then return end
    local total_velocity = entitylist.get_local_player():get_velocity():length_2d()
    local color = menu.get_color("Main Color")

    local keybinds = {}
    keybinds.is_active = false
    keybinds.name = ""
    keybinds.color = color.new()

    if menu.get_key_bind_state( "anti_aim.fake_duck_key" ) then
        table.insert(keybinds, {is_active = menu.get_key_bind_state( "rage.double_tap_key" ), name = "DT", color = color.new(255, 0, 30), kbname = "Double Tap", kbtype = menu.get_key_bind_mode("rage.double_tap_key"), ind = "DT", otclr = color.new(255,0,0), idealclr = color.new(242, 30, 15)})
    else
        table.insert(keybinds, {is_active = menu.get_key_bind_state( "rage.double_tap_key" ), name = "DT", color = color.new(250,250,250),kbname = "Double Tap", kbtype = menu.get_key_bind_mode("rage.double_tap_key"), ind = "DT", otclr = color.new(255,255,255), idealclr = color.new(132, 200, 16)})
    end
    table.insert(keybinds, {is_active = menu.get_key_bind_state( "rage.hide_shots_key" ), name = "ONSHOT", color = color.new(132, 200, 16),kbname = "Hide Shots", kbtype = menu.get_key_bind_mode("rage.hide_shots_key"), ind = "HS", otclr = color.new(255,255,255), idealclr = color.new(93, 146, 252)})
    table.insert(keybinds, {is_active = menu.get_key_bind_state( "rage.force_damage_key" ), name = "DAMAGE", color = color.new(132, 200, 16), kbname = "Minimum Damage", kbtype = menu.get_key_bind_mode("rage.force_damage_key"), ind = "DMG", otclr = color.new(255,255,255), idealclr = color.new(255, 185, 5)})
    table.insert(keybinds, {is_active = menu.get_key_bind_state( "misc.automatic_peek_key" ), name = "PEEK", color = color.new(132, 200, 16), kbname = "Automatic Peek", kbtype = menu.get_key_bind_mode("misc.automatic_peek_key"), ind = nil, otclr = color.new(255,255,255)})
    table.insert(keybinds, {is_active = menu.get_key_bind_state( "anti_aim.fake_duck_key" ), name = "DUCK", color = color.new(211,211,211),kbname = "Fake Duck", kbtype = menu.get_key_bind_mode("anti_aim.fake_duck_key"), ind = nil, otclr = color.new(255,0,0), idealclr = color.new(255,255,255)})

    if get_int("kb_type") == 2 then
        table.insert(keybinds, {is_active = menu.get_bool("anti_aim.enable_fake_lag"), name = "CHOKE: " .. menu.get_int("anti_aim.fake_lag_limit"), color = color.new(211,211,211)})
        local bg_color = color.new(20,20,20,50)

        local spacing = 0
        for i=1,#keybinds,1 do
            local name = keybinds[i].name
            local is_active = keybinds[i].is_active
        
            if ( is_active ) then
                local text_width = render.get_text_width(fonts.skeet_indicators, name)
                gradient_rect(15,screen.half_h + 25 + spacing + 150,15+(text_width/2),screen.half_h + 55+ spacing + 150,bg_color,true, false)
                gradient_rect(15+(text_width/2),screen.half_h + 25 + spacing + 150,15+text_width,screen.half_h + 55+ spacing + 150,bg_color,false, false)
                render.draw_text( fonts.skeet_indicators, 25, screen.half_h + 27 + spacing + 150, keybinds[i].color, name )
                spacing = spacing + 35 -- that 25 is font height
            end
        end
    end

    if get_int("kb_type") == 1 then
        local drag_x = kb_position_x
        local drag_y = kb_position_y
        local drag_w = 150
        local drag_h = 20
        gradient_rect(drag_x, drag_y - 2, drag_x + drag_w/2, drag_y, color.new(color:r(),color:g(),color:b(),255), true,true)
        gradient_rect(drag_x + drag_w/2, drag_y - 2, drag_x + drag_w, drag_y, color.new(color:r(),color:g(),color:b(),255),false,true)
        --render.draw_rect_filled(drag_x, drag_y, drag_w, drag_h, color.new(20,20,20,80))
        render.draw_text(fonts.verdana,drag_x + drag_w/2 - render.get_text_width(fonts.verdana, "keybinds")/2, drag_y + drag_h/2 - 7, color.new(255,255,255), "keybinds")
        local spacing = 0
        for i=1,#keybinds,1 do
            local name = keybinds[i].kbname
            local is_active = keybinds[i].is_active
        
            local kbstatus
            if keybinds[i].kbtype == 0 then kbstatus = "[Always On]" end
            if keybinds[i].kbtype == 1 then kbstatus = "[Hold]" end
            if keybinds[i].kbtype == 2 then kbstatus = "[Toggle]" end
            
            if ( is_active ) then
                render.draw_text( fonts.kbverdana, drag_x + 3, drag_y + 21 + spacing, color.new(255,255,255), name )
                render.draw_text( fonts.kbverdana, drag_x - 3 + drag_w - render.get_text_width(fonts.kbverdana, kbstatus), drag_y + 21 + spacing, color.new(255,255,255), kbstatus)
                spacing = spacing + 15 -- that 25 is font height
            end
        end
        drag(drag_x, drag_y, drag_w, drag_h)
    end

    local synced_dsy_delta = 0
    if menu.get_key_bind_state("anti_aim.invert_desync_key") then
        synced_dsy_delta = math.min(menu.get_int("anti_aim.desync_range_inverted"))
    else
        synced_dsy_delta = math.min(menu.get_int("anti_aim.desync_range"))
    end

    if get_int("indicators_type") == 1 then
        if menu.get_key_bind_state("anti_aim.invert_desync_key") then
            render.draw_text(fonts.smallpixel,screen.half_w - render.get_text_width(fonts.smallpixel, "Sea") - 3, screen.half_h + 15, color,"Sea")
            render.draw_text(fonts.smallpixel,screen.half_w - 3, screen.half_h + 15, color.new(255,255,255),"Side")
        else
            render.draw_text(fonts.smallpixel,screen.half_w - render.get_text_width(fonts.smallpixel, "Sea") - 3, screen.half_h + 15, color.new(255,255,255),"Sea")
            render.draw_text(fonts.smallpixel,screen.half_w - 3, screen.half_h + 15, color,"Side")
        end
        if menu.get_int("anti_aim.desync_type") ~= 0 then
            gradient_rect(screen.half_w , screen.half_h + 33, screen.half_w + synced_dsy_delta * 0.6, screen.half_h + 36, color.new(255,255,255), false, true)
            gradient_rect(screen.half_w - synced_dsy_delta * 0.6, screen.half_h + 33, screen.half_w, screen.half_h + 36, color.new(255,255,255), true,true)
        end
        local status = "STAND"
        if is_key_down(0x20) then status = "IN-AIR"
        elseif menu.get_key_bind_state("Edge Yaw") then status = "EDGE YAW"
        elseif menu.get_key_bind_state("Legit Anti Aim") then status = "LEGIT AA"
        elseif menu.get_key_bind_state("anti_aim.fake_duck_key") then status = "FAKE DUCK"
        elseif is_key_down(0x11) then status = "CROUCH"
        elseif not menu.get_key_bind_state("misc.slow_walk_key") and is_key_down(0x10) then status = "SLOW"
        elseif menu.get_key_bind_state("misc.slow_walk_key") then status = "SLOW WALK"
        elseif total_velocity > 5 then status = "MOVE"
        else status = "STAND" end
        render.draw_text(fonts.indismall, screen.half_w - (render.get_text_width(fonts.indismall, status)/2) + 1, screen.half_h + 34, color.new(255,255,255), status)
        local spacing = 0
        for i=1,#keybinds,1 do
            local name = keybinds[i].ind
            local is_active = keybinds[i].is_active

            if ( is_active ) and name ~= nil then
                render.draw_text(fonts.indismall, screen.half_w - render.get_text_width(fonts.indismall, name)/2 + 1, screen.half_h + 42 + spacing, keybinds[i].otclr, name)
                spacing = spacing + 9
            end
        end
    end

    if get_int("indicators_type") == 2 then
        render.draw_text(fonts.idealfont, screen.half_w + 2, screen.half_h + 20, color.new(245, 160, 70), "IDEAL YAW")
        local antiaimtypes = "DEFAULT"
        local antiaimmove = get_int("move_anti_aim_condition")
        local antiaimslow = get_int("slow_anti_aim_condition")
        if menu.get_key_bind_state("Legit Anti Aim") then
            antiaimtypes = "LEGIT AA" 
        elseif menu.get_key_bind_state("anti_aim.fake_duck_key") then antiaimtypes = "FAKE DUCK"
        else
            if not menu.get_key_bind_state("misc.slow_walk_key") then
                if antiaimmove == 0 then antiaimtypes = "DYNAMIC" end
                if antiaimmove == 1 then antiaimtypes = "DYNAMIC+" end
                if antiaimmove == 2 then antiaimtypes = "LOW DELTA" end
                if antiaimmove == 3 then antiaimtypes = "LOW DELTA+" end
                if antiaimmove == 4 then antiaimtypes = "RANDOM" end
                if antiaimmove == 5 then antiaimtypes = "SWITCH" end
                if antiaimmove == 6 then antiaimtypes = "CUSTOM" end
            else
                if antiaimslow == 0 then antiaimtypes = "DYNAMIC" end
                if antiaimslow == 1 then antiaimtypes = "DYNAMIC+" end
                if antiaimslow == 2 then antiaimtypes = "LOW DELTA" end
                if antiaimslow == 3 then antiaimtypes = "LOW DELTA+" end
                if antiaimslow == 4 then antiaimtypes = "RANDOM" end
                if antiaimslow == 5 then antiaimtypes = "SWITCH" end
            end
        end
        render.draw_text(fonts.idealfont, screen.half_w + 2, screen.half_h + 31, color.new(200, 170, 255), antiaimtypes)
        local spacing = 0
        for i=1,#keybinds,1 do
            local name = keybinds[i].ind
            local is_active = keybinds[i].is_active

            if (is_active) and name ~= nil then
                render.draw_text(fonts.idealfont, screen.half_w + 2, screen.half_h + 41 + spacing, keybinds[i].idealclr, name)
                spacing = spacing + 11
            end
        end
    end

    if get_int("desync_arrows") == 1 then
        local constantvelocity = 0
        if get_bool("dynamic_arrows") then
            constantvelocity = total_velocity
        else
            constantvelocity = 0
        end
        if menu.get_key_bind_state("anti_aim.invert_desync_key") then
            render.draw_text( fonts.arrowsfont, screen.half_w - 13 - 45 - math.floor(constantvelocity/9), screen.half_h + 45 - 59, color, "<" )
            render.draw_text( fonts.arrowsfont, screen.half_w - 13 + 55 + math.floor(constantvelocity/9), screen.half_h + 45 - 59, color.new(60,60,60,255), ">" )
        else
            render.draw_text( fonts.arrowsfont, screen.half_w - 13 + 55 + math.floor(constantvelocity/9), screen.half_h + 45 - 59, color, ">" )
            render.draw_text( fonts.arrowsfont, screen.half_w - 13 - 45 - math.floor(constantvelocity/9), screen.half_h + 45 - 59, color.new(60,60,60,255), "<" )
        end
        if menu.get_key_bind_state( "anti_aim.manual_left_key" ) then
            render.draw_text( fonts.arrowsfont, screen.half_w - 13 - 60 - math.floor(constantvelocity/9), screen.half_h + 45 - 59, color, "<" )
        elseif menu.get_key_bind_state( "anti_aim.manual_right_key" ) then
            render.draw_text( fonts.arrowsfont, screen.half_w - 13 + 70 + math.floor(constantvelocity/9), screen.half_h + 45 - 59, color, ">" )
        end
    end

    if get_int("desync_arrows") == 2 then
        if menu.get_key_bind_state("anti_aim.invert_desync_key") then
            render.draw_text( fonts.arrow2, screen.half_w + 48, screen.half_h  - 13.5, color.new(56, 56, 56, 150), "|" )
            render.draw_text( fonts.arrow2, screen.half_w - 52, screen.half_h  - 13.5, color, "|" )
        else
            render.draw_text( fonts.arrow2, screen.half_w - 52, screen.half_h  - 13.5, color.new(56, 56, 56, 150), "|" )
            render.draw_text( fonts.arrow2, screen.half_w + 48, screen.half_h - 13.5, color, "|" )
        end
        if menu.get_key_bind_state( "anti_aim.manual_left_key" ) then
            render.draw_text( fonts.arrow, screen.half_w - 71, screen.half_h - 26, color, "◀" )
            render.draw_text( fonts.arrow, screen.half_w + 53, screen.half_h - 26, color.new(56, 56, 56, 150), "▶" )
        elseif menu.get_key_bind_state( "anti_aim.manual_right_key" ) then
            render.draw_text( fonts.arrow, screen.half_w + 53, screen.half_h - 26, color, "▶" )
            render.draw_text( fonts.arrow, screen.half_w - 71, screen.half_h - 26, color.new(56, 56, 56, 150), "◀" )
        else
            render.draw_text( fonts.arrow, screen.half_w + 53, screen.half_h - 26, color.new(56, 56, 56, 150), "▶" )
            render.draw_text( fonts.arrow, screen.half_w - 71, screen.half_h - 26, color.new(56, 56, 56, 150), "◀" )
        end
    end

    if get_int("wt_type") ~= 0 then
        local ping = tostring(globals.get_ping())
        local serveradress = tostring(globals.get_server_address())
        local username = globals.get_username()
        local time = os.date("%X")

        local text = nil
        if get_int("wt_type") == 1 then
            text = "SeaSide / " .. username .. " / " .. serveradress .. " / latency: " .. ping .. " / " .. time
        elseif get_int("wt_type") == 2 then
            text = "seaside | " .. username .. " | " .. serveradress .. " | latency: " .. ping .. " | " .. time
        end

        local textsize = nil
        if text ~= nil then
            textsize = render.get_text_width(fonts.objects, text)
        end

        if get_int("wt_type") == 1 then
            gradient_rect(screen.w - textsize - 30, 1, screen.w, 20, color, true, true)
            render.draw_text(fonts.objects, screen.w - textsize - 7, 3, color.new(255,255,255), text)
        elseif get_int("wt_type") == 2 then
            render.draw_rect_filled( screen.w - textsize - 20, 8, screen.w, 2, color )
            render.draw_rect_filled( screen.w - textsize - 20, 10, screen.w, 18, color.new(20, 20, 20, 100) )
            render.draw_text(fonts.objects, screen.w - textsize - 10, 12, color.new(255,255,255), text)
        end
    end

    if get_int("vmode_scope") then
        console.set_float("fov_cs_debug", 90 )
    elseif not get_int("vmode_scope") then
        console.set_float("fov_cs_debug", 0)
    end

    if get_int("net_type") == 1 then
        lagtext = "unsafe"
        lagcolor = color.new(255,255,255)
        if menu.get_key_bind_state( "rage.double_tap_key" ) or menu.get_key_bind_state( "rage.hide_shots_key" ) then lagtext = "broken" lagcolor = color.new(0, 255, 30)
        else lagtext = "unsafe" lagcolor = color.new(255,50,50)
        end
        render.draw_text(fonts.lefont, screen.half_w - (render.get_text_width(fonts.lefont, "Clocksync: 0%  (+- 0.2ms)")/2), screen.h - 80, color.new(255,255,255,alpha), "Clocksync: 0%  (+- 0.2ms)")
        render.draw_text(fonts.lefont, screen.half_w - (render.get_text_width(fonts.lefont, "lagcomp: " .. lagtext)/2), screen.h - 64, lagcolor, "lagcomp: " .. lagtext)
        render.draw_text(fonts.lefont, screen.half_w - (render.get_text_width(fonts.lefont, "delay: " .. tostring(globals.get_ping()) .." ms")/2), screen.h - 48, color.new(255,255,255), "delay: " .. tostring(globals.get_ping() .." ms"))
        render.draw_text(fonts.lefont, screen.half_w - (render.get_text_width(fonts.lefont, "velocity: " .. tostring(math.floor(total_velocity)) .." u/s fps: " .. tostring(math.floor(1 / globals.get_frametime())))/2), screen.h - 32, color.new(255,255,255), "velocity: " .. tostring(math.floor(total_velocity)) .." u/s fps: " .. tostring(math.floor(1 / globals.get_frametime())))
        render.draw_text(fonts.lefont, screen.half_w - (render.get_text_width(fonts.lefont, "tickrate: " .. tostring(math.floor(1 / globals.get_intervalpertick())) .. " time: " .. tostring(os.date("%X",os.time())))/2), screen.h - 16, color.new(255,255,255), "tickrate: " .. tostring(math.floor(1 / globals.get_intervalpertick())) .. " time: " .. tostring(os.date("%X",os.time())))
    end
    alpha = 1.1
    alpha = math.min(math.floor(math.sin((globals.get_realtime() % 3) * 4) * 125 + 200), 255)
    if get_int("net_type") == 2 then
        render.draw_text( fonts.font7, screen.half_w - 80, screen.half_h + ( 50 * 7 ), color.new(255, 255, 255, alpha), "clock syncing")
        render.draw_text( fonts.font7, screen.half_w - 80 + 95, screen.half_h + ( 50 * 7 ), color.new(255, 255, 255), "+-" .. tostring(globals.get_ping()) .."ms")
        render.draw_text( fonts.font7, screen.half_w - 80 + 73, screen.half_h + ( 50 * 7 ), color.new(255,200,95,255), "  !  " )
        render.draw_text( fonts.font7, screen.half_w - 80, screen.half_h + ( 50 * 7 ) + 20, color.new(255, 255, 255), "in : 31.70k/s")
        render.draw_text( fonts.font7, screen.half_w - 80 + 75, screen.half_h + ( 50 * 7 ) + 20, color.new(255,125,95), "lerp " ..tostring(globals.get_ping()).. "ms")
        render.draw_text( fonts.font7, screen.half_w - 80, screen.half_h + ( 50 * 7 ) + 40, color.new(255, 255, 255), "out: 9.08k/s")
        render.draw_text( fonts.font7, screen.half_w - 80, screen.half_h + ( 50 * 7 ) + 60, color.new(255, 255, 255), "sv: 6.38 +- 0.02ms var 0.022 ms")
        render.draw_text( fonts.font7, screen.half_w - 80, screen.half_h + ( 50 * 7 ) + 80, color.new(255, 255, 255), "tick: "..tostring(math.floor(1 / globals.get_intervalpertick())).."p/s")
        render.draw_text( fonts.font7, screen.half_w - 80, screen.half_h + ( 50 * 7 ) + 100, color.new(255,125,95), "delay "..tostring(globals.get_ping()).." (+- 1m/s)")
        render.draw_text( fonts.font7, screen.half_w - 80 + 105, screen.half_h + ( 50 * 7 ) + 100, color.new(255,50,50), "datagram")
    	render.draw_text( fonts.font7, screen.half_w - 80 + 35, screen.half_h + ( 50 * 7 ) + 140, color.new(255, 255, 255, alpha), "lagcomp ")
    	if menu.get_key_bind_state( "rage.double_tap_key" ) or menu.get_key_bind_state( "rage.hide_shots_key" ) then
    	    render.draw_text( fonts.font7, screen.half_w - 80 + 85, screen.half_h + ( 50 * 7 ) + 140, color.new(0, 255, 30), "broken")
    	else
    	    render.draw_text( fonts.font7, screen.half_w - 80 + 85, screen.half_h + ( 50 * 7 ) + 140, color.new(255,50,50), "unsafe")
    	end
    end

    if get_bool("bt_dormant") then
        local localplayer = entitylist.get_local_player()
        if not localplayer then return end
        local tp_dist = menu.get_int( "misc.third_person_distance" )
        
        pl_orig = ffi.cast("Vector_t*",ffi_helpers.get_entity_address(localplayer:get_index())+312)
        for i=1, globals.get_maxclients() do
             ent = entitylist.get_player_by_index(i)
             player = entitylist.entity_to_player(ent)
            if ent == nil then goto continue end
            if player:get_health() < 1 or player:get_team() == localplayer:get_team() then goto continue end
             e_orig = ffi.cast("Vector_t*",ffi_helpers.get_entity_address(player:get_index())+312)

             if menu.get_key_bind_state( "misc.third_person_key" ) then
                distance = tp_dist + dist(pl_orig.x,pl_orig.y,pl_orig.z,e_orig.x,e_orig.y,e_orig.z)
             else
                distance = dist(pl_orig.x,pl_orig.y,pl_orig.z,e_orig.x,e_orig.y,e_orig.z)
             end

             if distance ~= nil then
                 viewoffset = ffi.cast("Vector_t*",ffi_helpers.get_entity_address(player:get_index())+264)
                 eyepos[1] = e_orig.x + viewoffset.x
                 eyepos[2] = e_orig.y + viewoffset.y
                 eyepos[3] = e_orig.z + viewoffset.z
                 newang = render.world_to_screen( vector.new(eyepos[1], eyepos[2],eyepos[3]) )
                 if newang.x ~= 0 and newang.y ~= 0 then
                    if player:get_dormant() == true then
                        render.draw_circle_filled( math.floor(math.floor(newang.x)), math.floor(math.floor(newang.y) - 2), 10 , 5, color )
                        render.draw_text(fonts.font, math.floor(math.floor(newang.x) - 12), math.floor(math.floor(newang.y) + 2), color, tostring(engine.get_player_info(i).name))
                        render.draw_text(fonts.font, math.floor(math.floor(newang.x) - 12), math.floor(math.floor(newang.y) + 10), color, "hp: " .. tostring(player:get_health()))
                    end
                end
            end
            ::continue::
        end
    end

    
    local position = render.world_to_screen(entitylist.get_local_player():get_origin())
    if get_bool("aa_debug") and menu.get_key_bind_state("misc.third_person_key") then
        e_orig = ffi.cast("Vector_t*",ffi_helpers.get_entity_address(entitylist.get_local_player():get_index())+312)
        viewoffset = ffi.cast("Vector_t*",ffi_helpers.get_entity_address(entitylist.get_local_player():get_index())+264)
        eyepos[1] = e_orig.x + viewoffset.x
        eyepos[2] = e_orig.y + viewoffset.y
        eyepos[3] = e_orig.z + viewoffset.z
        newang = render.world_to_screen( vector.new(eyepos[1], eyepos[2],eyepos[3]) )
        local defpos_x = position.x + 300
        local defpos_y = position.y - 300
        local sidetext = "<"
        local desyncangle = 0
        if menu.get_key_bind_state("anti_aim.invert_desync_key") then
            sidetext = ">"
            desyncangle = menu.get_int("anti_aim.desync_range_inverted")
        else
            sidetext = "<"
            desyncangle = menu.get_int("anti_aim.desync_range")
        end
        local osaa = ""
        local colorosaa = color.new()
        if menu.get_key_bind_state( "rage.double_tap_key" ) or menu.get_key_bind_state( "rage.hide_shots_key" ) then osaa = "ON" colorosaa = color.new(0,255,50)
        else osaa = "OFF" colorosaa = color.new(255,50,50)
        end
        render.draw_line(newang.x + 10, newang.y + 50, position.x + 300, position.y - 300, color.new(255,255,255,255))
        render.draw_rect_filled(defpos_x, defpos_y, 200,70,color.new(0,0,0,80))
        render.draw_rect_filled(defpos_x, defpos_y - 2, 200,2,color.new(color:r(),color:g(),color:b(),255))
        render.draw_text(fonts.fonttitle, defpos_x + 4, defpos_y + 4, color.new(255,255,255), "Anti-Aim Debug")
        render.draw_text(fonts.font10, defpos_x + 4, defpos_y + 22, color.new(255,255,255), "Side: ")
        render.draw_text(fonts.font10, defpos_x + 5 + render.get_text_width(fonts.font10, "Side: "), defpos_y + 22, color.new(color:r(),color:g(),color:b(),255), sidetext)
        render.draw_rect(defpos_x + 5, defpos_y + 52, 65, 15, color.new(20,20,20,200))
        render.draw_text(fonts.font7, defpos_x + 4, defpos_y + 39, color.new(255,255,255), "Desync:")
        gradient_rect(defpos_x + 7, defpos_y + 54, defpos_x + 7 + desyncangle, defpos_y + 54 + 11, color.new(color:r(),color:g(),color:b(),255), false, true)
        --render.draw_rect_filled(defpos_x + 7, defpos_y + 54, desyncangle, 11, color )
        render.draw_text(fonts.font7, defpos_x + 70, defpos_y + 53, color.new(255,255,255), desyncangle .. "°")
        render.draw_text(fonts.font7, defpos_x + 135, defpos_y + 53, color.new(255,255,255), "OSAA:")
        render.draw_text(fonts.font7, defpos_x + 135 + render.get_text_width(fonts.font7, "OSAA: "), defpos_y + 53, colorosaa, osaa)
    end


    if get_bool("no_blur") then
        console.set_int("@panorama_disable_blur", 1)
    else
        console.set_int("@panorama_disable_blur", 0)
    end

    if get_bool("dmg_show") and entitylist.get_local_player() ~= nil and entitylist.get_weapon_by_player(entitylist.get_local_player()) ~= nil  then
        local damagevalue = 1
        local holding = entitylist.get_weapon_by_player(entitylist.get_local_player()):get_class_name()
        
        if menu.get_key_bind_state("rage.force_damage_key") then
            if holding == "CWeaponSSG08" then
                damagevalue = getoverride(3)
            elseif holding == "CWeaponAWP" then
                damagevalue = getoverride(4)
            elseif holding == "CWeaponG3SG1" or holding == "CWeaponSCAR20" then
                damagevalue = getoverride(2)
            elseif holding == "CDEagle" then
                damagevalue = getoverride(0)
            elseif holding == "CWeaponHKP2000" or holding == "CWeaponElite" or holding == "CWeaponp250" or holding == "CWeaponFiveSeven" or holding == "CWeaponGlock" or holding == "CWeaponTec9" then
                damagevalue = getoverride(1)
            end
        else
            if holding == "CWeaponSSG08" then
                damagevalue = getdamage(3)
            elseif holding == "CWeaponAWP" then
                damagevalue = getdamage(4)
            elseif holding == "CWeaponG3SG1" or holding == "CWeaponSCAR20" then
                damagevalue = getdamage(2)
            elseif holding == "CDEagle" then
                damagevalue = getdamage(0)
            elseif holding == "CWeaponHKP2000" or holding == "CWeaponElite" or holding == "CWeaponp250" or holding == "CWeaponFiveSeven" or holding == "CWeaponGlock" or holding == "CWeaponTec9" then
                damagevalue = getdamage(1)
            end
        end 
        if damagevalue ~= nil and holding ~= "CKnife" and holding ~= "CDecoyGrenade" and holding ~= "CHEGrenade" and holding ~= "CFlashbang" and holding ~= "CWeaponTaser" and holding ~= "CIncendiaryGrenade" and holding ~= "CMolotovGrenade" then
            render.draw_text(fonts.font, screen.half_w + 8, screen.half_h - 25 , color.new(255, 255, 255), tostring(damagevalue))
        end 
    end

    if get_bool("fog_enable") then
        local fog_color = menu.get_color("Fog Color")
        console.set_string("fog_color", string.format("%i %i %i", fog_color:r(), fog_color:g(), fog_color:b()))
        distance1 = menu.get_float( "Start Distance" )
        distance2 = menu.get_float( "End Distance" )
        density = menu.get_float( "Density" )
        console.set_float("fog_override", 1)
        console.set_float("fog_start" , distance1 )
        console.set_float("fog_end" , distance2 )
        console.set_float("fog_maxdensity" , density / 100 )
        console.set_float( "r_3dsky", 0 )
    else
        console.set_float("fog_color", -1);
        console.set_float("fog_override", 0)
        console.set_float("fog_start", -1)
        console.set_float("fog_end", -1)
        console.set_float("fog_maxdensity", -1)
    end
end

reset_resolver = false

events.register_event( "round_start", function()
    reset_resolver = true
end)

misses = 0
function resolver(shot_info)
    local shot_result = shot_info.result
	local target = shot_info.target_index
    local bot = engine.get_player_info(target).bot

    if get_bool("resolver") then
        
        --bodyyaw = menu.get_int("player_list.player_settings["..target.."].body_yaw   ")
        --menu.set_int("player_list.player_settings["..target.."].body_yaw", 8)
    
        if shot_result == "Resolver" then
            misses = misses + 1
            if misses == 1 then
                menu.set_bool("player_list.player_settings["..target.."].force_body_yaw", true)
                menu.set_int("player_list.player_settings["..target.."].body_yaw", 8)
                menu.set_bool("player_list.player_settings["..target.."].force_safe_points", true)
                menu.set_bool("player_list.player_settings["..target.."].force_body_aim", false)
            end
            if misses == 2 then
                menu.set_int("player_list.player_settings["..target.."].body_yaw", -14)
            end
            if misses == 3 then
                menu.set_int("player_list.player_settings["..target.."].body_yaw", 7)
            end
            if misses == 4 then
                menu.set_int("player_list.player_settings["..target.."].body_yaw", -9)
            end
            if misses == 5 then
                menu.set_bool("player_list.player_settings["..target.."].force_body_yaw", false)
                menu.set_bool("player_list.player_settings["..target.."].force_body_aim", true)
                misses = 0
            end
        else
            misses = 0
        end

        --if shot_result == "Resolver" then
        --    misses = misses + 1
        --    if bodyyaw == 8 or bodyyaw == 0 and misses == 1 then
        --        menu.set_int("player_list.player_settings["..target.."].body_yaw", -14)
        --    elseif misses == 2 then
        --        menu.set_int("player_list.player_settings["..target.."].body_yaw", 7)
        --        misses = 0
        --    elseif misses == 1 then
        --        menu.set_int("player_list.player_settings["..target.."].body_yaw", -9)
        --        misses = 0
        --    elseif misses == 2 then
        --        menu.set_int("player_list.player_settings["..target.."].body_yaw", 8)
        --    end
        --else
        --    misses = 0
        --end
        
    else
        menu.set_int("player_list.player_settings["..target.."].body_yaw", 0)
        menu.set_bool("player_list.player_settings["..target.."].force_body_yaw", false)
    end
end

function disablebotresolver()
    for i = 1, globals.get_maxclients(), 1 do
        local ent = entitylist.get_player_by_index(i)
        if ent == nil then goto continue end
        local bot = engine.get_player_info(i).bot
        if bot == true then
            menu.set_bool("player_list.player_settings["..i.."].force_body_yaw", true)
            menu.set_int("player_list.player_settings["..i.."].body_yaw", 0)
            menu.set_bool("player_list.player_settings["..i.."].force_safe_points", true)
        end
        if reset_resolver then
            menu.set_bool("player_list.player_settings["..i.."].force_body_yaw", false)
            menu.set_bool("player_list.player_settings["..i.."].force_body_aim", false)
            menu.set_bool("player_list.player_settings["..i.."].force_safe_points", false)
            reset_resolver = false
        end
        ::continue::
    end
end

lagvalue = 0
switchvalue = 0

local function set_fakelag(lag)
    menu.set_int("anti_aim.fake_lag_limit",lag)
    menu.set_int("anti_aim.fake_lag_type", 0)
end

setdeltadesync = 0
desyncplus = 0
getmath = 0
int = 0
function antiaim()
    if not entitylist.get_local_player() then return end
    if menu.get_key_bind_state("Legit Anti Aim") then return end
    if menu.get_key_bind_state("Edge Yaw") then return end
    if menu.get_key_bind_state("Fake Flick") then return end
    if get_bool("anti_aim_enable") then
        if not menu.get_bool("anti_aim.enable") == true then menu.set_bool( "anti_aim.enable", true ) end
        if not menu.get_bool("anti_aim.enable_fake_lag") == true then menu.set_bool("anti_aim.enable_fake_lag",true) end

        local total_velocity = entitylist.get_local_player():get_velocity():length_2d() --math.sqrt
        local velocity = 0
        if total_velocity < 10 then velocity = 10 elseif total_velocity > 10 and total_velocity < 65 then velocity = 25 elseif total_velocity > 65 and total_velocity < 165 then velocity = 35 elseif total_velocity > 165 and total_velocity < 200 then velocity = 45 elseif total_velocity > 200 then velocity = 55 end

        local movestate = get_int("move_anti_aim_condition")
        local slowstate = get_int("slow_anti_aim_condition")
        local desync_delta = menu.get_int("Custom Desync Delta")
        local desync_type = get_int("custom_desync_type")
        --menu.set_int("anti_aim.pitch",1)
        menu.set_int("anti_aim.yaw_modifier", 0)
        if movestate ~= 5 and not menu.get_key_bind_state("Legit Anti Aim") then
            menu.set_int("anti_aim.yaw_offset", 0)
        end
        if menu.get_key_bind_state("misc.slow_walk_key") == true then
            if slowstate == 0 then menu.set_int("anti_aim.desync_type", 1) menu.set_int("anti_aim.desync_range", velocity) menu.set_int("anti_aim.desync_range_inverted", velocity) end
            if slowstate == 1 then menu.set_int("anti_aim.desync_type", 2) menu.set_int("anti_aim.desync_range", velocity) menu.set_int("anti_aim.desync_range_inverted", velocity) end
            if slowstate == 2 then menu.set_int("anti_aim.desync_type", 1) menu.set_int("anti_aim.desync_range", 15) menu.set_int("anti_aim.desync_range_inverted", 15) end
            if slowstate == 3 then menu.set_int("anti_aim.desync_type", 1) menu.set_int("anti_aim.desync_range", math.random(10,30)) menu.set_int("anti_aim.desync_range_inverted", math.random(10,30)) end
            if slowstate == 4 then menu.set_int("anti_aim.desync_type", 2) menu.set_int("anti_aim.desync_range", 40) menu.set_int("anti_aim.desync_range_inverted", 45) end
            if slowstate == 5 then menu.set_int("anti_aim.desync_type", 1) if switchvalue > 30 then menu.set_int("anti_aim.yaw_offset", math.random(-15,20)) menu.set_int("anti_aim.desync_range",math.random(28,38)) menu.set_int("anti_aim.desync_range_inverted",math.random(30,44)) menu.set_int("anti_aim.desync_type", math.random(1,2)) switchvalue = 0 else switchvalue = switchvalue + 1 end end
        end
        if menu.get_key_bind_state("misc.slow_walk_key") == false then
            if movestate == 0 then menu.set_int("anti_aim.desync_type", 1) menu.set_int("anti_aim.desync_range", velocity) menu.set_int("anti_aim.desync_range_inverted", velocity) end
            if movestate == 1 then menu.set_int("anti_aim.desync_type", 2) menu.set_int("anti_aim.desync_range", velocity) menu.set_int("anti_aim.desync_range_inverted", velocity) end
            if movestate == 2 then menu.set_int("anti_aim.desync_type", 1) menu.set_int("anti_aim.desync_range", 15) menu.set_int("anti_aim.desync_range_inverted", 15) end
            if movestate == 3 then menu.set_int("anti_aim.desync_type", 1) menu.set_int("anti_aim.desync_range", math.random(10,30)) menu.set_int("anti_aim.desync_range_inverted", math.random(10,30)) end
            if movestate == 4 then menu.set_int("anti_aim.desync_type", 2) menu.set_int("anti_aim.desync_range", 40) menu.set_int("anti_aim.desync_range_inverted", 45) end
            if movestate == 5 then menu.set_int("anti_aim.desync_type", 1) if switchvalue > 30 then menu.set_int("anti_aim.yaw_offset", math.random(-10,15)) menu.set_int("anti_aim.desync_range",math.random(28,38)) menu.set_int("anti_aim.desync_range_inverted",math.random(30,44)) menu.set_int("anti_aim.desync_type", math.random(1,2)) switchvalue = 0 else switchvalue = switchvalue + 1 end end
            if movestate == 6 then
                if desync_type == 0 then menu.set_int("anti_aim.desync_type", 1) menu.set_int("anti_aim.desync_range", math.random(1, desync_delta)) menu.set_int("anti_aim.desync_range_inverted", math.random(1, desync_delta)) end
                if desync_type == 1 then menu.set_int("anti_aim.desync_type", 2) menu.set_int("anti_aim.desync_range", math.floor(desync_delta/2)) menu.set_int("anti_aim.desync_range_inverted", math.floor(desync_delta/2)) end
                if desync_type == 2 then menu.set_int("anti_aim.desync_type", 1) if setdeltadesync == 0 then menu.set_int("anti_aim.desync_range", desync_delta) menu.set_int("anti_aim.desync_range_inverted", desync_delta) else if desyncplus > 300 then setdeltadesync = 0 desyncplus = 0 else menu.set_int("anti_aim.desync_range", menu.get_int("Second Desync Delta")) menu.set_int("anti_aim.desync_range_inverted", menu.get_int("Second Desync Delta")) desyncplus = desyncplus + 1 end end end
                if desync_type == 3 then menu.set_int("anti_aim.desync_type", 1) if getmath == 0 then menu.set_int("anti_aim.desync_range", desync_delta) menu.set_int("anti_aim.desync_range_inverted", desync_delta) getmath = 1 else menu.set_int("anti_aim.desync_range", menu.get_int("Second Desync Delta")) menu.set_int("anti_aim.desync_range_inverted", menu.get_int("Second Desync Delta")) getmath = 0 end end
                if desync_type == 4 then menu.set_int("anti_aim.desync_type", 1) menu.set_int("anti_aim.desync_range", 4) menu.set_int("anti_aim.desync_range_inverted", 60) menu.set_int( "anti_aim.target_yaw", 1 ) menu.set_bool("anti_aim.invert_desync_key", true) menu.set_int("anti_aim.yaw_offset", -10) end
            end
        end

        if get_bool("at_in_air") then
            if desync_type ~= 4 and get_int("move_anti_aim_condition") ~= 6 then
                if is_key_down(0x20) then
                    menu.set_int( "anti_aim.target_yaw", 1 )
                else
                    menu.set_int( "anti_aim.target_yaw", 0 )
                end
            end
        end
        
        if get_int("fl_condition") == 0 then set_fakelag(math.random(menu.get_int("Minimum Fake Lag Value"),16)) end
        if get_int("fl_condition") == 1 then
            if lagvalue ~= 17 then lagvalue = lagvalue + 1 else lagvalue = menu.get_int("Minimum Fake Lag Value") end
            menu.set_int("anti_aim.fake_lag_limit",lagvalue)
        end
        if get_int("fl_condition") ~= 2 then console.set_int("net_fakelag", 0) end
    end

    if get_bool("leg_breaker") then
        if globals.get_tickcount() % 5 == 0 then menu.set_int("misc.leg_movement", 2)
        else menu.set_int("misc.leg_movement", 1) end
    end

    
    
    if get_bool("no_pitch") then
        flag = entitylist.get_local_player():get_prop_int("CBasePlayer", "m_fFlags")

        if flag == 256 or flag == 262 then
            int = 0
        end

        if flag == 257 or flag == 261 or flag == 263 then
            int = int + 4
        end

        if int > 45 and int < 250 then
            menu.set_int("anti_aim.pitch", 0)
        elseif menu.get_key_bind_state("Legit Anti Aim") then
            menu.set_int("anti_aim.pitch", 0)
        else
            menu.set_int("anti_aim.pitch", 1)
        end
    end
end

function keybindstypes()
    if menu.get_key_bind_state("Legit Anti Aim") then 
        menu.set_int("anti_aim.pitch", 0)
        menu.set_int("anti_aim.yaw_offset", 180)
        if get_int("legit_aa") == 0 then
            menu.set_int("anti_aim.desync_type", 1)
            menu.set_int("anti_aim.desync_range", 60) 
            menu.set_int("anti_aim.desync_range_inverted", 60)
        elseif get_int("legit_aa") == 1 then
            menu.set_int("anti_aim.desync_type", 2)
            menu.set_int("anti_aim.desync_range", 60) 
            menu.set_int("anti_aim.desync_range_inverted", 60)
        end
    else
        menu.set_int("anti_aim.pitch", 1)
    end
    if menu.get_key_bind_state("Edge Yaw") then
        if menu.get_key_bind_state("Fake Flick") then menu.set_bool("anti_aim.edge_yaw", false) else menu.set_bool("anti_aim.edge_yaw", true) end
    else
        menu.set_bool("anti_aim.edge_yaw", false)
    end
    if menu.get_key_bind_state("Fake Flick") then 
        if menu.get_key_bind_state("Legit Anti Aim") then return end
        menu.set_int("anti_aim.desync_type", 3)
        menu.set_int("anti_aim.desync_range", math.random(50,60)) 
        menu.set_int("anti_aim.desync_range_inverted", math.random(50,60))
    end
end

fn_change_clantag = utils.find_signature("engine.dll", "53 56 57 8B DA 8B F9 FF 15")
set_clantag = ffi.cast("clantag_t", fn_change_clantag)

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

old_time = 0

local animation = {
    "  ",
    " 5 ",
    " S3 ",
    " Se4 ",
    " Sea5 ",
    " SeaS1 ",
    " SeaSi0 ",
    " SeaSid3 ",
    " SeaSide ",
    " SeaSide. ",
    " SeaSide.1 ",
    " SeaSide.l| ",
    " SeaSide.l|_ ",
    " SeaSide.l|_| ",
    " SeaSide.lu4 ",
    " SeaSide.lua ",
    " SeaSide.lu4 ",
    " SeaSide.l|_| ",
    " SeaSide.l|_ ",
    " SeaSide.l| ",
    " SeaSide.1 ",
    " SeaSide. ",
    " SeaSide ",
    " SeaSid3 ",
    " SeaSi0 ",
    " SeaS1 ",
    " Sea5 ",
    " Se4 ",
    " S3 ",
    " 5 ",
}
local remove = {
    "",
}
  
function clantag()
    if engine.is_in_game() then
	    if get_bool("do_clantag") then
            local curtime = math.floor(globals.get_curtime()*3)
            if old_time ~= curtime then
                set_clantag(animation[curtime % #animation+1], animation[curtime % #animation+1])
            end
            old_time = curtime
        else
            local curtime = math.floor(globals.get_curtime()*3)
            if old_time ~= curtime then
                set_clantag(remove[#remove], remove[#remove])
            end
            old_time = curtime
        end
    end
end

curpos = vector.new()
function setmovement(xz,yz,cmd)
    local local_player = entitylist.get_local_player()
    local current_pos = local_player:get_origin()
    local yaw = engine.get_view_angles().y

    local vector_forward = { 
        x = current_pos.x - xz,
        y = current_pos.y - yz,
    }
     
    local velocity = {
        x = -(vector_forward.x * math.cos(yaw / 180 * math.pi) + vector_forward.y * math.sin(yaw / 180 * math.pi)),
        y = vector_forward.y * math.cos(yaw / 180 * math.pi) - vector_forward.x * math.sin(yaw / 180 * math.pi),
    }
    cmd.forwardmove = velocity.x * 15
    cmd.sidemove = velocity.y * 15
end;

function autopeek(cmd)
    local localplayer = entitylist.get_local_player();
    local forw = bit.band(cmd.buttons, 8) == 8;
    local back = bit.band(cmd.buttons, 16) == 16;
    local righ = bit.band(cmd.buttons, 512) == 512;
    local left = bit.band(cmd.buttons, 1024) == 1024;
    local apeek = menu.get_key_bind_state( "misc.automatic_peek_key" );
    local originalpos = localplayer:get_origin();
    local OnGround = bit.band(localplayer: get_prop_int("CBasePlayer","m_hGroundEntity"), 1);

    if OnGround == 1 or bit.band(cmd.buttons, buttons.in_jump) == buttons.in_jump then -- air check
        air = true
    else
        air = false
    end
    if apeek == false then
        curpos = localplayer:get_origin();
    end
    if get_int("apeek_override") == 1 then
        if apeek == false then
            menu.set_bool( "misc.fast_stop", true );
        else
            if forw == false and back == false and left == false and righ == false and math.floor(curpos.x) ~= math.floor(originalpos.x) and math.floor(curpos.y) ~= math.floor(originalpos.y) and air == false then
                menu.set_bool( "misc.fast_stop", false );
                setmovement(curpos.x,curpos.y, cmd);
            else
                menu.set_bool( "misc.fast_stop", true );
            end
        end
    end
end

local logs = {}
function add_log(text, iskill)
    table.insert(logs, {text = text, dead = iskill , expiration = 5, fadein = 0})
end
local gpinf = engine.get_player_info

local function hitlog(shot_info)
    local results       = shot_info.result
    local target        = shot_info.target_index
    local targetname    = gpinf(target).name
    local serverdamage  = shot_info.server_damage
    local clientdamage  = shot_info.client_damage
    local serverhitbox  = shot_info.server_hitbox
    local clienthitbox  = shot_info.client_hitbox
    local hitchance     = shot_info.hitchance
    local backtrack     = shot_info.backtrack_ticks
    local safe          = tostring(shot_info.safe)
    local health_final  = entitylist.entity_to_player(entitylist.get_player_by_index(target)):get_health()
    local bodyyaw = menu.get_int("player_list.player_settings["..target.."].body_yaw   ")

    if get_int("logs_type") == 0 then return end
    if results == "Hit" then
        if health_final < 1 then
            add_log("Hit " .. targetname .. " for " .. serverdamage .. " in " .. serverhitbox .. " (" .. health_final .. ")", true)
            console_print_color(color.new(230,94,94,255),"SeaSide - Hit " .. targetname .. " for " .. serverdamage .. " damage in " .. serverhitbox .. " (backtrack: " .. backtrack .. "tick)\n")
        else
            add_log("Hit " .. targetname .. " for " .. serverdamage .. " in " .. serverhitbox .. " (" .. health_final .. ")", false)
            console_print_color(color.new(255,255,255,255),"SeaSide - Hit " .. targetname .. " for " .. serverdamage .. " damage in " .. serverhitbox .. " (backtrack: " .. backtrack .. "tick)\n")
        end
    elseif results == "Spread" then
        add_log("Miss " .. targetname .. " in " .. clienthitbox .. " due to spread ", false)
        console_print_color(color.new(255,255,255,255),"SeaSide - Miss " .. targetname .. " in " .. clienthitbox .. " due to spread (backtrack: " .. backtrack .. "tick)\n")
    elseif results == "Occlusion" then
        add_log("Miss " .. targetname .. " in " .. clienthitbox .. " due to occlusion ", false)
        console_print_color(color.new(255,255,255,255),"SeaSide - Miss " .. targetname .. " in " .. clienthitbox .. " due to occlusion (backtrack: " .. backtrack .. "tick)\n")
    elseif results == "Resolver" then
        add_log("Miss " .. targetname .. " in " .. clienthitbox .. " due to resolver ", false)
        console_print_color(color.new(255,255,255,255),"SeaSide - Miss " .. targetname .. " in " .. clienthitbox .. " due to resolver (backtrack: " .. backtrack .. "tick)\n")
    else
        add_log("Missed shot due to death ", false)
        console_print_color(color.new(255,255,255,255),"SeaSide - Miss " .. targetname .. " in " .. clienthitbox .. " due to death (backtrack: " .. backtrack .. "tick, safe: " .. safe ..")\n")
    end
end

local hitgroups = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }

function hurtevent(event)
    local localplayer = entitylist.get_local_player()
    if not localplayer then return end
    if get_int("logs_type") == 0 then return end

    local attacker = engine.get_player_for_user_id(event:get_int("attacker"))
    if not attacker then return end
    local victim = engine.get_player_for_user_id(event:get_int("userid"))
    if not victim then return end
    local damage = event:get_int("dmg_health")
    local hitgroup = event:get_int("hitgroup")
    if victim == localplayer:get_index() then
        local info = engine.get_player_info( attacker )
        local text = "Harmed by " ..info.name .. " in " .. hitgroups[hitgroup+1] .. " for " .. damage .. " damage "
        add_log(text, false)
        console_print_color(color.new(255,255,255,255),text .. "\n")
    end
end

function logsscreen()
    if get_int("logs_type") == 0 then return end
    for i = 1, #logs do
        if (logs[i] ~= nil) then
            local ratio = 1
            if (logs[i].expiration <= 1) then
                ratio = (logs[i].expiration) / 1
            end
            local step = 255 / 0.9 * (globals.get_frametime()) * 2
            if logs[i].expiration >= 4 then
                logs[i].fadein = 0
            else
                logs[i].fadein = logs[i].fadein + step
            end
            if logs[i].fadein > 244 then
                logs[i].fadein = 255
            end
            if string.match(logs[i].text, "Hit") and logs[i].dead == true then
                if get_int("logs_type") == 2 then
                    render.draw_text(fonts.font, screen.half_w - render.get_text_width(fonts.font, logs[i].text)/2, screen.half_h + 8 * (i - 1) * 2 + 180, color.new(230,94,94), logs[i].text)
                end
                if get_int("logs_type") == 1 then
                    render.draw_text(fonts.font, 5, 5 + 8 * (i - 1) * 2, color.new(230,94,94), "SeaSide - " .. logs[i].text)
                end
            else
                if get_int("logs_type") == 2 then
                    render.draw_text(fonts.font, screen.half_w - render.get_text_width(fonts.font, logs[i].text)/2, screen.half_h + 8 * (i - 1) * 2 + 180, color.new(255,255,255), logs[i].text)
                end
                if get_int("logs_type") == 1 then
                    render.draw_text(fonts.font, 5, 5 + 8 * (i - 1) * 2, color.new(255,255,255), "SeaSide - " .. logs[i].text)
                end
            end

            logs[i].expiration = logs[i].expiration - 0.007
            if (logs[i].expiration <= -1) then
                table.remove(logs, i)
            end
        end
    end
end

invertorjittervalue = 0
function jitter(cmd)
    local sliderspeed = menu.get_int("Jitter Value")
    if entitylist.get_local_player():get_velocity():length_2d() > 50 then
        if get_int("jitter_conditions") == 1 then
            if invertorjittervalue >= sliderspeed then
                if menu.get_key_bind_state("anti_aim.invert_desync_key") then
                    menu.set_bool("anti_aim.invert_desync_key", false)
                else
                    menu.set_bool("anti_aim.invert_desync_key", true)
                end
                invertorjittervalue = 0
            else
                invertorjittervalue = invertorjittervalue + 1
            end
        end
        if get_int("jitter_conditions") == 2 and is_key_down(0x20) then
            if invertorjittervalue >= sliderspeed then
                if menu.get_key_bind_state("anti_aim.invert_desync_key") then
                    menu.set_bool("anti_aim.invert_desync_key", false)
                else
                    menu.set_bool("anti_aim.invert_desync_key", true)
                end
                invertorjittervalue = 0
            else
                invertorjittervalue = invertorjittervalue + 1
            end
        end
    end
end

doonceon = false
function ragebot()
    local localplayer = entitylist.get_local_player()
    if not localplayer then return end
    if get_bool("bt_increse") then
        console.execute("sv_maxunlag 1")
    else
        console.execute("sv_maxunlag 0.200")
    end

    if get_int("dt_speed") == 0 then
        console.execute("sv_maxusrcmdprocessticks 16")
    elseif get_int("dt_speed") == 1 then
        console.execute("sv_maxusrcmdprocessticks 18")
    elseif get_int("dt_speed") == 2 then
        console.execute("sv_maxusrcmdprocessticks 22")
    end

    if get_bool("do_lag_comp") then
        if doonceon == false then
            console.execute("jointeam 1")
            console.set_int("cl_lagcompensation", 0)
            doonceon = true
        end
    else
        if doonceon == true then
            console.execute("jointeam 1")
            console.set_int("cl_lagcompensation", 1)
            doonceon = false
        end
    end
end

function thirdperson()
    if engine.is_connected() and entitylist.get_local_player() and entitylist.get_local_player():get_health() > 0 and get_bool("tpdist") then
        menu.set_int("misc.third_person_distance", menu.get_int("Third Person Distance"))
        if get_bool("camcolision") then
            console.set_int("cam_collision", 0)
        else
            console.set_int("cam_collision", 1)
        end
    else
        menu.set_int("misc.third_person_distance", 101)
        console.set_int("cam_collision", 1)
    end
end

sex = false
function bruteforce(shot_info)
    if get_int("ab_force") == 1 then
        if get_int("custom_desync_type") ~= 4 and get_int("move_anti_aim_condition") ~= 6 then
            if sex == false then
                if menu.get_key_bind_state("anti_aim.invert_desync_key") then
                    menu.set_bool("anti_aim.invert_desync_key", false)
                else
                    menu.set_bool("anti_aim.invert_desync_key", true)
                end
                sex = true
            else
                if menu.get_key_bind_state("anti_aim.invert_desync_key") then
                    menu.set_bool("anti_aim.invert_desync_key", false)
                else
                    menu.set_bool("anti_aim.invert_desync_key", true)
                end
                sex = false
            end
        end
    elseif get_int("ab_force") == 2 and shot_info.result == "Hit" then
        if get_int("custom_desync_type") ~= 4 and get_int("move_anti_aim_condition") ~= 6 then
            if sex == false then
                if menu.get_key_bind_state("anti_aim.invert_desync_key") then
                    menu.set_bool("anti_aim.invert_desync_key", false)
                else
                    menu.set_bool("anti_aim.invert_desync_key", true)
                end
                sex = true
            else
                if menu.get_key_bind_state("anti_aim.invert_desync_key") then
                    menu.set_bool("anti_aim.invert_desync_key", false)
                else
                    menu.set_bool("anti_aim.invert_desync_key", true)
                end
                sex = false
            end
        end
    end

    if get_int("custom_desync_type") == 2 then
        setdeltadesync = 1
    end
end

local players = {}
local function get_spectating_players()
    if not get_bool("lua_spectator") then return end
    players = {}
    players.name = ""

    for i = 1, globals.get_maxclients(), 1 do
        local ent = entitylist.get_player_by_index(i)
        local toplayer = entitylist.entity_to_player(ent)
        if not ent or toplayer:get_health() > 0 or toplayer:get_dormant() then goto continue end
        local spectating = ent:get_prop_int("CBasePlayer", "m_hObserverTarget")
        if spectating ~= nil then
            table.insert(players, {name = engine.get_player_info(i).name})
        end
        ::continue::
    end
end
function paintspec()
    local localplayer = entitylist.get_local_player()
    if not localplayer and not get_bool("lua_spectator") then return end
    local spacing = 0
    local watermark_space = 0
    if get_int("wt_type") ~= 0 then
        if get_int("wt_type") == 1 then
            watermark_space = 20
        elseif get_int("wt_type") == 2 then
            watermark_space = 27
        end
    else
        watermark_space = 0
    end
    if players ~= nil and localplayer ~= nil then
        for i = 1, #players, 1 do
            render.draw_text(fonts.spectators, screen.w - render.get_text_width(fonts.spectators, players[i].name) - 5, 1 + spacing + watermark_space,color.new(255,255,255),  players[i].name)
            spacing = spacing + 12
        end
    end
end

client.add_callback("on_shot", function(shot_info)
    if bUnloadedScript then
        return
    end
    if not entitylist.get_local_player() then return end
    bruteforce()
    resolver(shot_info)
    hitlog(shot_info)
    
end)

client.add_callback("create_move", function(cmd)
    if bUnloadedScript then
        return
    end
    if not entitylist.get_local_player() then return end
    jitter(cmd)
    antiaim()
    autopeek(cmd)
end)

client.add_callback("on_paint", function()
    if bUnloadedScript then
        return
    end
    if not entitylist.get_local_player() then return end
    clantag()
    keybindstypes()
    thirdperson()
    indicators()
    ragebot()
    logsscreen()
    disablebotresolver()
    get_spectating_players()
    paintspec()
end)

client.add_callback("unload", function()
    bUnloadedScript = true
end)
events.register_event("player_hurt", hurtevent)
