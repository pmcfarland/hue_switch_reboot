# This script checks if my front door Ring is online, if not it sends an api commmand to the
# hue switch to power off and back, power cycling the poe adapter for the ring and bringing it back online

# @author Patrick McFarland
# @date   11.10.21

while ($true) {
    if (-not (Test-Connection '192.168.1.YYY' -Quiet)) {
        Write-Host "Test failed: $(Get-Date -Format "MM/dd hh:mm tt")"
        Write-Host "Powering off Ring..." -ForegroundColor Red
		$ProgressPreference = 'SilentlyContinue'    # Subsequent calls do not display UI.
		Invoke-WebRequest -UseBasicParsing http://192.168.1.XX/api/<api_token>/lights/11/state -ContentType "application/json" -Method PUT -Body '{"on":false}'
		Start-Sleep -Seconds 10						# Wait a few seconds for power to cut off before turning back on
		$ProgressPreference = 'Continue'            # Subsequent calls do display UI.
		Write-Host "Powering on Ring..." -ForegroundColor Green
		$ProgressPreference = 'SilentlyContinue'    # Subsequent calls do not display UI.
		Invoke-WebRequest -UseBasicParsing http://192.168.1.XX/api/<api_token>/lights/11/state -ContentType "application/json" -Method PUT -Body '{"on":true}'
		Start-Sleep -Seconds 120 					# Wait 2 min for device to come back online before testing again
		$ProgressPreference = 'Continue'            # Subsequent calls do display UI.
    }
    else {
        Write-Host "Connection test passed: $(Get-Date -Format "MM/dd hh:mm tt")"
        Start-Sleep -Seconds 300
    }
}