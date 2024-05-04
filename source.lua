getgenv().frameworker = {} 
getgenv().frameworker_cache = {}
frameworker.service = setmetatable({},{__index = function(self,service)
    if frameworker_cache[service] then
        return frameworker_cache[service]
    end
    local good,result = pcall(function() game:GetService(service) end)  
    if good then
    frameworker_cache[service] = game:GetService(service)
     return game:GetService(service)
     else 
     return  
    end 
  end 
})
local services = frameworker.service
function frameworker:connect(signal,event) 
   return signal:Connect(event) 
end 
function frameworker:randomstring(length)
local amount = length or 10
     local strings = {} 
     for i=1,amount do 
         strings[i] = string.char(math.random(97,122)) 
     end 
     return table.concat(strings) 
end
function frameworker:getasset(id) 
return (isfile(id) and getcustomasset(id)) or game:GetObjects("rbxassetid://"..id)[1]
end 
function frameworker:chatcheck() 
if services.TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then 
 return true 
 else 
 return false 
 end 
end 
function frameworker:chat(msg) 
 if frameworker:chatcheck() then 
 services.TextChatService.TextChannels.RBXGeneral:SendAsync(msg) 
 else 
 services.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg,"All") 
 end 
end 
function frameworker.new(instance,property) 
 local thing = Instance.new(instance) 
 for i,v in pairs(property) do 
    thing[i] = v 
 end 
 return thing 
end 
function frameworker.dnew(instance,property)
  local thing = Drawing.new(instance)
  for i,v in pairs(property) do
      thing[i] = v
  end
  return thing
end
function frameworker.fpscap(number) 
     if setfpscap then 
     setfpscap(number) 
     end 
end
function frameworker:GetPlayer(player)
if player:lower():find("random") then
return services.Players:GetPlayers()[math.random(1,#frameworker.service.Players:GetPlayers())]
end
 local selectedplayer
     for _,v in next, services.Players:GetPlayers() do 
    if string.find(string.lower(v.Name),string.lower(player)) or string.find(string.lower(v.DisplayName),string.lower(player)) then
    selectedplayer = v
    end
     end
     return selectedplayer
end
function frameworker:GetDevice()
if services.Players.LocalPlayer.PlayerGui:FindFirstChild("TouchGui") then
return "Mobile"
else
return "PC"
end
end
function frameworker:IsUserMobile()
if services.Players.LocalPlayer.PlayerGui:FindFirstChild("TouchGui") then
return true
else
return false
end
end
function frameworker:TweenTeleport(cframe,time) 
services.TweenService:Create(services.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(time), {CFrame = cframe}):Play() 
end
function frameworker:Teleport(CFrame)
services.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame
end
function frameworker:LTeleport(cframe,time,duration)
local timer = tick()
local whentostop = duration or 0.5
repeat task.wait()
services.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = services.Players.LocalPlayer.Character.HumanoidRootPart.CFrame:Lerp(cframe,time)
until tick()-timer > whentostop
end
function frameworker:GetPlaceUID(placeid)
local id = placeid or game.PlaceId
    local the = services.HttpService:JSONDecode(http_request({Url = "https://apis.roblox.com/universes/v1/places/"..id.."/universe"}).Body)
    return the.universeId
end
local oldparent = {}
function frameworker:ProtectUI(ui)
assert(typeof(ui) == "Instance",string.format("invalid usage of ProtectUI, instance expected, not %s",typeof(ui)))
oldparent[ui] = ui.Parent
ui.Parent = gethui()
end
function frameworker:UnprotectUI(ui)
assert(typeof(ui) == "Instance",string.format("invalid usage of UnprotectUI, instance expected, not %s",typeof(ui)))
local parent = oldparent[ui.Parent]
if oldparent[ui] then
ui.Parent = oldparent[ui]
oldparent[ui] = nil
end
end
function frameworker:FireServer(remote,...)
remote:FireServer(table.unpack({...}))
end
function frameworker:InvokeServer(remote,...)
remote:InvokeServer(table.unpack({...}))
end
function frameworker:ConvertStringToCFrame(str)
 return CFrame.new(table.unpack(str:gsub(" ",""):split(",")))
end
return frameworker
