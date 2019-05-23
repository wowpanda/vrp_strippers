--[[
  Author(s): RolzZ
  Version: 1.0
]]--

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description "Add strippers"

client_scripts {
  "client/config.lua",
  "client/main.lua"
}

server_scripts {
  "@vrp/lib/utils.lua",
  "server/main.lua"
}

dependency "vrp"