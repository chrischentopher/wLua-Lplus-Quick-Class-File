_G.LF_LUA_PATH =  'G:\\svn\\phecda_client\\trunk\\Azure\\Output\\Lua'
_G.LF_AUTHOR_NAME = 'chentao'
_G.LplusFactoryIsOuter = true --是否外部版，外部版反在pck下或private\RunGamePck\More下
if not _G.LplusFactoryData then
	local require = require
	if _G.LplusFactoryIsOuter then --外部版不能用reload
		_G.LF_FILE_PATH = 'G:\\svn\\phecda_client\\trunk\\private\\RunGamePck\\More\\LplusFactory'
		require = function(module)
			local tbs = string.split(module, '.')
			local str = "More/".. table.concat(tbs, '/')..'.lua'
			print(str, 'str=============')
			return dofile(str)
		end
	else
		_G.LF_FILE_PATH = _G.LF_LUA_PATH..'\\LplusFactory'
	end
	_G.LplusFactoryData = require "LplusFactory.LplusFactoryData"
	_G.LplusFactory = require "LplusFactory.LplusFactory".Instance()
end
print('module More.LplusFactory init success')
