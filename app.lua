local lapis = require("lapis")
local app = lapis.Application()
local torch = require 'torch'
local nn = require 'nn'
local image = require 'image'

app:match("/", function(self)
  local file = self.params.upload

  local save = io.open("img.jpg", "w")
  save:write(file.content)  
  
  local img = image.load("img.jpg")

  print(img:size())
end)

return app
