local flickfont = render.create_font("Verdana", 12, 500, false, true, false)
local fontseasideind = render.create_font( "Smallest Pixel-7", 15, 500, true, true, false )
local fontlogo = render.create_font( "Smallest Pixel-7", 18, 500, true, true, false )
local fontside = render.create_font( "Verdana", 25, 500, true, true, false )
local arrow = render.create_font("Arial", 50, 400, false, false, false)
local arrow2 = render.create_font("Arial", 25, 400, false, false, false)
local font3 = render.create_font("Verdana", 13, 300, false, true, false) 
local font = render.create_font("Verdana", 12, 500, false, true, false)
local font7 = render.create_font( "Verdana", 12, 500, false, true, true )
local lefont = render.create_font("verdana", 16, 200, false, false, true)
local watermarkfont = render.create_font("Arial", 15, 400, true, true, false)
local font6 = render.create_font("Verdana", 12, 400, true, true, false)
local fontx = render.create_font( "Verdana", 15, 200, true, false, false )
local fonttitle = render.create_font("verdana", 18, 100, true, true, false)
local font9 = render.create_font("Tahoma", 12, 100, false, false, true)
local font11 = render.create_font("Tahoma", 13, 200, false, false, true)
local font10 = render.create_font("verdana", 17, 450, true, true, false)
local logsfont = render.create_font("Verdana", 12, 500, false, true, false)
local logofont = render.create_font("Dancing Script Regular", 50, 700, false, true, false)
local generalmenufont = render.create_font("Verdana", 30, 500, false, true, false)
local checkboxmenufont = render.create_font("Verdana", 15, 500, false, true, false)
local getscreen_x, getscreen_y = engine.get_screen_width(), engine.get_screen_height()
local getcenter_x, getcenter_y = getscreen_x / 2 , getscreen_y / 2

local ffi = require('ffi')
local user32 = ffi.load("user32")
ffi.cdef[[
    typedef int BOOL;
    typedef long LONG;
    typedef struct{
        LONG x, y;
    }POINT, *LPPOINT;

    short GetAsyncKeyState(int vKey);
    BOOL GetCursorPos(LPPOINT);
]]

local function is_key_down(vKey)
    return ffi.C.GetAsyncKeyState(vKey) < 0
end

local function getMousePos()
    local ppoint = ffi.new("POINT[1]")
    if ffi.C.GetCursorPos(ppoint) == 0 then
        error("Couldn't get cursor position!", 2)
    end

    return vector.new(ppoint[0].x, ppoint[0].y, 0)
end

surface = ffi.cast(ffi.typeof("void***"), utils.create_interface("vguimatsurface.dll", "VGUI_Surface031"))
set_color = ffi.cast(ffi.typeof('void(__thiscall*)(void*, int,int,int,int)'), surface[0][15])
filled_rect = ffi.cast(ffi.typeof('void(__thiscall*)(void*, int,int,int,int)'), surface[0][16])
filled_rect_fade = ffi.cast(ffi.typeof('void(__thiscall*)(void*, int,int,int,int,int,int,bool)'), surface[0][123])

VK_LBUTTON = 0x01
VK_SPACE = 0x20
VK_CONTROL = 0x11

local appdataraw = os.getenv("appdata")
local appdata = string.gsub(appdataraw, "\\", "/")
local path = appdata.."/Legendware/Scripts/seaside_slot1.txt"
local path2 = appdata.."/Legendware/Scripts/seaside_part.txt"
file.append( path, "" )
file.append( path2, "" )

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function getoverride(Value)
    return menu.get_int("rage.weapon[" .. Value .. "].force_damage_valueuee")
end

function getdamage(Value)
    return menu.get_int("rage.weapon[" .. Value .. "].minimum_damage  e")
end

menu.add_key_bind("Open Menu")
menu.add_color_picker("clrcolor")


local menurage = 1
local menuaa = 0
local menuvisual = 0
local menumisc = 0
local menuconfigs = 0

--ragebot
local switchragebotresolverfalse    = 1
local switchragebotresolvertrue     = 0

--antiaim
local moveconditiondisable          = 1
local moveconditiondefault          = 0
local moveconditiondefaultjitter    = 0
local moveconditioncustomjitter     = 0
local moveconditionlowdelta         = 0
local moveconditonlowdelta2         = 0
local moveconditionrandomjitter     = 0
local moveconditionswitch           = 0
local moveconditionidealyaw         = 0
local moveconditionidealjitter      = 0

local slowconditiondisable          = 1
local slowconditiondefault          = 0
local slowconditiondefaultjitter    = 0
local slowconditioncustomjitter     = 0
local slowconditionlowdelta         = 0
local slowconditonlowdelta2         = 0
local slowconditionrandomjitter     = 0
local slowconditionswitch           = 0
local slowconditionidealyaw         = 0
local slowconditionidealjitter      = 0

local antibrutedisabled             = 1
local antibruteonshot               = 0
local antibruteonhit                = 0

local legbreakerdisable             = 1
local legbreakernormal              = 0
local legbreakeroverride            = 0

local jitterdisable                 = 1
local jitteronmove                  = 0
local jitterinair                   = 0

local legitaadisable                = 1
local legitaadefault                = 0
local legitaajitter                 = 0

local attargetsdisabled             = 1
local attargetsinair                = 0

--visuals-tab indicators
local indicatorsdisable             = 1
local indicatorsseaside             = 0
local indicatorsidealyaw            = 0

local aaarrowdisable                = 1
local aaarrowseaside                = 0
local aaarrowskeet                  = 0
local aaarrowstatic                 = 1
local aaarrowdynamic                = 0

--visuals-tab main
local watermarkdisable              = 1
local watermarkseaside              = 0
local watermarkmetamod              = 0

local watermarkpositionleft         = 1
local watermarkpositionright        = 0

local netgraphdisable               = 1
local netgraphseaside               = 0
local netgraphskeet                 = 0

local antiaimdebugdisable           = 1
local antiaimdebugenable            = 0

local keybindsdisable               = 1
local keybindsenable                = 0

local fogdisable                    = 1
local fogenable                     = 0

local viewmodel                     = 1
local viewonscope                   = 0

--misc
local clantagdisable                = 1
local clantagenable                 = 0

local pitchlanddisable              = 1
local pitchlandenable               = 0

local disableblurdisable            = 1
local disableblurenable             = 0

local logsdisable                   = 1
local logsenable                    = 0
local logsconsole                   = 0

local modelchangerdisable           = 1
local modelchangerenable            = 0

local overrideautopeekonshot        = 1
local overrideautopeekalways        = 0

local backtrackdefault              = 1
local backtrackenhanced             = 0

local mindmghide                    = 1
local mindmgshow                    = 0

local betterdormant                 = 1
local enableddormant                = 0

--keybinds
local pos_x                         = 100
local pos_y                         = 100

--configsystem
local loadconfigfile                = 0
local saveconfigfile                = 0

ffi.cdef[[
    int VirtualProtect(void* lpAddress, unsigned long dwSize, unsigned long flNewProtect, unsigned long* lpflOldProtect);
    void* VirtualAlloc(void* lpAddress, unsigned long dwSize, unsigned long  flAllocationType, unsigned long flProtect);
    int VirtualFree(void* lpAddress, unsigned long dwSize, unsigned long dwFreeType);

    typedef int(__fastcall* clantag_t)(const char*, const char*);

    typedef unsigned char BYTE;
    typedef void *PVOID;
    typedef PVOID HMODULE;
    typedef const char *LPCSTR;
    typedef int *FARPROC;
    
    HMODULE GetModuleHandleA(
        LPCSTR lpModuleName
    );
    
    FARPROC GetProcAddress(
        HMODULE hModule,
        LPCSTR  lpProcName
    );
    
    typedef struct{
        BYTE r, g, b, a;
    } Color;
    
    typedef void(__cdecl *ColorMsgFn)(Color&, const char*);

    typedef struct tagPOINT {
        long x;
        long y;
    } POINT;

    bool GetCursorPos(
        POINT* lpPoint
    );
    
    short GetAsyncKeyState(
        int vKey
    );

    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);

    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
 
    typedef struct {
        uint8_t r;
        uint8_t g;
        uint8_t b;
        uint8_t a;
    } color_struct_t;

    typedef struct
    {
        float x;
        float y;
        float z;
    } Vector_t;

    typedef struct
    {
        char        pad0[0x60]; // 0x00
        void*       pEntity; // 0x60
        void*       pActiveWeapon; // 0x64
        void*       pLastActiveWeapon; // 0x68
        float        flLastUpdateTime; // 0x6C
        int            iLastUpdateFrame; // 0x70
        float        flLastUpdateIncrement; // 0x74
        float        flEyeYaw; // 0x78
        float        flEyePitch; // 0x7C
        float        flGoalFeetYaw; // 0x80
        float        flLastFeetYaw; // 0x84
        float        flMoveYaw; // 0x88
        float        flLastMoveYaw; // 0x8C // changes when moving/jumping/hitting ground
        float        flLeanAmount; // 0x90
        char        pad1[0x4]; // 0x94
        float        flFeetCycle; // 0x98 0 to 1
        float        flMoveWeight; // 0x9C 0 to 1
        float        flMoveWeightSmoothed; // 0xA0
        float        flDuckAmount; // 0xA4
        float        flHitGroundCycle; // 0xA8
        float        flRecrouchWeight; // 0xAC
        Vector_t    vecOrigin; // 0xB0
        Vector_t    vecLastOrigin;// 0xBC
        Vector_t    vecVelocity; // 0xC8
        Vector_t    vecVelocityNormalized; // 0xD4
        Vector_t    vecVelocityNormalizedNonZero; // 0xE0
        float        flVelocityLenght2D; // 0xEC
        float        flJumpFallVelocity; // 0xF0
        float        flSpeedNormalized; // 0xF4 // clamped velocity from 0 to 1
        float        flRunningSpeed; // 0xF8
        float        flDuckingSpeed; // 0xFC
        float        flDurationMoving; // 0x100
        float        flDurationStill; // 0x104
        bool        bOnGround; // 0x108
        bool        bHitGroundAnimation; // 0x109
        char        pad2[0x2]; // 0x10A
        float        flNextLowerBodyYawUpdateTime; // 0x10C
        float        flDurationInAir; // 0x110
        float        flLeftGroundHeight; // 0x114
        float        flHitGroundWeight; // 0x118 // from 0 to 1, is 1 when standing
        float        flWalkToRunTransition; // 0x11C // from 0 to 1, doesnt change when walking or crouching, only running
        char        pad3[0x4]; // 0x120
        float        flAffectedFraction; // 0x124 // affected while jumping and running, or when just jumping, 0 to 1
        char        pad4[0x208]; // 0x128
        float        flMinBodyYaw; // 0x330
        float        flMaxBodyYaw; // 0x334
        float        flMinPitch; //0x338
        float        flMaxPitch; // 0x33C
        int            iAnimsetVersion; // 0x340
    } CCSGOPlayerAnimationState_534535_t;

    typedef struct 
    {
    	void*   fnHandle;        
    	char    szName[260];     
    	int     nLoadFlags;      
    	int     nServerCount;    
    	int     type;            
    	int     flags;           
    	float  vecMins[3];       
    	float  vecMaxs[3];       
    	float   radius;          
    	char    pad[0x1C];       
    }model_t;
    
    typedef void(__cdecl* ForceUpdateFn)();
    typedef int(__thiscall* get_model_index_t)(void*, const char*);
    typedef const model_t(__thiscall* find_or_load_model_t)(void*, const char*);
    typedef int(__thiscall* add_string_t)(void*, bool, const char*, int, const void*);
    typedef void*(__thiscall* find_table_t)(void*, const char*);
    typedef void(__thiscall* set_model_index_t)(void*, int);
    typedef int(__thiscall* precache_model_t)(void*, const char*, bool);
    typedef void*(__thiscall* get_client_entity_t)(void*, int);

    enum{
        MB_OK = 0x00000000L,
        MB_ICONINFORMATION = 0x00000040L
    };
    
    typedef void* HANDLE;
    typedef HANDLE HWND;
    typedef const char* LPCSTR;
    typedef unsigned UINT;
    
    int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT);
    typedef unsigned char BYTE;
    typedef void *PVOID;
    typedef PVOID HMODULE;
    typedef const char *LPCSTR;
    typedef int *FARPROC;
    
    HMODULE GetModuleHandleA(
        LPCSTR lpModuleName
    );
    
    FARPROC GetProcAddress(
        HMODULE hModule,
        LPCSTR  lpProcName
    );
    
    typedef struct{
        BYTE r, g, b, a;
    } Color;
    
    typedef void(__cdecl *ColorMsgFn)(Color&, const char*);

    // UIEngine
    typedef void*(__thiscall* access_ui_engine_t)(void*, void); // 11
    typedef bool(__thiscall* is_valid_panel_ptr_t)(void*, void*); // 36
    typedef void*(__thiscall* get_last_target_panel_t)(void*); // 56
    typedef int (__thiscall *run_script_t)(void*, void*, char const*, char const*, int, int, bool, bool); // 113

    // IUIPanel
    typedef const char*(__thiscall* get_panel_id_t)(void*, void); // 9
    typedef void*(__thiscall* get_parent_t)(void*); // 25
    typedef void*(__thiscall* set_visible_t)(void*, bool); // 27

    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
 
    typedef struct {
        uint8_t r;
        uint8_t g;
        uint8_t b;
        uint8_t a;
    } color_struct_t;

    typedef void (*console_color_print)(const color_struct_t&, const char*, ...);
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

console.execute("clear")
local loginget = http.get("https://amosystems.000webhostapp.com", "/login.php?username="..globals.get_username())
local version = "0.9"
local latestversion = http.get("https://pastebin.com", "/raw/Lh2yMFZe")
local latestupdates = http.get("https://pastebin.com", "/raw/JLSsANuV")
console_print_color(color.new(200,255,0),
    "SeaSide - Getting request from database..." .. "\n" ..
    "SeaSide - Getting user data..." .. "\n\n\n"
)
local scriptenabled = true
if loginget == "true" and version == latestversion and scriptenabled == true then  --script start
console_print_color(color.new(200,255,0),
    "SeaSide - User identification confirmed..." .. "\n" ..
    "SeaSide - Loading script..." .. "\n" ..
    "SeaSide - Script succesfully loaded..." .. "\n\n\n" ..
    "░██████╗███████╗░█████╗░░██████╗██╗██████╗░███████╗░░░██╗░░░░░██╗░░░██╗░█████╗░" .. "\n" ..
    "██╔════╝██╔════╝██╔══██╗██╔════╝██║██╔══██╗██╔════╝░░░██║░░░░░██║░░░██║██╔══██╗" .. "\n" ..
    "╚█████╗░█████╗░░███████║╚█████╗░██║██║░░██║█████╗░░░░░██║░░░░░██║░░░██║███████║" .. "\n" ..
    "░╚═══██╗██╔══╝░░██╔══██║░╚═══██╗██║██║░░██║██╔══╝░░░░░██║░░░░░██║░░░██║██╔══██║" .. "\n" ..
    "██████╔╝███████╗██║░░██║██████╔╝██║██████╔╝███████╗██╗███████╗╚██████╔╝██║░░██║" .. "\n" ..
    "╚═════╝░╚══════╝╚═╝░░╚═╝╚═════╝░╚═╝╚═════╝░╚══════╝╚═╝╚══════╝░╚═════╝░╚═╝░░╚═╝" .. "\n\n\n" ..
    latestupdates .. "\n"
)

menu.add_slider_int("                     Jitter Value", 1, 100)
    menu.next_line()
    menu.add_key_bind("Legit AA")
    menu.next_line()
    menu.add_key_bind("Edge Yaw")   
    menu.next_line()
    menu.add_key_bind("Anti Aim Flick")
    menu.next_line()
    menu.add_color_picker("Indicator Color")
    menu.next_line()
    menu.add_color_picker("Arrows Color")
    menu.next_line()
    menu.add_color_picker("Manual Arrows Color")
    menu.next_line()
    menu.add_color_picker("Watermark")
    menu.next_line()
    menu.add_color_picker("HoloPanel Color")
    menu.next_line()
    menu.add_color_picker( "Keybinds" )
    menu.next_line()
    menu.add_color_picker("Dormant Color")
    menu.next_line()
    menu.add_color_picker( "Fog Color" )
    menu.add_slider_float( "                   Start Distance", 0, 1000 )
    menu.add_slider_float( "                    End Distance", 0, 5000 )
    menu.add_slider_float( "                          Density", 0, 100  )
    menu.next_line()
    menu.add_slider_int("Third Person Distance", 30, 150)
    menu.next_line()

misses = 0
local function resolver(shot_info)
    local shot_result = shot_info.result
    local shot_damage = shot_info.server_damage
    local client_hitbox = shot_info.client_hitbox
    local server_hitbox = shot_info.server_hitbox
    local shot_hitchance = shot_info.hitchance
	local player_info = engine.get_player_info
	local target = shot_info.target_index
	local target_name = player_info(target).name

    if switchragebotresolvertrue == 1 then
        menu.set_bool("player_list.player_settings["..target.."].force_body_yaw", true)
        bodyyaw = menu.get_int("player_list.player_settings["..target.."].body_yaw   ")
        menu.set_int("player_list.player_settings["..target.."].body_yaw", 8)
    
        if shot_result == "Resolver" then
            misses = misses + 1
            if bodyyaw == 8 or bodyyaw == 0 and misses == 1 then
                menu.set_int("player_list.player_settings["..target.."].body_yaw", -14)
            elseif misses == 2 then
                menu.set_int("player_list.player_settings["..target.."].body_yaw", 7)
                misses = 0
            elseif misses == 1 then
                menu.set_int("player_list.player_settings["..target.."].body_yaw", -9)
                misses = 0
            elseif misses == 2 then
                menu.set_int("player_list.player_settings["..target.."].body_yaw", 8)
            end 
        else
            misses = 0
        end
        
    else
        menu.set_int("player_list.player_settings["..target.."].body_yaw", 0)
        menu.set_bool("player_list.player_settings["..target.."].force_body_yaw", false)
    end
