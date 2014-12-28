local lapis = require("lapis")
local app = lapis.Application()
local torch = require("torch")
require("nn")
require("image")

app:match("/", function(self)
  local file = self.params.upload

  local save = io.open("img.jpg", "w")
  save:write(file.content)  
  save:close()
  
  local huy = torch.Tensor(20)
  local img = image.load("img.jpg")

  return ""..img:size()[2]
end)

return app
