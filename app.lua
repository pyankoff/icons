local lapis = require("lapis")
local app = lapis.Application()
local torch = require("torch")
require("nn")
require("image")

torch.setdefaulttensortype('torch.FloatTensor')
local network = 'icons97good.net'
local model = torch.load(network, 'ascii')

local file = io.open("filteredApps.txt", "r");
local appsList = {}
for line in file:lines() do
  table.insert (appsList, line);
end

x = {31, 183, 335, 487}
y = {89, 254, 420, 586, 753, 972}

app:match("/", function(self)
  local file = self.params.upload

  local save = io.open("img.jpg", "w")
  save:write(file.content)  
  save:close()
  
  local inputImage = image.load("img.jpg")
  for i = 1, 4 do
    for j = 1, 6 do
      icon = inputImage[{{}, {y[j],y[j]+120}, {x[i],x[i]+120}}]
      img = image.scale(icon, 32, 32)

      output = model:forward(img)
      k, result = torch.max(output, 1)
      print(appsList[result[1]+1])
    end
  end

end)

return app