end

a = 0
b = 0
function antiaim()
    if not entitylist.get_local_player() then return end
    if not menu.get_key_bind_state("Anti Aim Flick") then
        total_velocity = entitylist.get_local_player():get_velocity():length_2d()
        menu.set_bool("anti_aim.enable_fake_lag", true)
        if menu.get_key_bind_state("misc.slow_walk_key") == true then
            if slowconditiondefault == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 1)
                menu.set_int("anti_aim.desync_range", 60)
                menu.set_int("anti_aim.desync_range_inverted", 60)
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if slowconditiondefaultjitter  == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 2)
                menu.set_int("anti_aim.desync_range", 60)
                menu.set_int("anti_aim.desync_range_inverted", 60)
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if slowconditioncustomjitter == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 2)
                menu.set_int("anti_aim.desync_range", math.random(35,38))
                menu.set_int("anti_aim.desync_range_inverted", math.random(31,34))
                menu.set_int("anti_aim.yaw_modifier_range", 10)
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if slowconditionlowdelta == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 1)
                menu.set_int("anti_aim.yaw_offset", 0)
                menu.set_int("anti_aim.desync_range", math.random(15,24))
                menu.set_int("anti_aim.desync_range_inverted", math.random(20,24))
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if slowconditonlowdelta2 == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 1)
                menu.set_int("anti_aim.yaw_offset", -5)
                menu.set_int("anti_aim.desync_range", math.random(20,35))
                menu.set_int("anti_aim.desync_range_inverted", math.random(25,40))
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if slowconditionrandomjitter == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.yaw_offset", 0)
                menu.set_int("anti_aim.desync_type", math.random(1, 2))
                menu.set_int("anti_aim.desync_range", 40)
                menu.set_int("anti_aim.desync_range_inverted", 45)
                if b >= 100 then
                    menu.set_int("anti_aim.desync_range", math.random(28,35))
                    menu.set_int("anti_aim.desync_range_inverted", math.random(33, 43))
                    b = 0
                else 
                    b= b+1
                end
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if slowconditionswitch == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 1)
                if a >= 50 then
                    menu.set_int("anti_aim.yaw_offset", math.random(-15,20))
                    menu.set_int("anti_aim.desync_range",math.random(28,38))
                    menu.set_int("anti_aim.desync_range_inverted",math.random(30,44))
                    menu.set_int("anti_aim.desync_type", math.random(1,2))
                    a = 0
                else
                    a=a+1
                
                end
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if slowconditionidealyaw == 1 then
                if total_velocity <= 5 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 10)
                    menu.set_int("anti_aim.desync_range_inverted", 10)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 35 and total_velocity <= 65 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 25)
                    menu.set_int("anti_aim.desync_range_inverted", 25)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 65 and total_velocity <= 135 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 35)
                    menu.set_int("anti_aim.desync_range_inverted", 35)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 135 and total_velocity <= 185 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 45)
                    menu.set_int("anti_aim.desync_range_inverted", 45)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity > 185 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 60)
                    menu.set_int("anti_aim.desync_range_inverted", 60)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                end
            end 
            if slowconditionidealjitter == 1 then
                if total_velocity <= 5 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 10)
                    menu.set_int("anti_aim.desync_range_inverted", 10)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 35 and total_velocity <= 80 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 25)
                    menu.set_int("anti_aim.desync_range_inverted", 30)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 80 and total_velocity <= 120 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 35)
                    menu.set_int("anti_aim.desync_range_inverted", 40)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 120 and total_velocity <= 210 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 45)
                    menu.set_int("anti_aim.desync_range_inverted", 50)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity > 210 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 60)
                    menu.set_int("anti_aim.desync_range_inverted", 60)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                end
            end 
        end
        if menu.get_key_bind_state("misc.slow_walk_key") == false then
            if moveconditiondefault == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 1)
                menu.set_int("anti_aim.desync_range", 60)
                menu.set_int("anti_aim.desync_range_inverted", 60)
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if moveconditiondefaultjitter == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 2)
                menu.set_int("anti_aim.desync_range", 60)
                menu.set_int("anti_aim.desync_range_inverted", 60)
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if moveconditioncustomjitter == 1 then
                menu.set_int("anti_aim.yaw_modifier", 1)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 2)
                menu.set_int("anti_aim.desync_range", math.random(35,38))
                menu.set_int("anti_aim.desync_range_inverted", math.random(31,34))
                menu.set_int("anti_aim.yaw_modifier_range", 10)
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if moveconditionlowdelta == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 1)
                menu.set_int("anti_aim.yaw_offset", 0)
                menu.set_int("anti_aim.desync_range", math.random(15,24))
                menu.set_int("anti_aim.desync_range_inverted", math.random(20,24))
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if moveconditionlowdelta2 == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 1)
                menu.set_int("anti_aim.yaw_offset", -5)
                menu.set_int("anti_aim.desync_range", math.random(20,35))
                menu.set_int("anti_aim.desync_range_inverted", math.random(25,40))
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if moveconditionrandomjitter == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.yaw_offset", 0)
                menu.set_int("anti_aim.desync_type", math.random(1, 2))
                menu.set_int("anti_aim.desync_range", 40)
                menu.set_int("anti_aim.desync_range_inverted", 45)
                if b >= 100 then
                    menu.set_int("anti_aim.desync_range", math.random(28,35))
                    menu.set_int("anti_aim.desync_range_inverted", math.random(33, 43))
                    b = 0
                else 
                    b = b + 1
                end
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if moveconditionswitch == 1 then
                menu.set_int("anti_aim.yaw_modifier", 0)
                menu.set_int("anti_aim.pitch", 1)
                menu.set_int("anti_aim.desync_type", 1)
                if a >= 50 then
                    menu.set_int("anti_aim.yaw_offset", math.random(-15,20))
                    menu.set_int("anti_aim.desync_range",math.random(28,38))
                    menu.set_int("anti_aim.desync_range_inverted",math.random(30,44))
                    menu.set_int("anti_aim.desync_type", math.random(1,2))
                    a = 0
                else
                    a=a+1
                
                end
                if not legbreakeroverride == 1 then
                    menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                end
            end
            if moveconditionidealyaw == 1 then
                if total_velocity <= 5 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 10)
                    menu.set_int("anti_aim.desync_range_inverted", 10)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 35 and total_velocity <= 65 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 25)
                    menu.set_int("anti_aim.desync_range_inverted", 25)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 65 and total_velocity <= 135 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 35)
                    menu.set_int("anti_aim.desync_range_inverted", 35)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 135 and total_velocity <= 185 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 45)
                    menu.set_int("anti_aim.desync_range_inverted", 45)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity > 185 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 1)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 60)
                    menu.set_int("anti_aim.desync_range_inverted", 60)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                end 
            end
            if moveconditionidealjitter == 1 then
                if total_velocity <= 5 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 10)
                    menu.set_int("anti_aim.desync_range_inverted", 10)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 35 and total_velocity <= 80 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 25)
                    menu.set_int("anti_aim.desync_range_inverted", 30)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 80 and total_velocity <= 120 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 35)
                    menu.set_int("anti_aim.desync_range_inverted", 40)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity >= 120 and total_velocity <= 210 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 45)
                    menu.set_int("anti_aim.desync_range_inverted", 50)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                elseif total_velocity > 210 then
                    menu.set_int("anti_aim.yaw_modifier", 0)
                    menu.set_int("anti_aim.pitch", 1)
                    menu.set_int("anti_aim.desync_type", 2)
                    menu.set_int("anti_aim.yaw_offset", 0)
                    menu.set_int("anti_aim.desync_range", 60)
                    menu.set_int("anti_aim.desync_range_inverted", 60)
                    if not legbreakeroverride == 1 then
                        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
                    end
                end
            end 
        end
        if attargetsinair == 1 and is_key_down(VK_SPACE) then
            menu.set_int( "anti_aim.target_yaw", 1 )
        elseif attargetsinair == 1 and not is_key_down(VK_SPACE) then
            menu.set_int( "anti_aim.target_yaw", 0 )
        end
    else
        menu.set_int("anti_aim.desync_type", 1)
        menu.set_int("anti_aim.desync_range", 60)
        menu.set_int("anti_aim.desync_range_inverted", 60)
        menu.set_bool("anti_aim.enable_fake_lag", false)
    end
end

--local function set_anti_aim(yaw, pitch, types, normal_range, inverted_range)
--    menu.set_int("anti_aim.yaw_modifier", yaw)
--    menu.set_int("anti_aim.pitch", pitch)
--    menu.set_int("anti_aim.desync_type", types) 
--    menu.set_int("anti_aim.desync_range", normal_range) 
--    menu.set_int("anti_aim.desync_range_inverted", inverted_range) 
--end
--local function set_fakelag(value)
--    menu.set_int("anti_aim.fake_lag_limit", value)
--end
--
--a = 0
--b = 0
--function antiaim()
--    if not entitylist.get_local_player() then return end
--    if menu.get_key_bind_state("Anti Aim Flick") then return end
--    total_velocity = entitylist.get_local_player():get_velocity():length_2d()
--    menu.set_bool("anti_aim.enable_fake_lag", true)
--    set_fakelag(math.random(8,16))
--    if menu.get_key_bind_state("misc.slow_walk_key") == true then
--        if slowconditiondefault == 1 then
--            set_anti_aim(0,1,1,60,60)
--        end
--        if slowconditiondefaultjitter == 1 then
--            set_anti_aim(0,1,2,60,60)
--        end
--        if slowconditioncustomjitter == 1 then
--            set_anti_aim(0,1,2,math.random(35,38),math.random(31,34))
--        end
--        if slowconditionlowdelta == 1 then
--            set_anti_aim(0,1,1,math.random(15,24),math.random(20,24))
--        end
--        if slowconditonlowdelta2 == 1 then
--            set_anti_aim(0,1,1,math.random(20,35),math.random(25,40))
--        end
--        local desync_client, desync_client_inverted, desync_type, store_delta, store_inverted_delta= 0, 0, 1
--        if slowconditionrandomjitter == 1 then
--            if b >= 100 then
--                desync_client = math.random(28,35)
--                desync_client_inverted = math.random(33, 43)
--                store_delta = desync_client
--                store_inverted_delta = desync_client_inverted
--                b = 0
--            else
--                desync_client = store_delta
--                desync_client_inverted = store_inverted_delta
--                b = b + 1
--            end
--            set_anti_aim(0,1,math.random(1, 2),desync_client,desync_client_inverted)
--        end
--        if slowconditionswitch == 1 then
--            if a >= 50 then
--                desync_client = math.random(28,38)
--                desync_client_inverted = math.random(30,44)
--                desync_type = 2
--                a = 0
--            else
--                desync_client = desync_client
--                desync_client_inverted = desync_client_inverted
--                desync_type = 1
--                a = a + 1
--            end
--            set_anti_aim(0,1,desync_type,desync_client,desync_client_inverted)
--        end
--        local desyncangles = total_velocity/4
--        if desyncangles > 60 then
--            desyncangles = 60
--        elseif desyncangles < 10 then
--            desyncangles = 10
--        end
--        if slowconditionidealyaw == 1 then
--            set_anti_aim(0,1,1,desyncangles,desyncangles)
--        end 
--        if slowconditionidealjitter == 1 then
--            set_anti_aim(0,1,2,desyncangles,desyncangles)
--        end 
--    end
--    if menu.get_key_bind_state("misc.slow_walk_key") == false then
--        if moveconditiondefault == 1 then
--            set_anti_aim(0,1,1,60,60)
--        end
--        if moveconditiondefaultjitter == 1 then
--            set_anti_aim(0,1,2,60,60)
--        end
--        if moveconditioncustomjitter == 1 then
--            set_anti_aim(0,1,2,math.random(35,38),math.random(31,34))
--        end
--        if moveconditionlowdelta == 1 then
--            set_anti_aim(0,1,1,math.random(15,24),math.random(20,24))
--        end
--        if moveconditionlowdelta2 == 1 then
--            set_anti_aim(0,1,1,math.random(20,35),math.random(25,40))
--        end
--        local desync_client, desync_client_inverted, desync_type, store_delta, store_inverted_delta = 0, 0, 1
--        if moveconditionrandomjitter == 1 then
--            if b >= 100 then
--                desync_client = math.random(28,35)
--                desync_client_inverted = math.random(33, 43)
--                store_delta = desync_client
--                store_inverted_delta = desync_client_inverted
--                b = 0
--            else
--                desync_client = store_delta
--                desync_client_inverted = store_inverted_delta
--                b = b + 1
--            end
--            set_anti_aim(0,1,math.random(1, 2),desync_client,desync_client_inverted)
--        end
--        if moveconditionswitch == 1 then
--            if a >= 50 then
--                desync_client = math.random(28,38)
--                desync_client_inverted = math.random(30,44)
--                desync_type = 2
--                store_delta = desync_client
--                store_inverted_delta = desync_client_inverted
--                a = 0
--            else
--                desync_client = store_delta
--                desync_client_inverted = store_inverted_delta
--                desync_type = 1
--                a = a + 1
--            end
--            set_anti_aim(0,1,desync_type,desync_client,desync_client_inverted)
--        end
--        
--        if moveconditionidealyaw == 1 then
--            local desyncangles_velocity = total_velocity/4
--            menu.set_int("anti_aim.desync_type", desyncangles_velocity) 
--            menu.set_int("anti_aim.desync_range", desyncangles_velocity) 
--            menu.set_int("anti_aim.yaw_modifier", 0)
--            menu.set_int("anti_aim.pitch", 1)
--            menu.set_int("anti_aim.desync_type", 1) 
--        end
--        if moveconditionidealjitter == 1 then
--            local desyncangles_velocity = total_velocity/4
--            menu.set_int("anti_aim.desync_type", desyncangles_velocity) 
--            menu.set_int("anti_aim.desync_range", desyncangles_velocity) 
--            menu.set_int("anti_aim.yaw_modifier", 0)
--            menu.set_int("anti_aim.pitch", 1)
--            menu.set_int("anti_aim.desync_type", 2) 
--        end 
--        if attargetsinair == 1 and is_key_down(VK_SPACE) then
--            menu.set_int( "anti_aim.target_yaw", 1 )
--        elseif attargetsinair == 1 and not is_key_down(VK_SPACE) then
--            menu.set_int( "anti_aim.target_yaw", 0 )
--        end
--    end
--end

function legbreaker(cmd)
    if legbreakernormal == 1 then
        menu.set_int("misc.leg_movement", math.random(1, 2))
        menu.set_int("anti_aim.fake_lag_limit",math.random(8,16))
    elseif legbreakeroverride == 1 then
        if cmd.command_number % 3 == 1 then
            menu.set_int("misc.leg_movement", 1)
        else
            menu.set_int("misc.leg_movement", 2)
        end
        menu.set_int("anti_aim.fake_lag_limit", 12 )
    end
end

oldtickcount = 0
flick = 0
inverted = menu.get_key_bind_state("anti_aim.invert_desync_key")
function fakeflick()
    local isFlick = menu.get_key_bind_state("Anti Aim Flick")
    if not engine.is_in_game() then return end
    if isFlick then
        if globals.get_tickcount() - oldtickcount > 64 then
            oldtickcount = globals.get_tickcount()
        end
        if globals.get_tickcount() - oldtickcount > 50 then
            flick = 1
            oldtickcount = globals.get_tickcount()
        else
            flick = 0
            menu.set_int("anti_aim.yaw_offset", 0 )
        end
        if flick == 1 then
            if inverted then
                menu.set_int("anti_aim.yaw_offset", math.random(-120, -90) )
            else
                menu.set_int("anti_aim.yaw_offset", math.random(90, 120) )
            end
        end
    else
        flick = 0
    end
end
    
x = 0
switchinverted = false

local function switcher(cmd)
    if jitteronmove == 1 and entitylist.get_local_player():get_velocity():length_2d() > 50 and not is_key_down(VK_SPACE) and not menu.get_key_bind_state("misc.slow_walk_key") then
        local sliderspeed = menu.get_int("                     Jitter Value")
        if x >= sliderspeed then
            if switchinverted == false then
                menu.set_bool("anti_aim.invert_desync_key", true)
                switchinverted = true
            elseif switchinverted == true then
                menu.set_bool("anti_aim.invert_desync_key", false)
                switchinverted = false
            end
            x = 0
        else
            x = x + 1
        end 
    elseif jitterinair == 1 and entitylist.get_local_player():get_velocity():length_2d() > 50 and is_key_down(VK_SPACE) and not menu.get_key_bind_state("misc.slow_walk_key") then
        local sliderspeed = menu.get_int("                     Jitter Value")
        if x >= sliderspeed then
            if switchinverted == false then
                menu.set_bool("anti_aim.invert_desync_key", true)
                switchinverted = true
            elseif switchinverted == true then
                menu.set_bool("anti_aim.invert_desync_key", false)
                switchinverted = false
            end
            x = 0
        else
            x = x + 1
        end
    end 
end 

sex = false
    
function killleft(event)
    if engine.get_player_for_user_id(event:get_int("attacker")) == engine.get_local_player_index() and engine.get_player_for_user_id(event:get_int("userid")) ~= engine.get_local_player_index() then
        sex = true
    end
end

