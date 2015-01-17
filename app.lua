local lapis = require("lapis")
local app = lapis.Application()
local torch = require("torch")
local os = require("os")
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
  local url = self.params.url

  os.execute("wget " .. url)

  response = "bitch "
  local inputImage = image.load(paths.basename(url))
  for i = 1, 4 do
    for j = 1, 6 do
      icon = inputImage[{{}, {y[j],y[j]+120}, {x[i],x[i]+120}}]
      img = image.scale(icon, 32, 32)

      output = model:forward(img)
      k, result = torch.max(output, 1)
      response = response .. appsList[result[1]+1] .. "\n"
    end
  end
  return { json = { apps = response }}
end)

return app
