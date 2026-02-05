Add-Type -AssemblyName System.Drawing

$source = "c:\Users\Joel\OneDrive\Documents\Anti Gravity\The Para\Para\images\logo.png"
$dest = "c:\Users\Joel\OneDrive\Documents\Anti Gravity\The Para\Para\images\logo_edited.png"
# Original Theme Yellow: #e3d46b (R=227, G=212, B=107)
$targetColor = [System.Drawing.Color]::FromArgb(255, 227, 212, 107)

try {
    $bmp = [System.Drawing.Bitmap]::FromFile($source)
    
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        for ($y = 0; $y -lt $bmp.Height; $y++) {
            $pixel = $bmp.GetPixel($x, $y)
            
            # IMPROVED RED DETECTION:
            # any pixel where R > G and R > B is considered reddish.
            # We remove the "R > 100" threshold to catch dark red (maroon) pixels.
            if ($pixel.R -gt $pixel.G -and $pixel.R -gt $pixel.B) {
                # Preserve transparency (Anti-aliasing)
                if ($pixel.A -gt 0) {
                    $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($pixel.A, $targetColor))
                }
            }
        }
    }
    
    $bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Success: Saved edited logo to $dest"
}
catch {
    Write-Host "Error: $_"
}