function on_shot(shot_info)
    if antibruteonshot == 1 then
        if sex == true then
            if menu.get_key_bind_state("anti_aim.invert_desync_key") then
                menu.set_bool("anti_aim.invert_desync_key", false)
            end
            sex = false
        elseif menu.get_key_bind_state("anti_aim.invert_desync_key") and sex == false then
            menu.set_bool("anti_aim.invert_desync_key", false)
        elseif sex == false then
            menu.set_bool("anti_aim.invert_desync_key", true)
        end
    end
    
    if antibruteonhit == 1 then
        if shot_info.result == "Hit" then
            if sex == true then
                if menu.get_key_bind_state("anti_aim.invert_desync_key") then
                    menu.set_bool("anti_aim.invert_desync_key", false)
                else
                end
                sex = false
            elseif menu.get_key_bind_state("anti_aim.invert_desync_key") and sex == false then
                menu.set_bool("anti_aim.invert_desync_key", false)
            elseif sex == false then
                menu.set_bool("anti_aim.invert_desync_key", true)
            end
        end
    end
end

function legitaaonkey()
    if menu.get_key_bind_state("Legit AA") then
        if legitaadefault == 1 then
            menu.set_int("anti_aim.pitch", 0)
            menu.set_int("anti_aim.yaw_offset", -180)
        elseif legitaajitter == 1 then
            menu.set_int("anti_aim.pitch", 0)
            menu.set_int("anti_aim.yaw_modifier", 1)
            menu.set_int("anti_aim.yaw_modifier_range", math.random(5,35))
            menu.set_int("anti_aim.yaw_offset", 180)
            menu.set_int("anti_aim.desync_type", 2)
            menu.set_int("anti_aim.desync_range", math.random(28,43))
            menu.set_int("anti_aim.desync_range_inverted", math.random(34,49))
        end
    else
        menu.set_int("anti_aim.yaw_modifier", 0)
        menu.set_int("anti_aim.yaw_modifier_range", 0)
        menu.set_int("anti_aim.pitch", 1) 
        if not menu.get_key_bind_state("Anti Aim Flick") then
            menu.set_int("anti_aim.yaw_offset", 1)
        end
    end
end

function edgeyaw()
    if menu.get_key_bind_state("Edge Yaw") then
        menu.set_bool("anti_aim.edge_yaw", true)
    else
        menu.set_bool("anti_aim.edge_yaw", false)
    end
end


types = {"always", "holding", "toggled"}
get_state, get_mode = menu.get_key_bind_state, menu.get_key_bind_mode
count = 0
crl = 0
local function add_bind(name, bind_name, x, y)
    if get_state(bind_name) then
        render.draw_text(font, x, y + 22 + (15 * count), color.new(255, 255, 255), name)     
        text_width = render.get_text_width(font, "[" .. types[get_mode(bind_name) + 1] .. "]")
        
        render.draw_text(font, x + 151 - text_width - 5, y + 23 + (15 * count), color.new(255, 255, 255), "[" .. types[get_mode(bind_name) + 1] .. "]")     
        count = count + 1   
    end
end

local function gradient_rect(x,y,x1,y1,color,reversed)
    if not reversed then
        set_color(surface,0,0,0,color:a())
        filled_rect_fade(surface,x,y,x1+2,y1,120,0,true)
        
        set_color(surface,color:r(),color:g(),color:b(),255)
        filled_rect_fade(surface,x,y,x1,y1,163,0,true)
    else
        set_color(surface,0,0,0,color:a())
        filled_rect_fade(surface,x-2,y,x1,y1,0,120,true)
        
        set_color(surface,color:r(),color:g(),color:b(),255)
        filled_rect_fade(surface,x,y,x1,y1,0,163,true)
    end
end

local function watermarkcustomrect(x,y,x1,y1,reversed)
    if not reversed then
        set_color(surface,menu.get_color("Watermark"):r(),menu.get_color("Watermark"):g(),menu.get_color("Watermark"):b(),255)
        filled_rect_fade(surface,x,y,x1+2,y1,120,0,true)
        
        set_color(surface,menu.get_color("Watermark"):r(),menu.get_color("Watermark"):g(),menu.get_color("Watermark"):b(),menu.get_color("Watermark"):a())
        filled_rect_fade(surface,x,y,x1,y1,163,0,true)
    else
        set_color(surface,menu.get_color("Watermark"):r(),menu.get_color("Watermark"):g(),menu.get_color("Watermark"):b(),255)
        filled_rect_fade(surface,x-2,y,x1,y1,0,120,true)
        
        set_color(surface,menu.get_color("Watermark"):r(),menu.get_color("Watermark"):g(),menu.get_color("Watermark"):b(),menu.get_color("Watermark"):a())
        filled_rect_fade(surface,x,y,x1,y1,0,163,true)
    end
end

adaos = 0
compensate = 0
total_velocity = 0
client.add_callback("create_move", function()
    if engine.is_connected() and entitylist.get_local_player() then
        total_velocity = entitylist.get_local_player():get_velocity():length_2d()
    end
end)
client.add_callback("on_paint", function()
    if engine.is_connected() and entitylist.get_local_player() and entitylist.get_local_player():get_health() > 0 then
        menu.set_int("misc.third_person_distance", menu.get_int("Third Person Distance"))
    else
        menu.set_int("misc.third_person_distance", 101)
    end
end)

