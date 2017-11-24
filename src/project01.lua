print("Hello World!")
dofile('lib-BLYNK.lua')
bl = blynk.new(MyBlynkToken) --defined in creds.lua
print("Before connect")
bl:connect()

