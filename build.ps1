# PowerShell script to build custom Jitsi Docker images
# Run this from the root of your cloned docker-jitsi-meet repo

$components = @("base", "web", "prosody", "jicofo", "jvb")
$customTag = "my-custom"

foreach ($component in $components) {
    $path = Join-Path -Path "." -ChildPath $component
    if (Test-Path "$path\Dockerfile") {
        $imageName = "dixoncb/${component}:${customTag}"
        Write-Host "`nBuilding $imageName from $path..."
        docker build -t $imageName $path
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Successfully built $imageName"
        } else {
            Write-Host "Failed to build $imageName"
            break
        }
    } else {
        Write-Host "No Dockerfile found for $component in $path, skipping..."
    }
}