function allpaint()
    if not engine.is_connected() then return end

    damageOverride = menu.get_key_bind_state( "rage.force_damage_key" )
    inverted = menu.get_key_bind_state( "anti_aim.invert_desync_key" )
    doubleTap = menu.get_key_bind_state( "rage.double_tap_key" )
    hideShots = menu.get_key_bind_state( "rage.hide_shots_key" )
    fakeDuck = menu.get_key_bind_state( "anti_aim.fake_duck_key" )
    leftAA = menu.get_key_bind_state( "anti_aim.manual_left_key" )
    rightAA = menu.get_key_bind_state( "anti_aim.manual_right_key" )
    SlowWalk = menu.get_key_bind_state( "misc.slow_walk_key" )

    main = menu.get_color("Indicator Color")
    second = menu.get_color("Arrows Color")
    manualaa = menu.get_color("Manual Arrows Color")

    ballchunks = 1

    alpha = 1,1
    alpha = math.min(math.floor(math.sin((globals.get_realtime() % 3) * 4) * 125 + 200), 255) 

    ping = tostring(globals.get_ping())
    tick = tostring(math.floor(1 / globals.get_intervalpertick()))
    getframerate = tostring(math.floor(1 / globals.get_frametime()))

    if inverted then
        synced_dsy_delta = math.min(menu.get_int("anti_aim.desync_range_inverted"))
    else
        synced_dsy_delta = math.min(menu.get_int("anti_aim.desync_range"))
    end

    if entitylist.get_local_player() and entitylist.get_local_player():get_health() > 0 then
        if flick == 1 then
            if inverted then
                render.draw_text( fontseasideind, getcenter_x - 13 - 20, getcenter_y + 45 - 70 , main, "FLICK LEFT")
            else
                render.draw_text( fontseasideind, getcenter_x - 13 - 21, getcenter_y + 45 - 70 , main, "FLICK RIGHT")
            end
        end

        if aaarrowseaside == 1 then
            if aaarrowdynamic == 1 then
                if inverted then
                    render.draw_text( fontside, getcenter_x - 13 - 45 - total_velocity/9, getcenter_y + 45 - 59, second, "<" )
                    render.draw_text( fontside, getcenter_x - 13 + 55 + total_velocity/9, getcenter_y + 45 - 59, color.new(60,60,60,255), ">" )
                else
                    render.draw_text( fontside, getcenter_x - 13 + 55 + total_velocity/9, getcenter_y + 45 - 59, second, ">" )
                    render.draw_text( fontside, getcenter_x - 13 - 45 - total_velocity/9, getcenter_y + 45 - 59, color.new(60,60,60,255), "<" )
                end
            
                if leftAA then
                    render.draw_text( fontside, getcenter_x - 13 - 60 - total_velocity/9, getcenter_y + 45 - 59, manualaa, "<" )
                elseif rightAA then
                    render.draw_text( fontside, getcenter_x - 13 + 70 + total_velocity/9, getcenter_y + 45 - 59, manualaa, ">" )
                end
            else
                if inverted then
                    render.draw_text( fontside, getcenter_x - 13 - 45, getcenter_y + 45 - 59, second, "<" )
                    render.draw_text( fontside, getcenter_x - 13 + 55, getcenter_y + 45 - 59, color.new(60,60,60,255), ">" )
                else
                    render.draw_text( fontside, getcenter_x - 13 + 55, getcenter_y + 45 - 59, second, ">" )
                    render.draw_text( fontside, getcenter_x - 13 - 45, getcenter_y + 45 - 59, color.new(60,60,60,255), "<" )
                end
            
                if leftAA then
                    render.draw_text( fontside, getcenter_x - 13 - 60, getcenter_y + 45 - 59, manualaa, "<" )
                elseif rightAA then
                    render.draw_text( fontside, getcenter_x - 13 + 70, getcenter_y + 45 - 59, manualaa, ">" )
                end
            end
        elseif aaarrowskeet == 1 then
            if aaarrowdynamic == 1 then
                if inverted then
                    render.draw_text( arrow2, getcenter_x + 48 + total_velocity/9, getcenter_y - 13.5, color.new(56, 56, 56, 150), "|" )
                    render.draw_text( arrow2, getcenter_x - 52 - total_velocity/9, getcenter_y - 13.5, second, "|" )
                else
                    render.draw_text( arrow2, getcenter_x - 52 - total_velocity/9, getcenter_y - 13.5, color.new(56, 56, 56, 150), "|" )
                    render.draw_text( arrow2, getcenter_x + 48 + total_velocity/9, getcenter_y - 13.5, second, "|" )
                end
            
                if leftAA then
                    render.draw_text( arrow, getcenter_x - 71 - total_velocity/9, getcenter_y - 26, manualaa, "◀" )
                    render.draw_text( arrow, getcenter_x + 53 + total_velocity/9, getcenter_y - 26, color.new(56, 56, 56, 150), "▶" )
                elseif rightAA then
                    render.draw_text( arrow, getcenter_x + 53 + total_velocity/9, getcenter_y - 26, manualaa, "▶" )
                    render.draw_text( arrow, getcenter_x - 71 - total_velocity/9, getcenter_y - 26, color.new(56, 56, 56, 150), "◀" )
                else
                    render.draw_text( arrow, getcenter_x + 53 + total_velocity/9, getcenter_y - 26, color.new(56, 56, 56, 150), "▶" )
                    render.draw_text( arrow, getcenter_x - 71 - total_velocity/9, getcenter_y - 26, color.new(56, 56, 56, 150), "◀" )
                end
            else
                if inverted then
                    render.draw_text( arrow2, getcenter_x + 48, getcenter_y - 13.5, color.new(56, 56, 56, 150), "|" )
                    render.draw_text( arrow2, getcenter_x - 52, getcenter_y - 13.5, second, "|" )
                else
                    render.draw_text( arrow2, getcenter_x - 52, getcenter_y - 13.5, color.new(56, 56, 56, 150), "|" )
                    render.draw_text( arrow2, getcenter_x + 48, getcenter_y - 13.5, second, "|" )
                end
            
                if leftAA then
                    render.draw_text( arrow, getcenter_x - 71, getcenter_y - 26, manualaa, "◀" )
                    render.draw_text( arrow, getcenter_x + 53, getcenter_y - 26, color.new(56, 56, 56, 150), "▶" )
                elseif rightAA then
                    render.draw_text( arrow, getcenter_x + 53, getcenter_y - 26, manualaa, "▶" )
                    render.draw_text( arrow, getcenter_x - 71, getcenter_y - 26, color.new(56, 56, 56, 150), "◀" )
                else
                    render.draw_text( arrow, getcenter_x + 53, getcenter_y - 26, color.new(56, 56, 56, 150), "▶" )
                    render.draw_text( arrow, getcenter_x - 71, getcenter_y - 26, color.new(56, 56, 56, 150), "◀" )
                end
            end
        end

        if indicatorsseaside == 1 then
            if inverted then
                render.draw_text( fontlogo, getcenter_x - 13 - 15, getcenter_y + 45 - 25, main, "Sea" )
                render.draw_text( fontlogo, getcenter_x - 13 + 10, getcenter_y + 45 - 25, second, "Side" )
            else
                render.draw_text( fontlogo, getcenter_x - 13 - 15, getcenter_y + 45 - 25, second, "Sea" )
                render.draw_text( fontlogo, getcenter_x - 13 + 10, getcenter_y + 45 - 25, main, "Side" )
            end

            gradient_rect(getcenter_x , getcenter_y+38, getcenter_x + synced_dsy_delta * 0.6, getcenter_y + 41, main, false)
            gradient_rect(getcenter_x - synced_dsy_delta * 0.6, getcenter_y+38, getcenter_x, getcenter_y + 41, main, true)

            if is_key_down(VK_SPACE) then
                render.draw_text( fontseasideind, getcenter_x - 13 - 5, getcenter_y + 45 - 5 , main, "IN-AIR")
            elseif is_key_down(VK_CONTROL) then
                render.draw_text( fontseasideind, getcenter_x - 13 - 1, getcenter_y + 45 - 5, main, "Duck")
            elseif SlowWalk then
                render.draw_text( fontseasideind, getcenter_x - 13 - 18, getcenter_y + 45 - 5 , main, "Slow Walk")
            elseif total_velocity > 5 then
                render.draw_text( fontseasideind, getcenter_x - 13 - 1, getcenter_y + 45 - 5, main, "Move")
            elseif total_velocity < 5 then
                render.draw_text( fontseasideind, getcenter_x - 13 - 3, getcenter_y + 45 - 5 , main, "Stand")
            end



            --dmg
            if damageOverride then
                space1 = 10
                render.draw_text( fontseasideind, getcenter_x - 13 - 13, getcenter_y + 45 + 4, main, "override")
            else
                space1 = 0
            end
            --dt
            if doubleTap then
                space2 = 10
                render.draw_text( fontseasideind, getcenter_x - 13 + 8, getcenter_y + 45 + space1 + 4, main, "DT" )
            else    
                space2 = 0
            end
            --HS
            if hideShots then 
                space3 = 10
                render.draw_text( fontseasideind, getcenter_x - 13 + 7, getcenter_y + 45 + space1 + space2 + 4, main, "HS" )
            else
                space3 = 0
            end
            --Override
            if fakeDuck then
                space4 = 10
                render.draw_text( fontseasideind, getcenter_x - 13 + 7, getcenter_y + 45 + space1 + space2 + space3 + 4, main, "FD" )
            else
                space4 = 0
            end
        elseif indicatorsidealyaw == 1 then
            render.draw_text(font3, getcenter_x + 2, getcenter_y +40, color.new(245, 160, 70),"IDEAL YAW")
            if menu.get_key_bind_state("Legit AA") and menu.get_key_bind_state("misc.slow_walk_key") then 
                render.draw_text(font3, getcenter_x + 2 , getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif slowconditiondefault == 1 and menu.get_key_bind_state("misc.slow_walk_key") then 
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"DEFAULT")
                ballchunks = ballchunks + 1
            elseif slowconditiondefaultjitter == 1 and menu.get_key_bind_state("misc.slow_walk_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"JITTER")
                ballchunks = ballchunks + 1
            elseif slowconditioncustomjitter == 1 and menu.get_key_bind_state("misc.slow_walk_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"JITTER+")
                ballchunks = ballchunks + 1
            elseif slowconditionlowdelta == 1 and menu.get_key_bind_state("misc.slow_walk_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LOWDELTA")
                ballchunks = ballchunks + 1
            elseif slowconditonlowdelta2 == 1 and menu.get_key_bind_state("misc.slow_walk_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LOWDELTA+")
                ballchunks = ballchunks + 1
            elseif slowconditionrandomjitter == 1 and menu.get_key_bind_state("misc.slow_walk_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"RJITTER")
                ballchunks = ballchunks + 1
            elseif slowconditionswitch == 1 and menu.get_key_bind_state("misc.slow_walk_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"SWITCH")
                ballchunks = ballchunks + 1
            elseif slowconditionidealyaw == 1 and menu.get_key_bind_state("misc.slow_walk_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"DYNAMIC")
                ballchunks = ballchunks + 1
            elseif slowconditionidealjitter ==1 and menu.get_key_bind_state("misc.slow_walk_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"DYNAMIC+")
                ballchunks = ballchunks + 1
            elseif moveconditiondefault == 1 and menu.get_key_bind_state("Legit AA") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif moveconditiondefault == 1  and menu.get_key_bind_state("misc.slow_walk_key") == false then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"DEFAULT")
                ballchunks = ballchunks + 1
            elseif moveconditiondefaultjitter == 1 and menu.get_key_bind_state("Legit AA") then
                render.draw_text(font3, getcenter_x + 2 , getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif moveconditiondefaultjitter == 1 and menu.get_key_bind_state("misc.slow_walk_key") == false then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"JITTER")
                ballchunks = ballchunks + 1
            elseif moveconditioncustomjitter == 1 and menu.get_key_bind_state("Legit AA") then
                render.draw_text(font3, getcenter_x + 2 , getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif moveconditioncustomjitter == 1  and menu.get_key_bind_state("misc.slow_walk_key") == false then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"JITTER+")
                ballchunks = ballchunks + 1
            elseif moveconditionlowdelta == 1 and menu.get_key_bind_state("Legit AA") then
                render.draw_text(font3, getcenter_x + 2 , getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif moveconditionlowdelta == 1 and menu.get_key_bind_state("misc.slow_walk_key") == false then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LOWDELTA")
                ballchunks = ballchunks + 1
            elseif moveconditonlowdelta2 == 1 and menu.get_key_bind_state("Legit AA") then
                render.draw_text(font3, getcenter_x + 2 , getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif moveconditonlowdelta2 == 1 and menu.get_key_bind_state("misc.slow_walk_key") == false then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LOWDELTA+")
                ballchunks = ballchunks + 1
            elseif moveconditionrandomjitter == 1 and menu.get_key_bind_state("Legit AA") then
                render.draw_text(font3, getcenter_x + 2 , getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif moveconditionrandomjitter == 1 and menu.get_key_bind_state("misc.slow_walk_key") == false then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"RJITTER")
                ballchunks = ballchunks + 1
            elseif moveconditionswitch == 1 and menu.get_key_bind_state("Legit AA") then
                render.draw_text(font3, getcenter_x + 2 , getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif moveconditionswitch == 1 and menu.get_key_bind_state("misc.slow_walk_key") == false then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"SWITCH")
                ballchunks = ballchunks + 1
            elseif moveconditionidealyaw == 1 and menu.get_key_bind_state("Legit AA") then
                render.draw_text(font3, getcenter_x + 2 , getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif moveconditionidealyaw == 1 and menu.get_key_bind_state("misc.slow_walk_key") == false then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"DYNAMIC")
                ballchunks = ballchunks + 1
            elseif moveconditionidealjitter == 1 and menu.get_key_bind_state("Legit AA") then
                render.draw_text(font3, getcenter_x + 2 , getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"LEGIT AA")
                ballchunks = ballchunks + 1
            elseif moveconditionidealjitter == 1 and menu.get_key_bind_state("misc.slow_walk_key") == false then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(200, 170, 255),"DYNAMIC+")
                ballchunks = ballchunks + 1
            end
            if menu.get_key_bind_state("rage.double_tap_key" ) and menu.get_key_bind_state("anti_aim.fake_duck_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(242, 30, 15),"DT")
                ballchunks = ballchunks + 1
            elseif menu.get_key_bind_state("rage.double_tap_key" ) then 
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(25, 255, 25),"DT")
                ballchunks = ballchunks + 1
            elseif menu.get_key_bind_state("anti_aim.fake_duck_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(255,255,255), "FD")
                ballchunks = ballchunks + 1
            end
            if menu.get_key_bind_state("rage.hide_shots_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(93, 146, 252), "AA")
                ballchunks = ballchunks + 1
            end
            if menu.get_key_bind_state("rage.force_damage_key") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(255, 185, 5), "DMG")
                ballchunks = ballchunks + 1
            end
            if menu.get_key_bind_state("Edge Yaw") then
                render.draw_text(font3, getcenter_x + 2, getcenter_y +40+(11*ballchunks), color.new(255, 255, 255),"EDGE")
                ballchunks = ballchunks + 1
            end
        end

        if mindmgshow == 1 and entitylist.get_local_player() ~= nil and entitylist.get_weapon_by_player(entitylist.get_local_player()) ~= nil  then
            local damgevalue = -1
            local holding = entitylist.get_weapon_by_player(entitylist.get_local_player()):get_class_name()
            --client.log(holding)
            
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
            if damagevalue ~= nil and holding ~= "CKnife" and holding ~= "CDecoyGrenade" and holding ~= "CHEGrenade" and holding ~= "CFlashbang" and holding ~= "CWeaponTaser" and holding ~= "CIncendiaryGrenade" and holding ~= "CMolotovGrenade" and mindmgshow == 1 then
                render.draw_text(font, getcenter_x + 8, getcenter_y - 25 , color.new(255, 255, 255), tostring(damagevalue))
            end 
        end

        if netgraphskeet == 1 then
            render.draw_text( font7, getcenter_x - 80, getcenter_y + ( 50 * 7 ), color.new(255, 255, 255, alpha), "clock syncing")
    		render.draw_text( font7, getcenter_x - 80 + 95, getcenter_y + ( 50 * 7 ), color.new(255, 255, 255), "+-" .. ping .."ms")
    		render.draw_text( font7, getcenter_x - 80 + 73, getcenter_y + ( 50 * 7 ), color.new(255,200,95,255), "  !  " )
            render.draw_text( font7, getcenter_x - 80, getcenter_y + ( 50 * 7 ) + 20, color.new(255, 255, 255), "in : 31.70k/s")
            render.draw_text( font7, getcenter_x - 80 + 75, getcenter_y + ( 50 * 7 ) + 20, color.new(255,125,95), "lerp " ..ping.. "ms")
            render.draw_text( font7, getcenter_x - 80, getcenter_y + ( 50 * 7 ) + 40, color.new(255, 255, 255), "out: 9.08k/s")
            render.draw_text( font7, getcenter_x - 80, getcenter_y + ( 50 * 7 ) + 60, color.new(255, 255, 255), "sv: 6.38 +- 0.02ms var 0.022 ms")
            render.draw_text( font7, getcenter_x - 80, getcenter_y + ( 50 * 7 ) + 80, color.new(255, 255, 255), "tick: "..tick.."p/s")
            render.draw_text( font7, getcenter_x - 80, getcenter_y + ( 50 * 7 ) + 100, color.new(255,125,95), "delay "..ping.." (+- 1m/s)")
            render.draw_text( font7, getcenter_x - 80 + 105, getcenter_y + ( 50 * 7 ) + 100, color.new(255,50,50), "datagram")
    		render.draw_text( font7, getcenter_x - 80 + 35, getcenter_y + ( 50 * 7 ) + 140, color.new(255, 255, 255, alpha), "lagcomp ")
    		if doubleTap or hideShots then
    		    render.draw_text( font, getcenter_x - 80 + 85, getcenter_y + ( 50 * 7 ) + 140, color.new(0, 255, 30), "broken")
    		else
    		    render.draw_text( font, getcenter_x - 80 + 85, getcenter_y + ( 50 * 7 ) + 140, color.new(255,50,50), "unsafe")
    		end
        end

        if netgraphseaside == 1 then
            render.draw_text(lefont, getscreen_x - 1000, getscreen_y - 165, color.new(255, 255, 255), " Clocksync: 0%  (+- 0.2ms)")
            render.draw_text(lefont, getscreen_x - 1000, getscreen_y - 147, color.new(255, 255, 255), " delay: " .. tostring(globals.get_ping() .." ms"))
            render.draw_text(lefont, getscreen_x - 1000, getscreen_y - 127, color.new(255, 255, 255), " velocity: " .. tostring(total_velocity - 1) .." u/s" .. " fps: " .. getframerate .. "")
            render.draw_text(lefont, getscreen_x - 1000, getscreen_y - 107, color.new(255, 255, 255), " tickrate: " .. tostring(tick) .. " time: " .. tostring(os.date("%X",os.time())))
        end

        if fogenable == 1 then
            local fog_color = menu.get_color("Fog Color")
            console.set_string("fog_color", string.format("%i %i %i", fog_color:r(), fog_color:g(), fog_color:b()))
            distance1 = menu.get_float( "                   Start Distance" )
            distance2 = menu.get_float( "                    End Distance" )
            density = menu.get_float( "                          Density" )
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

        if menu.get_key_bind_state("misc.third_person_key") and antiaimdebugenable == 1 then
            velocityfinalvalue = total_velocity/2 + 50
            if not is_key_down(VK_SPACE) and velocityfinalvalue > 5 then
                for i = 0, velocityfinalvalue, 1 do
                    adaos = i
                    compensate = i/2
                end
            elseif is_key_down(VK_CONTROL) and is_key_down(VK_SPACE) then
                velocityfinalvalue = velocityfinalvalue/4
            else
                adaos = 0
            end

            yaw = menu.get_int("anti_aim.yaw_offset")
            positionxholo = getcenter_x + 120
            positionyholo = getcenter_y + 60 + adaos/8 - velocityfinalvalue/4
            line_color1 = menu.get_color("HoloPanel Color")
            render.draw_rect_filled(positionxholo, positionyholo - 3, 200, 2, line_color1)
            render.draw_rect_filled(positionxholo, positionyholo - 2, 200, 70, color.new(20, 20, 20, 50))
            render.draw_text(fonttitle, positionxholo + 5, positionyholo + 2, color.new(255, 255, 255), "Anti Aim Debug")
            render.draw_text(font10, positionxholo + 11, positionyholo + 28, color.new(255, 255, 255), "Angle")
            render.draw_text(font10, positionxholo + 53, positionyholo + 28, color.new(255, 255, 255), ""..synced_dsy_delta.."°")
            render.draw_rect_filled(positionxholo + 5, positionyholo + 30, 2, 13, line_color1)
            
            if inverted then
                render.draw_rect_filled(positionxholo + 60 - synced_dsy_delta/2, positionyholo + 55, synced_dsy_delta/2, 10, line_color1)
            else
                render.draw_rect_filled(positionxholo + 60, positionyholo + 55, synced_dsy_delta/2, 10, line_color1)
            end
            render.draw_rect(positionxholo + 30, positionyholo + 55, 60, 10, color.new(20, 20, 20))
            render.draw_text(font9, positionxholo + 5, positionyholo + 53, color.new(255, 255, 255), "DSY:")
        
            render.draw_text(font9, positionxholo + 135, positionyholo + 53, color.new(255, 255, 255), "OSAA:")
            if antibruteonshot == 1 or antibruteonhit == 1 then
                render.draw_text(font9, positionxholo + 170, positionyholo + 53, color.new(155, 255, 0 ), "ON")
            elseif antibrutedisabled == 1 then
                render.draw_text(font9, positionxholo + 170, positionyholo + 53, color.new(228, 0, 0 ), "OFF")
            end
        end 
    end
    if watermarkmetamod == 1 then
        if engine.is_in_game() then
            local username = globals.get_username()
            local ping = tostring(globals.get_ping())
            local tickrate = math.floor(1.0 / globals.get_intervalpertick())
            local get_time = os.date("%X", os.time())
        
            local text
            
            if engine.is_connected() then
                text = tostring(" seaside [alpha] | " .. globals.get_username() .. " | delay: " .. ping .. "ms | " .. tickrate .. "tick | "..get_time.. " ")
            else
                text = tostring(" seaside [alpha] | " .. globals.get_username() .. " | " ..get_time.. " ")
            end
        
            local line_color = menu.get_color("Watermark")
            local text_color = color.new(255, 255, 255)
            local bg_color = color.new(20, 20, 20, 100)
        
            local x = getscreen_x - 10 - render.get_text_width(font6, text) - 4
            local y = 10
            local w = render.get_text_width(font6, text) + 5
            if watermarkpositionleft == 1 then
                render.draw_rect_filled(10, y - 1, w, 2, line_color)
                render.draw_rect_filled(10, y + 1, w, 18, bg_color)
                render.draw_text(font6, 10 + 2.5, y + 3, text_color, text)
            elseif watermarkpositionright == 1 then
                render.draw_rect_filled(x, y - 1, w, 2, line_color)
                render.draw_rect_filled(x, y + 1, w, 18, bg_color)
                render.draw_text(font6, x + 2.5, y + 3, text_color, text)
            end
        end
    end 

    if watermarkseaside == 1 then
        
        local wtcolor = menu.get_color("Watermark")
    
        local ping = tostring(globals.get_ping())
        local server1 = tostring(globals.get_server_address())
        local seaside = tostring(" SeaSide")
    
        local text = "SeaSide / " .. globals.get_username() .. " / ping: " .. ping .. " / " .. server1 .. " / fps: "
    
        local username = render.get_text_width( watermarkfont, globals.get_username() )
        local server = render.get_text_width( watermarkfont, server1 )
        local fpswidth = render.get_text_width( watermarkfont, getframerate )
        local textwidth = render.get_text_width( watermarkfont, text )
    
        local switfpscache = 21
    
        if watermarkpositionleft == 1 then
            render.draw_rect_filled(0, 4, 5, 18, wtcolor )
            watermarkcustomrect(2, 4, 190 + username + server, 22, false)
            render.draw_text( watermarkfont, 4, 5.5, color.new(0,0,0,255), seaside)
            render.draw_text( watermarkfont, 5, 5, color.new(255,255,255,255), text)
            if tonumber(getframerate)/10 < 10 then
                render.draw_text( watermarkfont, textwidth + 5, 5, color.new(255,255,255,255), " " .. getframerate)
            else
                render.draw_text( watermarkfont, textwidth + 5, 5, color.new(255,255,255,255), "" .. getframerate)
            end
        elseif watermarkpositionright == 1 then
            render.draw_rect_filled(getscreen_x - 2, 4, 5, 18, wtcolor )
            watermarkcustomrect(getscreen_x - 35 - textwidth, 4 , getscreen_x - 2, 22, true)
            render.draw_text( watermarkfont, getscreen_x - 26 - textwidth, 5.5, color.new(0,0,0,255), seaside)
            render.draw_text( watermarkfont, getscreen_x - 25 - textwidth, 5, color.new(255,255,255,255), text)
            if tonumber(getframerate)/10 < 10 then
                render.draw_text( watermarkfont, getscreen_x - 25, 5, color.new(255,255,255,255), " " .. getframerate)
            else
                render.draw_text( watermarkfont, getscreen_x - 27, 5, color.new(255,255,255,255), "" .. getframerate)
            end
        end
    end

    if entitylist.get_local_player() ~= nil then
        is_scoped = entitylist.get_local_player():is_scoped()
    end
    if viewonscope == 1 then
        if is_scoped then
            console.set_float("fov_cs_debug", 90 )
        else
            console.set_float("fov_cs_debug", 0)
        end
    end
    if viewmodel == 1 then
        console.set_float("fov_cs_debug", 0)
    end
end

local drg = 0;
function drag(x, y, w, h)
    local mouse_pos = getMousePos()
    if mouse_pos.x >= x then
        if mouse_pos.x <= x + w then
            if mouse_pos.y <= y + h then
                if mouse_pos.y >= y then
                    if is_key_down(VK_LBUTTON) and (drg == 0) then
                    drg = 1;
                    memoryx = x - mouse_pos.x
                    memoryy = y - mouse_pos.y
                    end
                end
            end
        end
    end
    if not is_key_down(VK_LBUTTON) then
        drg = 0
    end
    if (drg == 1) then
        pos_x = mouse_pos.x+memoryx
        pos_y = mouse_pos.y+memoryy
    --    menu.set_int("test_x", xc+memoryx )
    --    menu.set_int("test_y", xy+memoryy )
    end
end

client.add_callback("on_paint", function()
    if not engine.is_connected() then return end
    if keybindsenable == 1 then
        local test_x = pos_x;
        local test_y = pos_y;
        local test_w = 150;
        local test_h = 18;

        if test_x == nil or test_y == nil then test_x, test_y = 100, 100 end
        if test_x < 0 then
            test_x = 0
        end
        if test_x > getscreen_x - 150 then
            test_x = getscreen_x - 150
        end
        if test_y < 0 then
            test_y = 0
        end
        if test_y > getscreen_y - 18 then
            test_y = getscreen_y - 18
        end

        gradient_rect(test_x + 80, test_y - 3 , test_x + 147, test_y, menu.get_color("Keybinds"),false)
        gradient_rect(test_x + 3, test_y - 3, test_x + 80, test_y, menu.get_color("Keybinds"),true)
        
        --render.draw_rect_filled(pos_x + 3, pos_y, 147, 18, color.new(20, 20, 20, 20))
        render.draw_text(font, test_x + 55, test_y + 2, color.new(255, 255, 255), "keybinds")
        count = 0
        
        add_bind("Double tap", "rage.double_tap_key", test_x + 3, test_y + -2)
        add_bind("Hide shots", "rage.hide_shots_key", test_x + 3, test_y + -2)
        add_bind("Damage override", "rage.force_damage_key", test_x + 3, test_y + -2)
        add_bind("Fake Duck", "anti_aim.fake_duck_key", test_x + 3, test_y + -2)
        add_bind("Edge jump", "misc.edge_jump_key", test_x + 3, test_y + -2)
        add_bind("Slow Walk", "misc.slow_walk_key", test_x + 3, test_y + -2)
        add_bind("Auto peek", "misc.automatic_peek_key", test_x + 3, test_y + -2)
        add_bind("Third person", "misc.third_person_key", test_x + 3, test_y + -2)
        add_bind("Edge yaw", "Edge Yaw", test_x + 3, test_y + -2)
        add_bind("Legit AA", "Legit AA", test_x + 3, test_y + -2)
        add_bind("Anti Aim Flick", "Anti Aim Flick", test_x + 3, test_y + -2)
        drag(test_x, test_y, test_w, test_h )
    end
end)

function panoramablur()
    if disableblurenable == 1 then
        console.set_int("@panorama_disable_blur", 1)
    else
        console.set_int("@panorama_disable_blur", 0)
    end
end

client.add_callback("create_move", function()
    if backtrackenhanced == 1 then
        console.execute("sv_maxunlag 1")
    else
        console.execute("sv_maxunlag 0.200")
    end
end)

function roundprestartstring()
    client.log( "\n------------------------------------------------------------" )
    client.log( "\n------------------------------------------------------------" )
    client.log( "\n------------------------------------------------------------" )
end

local gpinf = engine.get_player_info
    
local logs = {}
local killtrue = {}

function add_log(text, kill)
    table.insert(logs, {text = text, expiration = 5, fadein = 0})
    table.insert(killtrue, {text = kill, expiration = 5, fadein = 0})
end

local ffi = require("ffi")

ffi.cdef[[
    typedef struct
    {
        float x;
        float y;
        float z;
    } Vector_t;
    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);
]]

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

eyepos = {0,0,0}
client.add_callback( "on_paint", function() 
    if enableddormant == 1 then
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
                        render.draw_circle_filled( math.floor(math.floor(newang.x)), math.floor(math.floor(newang.y) - 2), 10 , 5, menu.get_color("Dormant Color") )
                        render.draw_text(font, math.floor(math.floor(newang.x) - 12), math.floor(math.floor(newang.y) + 2), menu.get_color("Dormant Color"), tostring(engine.get_player_info(i).name))
                        render.draw_text(font, math.floor(math.floor(newang.x) - 12), math.floor(math.floor(newang.y) + 10), menu.get_color("Dormant Color"), "hp: " .. tostring(player:get_health()))
                    end
                end
            end
            ::continue::
        end
    end
end)


finaldamagevalue = 0
kill = false

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

    if logsenable == 1 then
        if results == "Hit" then
            if health_final == 0 then
                local text = "Hit " .. targetname .. " for " .. serverdamage .. " in " .. serverhitbox .. " (".. health_final ..")"
                add_log(text, "1")
                console_print_color(color.new(230,94,94,255),text .. "\n")
            else
                local text = "Hit " .. targetname .. " for " .. serverdamage .. " in " .. serverhitbox .. " (".. health_final ..")"
                add_log(text, "0")
                console_print_color(color.new(255,255,255,255),text .. "\n")
            end
        elseif results == "Spread" then
            local text = "Miss " .. targetname .. " in " .. clienthitbox .. " due to spread "
            add_log(text, "0")
            console_print_color(color.new(255,255,255,255),text .. "\n")
        elseif results == "Occlusion" then
            local text = "Miss " .. targetname .. " in " .. clienthitbox .. " due to occlusion "
            add_log(text, "0")
            console_print_color(color.new(255,255,255,255),text .. "\n")
        elseif results == "Resolver" then
            local text = "Miss " .. targetname .. " in " .. clienthitbox .. " due to resolver "
            add_log(text, "0")
            console_print_color(color.new(255,255,255,255),text .. "\n")
        else
            local text = "Missed shot due to death "
            add_log(text, "0")
            console_print_color(color.new(255,255,255,255),text .. "\n")
        end
    end
    if logsconsole == 1 then
        if results == "Hit" then
            client.log( "\n[SeaSide] Hit " .. targetname .. " for " .. serverdamage .. " in " .. serverhitbox .. " (".. health_final ..")" )
        elseif results == "Spread" then
          client.log( "\n[SeaSide] Miss " .. targetname .. " in " .. clienthitbox .. " due to spread ") 
        elseif results == "Occlusion" then
          client.log( "\n[SeaSide] Miss " .. targetname .. " in " .. clienthitbox .. " due to occlusion ")
        elseif results == "Resolver" then
          client.log( "\n[SeaSide] Miss " .. targetname .. " in " .. clienthitbox .. " due to resolver ")
        else
          client.log( "\n[SeaSide] Missed shot due to death")
        end
    end
end

local hitgroups = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }

function hurtevent(event)
    local localplayer = entitylist.get_local_player()
    if not localplayer then return end

    local attacker = engine.get_player_for_user_id(event:get_int("attacker"))
    if not attacker then return end
    local victim = engine.get_player_for_user_id(event:get_int("userid"))
    if not victim then return end
    local damage = event:get_int("dmg_health")
    local hitgroup = event:get_int("hitgroup")
    if victim == localplayer:get_index() then
        local info = engine.get_player_info( attacker )
        if logsenable == 1 then
            local text = "Harmed by " ..info.name .. " in " .. hitgroups[hitgroup+1] .. " for " .. damage .. " damage "
            add_log(text, "0")
            console_print_color(color.new(255,255,255,255),text .. "\n")
        elseif logsconsole == 1 then
            client.log("\n[SeaSide] Harmed by " ..info.name .. " in " .. hitgroups[hitgroup+1] .. " for " .. damage .. " damage ")
        end
    end
end

client.add_callback("on_paint", function()
    for i = 1, #logs do
        if (logs[i] ~= nil) then
            local ratio = 1
            if (logs[i].expiration <= 1) then
                ratio = (logs[i].expiration) / 1
                ratio = (killtrue[i].expiration) / 1
            end
            local step = 255 / 0.9 * (globals.get_frametime()) * 2
            if logs[i].expiration >= 4 then
                logs[i].fadein = 0
                killtrue[i].fadein = 0
            else
                logs[i].fadein = logs[i].fadein + step
                killtrue[i].fadein = killtrue[i].fadein + step
            end
            if logs[i].fadein > 244 then
                logs[i].fadein = 255
                killtrue[i].fadein = 255
            end

            if string.match(logs[i].text, "Hit") and string.match(killtrue[i].text, "1") then
                render.draw_text(font, getcenter_x - render.get_text_width(font, logs[i].text)/2, getcenter_y + 8 * (i - 1) * 2 + 180, color.new(230,94,94), logs[i].text)
            else
                render.draw_text(font, getcenter_x - render.get_text_width(font, logs[i].text)/2, getcenter_y + 8 * (i - 1) * 2 + 180, color.new(255,255,255), logs[i].text)
            end

            logs[i].expiration = logs[i].expiration - 0.007
            if (logs[i].expiration <= -1) then
                table.remove(logs, i)
                table.remove(killtrue, i)
            end
        end
    end
end)


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
	    if clantagenable == 1 then
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

client.add_callback( "create_move", function(cmd)
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
    if overrideautopeekalways == 1 then
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
    elseif overrideautopeekonshot == 1 then
    end
end)

int = 0
function createmove_func(cmd)
    if pitchlanddisable == 1 then return end
    if entitylist.get_local_player() == nil then return end

    flag = entitylist.get_local_player():get_prop_int("CBasePlayer", "m_fFlags")

    if flag == 256 or flag == 262 then
        int = 0
    end

    if flag == 257 or flag == 261 or flag == 263 then
        int = int + 4
    end

    if int > 45 and int < 250 then
        menu.set_int("anti_aim.pitch", 0)
    elseif menu.get_key_bind_state("Legit AA") then
        menu.set_int("anti_aim.pitch", 0)
    else
        menu.set_int("anti_aim.pitch", 1)
    end
end

entity_list_ptr = ffi.cast("void***", utils.create_interface("client.dll", "VClientEntityList003"))
get_client_entity_fn = ffi.cast("GetClientEntity_4242425_t", entity_list_ptr[0][3])

local ffi_helpers = {
    get_entity_address = function(ent_index)
        local addr = get_client_entity_fn(entity_list_ptr, ent_index)
        return addr
    end
}

local offset_value = 0x9960
local shared_onground

client.add_callback("on_paint", function()
    local localplayer = entitylist.get_local_player()
    if not localplayer then return end

    local bOnGround = bit.band(localplayer:get_prop_float("CBasePlayer", "m_fFlags"), bit.lshift(1,0)) ~= 0
    if not bOnGround then
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(localplayer:get_index()) + offset_value)[0].flDurationInAir = 99
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(localplayer:get_index()) + offset_value)[0].flHitGroundCycle = 0
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(localplayer:get_index()) + offset_value)[0].bHitGroundAnimation = false
    end

    shared_onground = bOnGround
end)
client.add_callback("on_paint", function()
    local localplayer = entitylist.get_local_player()
    if not localplayer then return end

    local bOnGround = bit.band(localplayer:get_prop_float("CBasePlayer", "m_fFlags"), bit.lshift(1,0)) ~= 0
    if bOnGround and not shared_onground then
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(localplayer:get_index()) + offset_value)[0].flDurationInAir = 0.5
    end 
end)
function GetModuleHandle(file)
    return ffi.C.GetModuleHandleA(file)
end

local function copy(dst, src, len)
    return ffi.copy(ffi.cast('void*', dst), ffi.cast('const void*', src), len)
end
local buff = {free = {}}
local function VirtualProtect(lpAddress, dwSize, flNewProtect, lpflOldProtect)
    return ffi.C.VirtualProtect(ffi.cast('void*', lpAddress), dwSize, flNewProtect, lpflOldProtect)
end
local function VirtualAlloc(lpAddress, dwSize, flAllocationType, flProtect, blFree)
    local alloc = ffi.C.VirtualAlloc(lpAddress, dwSize, flAllocationType, flProtect)
    if blFree then
        table.insert(buff.free, function()
            ffi.C.VirtualFree(alloc, 0, 0x8000)
        end)
    end
    return ffi.cast('intptr_t', alloc)
end

local vmt_hook = {hooks = {}}
function vmt_hook.new(vt)
    local new_hook = {}
    local org_func = {}
    local old_prot = ffi.new('unsigned long[1]')
    local virtual_table = ffi.cast('intptr_t**', vt)[0]
    new_hook.this = virtual_table
    new_hook.hookMethod = function(cast, func, method)
        org_func[method] = virtual_table[method]
        VirtualProtect(virtual_table + method, 4, 0x4, old_prot)
        virtual_table[method] = ffi.cast('intptr_t', ffi.cast(cast, func))
        VirtualProtect(virtual_table + method, 4, old_prot[0], old_prot)
        return ffi.cast(cast, org_func[method])
    end
    new_hook.unHookMethod = function(method)
        VirtualProtect(virtual_table + method, 4, 0x4, old_prot)

        local alloc_addr = VirtualAlloc(nil, 5, 0x1000, 0x40, false)
        local trampoline_bytes = ffi.new('uint8_t[?]', 5, 0x90)
        trampoline_bytes[0] = 0xE9
        ffi.cast('int32_t*', trampoline_bytes + 1)[0] = org_func[method] - tonumber(alloc_addr) - 5
        copy(alloc_addr, trampoline_bytes, 5)
        virtual_table[method] = ffi.cast('intptr_t', alloc_addr)
        VirtualProtect(virtual_table + method, 4, old_prot[0], old_prot)
        org_func[method] = nil
    end
    new_hook.unHookAll = function()
        for method, func in pairs(org_func) do
            new_hook.unHookMethod(method)
        end
    end
    table.insert(vmt_hook.hooks, new_hook.unHookAll)
    return new_hook
end

client.add_callback( 'unload', function()
    for i, unHookFunc in ipairs(vmt_hook.hooks) do
        unHookFunc()
    end
end)

local customplayers = {
    { "DangerZone A", "models/player/custom_player/legacy/tm_jumpsuit_varianta.mdl"},
    { "DangerZone B", "models/player/custom_player/legacy/tm_jumpsuit_variantb.mdl"},
    { "DangerZone Red", "models/player/custom_player/kirby/leetkumla/leetkumla.mdl"},
    { "GTA2", "models/player/custom_player/z-piks.ru/gta_crip.mdl"},
    { "Arctic", "models/player/custom_player/kuristaja/cso2/arctic/arctic.mdl"},
    { "Choi", "models/player/custom_player/kuristaja/cso2/choi/choi.mdl"},
    { "Emma", "models/player/custom_player/kuristaja/cso2/emma/emma.mdl"},
    { "Lisa", "models/player/custom_player/kuristaja/cso2/lisa/lisa.mdl"},
    { "Gunslinger Blue", "models/player/custom_player/caleon1/gunslinger/gunslinger_blue.mdl"},
    { "Gunslinger Red", "models/player/custom_player/caleon1/gunslinger/gunslinger_red.mdl"},
    { "Walrider", "models/player/custom_player/ic3d/outlast/walrider/walrider.mdl"},
}

local class_ptr = ffi.typeof("void***")
local void_ptr = ffi.typeof("void*")

local rawientitylist = utils.create_interface("client.dll", "VClientEntityList003") or print("VClientEntityList003 wasnt found")
local ientitylist = ffi.cast(class_ptr, rawientitylist) or print("rawientitylist is nil")
local get_client_entity = ffi.cast("get_client_entity_t", ientitylist[0][3]) or print("get_client_entity is nil")

local rawivmodelinfo = utils.create_interface("engine.dll", "VModelInfoClient004") or print("VModelInfoClient004 wasnt found")
local ivmodelinfo = ffi.cast(class_ptr, rawivmodelinfo) or print("rawivmodelinfo is nil")
local get_model_index = ffi.cast("get_model_index_t", ivmodelinfo[0][2]) or print("get_model_info is nil")
local find_or_load_model = ffi.cast("find_or_load_model_t", ivmodelinfo[0][39]) or print("find_or_load_model is nil")

local rawnetworkstringtablecontainer = utils.create_interface("engine.dll", "VEngineClientStringTable001") or print("VEngineClientStringTable001 wasnt found")
local networkstringtablecontainer = ffi.cast(class_ptr, rawnetworkstringtablecontainer) or print("rawnetworkstringtablecontainer is nil")
local find_table = ffi.cast("find_table_t", networkstringtablecontainer[0][3]) or print("find_table is nil")
local force_updatefn = utils.find_signature( 'engine.dll',   "A1 ? ? ? ? B9 ? ? ? ? 56 FF 50 14 8B 34 85" )
local force_update = ffi.cast("ForceUpdateFn", force_updatefn)

local model_names = {}
for k,v in pairs(customplayers) do
    table.insert(model_names, v[1])
end

menu.next_line()
menu.add_combo_box( '                          Models', model_names )

local function precache_model(modelname)
    local rawprecache_table = find_table(networkstringtablecontainer, "modelprecache") or print("couldnt find modelprecache")
    if rawprecache_table then
        local precache_table = ffi.cast(class_ptr, rawprecache_table) or print("couldnt cast precache_table")
        if precache_table then
            local add_string = ffi.cast("add_string_t", precache_table[0][8]) or print("add_string is nil")
            local emtpy_void_ptr = ffi.cast(void_ptr, 0)

            find_or_load_model(ivmodelinfo, modelname)
            local idx = add_string(precache_table, false, modelname, -1, emtpy_void_ptr)
            if idx == -1 then
              return false
            end
        end
    end
    return true
end

local function set_model_index(entity, idx)
    local raw_entity = get_client_entity(ientitylist, entity)
    if raw_entity then 
        local gce_entity = ffi.cast(class_ptr, raw_entity)
        local a_set_model_index = ffi.cast("set_model_index_t", gce_entity[0][75])
        if a_set_model_index == nil then 
            print("set_model_index is nil")
        end
        a_set_model_index(gce_entity, idx)
    end
end

local function change_model(ent, model)
    if model:len() > 5 then 
        if precache_model(model) == false then 
            print("invalid model")
        end
        local idx = get_model_index(ivmodelinfo, model)
        if idx == -1 then 
            return
        end
        set_model_index(ent, idx)
    end
end

local team_references, team_model_paths = {}, {}
local model_index_prev
local model_name, model_path, model_is_t

local l_i = 0
local oldcboxint = 0
local update_skins = true
function modelchanger(stage)
    if modelchangerenable == 1 then
        if stage ~= 4 then return end

        local me = engine.get_local_player_index()
        if me == nil then return end

        local cboxint = menu.get_int( '                          Models' ) + 1
    
        change_model(me, customplayers[cboxint][2])
    end
end

local CMInt = utils.create_interface( "client.dll", "VClient018" )
local Client = vmt_hook.new(CMInt)

function fsnweather(stage)
    modelchanger(stage)
    res = fsn(stage)
    return res
end

fsn = Client.hookMethod("void(__stdcall *)(int Stage)", fsnweather, 37)


--callbacks
client.add_callback("on_shot", resolver)
client.add_callback("create_move", antiaim )
client.add_callback("create_move", legbreaker)
client.add_callback("create_move", fakeflick)
client.add_callback("create_move", switcher)
client.add_callback("on_shot", on_shot)
client.add_callback("create_move", legitaaonkey)
client.add_callback("create_move", edgeyaw)
client.add_callback("on_paint", allpaint)
client.add_callback("on_paint", panoramablur)
client.add_callback("on_shot", hitlog)
client.add_callback("on_paint", clantag)
client.add_callback("create_move", createmove_func)

--events
events.register_event("player_death", killleft)
events.register_event("round_prestart", roundprestartstring)
events.register_event("player_hurt", hurtevent)

--materials
local glow = [[
    { 
        "$additive"					"1" 
        "$envmap"					"models/effects/cube_white" 
        "$envmaptint"				"[1 1 1]" 
        "$envmapfresnel"			"1" 
        "$envmapfresnelminmaxexp" 	"[0 1 2]" 
        "$alpha" 					"0.8" 
    }
]]

local bubble = [[
    {
        "$basetexture"                "dev/zone_warning"
        "$additive"                    "1"
        "$envmap"                    "editor/cube_vertigo"
        "$envmaptint"                "[0 0.5 0.55]"
        "$envmapfresnel"            "1"
        "$envmapfresnelminmaxexp"   "[0.00005 0.6 6]"
        "$alpha"                    "1"
    }
]]

local circuit = [[
    {
    "$additive" "1"
    "$envmap" "models/effects/cube_white"
    "$envmaptint" "[1 1 1]"
    "$envmapfresnel" "1"
    "$envmapfresnelminmaxexp" "[0 5 10]"
    "$alpha" "1"
    }
]]

material.create("Glow", glow, false)
material.create("Circuit", circuit, false)
material.create("Bubble", bubble, false)

--unload
client.add_callback("unload", function()
    menu.set_bool("anti_aim.invert_desync_key", false)
    console.set_float("fog_color", -1);
    console.set_float("fog_override", 0)
    console.set_float("fog_start", -1)
    console.set_float("fog_end", -1)
    console.set_float("fog_maxdensity", -1)
    scriptenabled = false
end)

local posix = 300
local posiy = 300
local draug = 0;
function menudrag(x, y, w, h)
    if not menu.get_key_bind_state("Open Menu") then return end
    local mouse_pos = getMousePos()
    if mouse_pos.x >= x then
        if mouse_pos.x <= x + w then
            if mouse_pos.y <= y + h then
                if mouse_pos.y >= y then
                    if is_key_down(VK_LBUTTON) and (draug == 0) then
                    draug = 1;
                    memoryx = x - mouse_pos.x
                    memoryy = y - mouse_pos.y
                    end
                end
            end
        end
    end
    if not is_key_down(VK_LBUTTON) then
        draug = 0
    end
    if (draug == 1) then
        posix = mouse_pos.x+memoryx
        posiy = mouse_pos.y+memoryy
    --    menu.set_int("test_x", xc+memoryx )
    --    menu.set_int("test_y", xy+memoryy )
    end
end

function menupaint()
    mouse_pos = getMousePos()
    --client.log("" .. tostring(mouse_pos.x) .. " - " .. tostring(mouse_pos.y) .. "")
    
    if not menu.get_key_bind_state("Open Menu") then
        return
    end
    
    local menu_x = posix
    local menu_y = posiy
    local menuswitchx = 160
    local menuswitchy = 100
    if menu_x < 0 then
        menu_x = 0
    end
    if menu_x > getscreen_x - 600 then
        menu_x = getscreen_x - 600
    end
    if menu_y < 0 then
        menu_y = 0
    end
    if menu_y > getscreen_y - 400 then
        menu_y = getscreen_y - 400
    end

    menudrag(menu_x, menu_y, menuswitchx, menuswitchy)
    
    local maincolor = menu.get_color("clrcolor")
    render.draw_rect_filled( menu_x, menu_y, 600, 400, color.new(20,20,20,200) )
    render.draw_rect_filled( menu_x, menu_y, 600, 2, maincolor )
    render.draw_text( logofont, menu_x + 30, menu_y + 30, color.new(255,255,255), "SeaSide")

    render.draw_text( generalmenufont, menu_x + 30, menu_y + 120, color.new(255,255,255), "Rage")
    render.draw_text( generalmenufont, menu_x + 30, menu_y + 170, color.new(255,255,255), "Anti-Aim")
    render.draw_text( generalmenufont, menu_x + 30, menu_y + 220, color.new(255,255,255), "Visuals")
    render.draw_text( generalmenufont, menu_x + 30, menu_y + 270, color.new(255,255,255), "Misc")
    render.draw_text( generalmenufont, menu_x + 30, menu_y + 320, color.new(255,255,255), "Configs")

    render.draw_rect_filled( menu_x + 160, menu_y + 20, 5, 360, color.new(20,20,20,50) )
    --client.log(tostring(is_key_down(VK_LBUTTON)))

    if is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x + 2 and mouse_pos.y >= menu_y + 115 and mouse_pos.x <= menu_x + 159 and mouse_pos.y <= menu_y + 154 or menurage == 1 then
        render.draw_rect_filled(   menu_x + 150, menu_y + 119, 10, 35, maincolor )
        menurage = 1
        menuaa = 0
        menuvisual = 0
        menumisc = 0
        menuconfigs = 0
    end
    if is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x + 2 and mouse_pos.y >= menu_y + 160 and mouse_pos.x <= menu_x + 159 and mouse_pos.y <= menu_y + 204 or menuaa == 1 then
        render.draw_rect_filled( menu_x + 150, menu_y + 170, 10, 35, maincolor )
        menurage = 0
        menuaa = 1
        menuvisual = 0
        menumisc = 0
        menuconfigs = 0
    end
    if is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x + 2 and mouse_pos.y >= menu_y + 214 and mouse_pos.x <= menu_x + 159 and mouse_pos.y <= menu_y + 255 or menuvisual == 1 then
        render.draw_rect_filled( menu_x + 150, menu_y + 220, 10, 35, maincolor )
        menurage = 0
        menuaa = 0
        menuvisual = 1
        menumisc = 0
        menuconfigs = 0
    end
    if is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x + 2 and mouse_pos.y >= menu_y + 259 and mouse_pos.x <= menu_x + 159 and mouse_pos.y <= menu_y + 300 or menumisc == 1 then
        render.draw_rect_filled( menu_x + 150, menu_y + 270, 10, 35, maincolor )
        menurage = 0
        menuaa = 0
        menuvisual = 0
        menumisc = 1
        menuconfigs = 0
    end
    if is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x + 2 and mouse_pos.y >= menu_y + 313 and mouse_pos.x <= menu_x + 159 and mouse_pos.y <= menu_y + 352 or menuconfigs == 1 then
        render.draw_rect_filled( menu_x + 150, menu_y + 320, 10, 35, maincolor )
        menurage = 0
        menuaa = 0
        menuvisual = 0
        menumisc = 0
        menuconfigs = 1
    end

    if menurage == 1 then
        render.draw_rect_filled( menu_x + 255, menu_y + 28, 118, 20, color.new(25,25,25,200) )
        if switchragebotresolverfalse == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x + 255 and mouse_pos.x <= menu_x + 315 and mouse_pos.y >= menu_y + 28 and mouse_pos.y <= menu_y + 46 then
            switchragebotresolverfalse = 1
            switchragebotresolvertrue = 0

            render.draw_text( checkboxmenufont, menu_x + 260, menu_y + 30, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x + 317, menu_y +30, color.new(50,50,50,150), "Enabled")
        end
        if switchragebotresolvertrue == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x + 316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +28 and mouse_pos.y <= menu_y +46 then
            switchragebotresolverfalse = 0
            switchragebotresolvertrue = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +30, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +30, maincolor, "Enabled")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +30, color.new(255,255,255), "Resolver")

        render.draw_rect_filled(menu_x +255, menu_y +58, 120, 20, color.new(25,25,25,200) )
        if backtrackdefault == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +308 and mouse_pos.y >= menu_y +49 and mouse_pos.y <= menu_y +68 then
            backtrackdefault = 1
            backtrackenhanced = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +60, maincolor, "Default")
            render.draw_text( checkboxmenufont, menu_x +310, menu_y +60, color.new(50,50,50,150), "Enhanced")
        end
        if backtrackenhanced == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +309 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +49 and mouse_pos.y <= menu_y +68 then
            backtrackdefault = 0
            backtrackenhanced = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +60, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +310, menu_y +60, maincolor, "Enhanced")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +60, color.new(255,255,255), "Backtrack")
    end

    if menuaa == 1 then
        --move
        render.draw_rect_filled( menu_x +250, menu_y +30, 330, 40, color.new(25,25,25,200) )
        if moveconditiondisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +250 and mouse_pos.x <= menu_x +310 and mouse_pos.y >= menu_y +30 and mouse_pos.y <= menu_y +45 then
            moveconditiondisable = 1
            moveconditiondefault = 0
            moveconditiondefaultjitter = 0
            moveconditioncustomjitter = 0
            moveconditionlowdelta = 0
            moveconditonlowdelta2 = 0
            moveconditionrandomjitter = 0
            moveconditionswitch = 0
            moveconditionidealyaw = 0
            moveconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, color.new(50,50,50,150), "IdealJitter")
        end
        if moveconditiondefault == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >=  menu_x +310 and mouse_pos.x <=  menu_x +362 and mouse_pos.y >= menu_y +30 and mouse_pos.y <= menu_y +45 then
            moveconditiondisable = 0
            moveconditiondefault = 1
            moveconditiondefaultjitter = 0
            moveconditioncustomjitter = 0
            moveconditionlowdelta = 0
            moveconditonlowdelta2 = 0
            moveconditionrandomjitter = 0
            moveconditionswitch = 0
            moveconditionidealyaw = 0
            moveconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, maincolor, "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, color.new(50,50,50,150), "IdealJitter")
        end
        if moveconditiondefaultjitter == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >=  menu_x +363 and mouse_pos.x <=  menu_x +396 and mouse_pos.y >= menu_y +30 and mouse_pos.y <= menu_y +45 then
            moveconditiondisable = 0
            moveconditiondefault = 0
            moveconditiondefaultjitter = 1
            moveconditioncustomjitter = 0
            moveconditionlowdelta = 0
            moveconditonlowdelta2 = 0
            moveconditionrandomjitter = 0
            moveconditionswitch = 0
            moveconditionidealyaw = 0
            moveconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, maincolor, "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, color.new(50,50,50,150), "IdealJitter")
        end
        if moveconditioncustomjitter == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >=  menu_x +397 and mouse_pos.x <=  menu_x +440 and mouse_pos.y >= menu_y +30 and mouse_pos.y <= menu_y +45 then
            moveconditiondisable = 0
            moveconditiondefault = 0
            moveconditiondefaultjitter = 0
            moveconditioncustomjitter = 1
            moveconditionlowdelta = 0
            moveconditonlowdelta2 = 0
            moveconditionrandomjitter = 0
            moveconditionswitch = 0
            moveconditionidealyaw = 0
            moveconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, maincolor, "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, color.new(50,50,50,150), "IdealJitter")
        end
        if moveconditionlowdelta == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >=  menu_x +441 and mouse_pos.x <=  menu_x +503 and mouse_pos.y >= menu_y +30 and mouse_pos.y <= menu_y +45 then
            moveconditiondisable = 0
            moveconditiondefault = 0
            moveconditiondefaultjitter = 0
            moveconditioncustomjitter = 0
            moveconditionlowdelta = 1
            moveconditonlowdelta2 = 0
            moveconditionrandomjitter = 0
            moveconditionswitch = 0
            moveconditionidealyaw = 0
            moveconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, maincolor, "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, color.new(50,50,50,150), "IdealJitter")
        end
        if moveconditonlowdelta2 == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >=  menu_x +504 and mouse_pos.x <=  menu_x +579 and mouse_pos.y >= menu_y +30 and mouse_pos.y <= menu_y +45 then
            moveconditiondisable = 0
            moveconditiondefault = 0
            moveconditiondefaultjitter = 0
            moveconditioncustomjitter = 0
            moveconditionlowdelta = 0
            moveconditonlowdelta2 = 1
            moveconditionrandomjitter = 0
            moveconditionswitch = 0
            moveconditionidealyaw = 0
            moveconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, maincolor, "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, color.new(50,50,50,150), "IdealJitter")
        end
        if moveconditionrandomjitter == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >=  menu_x +250 and mouse_pos.x <=  menu_x +337 and mouse_pos.y >= menu_y +46 and mouse_pos.y <= menu_y +69 then
            moveconditiondisable = 0
            moveconditiondefault = 0
            moveconditiondefaultjitter = 0
            moveconditioncustomjitter = 0
            moveconditionlowdelta = 0
            moveconditonlowdelta2 = 0
            moveconditionrandomjitter = 1
            moveconditionswitch = 0
            moveconditionidealyaw = 0
            moveconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, maincolor, "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, color.new(50,50,50,150), "IdealJitter")
        end
        if moveconditionswitch == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >=  menu_x +338 and mouse_pos.x <=  menu_x +382 and mouse_pos.y >= menu_y +46 and mouse_pos.y <= menu_y +69 then
            moveconditiondisable = 0
            moveconditiondefault = 0
            moveconditiondefaultjitter = 0
            moveconditioncustomjitter = 0
            moveconditionlowdelta = 0
            moveconditonlowdelta2 = 0
            moveconditionrandomjitter = 0
            moveconditionswitch = 1
            moveconditionidealyaw = 0
            moveconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, maincolor, "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, color.new(50,50,50,150), "IdealJitter")
        end
        if moveconditionidealyaw == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >=  menu_x +383 and mouse_pos.x <=  menu_x +443 and mouse_pos.y >= menu_y +46 and mouse_pos.y <= menu_y +69 then
            moveconditiondisable = 0
            moveconditiondefault = 0
            moveconditiondefaultjitter = 0
            moveconditioncustomjitter = 0
            moveconditionlowdelta = 0
            moveconditonlowdelta2 = 0
            moveconditionrandomjitter = 0
            moveconditionswitch = 0
            moveconditionidealyaw = 1
            moveconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, maincolor, "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, color.new(50,50,50,150), "IdealJitter")
        end
        if moveconditionidealjitter == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >=  menu_x +444 and mouse_pos.x <=  menu_x +510 and mouse_pos.y >= menu_y +46 and mouse_pos.y <= menu_y +69 then
            moveconditiondisable = 0
            moveconditiondefault = 0
            moveconditiondefaultjitter = 0
            moveconditioncustomjitter = 0
            moveconditionlowdelta = 0
            moveconditonlowdelta2 = 0
            moveconditionrandomjitter = 0
            moveconditionswitch = 0
            moveconditionidealyaw = 0
            moveconditionidealjitter = 1
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +32, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +32, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +32, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +32, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +32, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +50, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +50, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +50, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +50, maincolor, "IdealJitter")
        end
        render.draw_text( checkboxmenufont,  menu_x +180, menu_y +42, color.new(255,255,255), "Move AA")

        --slow
        render.draw_rect_filled( menu_x +250, menu_y +80, 330, 40, color.new(25,25,25,200) )
        if slowconditiondisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +250 and mouse_pos.x <= menu_x +310 and mouse_pos.y >= menu_y +80 and mouse_pos.y <= menu_y +95 then
            slowconditiondisable = 1
            slowconditiondefault = 0
            slowconditiondefaultjitter = 0
            slowconditioncustomjitter = 0
            slowconditionlowdelta = 0
            slowconditonlowdelta2 = 0
            slowconditionrandomjitter = 0
            slowconditionswitch = 0
            slowconditionidealyaw = 0
            slowconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, color.new(50,50,50,150), "IdealJitter")
        end
        if slowconditiondefault == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +310 and mouse_pos.x <= menu_x +362 and mouse_pos.y >= menu_y +80 and mouse_pos.y <= menu_y +95 then
            slowconditiondisable = 0
            slowconditiondefault = 1
            slowconditiondefaultjitter = 0
            slowconditioncustomjitter = 0
            slowconditionlowdelta = 0
            slowconditonlowdelta2 = 0
            slowconditionrandomjitter = 0
            slowconditionswitch = 0
            slowconditionidealyaw = 0
            slowconditionidealjitter = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, maincolor, "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, color.new(50,50,50,150), "IdealJitter")
        end
        if slowconditiondefaultjitter == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +363 and mouse_pos.x <= menu_x +396 and mouse_pos.y >= menu_y +80 and mouse_pos.y <= menu_y +95 then
            slowconditiondisable = 0
            slowconditiondefault = 0
            slowconditiondefaultjitter = 1
            slowconditioncustomjitter = 0
            slowconditionlowdelta = 0
            slowconditonlowdelta2 = 0
            slowconditionrandomjitter = 0
            slowconditionswitch = 0
            slowconditionidealyaw = 0
            slowconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, maincolor, "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, color.new(50,50,50,150), "IdealJitter")
        end
        if slowconditioncustomjitter == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +397 and mouse_pos.x <= menu_x +440 and mouse_pos.y >= menu_y +80 and mouse_pos.y <= menu_y +95 then
            slowconditiondisable = 0
            slowconditiondefault = 0
            slowconditiondefaultjitter = 0
            slowconditioncustomjitter = 1
            slowconditionlowdelta = 0
            slowconditonlowdelta2 = 0
            slowconditionrandomjitter = 0
            slowconditionswitch = 0
            slowconditionidealyaw = 0
            slowconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, maincolor, "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, color.new(50,50,50,150), "IdealJitter")
        end
        if slowconditionlowdelta == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +441 and mouse_pos.x <= menu_x +503 and mouse_pos.y >= menu_y +80 and mouse_pos.y <= menu_y +95 then
            slowconditiondisable = 0
            slowconditiondefault = 0
            slowconditiondefaultjitter = 0
            slowconditioncustomjitter = 0
            slowconditionlowdelta = 1
            slowconditonlowdelta2 = 0
            slowconditionrandomjitter = 0
            slowconditionswitch = 0
            slowconditionidealyaw = 0
            slowconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, maincolor, "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, color.new(50,50,50,150), "IdealJitter")
        end
        if slowconditonlowdelta2 == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +504 and mouse_pos.x <= menu_x +579 and mouse_pos.y >=menu_y +80 and mouse_pos.y <= menu_y +95 then
            slowconditiondisable = 0
            slowconditiondefault = 0
            slowconditiondefaultjitter = 0
            slowconditioncustomjitter = 0
            slowconditionlowdelta = 0
            slowconditonlowdelta2 = 1
            slowconditionrandomjitter = 0
            slowconditionswitch = 0
            slowconditionidealyaw = 0
            slowconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, maincolor, "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, color.new(50,50,50,150), "IdealJitter")
        end
        if slowconditionrandomjitter == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +250 and mouse_pos.x <= menu_x +337 and mouse_pos.y >= menu_y +96 and mouse_pos.y <= menu_y +116 then
            slowconditiondisable = 0
            slowconditiondefault = 0
            slowconditiondefaultjitter = 0
            slowconditioncustomjitter = 0
            slowconditionlowdelta = 0
            slowconditonlowdelta2 = 0
            slowconditionrandomjitter = 1
            slowconditionswitch = 0
            slowconditionidealyaw = 0
            slowconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, maincolor, "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, color.new(50,50,50,150), "IdealJitter")
        end
        if slowconditionswitch == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +338 and mouse_pos.x <= menu_x +382 and mouse_pos.y >= menu_y +96 and mouse_pos.y <= menu_y +116 then
            slowconditiondisable = 0
            slowconditiondefault = 0
            slowconditiondefaultjitter = 0
            slowconditioncustomjitter = 0
            slowconditionlowdelta = 0
            slowconditonlowdelta2 = 0
            slowconditionrandomjitter = 0
            slowconditionswitch = 1
            slowconditionidealyaw = 0
            slowconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, maincolor, "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, color.new(50,50,50,150), "IdealJitter")
        end
        if slowconditionidealyaw == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +383 and mouse_pos.x <= menu_x +443 and mouse_pos.y >= menu_y +96 and mouse_pos.y <= menu_y +116  then
            slowconditiondisable = 0
            slowconditiondefault = 0
            slowconditiondefaultjitter = 0
            slowconditioncustomjitter = 0
            slowconditionlowdelta = 0
            slowconditonlowdelta2 = 0
            slowconditionrandomjitter = 0
            slowconditionswitch = 0
            slowconditionidealyaw = 1
            slowconditionidealjitter = 0
        
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, maincolor, "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, color.new(50,50,50,150), "IdealJitter")
        end
        if slowconditionidealjitter == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +444 and mouse_pos.x <= menu_x +510 and mouse_pos.y >= menu_y +96 and mouse_pos.y <= menu_y +116  then
            slowconditiondisable = 0
            slowconditiondefault = 0
            slowconditiondefaultjitter = 0
            slowconditioncustomjitter = 0
            slowconditionlowdelta = 0
            slowconditonlowdelta2 = 0
            slowconditionrandomjitter = 0
            slowconditionswitch = 0
            slowconditionidealyaw = 0
            slowconditionidealjitter = 1

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +84, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +315, menu_y +84, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +84, color.new(50,50,50,150), "Jitter")
            render.draw_text( checkboxmenufont, menu_x +400, menu_y +84, color.new(50,50,50,150), "Jitter+")
            render.draw_text( checkboxmenufont, menu_x +443, menu_y +84, color.new(50,50,50,150), "LowDelta")
            render.draw_text( checkboxmenufont, menu_x +506, menu_y +84, color.new(50,50,50,150), "LowDelta+")
            render.draw_text( checkboxmenufont, menu_x +255, menu_y +100, color.new(50,50,50,150), "RandomJitter")
            render.draw_text( checkboxmenufont, menu_x +340, menu_y +100, color.new(50,50,50,150), "Switch")
            render.draw_text( checkboxmenufont, menu_x +384, menu_y +100, color.new(50,50,50,150), "IdealYaw")
            render.draw_text( checkboxmenufont, menu_x +446, menu_y +100, maincolor, "IdealJitter")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +90, color.new(255,255,255), "Slow AA")

        --antibrute
        render.draw_rect_filled( menu_x +250, menu_y +130, 155, 20, color.new(25,25,25,200) )
        if antibrutedisabled == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +308 and mouse_pos.y >= menu_y +130 and mouse_pos.y <= menu_y +147 then
            antibrutedisabled = 1
            antibruteonshot = 0
            antibruteonhit = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +132, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +132, color.new(50,50,50,150), "OnShot")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +132, color.new(50,50,50,150), "OnHit")
        end
        if antibruteonshot == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +309 and mouse_pos.x <= menu_x +361 and mouse_pos.y >= menu_y +130 and mouse_pos.y <= menu_y +147 then
            antibrutedisabled = 0
            antibruteonshot = 1
            antibruteonhit = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +132, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +132, maincolor, "OnShot")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +132, color.new(50,50,50,150), "OnHit")
        end
        if antibruteonhit == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +362 and mouse_pos.x <= menu_x +402 and mouse_pos.y >= menu_y +130 and mouse_pos.y <= menu_y +147 then
            antibrutedisabled = 0
            antibruteonshot = 0
            antibruteonhit = 1

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +132, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +132, color.new(50,50,50,150), "OnShot")
            render.draw_text( checkboxmenufont, menu_x +365, menu_y +132, maincolor, "OnHit")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +132, color.new(255,255,255), "AntiBrute")

        --legbreaker
        render.draw_rect_filled(menu_x +250, menu_y +159, 162, 20, color.new(25,25,25,200) )
        if legbreakerdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x + 255 and mouse_pos.x <= menu_x + 308 and mouse_pos.y >= menu_y +160 and mouse_pos.y <= menu_y +176 then
            legbreakerdisable = 1
            legbreakernormal = 0
            legbreakeroverride = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +161, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +161, color.new(50,50,50,150), "Normal")
            render.draw_text( checkboxmenufont, menu_x +360, menu_y +161, color.new(50,50,50,150), "Fakelag")
        end
        if legbreakernormal == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +309 and mouse_pos.x <= menu_x +357 and mouse_pos.y >= menu_y +160 and mouse_pos.y <= menu_y +176 then
            legbreakerdisable = 0
            legbreakernormal = 1
            legbreakeroverride = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +161, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +161, maincolor, "Normal")
            render.draw_text( checkboxmenufont, menu_x +360, menu_y +161, color.new(50,50,50,150), "Fakelag")
        end
        if legbreakeroverride == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +358 and mouse_pos.x <= menu_x +410 and mouse_pos.y >= menu_y +160 and mouse_pos.y <= menu_y +176 then
            legbreakerdisable = 0
            legbreakernormal = 0
            legbreakeroverride = 1

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +161, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont,  menu_x +313, menu_y +161, color.new(50,50,50,150), "Normal")
            render.draw_text( checkboxmenufont,  menu_x +360, menu_y +161, maincolor, "Fakelag")
        end
        render.draw_text( checkboxmenufont,  menu_x +180, menu_y +161, color.new(255,255,255), "LegBraker")

        --jitter
        render.draw_rect_filled( menu_x +250, menu_y +188, 151, 20, color.new(25,25,25,200) )
        if jitterdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +250 and mouse_pos.x <= menu_x +310 and mouse_pos.y >= menu_y +189 and mouse_pos.y <= menu_y +207 then
            jitterdisable = 1
            jitteronmove = 0
            jitterinair = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +190, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +190, color.new(50,50,50,150), "OnMove")
            render.draw_text( checkboxmenufont, menu_x +368, menu_y +190, color.new(50,50,50,150), "InAir")
        end
        if jitteronmove == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +311 and mouse_pos.x <= menu_x +364 and mouse_pos.y >= menu_y +189 and mouse_pos.y <= menu_y +207 then
            jitterdisable = 0
            jitteronmove = 1
            jitterinair = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +190, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +190, maincolor, "OnMove")
            render.draw_text( checkboxmenufont, menu_x +368, menu_y +190, color.new(50,50,50,150), "InAir")
        end
        if jitterinair == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +365 and mouse_pos.x <= menu_x +400 and mouse_pos.y >= menu_y +189 and mouse_pos.y <= menu_y +207 then
            jitterdisable = 0
            jitteronmove = 0
            jitterinair = 1

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +190, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +190, color.new(50,50,50,150), "OnMove")
            render.draw_text( checkboxmenufont, menu_x +368, menu_y +190, maincolor, "InAir")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +190, color.new(255,255,255), "Jitter")

        --legitaa
        render.draw_rect_filled( menu_x +250, menu_y +217, 148, 20, color.new(25,25,25,200) )
        if legitaadisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +250 and mouse_pos.x <= menu_x +309 and mouse_pos.y >= menu_y +217 and mouse_pos.y <= menu_y +236 then
            legitaadisable = 1
            legitaadefault = 0
            legitaajitter = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +219, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +219, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +363, menu_y +219, color.new(50,50,50,150), "Jitter")
        end
        if legitaadefault == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +310 and mouse_pos.x <= menu_x +360 and mouse_pos.y >= menu_y +217 and mouse_pos.y <= menu_y +236 then
            legitaadisable = 0
            legitaadefault = 1
            legitaajitter = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +219, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +219, maincolor, "Default")
            render.draw_text( checkboxmenufont, menu_x +363, menu_y +219, color.new(50,50,50,150), "Jitter")
        end
        if legitaajitter == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +361 and mouse_pos.x <= menu_x +397 and mouse_pos.y >= menu_y +217 and mouse_pos.y <= menu_y +236 then
            legitaadisable = 0
            legitaadefault = 0
            legitaajitter = 1

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +219, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +219, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +363, menu_y +219, maincolor, "Jitter")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +219, color.new(255,255,255), "Legit AA")

        render.draw_rect_filled( menu_x +250, menu_y +246, 95, 20, color.new(25,25,25,200) )
        if attargetsdisabled == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +250 and mouse_pos.x <= menu_x +310 and mouse_pos.y >= menu_y +246 and mouse_pos.y <= menu_y +265 then
            attargetsdisabled = 1
            attargetsinair = 0

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +248, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +248, color.new(50,50,50,150), "InAir")
        end
        if attargetsinair == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +311 and mouse_pos.x <= menu_x +344 and mouse_pos.y >= menu_y +246 and mouse_pos.y <= menu_y +265 then
            attargetsdisabled = 0
            attargetsinair = 1

            render.draw_text( checkboxmenufont, menu_x +255, menu_y +248, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +313, menu_y +248, maincolor, "InAir")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +248, color.new(255,255,255), "At Targets")
    end    
