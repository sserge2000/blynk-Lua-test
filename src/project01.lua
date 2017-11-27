
dofile('lib-BLYNK.lua')

PROFILE_TICK = 5 --ms
HEARTBEAT_TICK = 10000 --ms

lastTime = -1
maxDelay = -1

function performanceTick()
  currentTime = tmr.now()
  if lastTime<0 then
    lastTime = currentTime
  else
    currentDelay = bit.band((currentTime - lastTime), 0x7fffffff) --compensates for timer rollover https://github.com/hackhitchin/esp8266-co-uk/issues/2
    lastTime = currentTime
    if currentDelay>maxDelay then
      maxDelay = currentDelay
    end
  end
end

function heartBeat()
  print("HB: maxDelay: ", maxDelay)
  maxDelay = -1
end

print("Hello World!")

tmr.create():alarm(PROFILE_TICK, tmr.ALARM_AUTO, performanceTick)
tmr.create():alarm(HEARTBEAT_TICK, tmr.ALARM_AUTO, heartBeat)

bl = blynk.new(MyBlynkToken) --defined in creds.lua
print("Before connect")
bl:connect()

performanceTick()
heartBeat()