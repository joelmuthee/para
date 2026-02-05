Add-Type -AssemblyName System.Drawing

$source = "c:\Users\Joel\OneDrive\Documents\Anti Gravity\The Para\Para\images\logo.png"
$dest = "c:\Users\Joel\OneDrive\Documents\Anti Gravity\The Para\Para\images\logo_edited.png"
$targetColor = [System.Drawing.Color]::FromArgb(255, 227, 212, 107) # #e3d46b

try {
    $bmp = [System.Drawing.Bitmap]::FromFile($source)
    
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        for ($y = 0; $y -lt $bmp.Height; $y++) {
            $pixel = $bmp.GetPixel($x, $y)
            
            # Simple Red Detection: High Red, Low Green/Blue
            if ($pixel.R -gt 100 -and $pixel.R -gt ($pixel.G * 1.5) -and $pixel.R -gt ($pixel.B * 1.5)) {
                # Preserve Alpha
                if ($pixel.A -gt 0) {
                     $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($pixel.A, $targetColor))
                }
            }
        }
    }
    
    $bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Success: Saved edited logo to $dest"
} catch {
    Write-Host "Error: $_"
}