end

function menupaint2()
    mouse_pos = getMousePos()

    if not menu.get_key_bind_state("Open Menu") and not menuvisuals == 1 then
        return
    end

    local menu_x = posix
    local menu_y = posiy
    local menuswitchx = 160
    local menuswitchy = 100

    menudrag(menu_x, menu_y, menuswitchx, menuswitchy)

    if menu_x < 0 then
        menu_x = 0
    end
    if menu_x > getscreen_x - 600 then
        menu_x = getscreen_x - 600
    end
    if menu_y < 0 then
        menu_y = 0
    end
    if menu_y > getscreen_y - 400 then
        menu_y = getscreen_y - 400
    end

    local maincolor = menu.get_color("clrcolor")
    if menuvisual == 1 and menu.get_key_bind_state("Open Menu") then
        render.draw_rect_filled( menu_x +255, menu_y +30, 175, 20, color.new(25,25,25,200) )
        if watermarkdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +250 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +30 and mouse_pos.y <=menu_y +50 then
            watermarkdisable = 1
            watermarkseaside = 0
            watermarkmetamod = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +32, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +32, color.new(50,50,50,150), "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +32, color.new(50,50,50,150), "MetaMod")
        end
        if watermarkseaside == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +368 and mouse_pos.y >= menu_y +30 and mouse_pos.y <=menu_y +50 then
            watermarkdisable = 0
            watermarkseaside = 1
            watermarkmetamod = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +32, maincolor, "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +32, color.new(50,50,50,150), "MetaMod")
        end
        if watermarkmetamod == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +369 and mouse_pos.x <= menu_x +429 and mouse_pos.y >= menu_y +30 and mouse_pos.y <=menu_y +50 then
            watermarkdisable = 0
            watermarkseaside = 0
            watermarkmetamod = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +32, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +32, color.new(50,50,50,150), "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +32, maincolor, "MetaMod")
        end
        render.draw_rect_filled( menu_x +434, menu_y +30, 72, 20, color.new(25,25,25,200) )
        if watermarkpositionleft == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +434 and mouse_pos.x <= menu_x +464 and mouse_pos.y >= menu_y +30 and mouse_pos.y <= menu_y +50 then
            watermarkpositionleft = 1
            watermarkpositionright = 0

            render.draw_text( checkboxmenufont, menu_x +439, menu_y +32, maincolor, "Left")
            render.draw_text( checkboxmenufont, menu_x +468, menu_y +32, color.new(50,50,50,150), "Right")
        end
        if watermarkpositionright == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +465 and mouse_pos.x <= menu_x +504 and mouse_pos.y >= menu_y +30 and mouse_pos.y <= menu_y +50 then
            watermarkpositionleft = 0
            watermarkpositionright = 1

            render.draw_text( checkboxmenufont, menu_x +439, menu_y +32, color.new(50,50,50,150), "Left")
            render.draw_text( checkboxmenufont, menu_x +468, menu_y +32, maincolor, "Right")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +32, color.new(255,255,255), "Watermark")

        --indicator
        render.draw_rect_filled( menu_x +255, menu_y +59, 175, 20, color.new(25,25,25,200) )
        if indicatorsdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +250 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +59 and mouse_pos.y <=menu_y +77 then
            indicatorsdisable = 1
            indicatorsseaside = 0
            indicatorsidealyaw = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +61, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +61, color.new(50,50,50,150), "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +61, color.new(50,50,50,150), "IdealYaw")
        end
        if indicatorsseaside == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +368 and mouse_pos.y >= menu_y +59 and mouse_pos.y <=menu_y +77 then
            indicatorsdisable = 0
            indicatorsseaside = 1
            indicatorsidealyaw= 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +61, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +61, maincolor, "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +61, color.new(50,50,50,150), "IdealYaw")
        end
        if indicatorsidealyaw == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +369 and mouse_pos.x <= menu_x +429 and mouse_pos.y >= menu_y +59 and mouse_pos.y <=menu_y +77 then
            indicatorsdisable  = 0
            indicatorsseaside  = 0
            indicatorsidealyaw = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +61, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +61, color.new(50,50,50,150), "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +61, maincolor, "IdealYaw")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +61, color.new(255,255,255), "Indicators")


        render.draw_rect_filled( menu_x +255, menu_y +88, 190, 20, color.new(25,25,25,200) )
        if aaarrowdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +250 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +88 and mouse_pos.y <= menu_y +106 then
            aaarrowdisable = 1 
            aaarrowseaside = 0
            aaarrowskeet = 0
            render.draw_text( checkboxmenufont, menu_x +260, menu_y +90, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +90, color.new(50,50,50,150), "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +90, color.new(50,50,50,150), "TeamSkeet")
        end
        if aaarrowseaside == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +368 and mouse_pos.y >= menu_y +88 and mouse_pos.y <= menu_y +106 then
            aaarrowdisable = 0 
            aaarrowseaside = 1
            aaarrowskeet = 0
            render.draw_text( checkboxmenufont, menu_x +260, menu_y +90, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +90, maincolor, "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +90, color.new(50,50,50,150), "TeamSkeet")
        end
        if aaarrowskeet == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +369 and mouse_pos.x <= menu_x +443 and mouse_pos.y >= menu_y +88 and mouse_pos.y <= menu_y +106 then
            aaarrowdisable = 0 
            aaarrowseaside = 0
            aaarrowskeet = 1
            render.draw_text( checkboxmenufont, menu_x +260, menu_y +90, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +90, color.new(50,50,50,150), "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +90, maincolor, "TeamSkeet")
        end
        render.draw_rect_filled( menu_x +448, menu_y +88, 100, 20, color.new(25,25,25,200) )
        if aaarrowstatic == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +448 and mouse_pos.x <= menu_x +489 and mouse_pos.y >= menu_y +88 and mouse_pos.y <= menu_y +106 then
            aaarrowstatic = 1
            aaarrowdynamic = 0

            render.draw_text( checkboxmenufont, menu_x +453, menu_y +90, maincolor, "Static")
            render.draw_text( checkboxmenufont, menu_x +491, menu_y +90, color.new(50,50,50,150), "Dynamic")
        end
        if aaarrowdynamic == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +490 and mouse_pos.x <= menu_x +547 and mouse_pos.y >= menu_y +88 and mouse_pos.y <= menu_y +106 then
            aaarrowstatic = 0
            aaarrowdynamic = 1

            render.draw_text( checkboxmenufont, menu_x +453, menu_y +90, color.new(50,50,50,150), "Static")
            render.draw_text( checkboxmenufont, menu_x +491, menu_y +90, maincolor, "Dynamic")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +90, color.new(255,255,255), "Arrows")

        render.draw_rect_filled( menu_x +255, menu_y +117, 157, 20, color.new(25,25,25,200) )
        if netgraphdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +117 and mouse_pos.y <= menu_y +135 then
            netgraphdisable = 1
            netgraphseaside = 0
            netgraphskeet = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +119, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +119, color.new(50,50,50,150), "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +119, color.new(50,50,50,150), "Skeet")
        end
        if netgraphseaside == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +315 and mouse_pos.x <= menu_x +368 and mouse_pos.y >= menu_y +117 and mouse_pos.y <= menu_y +135 then
            netgraphdisable = 0
            netgraphseaside = 1
            netgraphskeet = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +119, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +119, maincolor, "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +119, color.new(50,50,50,150), "Skeet")
        end
        if netgraphskeet == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +369 and mouse_pos.x <= menu_x +411 and mouse_pos.y >= menu_y +117 and mouse_pos.y <= menu_y +135 then
            netgraphdisable = 0
            netgraphseaside = 0
            netgraphskeet = 1   

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +119, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +119, color.new(50,50,50,150), "SeaSide")
            render.draw_text( checkboxmenufont, menu_x +370, menu_y +119, maincolor, "Skeet")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +119, color.new(255,255,255), "NetGraph")

        render.draw_rect_filled( menu_x +255, menu_y +146, 118, 20, color.new(25,25,25,200) )
        if antiaimdebugdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +146 and mouse_pos.y <= menu_y +168 then
            antiaimdebugdisable = 1
            antiaimdebugenable = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +148, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +148, color.new(50,50,50,150), "Enabled")
        end
        if antiaimdebugenable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +146 and mouse_pos.y <= menu_y +168 then
            antiaimdebugdisable = 0
            antiaimdebugenable = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +148, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +148, maincolor, "Enabled")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +148, color.new(255,255,255), "Holo Panel")

        render.draw_rect_filled( menu_x +255, menu_y +175, 118, 20, color.new(25,25,25,200) )
        if keybindsdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +175 and mouse_pos.y <= menu_y +193 then
            keybindsdisable = 1
            keybindsenable = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +177, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +177, color.new(50,50,50,150), "Enabled")
        end
        if keybindsenable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +175 and mouse_pos.y <= menu_y +193 then
            keybindsdisable = 0
            keybindsenable = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +177, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +177, maincolor, "Enabled")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +177, color.new(255,255,255), "Keybinds")

        render.draw_rect_filled( menu_x +255, menu_y +204, 118, 20, color.new(25,25,25,200) )
        if fogdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +204 and mouse_pos.y <= menu_y +222 then
            fogdisable = 1
            fogenable = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +206, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +206, color.new(50,50,50,150), "Enabled")
        end
        if fogenable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +204 and mouse_pos.y <= menu_y +222 then
            fogdisable = 0
            fogenable = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +206, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +206, maincolor, "Enabled")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +206, color.new(255,255,255), "Fog")

        render.draw_rect_filled( menu_x +255, menu_y +233, 118, 20, color.new(25,25,25,200) )
        if mindmghide == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +233 and mouse_pos.y <= menu_y +254 then
            mindmghide = 1
            mindmgshow = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +235, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +235, color.new(50,50,50,150), "Enabled")
        end
        if mindmgshow == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +233 and mouse_pos.y <= menu_y +254 then
            mindmghide = 0
            mindmgshow = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +235, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +235, maincolor, "Enabled")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +235, color.new(255,255,255), "DMG Cross")

        render.draw_rect_filled( menu_x +255, menu_y +262, 120, 20, color.new(25,25,25,200) )
        if viewmodel == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +262 and mouse_pos.y <= menu_y +283 then
            viewmodel = 1
            viewonscope = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +264, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +264, color.new(50,50,50,150), "OnScope")
        end
        if viewonscope == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +372 and mouse_pos.y >= menu_y +262 and mouse_pos.y <= menu_y +283 then
            viewmodel = 0
            viewonscope = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +264, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +264, maincolor, "OnScope")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +264, color.new(255,255,255), "Viewmodel")

        render.draw_rect_filled( menu_x +255, menu_y +291, 100, 20, color.new(25,25,25,200) )
        if betterdormant == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +308 and mouse_pos.y >= menu_y +291 and mouse_pos.y <= menu_y +310 then
            betterdormant = 1
            enableddormant = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +293, maincolor, "Default")
            render.draw_text( checkboxmenufont, menu_x +310, menu_y +293, color.new(50,50,50,150), "Better")
        end
        if enableddormant == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +309 and mouse_pos.x <= menu_x +352 and mouse_pos.y >= menu_y +291 and mouse_pos.y <= menu_y +310 then
            betterdormant = 0
            enableddormant = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +293, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +310, menu_y +293, maincolor, "Better")
        end
        render.draw_text( checkboxmenufont, menu_x +180, menu_y +293, color.new(255,255,255), "Dormant")
    end

    if menumisc == 1 and menu.get_key_bind_state("Open Menu") then
        render.draw_rect_filled( menu_x +255,  menu_y +28, 118, 20, color.new(25,25,25,200) )
        if clantagdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +28 and mouse_pos.y <= menu_y +46 then
            clantagdisable = 1
            clantagenable = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +30, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +30, color.new(50,50,50,150), "Enabled")
        end
        if clantagenable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +28 and mouse_pos.y <= menu_y +46 then
            clantagdisable = 0
            clantagenable = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +30, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +30, maincolor, "Enabled")
        end
        render.draw_text( checkboxmenufont,  menu_x +180, menu_y +30, color.new(255,255,255), "Clantag")

        render.draw_rect_filled(  menu_x +255, menu_y +57, 118, 20, color.new(25,25,25,200) )
        if pitchlanddisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +57 and mouse_pos.y <= menu_y +75 then
            pitchlanddisable = 1
            pitchlandenable = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +59, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +59, color.new(50,50,50,150), "Enabled")
        end
        if pitchlandenable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +57 and mouse_pos.y <= menu_y +75 then
            pitchlanddisable = 0
            pitchlandenable = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +59, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +59, maincolor, "Enabled")
        end
        render.draw_text( checkboxmenufont,  menu_x +180, menu_y +59, color.new(255,255,255), "Pitch 0")

        render.draw_rect_filled(  menu_x +255, menu_y +86, 118, 20, color.new(25,25,25,200) )
        if disableblurdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +86 and mouse_pos.y <= menu_y +105 then
            disableblurdisable = 1
            disableblurenable = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +88, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +88, color.new(50,50,50,150), "Enabled")
        end
        if disableblurenable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +86 and mouse_pos.y <= menu_y +105 then
            disableblurdisable = 0
            disableblurenable = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +88, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +88, maincolor, "Enabled")
        end
        render.draw_text( checkboxmenufont,  menu_x +180, menu_y +88, color.new(255,255,255), "No Blur")

        render.draw_rect_filled(  menu_x +255, menu_y +115, 200, 20, color.new(25,25,25,200) )
        if logsdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +115 and mouse_pos.y <= menu_y +134 then
            logsdisable = 1
            logsenable = 0
            logsconsole = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +117, maincolor, "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +117, color.new(50,50,50,150), "OnScreen")
            render.draw_text( checkboxmenufont, menu_x +381, menu_y +117, color.new(50,50,50,150), "OnConsole")
        end
        if logsenable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +379 and mouse_pos.y >= menu_y +115 and mouse_pos.y <= menu_y +134 then
            logsdisable = 0
            logsenable = 1
            logsconsole = 0

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +117, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +117, maincolor, "OnScreen")
            render.draw_text( checkboxmenufont, menu_x +381, menu_y +117, color.new(50,50,50,150), "OnConsole")
        end
        if logsconsole == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +380 and mouse_pos.x <= menu_x +451 and mouse_pos.y >= menu_y +115 and mouse_pos.y <= menu_y +134 then
            logsdisable = 0
            logsenable = 0
            logsconsole = 1

            render.draw_text( checkboxmenufont, menu_x +260, menu_y +117, color.new(50,50,50,150), "Disabled")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +117, color.new(50,50,50,150), "OnScreen")
            render.draw_text( checkboxmenufont, menu_x +381, menu_y +117, maincolor, "OnConsole")
        end
        render.draw_text( checkboxmenufont,  menu_x +180, menu_y +117, color.new(255,255,255), "Logs")

        render.draw_rect_filled(  menu_x +255, menu_y +144, 118, 20, color.new(25,25,25,200) )
        if overrideautopeekonshot == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +318 and mouse_pos.y >= menu_y +144 and mouse_pos.y <= menu_y +163 then
            overrideautopeekonshot = 1
            overrideautopeekalways = 0

            render.draw_text( checkboxmenufont, menu_x +263, menu_y +146, maincolor, "OnShot")
            render.draw_text( checkboxmenufont, menu_x +320, menu_y +146, color.new(50,50,50,150), "Always")
        end
        if overrideautopeekalways == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +319 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +144 and mouse_pos.y <= menu_y +163 then
            overrideautopeekonshot = 0
            overrideautopeekalways = 1

            render.draw_text( checkboxmenufont, menu_x +263, menu_y +146, color.new(50,50,50,150), "OnShot")
            render.draw_text( checkboxmenufont, menu_x +320, menu_y +146, maincolor, "Always")
        end
        render.draw_text( checkboxmenufont,  menu_x +180, menu_y +146, color.new(255,255,255), "AutoPeek")

        render.draw_rect_filled(  menu_x +255, menu_y +173, 118, 20, color.new(25,25,25,200) )
        if modelchangerdisable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +173 and mouse_pos.y <= menu_y +192 then
            modelchangerdisable = 1
            modelchangerenable = 0

            render.draw_text( checkboxmenufont, menu_x +263, menu_y +175, maincolor, "Default")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +175, color.new(50,50,50,150), "Custom")
        end
        if modelchangerenable == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +173 and mouse_pos.y <= menu_y +192 then
            modelchangerdisable = 0
            modelchangerenable = 1

            render.draw_text( checkboxmenufont, menu_x +263, menu_y +175, color.new(50,50,50,150), "Default")
            render.draw_text( checkboxmenufont, menu_x +317, menu_y +175, maincolor, "Custom")
        end
        render.draw_text( checkboxmenufont,  menu_x +180, menu_y +175, color.new(255,255,255), "Model")
    end

    if menuconfigs == 1 and menu.get_key_bind_state("Open Menu") then
        render.draw_rect_filled( menu_x +255, menu_y +28, 118, 20, color.new(25,25,25,200) )
        if saveconfigfile == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +255 and mouse_pos.x <= menu_x +315 and mouse_pos.y >= menu_y +28 and mouse_pos.y <= menu_y +46 then
            saveconfigfile = 1
            loadconfigfile = 0

            render.draw_text( checkboxmenufont, menu_x +265, menu_y +30, maincolor, "Saved")
            render.draw_text( checkboxmenufont, menu_x +326, menu_y +30, color.new(50,50,50,150), "Load")
        end
        if loadconfigfile == 1 or is_key_down(VK_LBUTTON) and mouse_pos.x >= menu_x +316 and mouse_pos.x <= menu_x +370 and mouse_pos.y >= menu_y +28 and mouse_pos.y <= menu_y +46 then
            saveconfigfile = 0
            loadconfigfile = 1

            render.draw_text( checkboxmenufont, menu_x +270, menu_y +30, color.new(50,50,50,150), "Save")
            render.draw_text( checkboxmenufont, menu_x +320, menu_y +30, maincolor, "Loaded")
        end
        if loadconfigfile == 0 and saveconfigfile == 0 then
            saveconfigfile = 0
            loadconfigfile = 0

            render.draw_text( checkboxmenufont, menu_x +270, menu_y +30, color.new(50,50,50,150), "Save")
            render.draw_text( checkboxmenufont, menu_x +326, menu_y +30, color.new(50,50,50,150), "Load")
        end

        render.draw_text( checkboxmenufont, menu_x +180, menu_y +30, color.new(255,255,255), "Slot 1")
    end
