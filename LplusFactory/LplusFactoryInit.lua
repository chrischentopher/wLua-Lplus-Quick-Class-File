_G.LF_LUA_PATH =  'G:\\svn\\phecda_client\\trunk\\Azure\\Output\\Lua'
_G.LF_AUTHOR_NAME = 'chentao'
_G.LplusFactoryIsOuter = true --是否外部版，外部版反在pck下或private\RunGamePck\More下
if not _G.LplusFactoryData then
	if _G.LplusFactoryIsOuter then --外部版不能用reload
		_G.LF_FILE_PATH = 'G:\\svn\\phecda_client\\trunk\\private\\RunGamePck\\More\\LplusFactory'
		_G.LplusFactoryData = dofile"More/LplusFactory/LplusFactoryData.lua"
		_G.LplusFactory = dofile"More/LplusFactory/LplusFactory.lua".Instance()
	else
		_G.LF_FILE_PATH = _G.LUA_PATH..'\\LplusFactory'
		_G.LplusFactoryData = require "LplusFactory.LplusFactoryData"
		_G.LplusFactory = require "LplusFactory.LplusFactory".Instance()
	end
end
print('module More.LplusFactory init success')
