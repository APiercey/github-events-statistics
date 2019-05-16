Application.load(:gh_events) 

for app <- Application.spec(:gh_events, :applications) do
  Application.ensure_all_started(app)
end

ExUnit.start(trace: true)
