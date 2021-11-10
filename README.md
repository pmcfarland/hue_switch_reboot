# hue_switch_reboot
Powercycles a Hue smart plug when the connected device goes offline.


I've been having an issue with my Ring doorbell where it goes offline periodically. I've dealt with Ring support and they are sending a replacement, but between the back and forth with support and shipping delays it's been a while. In the meantime I would still like to have a working Ring so rather than manually powercycling the device I wanted to handle that automatically.

I have a Philips Hue smart plug (https://www.philips-hue.com/en-us/p/hue-smart-plug/046677552343) connected to the Ring POE adapter that is powering my doorbell so I can simply toggle the switch off and back on again. That saves me the trip of going down into my basement but I figured I can do better.

I setup a Powershell script that pings the IP address for my Ring and if it fails then turns the plug off, waits a few seconds and then back on and finally waits 2 minutes before checking agian to give it time to come back up.

It's crude, but hopefully should only be in service for a couple weeks at most, saves me from having to think about it and was a fun experiment. If this was a permanent solution I would have had it check several times in a row to confirm that it's actually down and not just a fluke. It would also be useful to get some notification/external log when it happens such as an email or telegram message, but again this is only temporary.


Note, I have santized the script so you will need to plug in your own info.
============================================================================


First what you want it to ping:
    if (-not (Test-Connection '192.168.1.YYY' -Quiet)) {
    
Then you will need to set the IP address for your Hue hub:
    Invoke-WebRequest -UseBasicParsing http://192.168.1.XX/api/

And finally you'll need your API token to be able to complete the request:
     http://192.168.1.XX/api/<api_token>/lights/11/state
     
I found this guide to be very useful getting started with Hue's API: https://austenclement.com/getting-started-with-the-philips-hue-rest-api/

I have mine set to check ever 5 min (300 seconds) but that is configurable. I wouldn't recomend going much lower though as you're likely hood of getting false netagives(ping failing when it's actually up) increases.
