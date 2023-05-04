--[[
	自动生成lpus类
]]
local LUA_PATH = _G.LF_LUA_PATH or 'D:\\Projects\\Trunk\\Azure\\Output\\Lua'
local LF_FILE_PATH = _G.LF_FILE_PATH or 'D:\\Projects\\Trunk\\Azure\\Output\\Lua\\LplusFactory'
local AUTHOR_NAME = _G.LF_AUTHOR_NAME or 'chentao'
local Lplus = require "Lplus"
local LplusFactoryData = _G.LplusFactoryData or require "LplusFactory.LplusFactoryData" --外部版去掉此句

---@class LplusFactory.LplusFactory:System.Object
---@field protected m_data LplusFactoryData
---@field public Commit fun():LplusFactory.LplusFactory @notnull
---@field public Instance fun():LplusFactory.LplusFactory
---@field public createOne fun(self:LplusFactory.LplusFactory, className:string, baseClass:string):LplusFactory.LplusFactory
---@field public print fun(self:LplusFactory.LplusFactory):LplusFactory.LplusFactory
---@field public commit fun(self:LplusFactory.LplusFactory, filename:string):LplusFactory.LplusFactory
---@field public sequence fun(self:LplusFactory.LplusFactory, infos:table):LplusFactory.LplusFactory
---@field public prefix fun(self:LplusFactory.LplusFactory, desc:string, author:string):LplusFactory.LplusFactory
---@field public prefix_line fun(self:LplusFactory.LplusFactory, line:string):LplusFactory.LplusFactory
---@field public require fun(self:LplusFactory.LplusFactory, path:string, name:string):LplusFactory.LplusFactory
---@field public ForwardDeclare fun(self:LplusFactory.LplusFactory, path:string, name:string):LplusFactory.LplusFactory
---@field public field fun(self:LplusFactory.LplusFactory, type:string, name:string, value:any):LplusFactory.LplusFactory
---@field public functions fun(self:LplusFactory.LplusFactory, function_type:string, name:string, params:string, returns:string, param_names:string, function_body:string, upvalues_name:string, upvalues_value:string):LplusFactory.LplusFactory
---@field public static fun(self:LplusFactory.LplusFactory, name:string, params:string, returns:string, param_names:string, function_body:string, upvalues_name:string, upvalues_value:string):LplusFactory.LplusFactory
---@field public methods fun(self:LplusFactory.LplusFactory, name:string, params:string, returns:string, param_names:string, function_body:string, upvalues_name:string, upvalues_value:string):LplusFactory.LplusFactory
---@field public override fun(self:LplusFactory.LplusFactory, name:string, params:string, returns:string, param_names:string, function_body:string, upvalues_name:string, upvalues_value:string):LplusFactory.LplusFactory
---@field public constructor fun(self:LplusFactory.LplusFactory, name:string, params:string, returns:string, param_names:string, function_body:string, upvalues_name:string, upvalues_value:string):LplusFactory.LplusFactory
---@field public final fun(self:LplusFactory.LplusFactory, name:string, params:string, returns:string, param_names:string, function_body:string, upvalues_name:string, upvalues_value:string):LplusFactory.LplusFactory
---@field public InstanceStatic fun(self:LplusFactory.LplusFactory):LplusFactory.LplusFactory
---@field public newStatic fun(self:LplusFactory.LplusFactory):LplusFactory.LplusFactory
---@field public newFinal fun(self:LplusFactory.LplusFactory):LplusFactory.LplusFactory
---@field public virtual fun(self:LplusFactory.LplusFactory, name:string, params:string, returns:string, param_names:string, function_body:string, upvalues_name:string, upvalues_value:string):LplusFactory.LplusFactory
---@field public ViewFunctions fun(self:LplusFactory.LplusFactory, functions:table):LplusFactory.LplusFactory
---@field public sample fun(self:LplusFactory.LplusFactory)
---@field public sampleClass fun(self:LplusFactory.LplusFactory, name:string, path:any)
---@field public withCleanerHelp fun(self:LplusFactory.LplusFactory)
---@field public withAddHandlerAutoDelOnDestroy fun(self:LplusFactory.LplusFactory)
---@field public samplePanel fun(self:LplusFactory.LplusFactory, name:string, resPath:string, functions:string, params:any)
---@field public sampleView fun(self:LplusFactory.LplusFactory, name:string, functions:string)
---@field public sampleBadge fun(self:LplusFactory.LplusFactory, name:string, notification_name:string)
---@field public sampleEvent fun(self:LplusFactory.LplusFactory, name:string)
---@field public samplePB fun(self:LplusFactory.LplusFactory, name:string, cmdName:string)
---@field public sampleConfig fun(self:LplusFactory.LplusFactory, cfg:table)
---@field public sampleFile fun(self:LplusFactory.LplusFactory, fileName:string)
local LplusFactory = Lplus.Class("LplusFactory.LplusFactory")
do
    local def = LplusFactory.define
    local instance

    ---@type LplusFactoryData
    def.field(LplusFactoryData).m_data = nil
    ---@return LplusFactory.LplusFactory
    def.static("=>", LplusFactory).Instance = function()
        if not instance then
            instance = LplusFactory()
        end
        return instance
    end

    ---@param self LplusFactory.LplusFactory
    ---@param className string
    ---@param baseClass string
    ---@return LplusFactory.LplusFactory
    def.method('string', 'string', "=>", LplusFactory).createOne = function(self, className, baseClass)
        if self.m_data then
            return self
        end
        self.m_data = LplusFactoryData()
        self.m_data.className = className
        self.m_data.baseClass = baseClass
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@return LplusFactory.LplusFactory
    def.method( "=>", LplusFactory).print = function(self)
        table.dump(self.m_data)
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param filename string
    ---@return LplusFactory.LplusFactory
    def.method('string',"=>", LplusFactory).commit = function(self, filename)
        local file, err = io.open(filename,"w")
        print(file, filename, 'file----------------------------------')
        local m_data = self.m_data
        if file then
            --prefix
            for _, v in ipairs(m_data.prefixes) do
                file:write(v)
            end
            for _, v in ipairs(m_data.requires) do
                file:write(v)
            end

            for _, v in ipairs(m_data.befores) do
                file:write(v)
            end

            if m_data.className ~= '' then
                if m_data.baseClass == '' then
                    file:write(("local %s = Lplus.Class(\"%s\")\n"):format(m_data.className, m_data.className))
                else
                    file:write(("local %s = Lplus.Extend(%s, \"%s\")\n"):format(m_data.className, m_data.baseClass, m_data.className))
                end
                file:write("do\n\t")
                file:write(("local def = %s.define\n"):format(m_data.className))

                for _, v in ipairs(m_data.fields) do
                    file:write(v)
                end
                for _, v in ipairs(m_data.finals) do
                    file:write(v)
                end
                for _, v in ipairs(m_data.constructors) do
                    file:write(v)
                end
                for _, v in ipairs(m_data.statics) do
                    file:write(v)
                end
                for _, v in ipairs(m_data.overrides) do
                    file:write(v)
                end
                for _, v in ipairs(m_data.virtuals) do
                    file:write(v)
                end
                for _, v in ipairs(m_data.methods) do
                    file:write(v)
                end
                for _, v in ipairs(m_data.lines_in_def) do
                    file:write(v..'\n')
                end
                local commit_kind = m_data.commit_kind
                if commit_kind == 'before' then
                    file:write(("\t%s.Commit()\n"):format(m_data.className))
                end
                file:write("end\n")
                for _, v in ipairs(m_data.lines_after_def) do
                    file:write(v)
                end
                if commit_kind == 'return' then
                    file:write(("return %s.Commit()"):format(m_data.className))
                end
            end
            for _, v in ipairs(m_data.afters) do
                file:write(v)
            end
            file:close()
        end
        self.m_data = nil
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param infos table
    ---@return LplusFactory.LplusFactory
    def.method('table', "=>", LplusFactory).sequence = function(self, infos)
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param desc string
    ---@param author string
    ---@return LplusFactory.LplusFactory
    def.method('string', "string", "=>", LplusFactory).prefix = function(self, desc, author)
        local prefixes = self.m_data.prefixes
        prefixes[1] = (prefixes[1]):format(desc)
        prefixes[3] = (prefixes[3]):format(author)
        local t = os.date("*t", nil)
        prefixes[4] = (prefixes[4]):format(t.year, t.month, t.day, t.hour, t.min)
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param line string
    ---@return LplusFactory.LplusFactory
    def.method('string', "=>", LplusFactory).prefix_line = function(self, line)
        local prefixes = self.m_data.prefixes
        prefixes[#prefixes+1] = line..'\n'
        return self
    end

    --- 玩家回归
    --- Generated by EmmyLua(https://github.com/EmmyLua)
    --- Created by wangyinliang
    --- DateTime: 2022/6/16 19:49

    ---@param self LplusFactory.LplusFactory
    ---@param path string
    ---@param name string
    ---@return LplusFactory.LplusFactory
    def.method('string',"string","=>", LplusFactory).require = function(self, path, name)
        local requires = self.m_data.requires
        if path == '' then
            requires[#requires + 1] = string.format("local %s = require \"%s\"\n", name, name)
        else
            requires[#requires + 1] = string.format("local %s = require \"%s.%s\"\n", name, path, name)
        end
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param path string
    ---@param name string
    ---@return LplusFactory.LplusFactory
    def.method('string',"string","=>", LplusFactory).ForwardDeclare = function(self, path, name)
        local requires = self.m_data.requires
        if path == '' then
            requires[#requires + 1] = string.format("local %s = Lplus.ForwardDeclare \"%s\"\n", name, name)
        else
            requires[#requires + 1] = string.format("local %s = Lplus.ForwardDeclare \"%s.%s\"\n", name, path, name)
        end
        return self
    end

    local baseDefault = {
        number = 0,
        string = "",
        boolean = "false",
        userdata = "nil",
        table = [[function()
       return {}
   end
]],
    }
    ---@param self LplusFactory.LplusFactory
    ---@param type string
    ---@param name string
    ---@param value any
    ---@return LplusFactory.LplusFactory
    def.method('string',"string", "dynamic", "=>", LplusFactory).field = function(self, type, name, value)
        local fields = self.m_data.fields
        local base = baseDefault[type]
        value = value or base or "nil"
        if base then
            fields[#fields + 1] = string.format("   def.field(\"%s\").%s = %s\n", type, name, value)
        else
            fields[#fields + 1] = string.format("   def.field(%s).%s = %s\n", type, name, value)
        end
        return self
    end


    ---@param self LplusFactory.LplusFactory
    ---@param function_type string
    ---@param name string
    ---@param params string
    ---@param returns string
    ---@param param_names string
    ---@param function_body string
    ---@param upvalues_name string
    ---@param upvalues_value string
    ---@return LplusFactory.LplusFactory
    def.method('string',"string","string", "string", "string", "string", "string", "string", "=>", LplusFactory).functions = function(self, function_type, name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        local function_str = "\tdef.%s(%s).%s = function(%s)\n\t\t%s%s\n\tend\n"
        local function_types = self.m_data[function_type..'s']
        if upvalues_name ~= '' then
            upvalues_name = string.split(upvalues_name, ',')
            upvalues_value = string.split(upvalues_value, ',')
            for i, v in ipairs(upvalues_name) do
                function_types[#function_types + 1] = ("\tlocal %s = %s\n"):format(v, upvalues_value[i] or 'nil')
            end
        end
        local inTables = {}
        if params ~= '' then
            params = string.split(params, ',')
            for _, v in ipairs(params) do
                if baseDefault[v] or v == 'function' then
                    inTables[#inTables+1] = ("\"%s\""):format(v)
                else
                    inTables[#inTables+1] = ("%s"):format(v)
                end
            end
        end

        local returnStr = ''
        if returns ~= '' then
            inTables[#inTables+1] = "\"=>\""
            returns = string.split(returns, ',')
            local returnTable = {}
            for _, v in ipairs(returns) do
                if baseDefault[v] then
                    inTables[#inTables+1] = ("\"%s\""):format(v)
                else
                    inTables[#inTables+1] = ("%s"):format(v)
                end
                returnTable[#returnTable+1] = v..'_obj'
            end
            returnStr = ('\n\t\t--return %s'):format(table.concat(returnTable, ','))
        end
        local inTableBefore = table.concat(inTables, ', ')
        inTables = {}
        if function_type ~= 'static' and function_type ~= 'final' then
            inTables[1] = 'self'
        end
        if param_names ~= '' then
            param_names = string.split(param_names, ',')
            for _, v in ipairs(param_names) do
                inTables[#inTables+1] = ("%s"):format(v)
            end
        end
        local inTableAfter = table.concat(inTables, ', ')

        function_types[#function_types + 1] = (function_str):format(function_type, inTableBefore, name, inTableAfter, function_body, returnStr )
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param params string
    ---@param returns string
    ---@param param_names string
    ---@param function_body string
    ---@param upvalues_name string
    ---@param upvalues_value string
    ---@return LplusFactory.LplusFactory
    def.method('string',"string","string", "string", "string", "string", "string", "=>", LplusFactory).static = function(self, name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        self:functions('static', name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param params string
    ---@param returns string
    ---@param param_names string
    ---@param function_body string
    ---@param upvalues_name string
    ---@param upvalues_value string
    ---@return LplusFactory.LplusFactory
    def.method('string',"string","string", "string", "string", "string", "string", "=>", LplusFactory).methods = function(self, name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        self:functions('method', name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param params string
    ---@param returns string
    ---@param param_names string
    ---@param function_body string
    ---@param upvalues_name string
    ---@param upvalues_value string
    ---@return LplusFactory.LplusFactory
    def.method('string',"string","string", "string", "string", "string", "string", "=>", LplusFactory).override = function(self, name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        self:functions('override', name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param params string
    ---@param returns string
    ---@param param_names string
    ---@param function_body string
    ---@param upvalues_name string
    ---@param upvalues_value string
    ---@return LplusFactory.LplusFactory
    def.method('string',"string","string", "string", "string", "string", "string", "=>", LplusFactory).constructor = function(self, name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        self:functions('constructor', name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param params string
    ---@param returns string
    ---@param param_names string
    ---@param function_body string
    ---@param upvalues_name string
    ---@param upvalues_value string
    ---@return LplusFactory.LplusFactory
    def.method('string',"string","string", "string", "string", "string", "string", "=>", LplusFactory).final = function(self, name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        self:functions('final', name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@return LplusFactory.LplusFactory
    def.method("=>", LplusFactory).InstanceStatic = function(self)
        local m_data = self.m_data
        self:static("Instance", "", m_data.className, "", ("if not instance then\n\t\t\tinstance = %s()\n\t\tend\n\t\treturn instance"):format(m_data.className), "instance", "")
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@return LplusFactory.LplusFactory
    def.method("=>", LplusFactory).newStatic = function(self)
        local m_data = self.m_data
        self:static("new", "", m_data.className, "", ("local object = %s()\n\t\treturn object"):format(m_data.className), "", "")
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@return LplusFactory.LplusFactory
    def.method("=>", LplusFactory).newFinal = function(self)
        local m_data = self.m_data
        self:final("new", "", m_data.className, "", ("local object = %s()\n\t\treturn object"):format(m_data.className), "", "")
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param params string
    ---@param returns string
    ---@param param_names string
    ---@param function_body string
    ---@param upvalues_name string
    ---@param upvalues_value string
    ---@return LplusFactory.LplusFactory
    def.method("string", "string", "string", "string", "string", "string", "string", "=>", LplusFactory).virtual = function(self, name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        self:functions('virtual', name, params, returns, param_names, function_body, upvalues_name, upvalues_value)
        return self
    end

    local make_function_body = function(strs)
        return table.concat(strs, '\n\t\t')
    end

    ---@param self LplusFactory.LplusFactory
    ---@param functions table
    ---@return LplusFactory.LplusFactory
    def.method("table", "=>", LplusFactory).ViewFunctions = function(self, functions)
        local strs
        if table.FindKeyByValue(functions, 'onClickObj') then
            strs = {
                "--监听点击:",
                "local id = sender:GetName()",
                "local index = sender:GetUserData()",
            }
            self:methods("onClickObj", "userdata", "", "sender", make_function_body(strs), "", "")
        end
        if table.FindKeyByValue(functions, 'onToggleObj') then
            strs = {
                "--监听单选:",
                "local id = obj:GetName()",
                "local index = obj:GetUserData()",
            }
            self:methods("onToggleObj", "userdata,boolean", "", "obj,active",  make_function_body(strs), "", "")
        end
        if table.FindKeyByValue(functions, 'OnDestroy') then
            self:override("OnDestroy", "", "", "", "--界面销毁", "", "")
        end
        return self
    end

    ---@param self LplusFactory.LplusFactory
    ---@return void
    def.method().sample = function(self)
        local class = self:createOne('TestCt1', "")
        class:prefix(" 测试", AUTHOR_NAME)
        class:require("Utility", "LplusFactory")
        class:field("number", "m_index", nil)
        class:field("table", "m_tb1", "nil")
        class:field("LplusFactory", "m_Fac", nil)
        class:static("Instance", "", "TestCt1", "", "instance = TestCt1()\n\t\treturn instance", "instance", "")
        class:methods("InstanceM", "", "", "", "", "", "")
        class:static("Instance1", "number", "number", "number1", "local number1 = 1", "", "")
        class:methods("Instance1M", "number", "number", "number1", "local number1 = 1", "", "")
        class:commit(LUA_PATH.."\\GUI\\TestCt1.lua")
    end


    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param path any
    ---@return void
    def.method("string", "dynamic").sampleClass = function(self, name, path)
        local class = self:createOne(name, "")
        class:prefix(" 测试", AUTHOR_NAME)
        class:commit(path or (LUA_PATH..("\\%s.lua"):format(name)))
    end

    ---@param self LplusFactory.LplusFactory
    ---@return void
    def.method().withCleanerHelp = function(self)
        self:require("Utility", "CleanerHelper")
        local lines_in_def = self.m_data.lines_in_def
        lines_in_def[#lines_in_def+1] = '    CleanerHelper.defineCleaner(def, "cleaner", "disposeCleaner")'
        lines_in_def[#lines_in_def+1] = '    --记得在destroy处调用disposeCleaner'
    end

    ---@param self LplusFactory.LplusFactory
    ---@return void
    def.method().withAddHandlerAutoDelOnDestroy = function(self)
        self:ForwardDeclare("",'ECGame')
        local strs = {
            "--监听事件",
            "ECGame.EventManager:addHandlerWithCleaner(event, handler, self:cleaner())",
        }
        self:methods("AddHandlerAutoDelOnDestroy", "table,function", "", "event,handler", make_function_body(strs), "", "")
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param resPath string
    ---@param functions string
    ---@param params any
    ---@return void
    def.method("string", "string", 'string', 'dynamic').samplePanel = function(self, name, resPath, functions, params)
        if type(params) ~= 'table' then
            params = {}
        end
        local className = 'ECPanel'..name
        local class = self:createOne(className, "ECPanelBase")
        local withCleanerHelp = params.withCleanerHelp
        functions = string.split(functions, ',')

        if withCleanerHelp then
            class:withCleanerHelp()
            local key = table.FindKeyByValue(functions, 'OnDestroy')
            if key then
                table.remove(functions, key)
            end
            self:withAddHandlerAutoDelOnDestroy()
        end

        class:prefix("界面：", AUTHOR_NAME)
        class:require("GUI", "ECPanelBase")
        class:require("GUI", "ECGUITools")
        if table.FindKeyByValue(functions, 'Instance') then
            class:InstanceStatic()
        end
        local strs = {
            "--对象构造初始化",
        }
        class:constructor("init", "", "", "", make_function_body(strs), "", "")
        strs = {
            "if show then",
            "\tif self.m_panel == nil then",
            "\t\t--返回ECResPath.lua中的路径:",
            ("\t\tself:CreatePanel(RESPATH.%s)--返回ECResPath.lua中的路径"):format(resPath),
            "\telse",
            "\t\tself:Refresh()",
            "\tend",
            "else",
            "\tself:DestroyPanel()",
            "end",
        }
        class:methods("ShowPanel", "boolean", "", "show", make_function_body(strs), "", "")
        class:methods("Refresh", "", "", "", "", "", "")

        strs = {
            "--界面创建,设置ui元件:",
            "--ECGUITools.setVisible",
        }
        if withCleanerHelp then
            strs[#strs+ 1] = "--界面创建,设置监听"
            strs[#strs+ 1] = "--self:AddHandlerAutoDelOnDestroy"
        end
        class:override("OnCreate", "", "", "", make_function_body(strs), "", "")

        self:ViewFunctions(functions)

        if withCleanerHelp then
            strs = {
                "--销毁监听",
                "self:disposeCleaner()",
            }
            class:override("OnDestroy", "", "", "", make_function_body(strs), "", "")
        end

        local pathName
        if params.path then
            pathName = (LUA_PATH.."\\%s\\%s.lua"):format(params.path, className)
        else
            pathName = (LUA_PATH.."\\GUI\\%s.lua"):format(className)
        end
        class:commit(pathName)
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param functions string
    ---@return void
    def.method("string", 'string').sampleView = function(self, name, functions)
        local className = 'UIView'..name
        local class = self:createOne(className, "ECViewBase")
        class:prefix("界面视图：", AUTHOR_NAME)
        class:require("GUI", "ECViewBase")
        class:require("GUI", "ECGUITools")
        --class:field("number", "m_index", nil)
        local strs = {
            "--注册子控件对象",
            "--self:RegisterSubView()",
        }
        class:constructor("init", "", "", "", make_function_body(strs), "", "")

        strs = {
            "--界面创建，事件监听，设置ui元件:",
            "--self:AddHandlerAutoDelOnDestroy",
            "--ECGUITools.setVisible",
        }
        class:override("OnCreate", "", "", "", make_function_body(strs), "", "")
        functions = string.split(functions, ',')
        self:ViewFunctions(functions)
        local pathName = (LUA_PATH.."\\GUI\\%s.lua"):format(className)
        class:commit(pathName)
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param notification_name string
    ---@return void
    def.method('string', 'string').sampleBadge = function(self, name, notification_name)
        local className = 'N'..name.."Badge"
        local class = self:createOne(className, "INotification")
        class.m_data.commit_kind = 'before'
        class:prefix("小红点", AUTHOR_NAME)
        class:require("Notification", "INotification")
        class:require("Notification", "FENotificationMan")
        local strs
        strs = {
            "--返回小红点名，在notification.lua中配置使用",
            ("--在Notification\\Preload.lua中写：require \"Notification.notifications.%s\""):format(className),
            ("return \"%s\""):format(notification_name),
        }
        class:override("GetNotificationName", "", "string", "", make_function_body(strs), "", "")

        strs = {
            "--小红点变化监听事件",
            "--self:AddEventWithCleaner",
        }
        class:override("ListenEvent", "", "", "", make_function_body(strs), "", "")

        strs = {
            "--小红点通知",
            "--self:SetNotificationState",
            "--self:SetNotificationCount",
            "--self:SetNotificationStateEx",
        }
        class:override("OnRefreshHdl", "", "", "", make_function_body(strs), "", "")
        local line = ("if Lplus.fresh() then\n\tFENotificationMan.Get():Register(%s())\nend"):format(className)
        table.insert(class.m_data.lines_after_def, line)
        local pathName = (LUA_PATH.."\\Notification\\notifications\\%s.lua"):format(className)
        class:commit(pathName)
    end


    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@return void
    def.method('string').sampleEvent = function(self, name)
        local className = name.."Event"
        local class = self:createOne(className, "")
        class:prefix("事件", AUTHOR_NAME)
        class:newFinal()
        local pathName = (LUA_PATH.."\\Event\\%s.lua"):format(className)
        class:commit(pathName)
    end

    ---@param self LplusFactory.LplusFactory
    ---@param name string
    ---@param cmdName string
    ---@return void
    def.method('string', 'string').samplePB = function(self, name, cmdName)
        local fileName = "pb_"..name
        local class = self:createOne('', "")
        class:prefix("协议", AUTHOR_NAME)
        class:require("PB", "pb_helper")
        local befores = self.m_data.befores
        befores[#befores+1] = ('--- 在pb_preload.lua中写：require "PB.%s"\n'):format(fileName)
        befores[#befores+1] = 'local ECGame = Lplus.ForwardDeclare("ECGame")\n'
        befores[#befores+1] = ('local function %s( sender, msg )\n\t--ECGame.EventManager:raiseEvent()\nend\n'):format(cmdName)
        befores[#befores+1] = ('pb_helper.AddHandler(\"%s\", %s)\n'):format(cmdName, cmdName)
        local pathName = (LUA_PATH.."\\PB\\%s.lua"):format(fileName)
        class:commit(pathName)
    end

    ---@param self LplusFactory.LplusFactory
    ---@param cfg table
    ---@return void
    def.method('table').sampleConfig = function(self, cfg)
        for i, v in ipairs(cfg) do
            local methodName = v[1]
            table.remove(v, 1)
            print('config_value:',i, methodName, unpack(v))
            self[methodName](self, unpack(v))
        end
    end

    ---@param self LplusFactory.LplusFactory
    ---@param fileName string
    ---@return void
    def.method('string').sampleFile = function(self, fileName)
        local f = io.open(fileName, "r")
        if f then
            local content = f:read("*a")
            content = string.split(content, '\n')
            for i, v in ipairs(content) do
                local one = string.split(v, '|')
                for i, v in ipairs(one) do
                    if v == '\'\'' then
                        one[i] = ''
                    end
                end
                content[i] = one
            end
            self:sampleConfig(content)
        end
    end

    if false then
        --内部版：dofile"More/LplusFactory/LplusFactoryInit.lua"
        -- local LplusFactory = require "LplusFactory.LplusFactory".Instance
        --例子
        LplusFactory:samplePanel('TestCt1', "TestCt1", "Instance,onToggleObj,OnDestroy", nil)
        LplusFactory:sampleView('TestCt1', "onToggleObj,OnDestroy")
        LplusFactory:sampleBadge('TestCt1', "testct1")
        LplusFactory:sampleEvent('TestCt1')
        LplusFactory:samplePB('testct1', 'npt_testct1')
        --通用
        local cfg = {
            {'createOne','testCfg1', ''},
            {'prefix','测试', 'lyk'},
            {'require','PB','pb_helper'},
            {'newFinal'},
            {"methods", "onClickObj", "userdata", "", "sender", "--test", "", ""},
            {"commit", "G:\\svn\\phecda_client\\trunk\\Azure\\Output\\Lua\\testCfg1.lua"},
        }
        LplusFactory:sampleConfig(cfg)
        LplusFactory:sampleFile(LF_FILE_PATH..'\\testCfg1.ct')
    end

end
return LplusFactory.Commit()
