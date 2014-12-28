local lapis = require("lapis")
local app = lapis.Application()
local torch = require("torch")
require("nn")
require("image")

torch.setdefaulttensortype('torch.FloatTensor')
local network = 'icons97good.net'
local model = torch.load(network, 'ascii')

app:match("/", function(self)
  local file = self.params.upload

  local save = io.open("img.jpg", "w")
  save:write(file.content)  
  save:close()
  
  local huy = torch.Tensor(20)
  local img = image.load("img.jpg")
  img = image.scale(img, 32, 32)

  output = model:forward(img)
  y, result = torch.max(output, 1)

  return ""..result[1]
end)

return app