end

function saveloadconfig()
    if saveconfigfile == 1 then
        local write_stuff_nig = ""
        write_stuff_nig = write_stuff_nig .. "" .. tostring(switchragebotresolverfalse) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(switchragebotresolvertrue) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditiondisable      ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditiondefault      ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditiondefaultjitter) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditioncustomjitter ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditionlowdelta     ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditonlowdelta2     ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditionrandomjitter ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditionswitch       ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditionidealyaw     ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(moveconditionidealjitter  ) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditiondisable      ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditiondefault      ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditiondefaultjitter) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditioncustomjitter ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditionlowdelta     ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditonlowdelta2     ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditionrandomjitter ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditionswitch       ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditionidealyaw     ) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(slowconditionidealjitter  ) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(antibrutedisabled) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(antibruteonshot) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(antibruteonhit) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(legbreakerdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(legbreakernormal) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(legbreakeroverride) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(jitterdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(jitteronmove) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(jitterinair) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(legitaadisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(legitaadefault) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(legitaajitter) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(indicatorsdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(indicatorsseaside) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(indicatorsidealyaw) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(aaarrowdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(aaarrowseaside) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(aaarrowskeet) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(aaarrowstatic) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(aaarrowdynamic) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(watermarkdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(watermarkseaside) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(watermarkmetamod) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(watermarkpositionleft) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(watermarkpositionright) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(netgraphdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(netgraphseaside) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(netgraphskeet) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(antiaimdebugdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(antiaimdebugenable) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(keybindsdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(keybindsenable) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(fogdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(fogenable) .. "\n";

        file.write( path, write_stuff_nig)
        saveconfigfile = 2
    end
    
    if loadconfigfile == 1 then
        local read_thing = Split(file.read(path), "\n")
        switchragebotresolverfalse    = tonumber(read_thing[1])
        switchragebotresolvertrue     = tonumber(read_thing[2])
        
        moveconditiondisable          = tonumber(read_thing[3])
        moveconditiondefault          = tonumber(read_thing[4])
        moveconditiondefaultjitter    = tonumber(read_thing[5])
        moveconditioncustomjitter     = tonumber(read_thing[6])
        moveconditionlowdelta         = tonumber(read_thing[7])
        moveconditonlowdelta2         = tonumber(read_thing[8])
        moveconditionrandomjitter     = tonumber(read_thing[9])
        moveconditionswitch           = tonumber(read_thing[10])
        moveconditionidealyaw         = tonumber(read_thing[11])
        moveconditionidealjitter      = tonumber(read_thing[12])

        slowconditiondisable          = tonumber(read_thing[13])
        slowconditiondefault          = tonumber(read_thing[14])
        slowconditiondefaultjitter    = tonumber(read_thing[15])
        slowconditioncustomjitter     = tonumber(read_thing[16])
        slowconditionlowdelta         = tonumber(read_thing[17])
        slowconditonlowdelta2         = tonumber(read_thing[18])
        slowconditionrandomjitter     = tonumber(read_thing[19])
        slowconditionswitch           = tonumber(read_thing[20])
        slowconditionidealyaw         = tonumber(read_thing[21])
        slowconditionidealjitter      = tonumber(read_thing[22])

        antibrutedisabled             = tonumber(read_thing[23])
        antibruteonshot               = tonumber(read_thing[24])
        antibruteonhit                = tonumber(read_thing[25])

        legbreakerdisable             = tonumber(read_thing[26])
        legbreakernormal              = tonumber(read_thing[27])
        legbreakeroverride            = tonumber(read_thing[28])

        jitterdisable                 = tonumber(read_thing[29])
        jitteronmove                  = tonumber(read_thing[30])
        jitterinair                   = tonumber(read_thing[31])

        legitaadisable                = tonumber(read_thing[32])
        legitaadefault                = tonumber(read_thing[33])
        legitaajitter                 = tonumber(read_thing[34])
        
        indicatorsdisable             = tonumber(read_thing[35])
        indicatorsseaside             = tonumber(read_thing[36])
        indicatorsidealyaw            = tonumber(read_thing[37])

        aaarrowdisable                = tonumber(read_thing[38])
        aaarrowseaside                = tonumber(read_thing[39])
        aaarrowskeet                  = tonumber(read_thing[40])

        aaarrowstatic                 = tonumber(read_thing[41])
        aaarrowdynamic                = tonumber(read_thing[42])
        
        watermarkdisable              = tonumber(read_thing[43])
        watermarkseaside              = tonumber(read_thing[44])
        watermarkmetamod              = tonumber(read_thing[45])

        watermarkpositionleft         = tonumber(read_thing[46])
        watermarkpositionright        = tonumber(read_thing[47])

        netgraphdisable               = tonumber(read_thing[48])
        netgraphseaside               = tonumber(read_thing[49])
        netgraphskeet                 = tonumber(read_thing[50])

        antiaimdebugdisable           = tonumber(read_thing[51])
        antiaimdebugenable            = tonumber(read_thing[52])

        keybindsdisable               = tonumber(read_thing[53])
        keybindsenable                = tonumber(read_thing[54])

        fogdisable                    = tonumber(read_thing[55])
        fogenable                     = tonumber(read_thing[56])
        loadconfigfile = 2
    end
end

function savedoi()
    if saveconfigfile == 2 then
        local write_stuff_nig = ""
        write_stuff_nig = write_stuff_nig .. "" .. tostring(clantagdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(clantagenable) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(pitchlanddisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(pitchlandenable) .. "\n";
             
        write_stuff_nig = write_stuff_nig .. "" .. tostring(disableblurdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(disableblurenable) .. "\n";
                 
        write_stuff_nig = write_stuff_nig .. "" .. tostring(logsdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(logsenable) .. "\n";   

        write_stuff_nig = write_stuff_nig .. "" .. tostring(modelchangerdisable) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(modelchangerenable) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(overrideautopeekonshot) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(overrideautopeekalways) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(attargetsdisabled) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(attargetsinair) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(backtrackdefault) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(backtrackenhanced) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(mindmghide) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(mindmgshow) .. "\n";
        
        write_stuff_nig = write_stuff_nig .. "" .. tostring(logsconsole) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(viewmodel) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(viewonscope) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(pos_x) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(pos_y) .. "\n";

        write_stuff_nig = write_stuff_nig .. "" .. tostring(betterdormant) .. "\n";
        write_stuff_nig = write_stuff_nig .. "" .. tostring(enableddormant) .. "\n";

        file.write( path2, write_stuff_nig)
        saveconfigfile = 0
    end
end

function loaddoi()
    if loadconfigfile == 2 then
        local read_thing = Split(file.read(path2), "\n")
        clantagdisable                = tonumber(read_thing[1])
        clantagenable                 = tonumber(read_thing[2])

        pitchlanddisable              = tonumber(read_thing[3])
        pitchlandenable               = tonumber(read_thing[4])

        disableblurdisable            = tonumber(read_thing[5])
        disableblurenable             = tonumber(read_thing[6])

        logsdisable                   = tonumber(read_thing[7])
        logsenable                    = tonumber(read_thing[8])

        modelchangerdisable           = tonumber(read_thing[9])
        modelchangerenable            = tonumber(read_thing[10])

        overrideautopeekonshot        = tonumber(read_thing[11])
        overrideautopeekalways        = tonumber(read_thing[12])

        attargetsdisabled             = tonumber(read_thing[13])
        attargetsinair                = tonumber(read_thing[14])

        backtrackdefault              = tonumber(read_thing[15])
        backtrackenhanced             = tonumber(read_thing[16])

        mindmghide                    = tonumber(read_thing[17])
        mindmgshow                    = tonumber(read_thing[18])

        logsconsole                   = tonumber(read_thing[19])

        viewmodel                     = tonumber(read_thing[20])
        viewonscope                   = tonumber(read_thing[21])

        pos_x                         = tonumber(read_thing[22])
        pos_y                         = tonumber(read_thing[23])

        betterdormant                 = tonumber(read_thing[24])
        enableddormant                = tonumber(read_thing[25])

        loadconfigfile = 0
    end
end
client.add_callback("on_paint", menupaint)
client.add_callback("on_paint", menupaint2)
client.add_callback("on_paint", saveloadconfig)
client.add_callback("on_paint", savedoi)
client.add_callback("on_paint", loaddoi)

else
    user32.MessageBoxA(nil, "Invalid credentials !", "Failed to load !", ffi.C.MB_OK + ffi.C.MB_ICONINFORMATION)
    client.log("ACTIVATE THE HTTP REQUEST !!")
    client.unload_script("seaside.lua")
    return
end
