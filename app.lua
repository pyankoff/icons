local lapis = require("lapis")
local app = lapis.Application()
require 'torch'
require 'nn'
require 'image'

app:match("/", function(self)
  local file = self.params.upload

  local save = io.open("img.jpg", "w")
  save:write(file.content)  
  
  local img = image.load("img.jpg")

  return img:size()
end)

return app
