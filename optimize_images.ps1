
# Function to resize image
function Resize-Image {
    param (
        [string]$InputFile,
        [string]$OutputFile,
        [int]$MaxWidth,
        [int]$MaxHeight
    )

    Add-Type -AssemblyName System.Drawing

    if (-not (Test-Path $InputFile)) {
        Write-Host "File not found: $InputFile"
        return
    }

    $img = [System.Drawing.Image]::FromFile($InputFile)
    
    $ratioX = $MaxWidth / $img.Width
    $ratioY = $MaxHeight / $img.Height
    $ratio = $ratioX
    if ($ratioY -lt $ratioX) {
        $ratio = $ratioY
    }

    $newWidth = [int]($img.Width * $ratio)
    $newHeight = [int]($img.Height * $ratio)

    $newImg = new-object System.Drawing.Bitmap $newWidth, $newHeight
    $graph = [System.Drawing.Graphics]::FromImage($newImg)
    $graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    
    $graph.DrawImage($img, 0, 0, $newWidth, $newHeight)

    # Save as JPEG with compression
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 80)

    $newImg.Save($OutputFile, $codec, $encoderParams)

    $img.Dispose()
    $newImg.Dispose()
    $graph.Dispose()
    
    Write-Host "Optimized $InputFile -> $OutputFile"
}

$imagesDir = "c:\Users\Joel\OneDrive\Documents\Anti Gravity\The Para\Para\images"
$realImagesDir = "c:\Users\Joel\OneDrive\Documents\Anti Gravity\The Para\Para\Real images"

# Optimize Logo (Previously done, but ensuring consistency)
Resize-Image -InputFile "$imagesDir\logo_final.jpg" -OutputFile "$imagesDir\logo_optimized.jpg" -MaxWidth 600 -MaxHeight 600

# Optimize Favicon
Resize-Image -InputFile "$imagesDir\favicon_final.jpg" -OutputFile "$imagesDir\favicon_optimized.jpg" -MaxWidth 192 -MaxHeight 192

# Optimize Barbershop Image (Huge file)
Resize-Image -InputFile "$realImagesDir\Executive haircut.JPG" -OutputFile "$realImagesDir\Executive haircut_optimized.JPG" -MaxWidth 800 -MaxHeight 800

# Optimize Facial Image (Also large)
Resize-Image -InputFile "$realImagesDir\Executive facial.png" -OutputFile "$realImagesDir\Executive facial_optimized.JPG" -MaxWidth 800 -MaxHeight 800

Write-Host "Optimization Complete."
