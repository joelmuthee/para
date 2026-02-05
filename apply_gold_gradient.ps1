Add-Type -AssemblyName System.Drawing

$source = "c:\Users\Joel\OneDrive\Documents\Anti Gravity\The Para\Para\images\logo.png"
$dest = "c:\Users\Joel\OneDrive\Documents\Anti Gravity\The Para\Para\images\logo_gradient.png"

# Color Stops for Gold Gradient
$c1 = [System.Drawing.Color]::FromArgb(255, 255, 250, 205) # Top Highlight (LemonChiffon)
$c2 = [System.Drawing.Color]::FromArgb(255, 227, 212, 107) # Middle (Theme Yellow)
$c3 = [System.Drawing.Color]::FromArgb(255, 139, 101, 8)   # Bottom Shadow (Dark GoldenRod)

function Get-GradientColor {
    param ($ratio)
    
    if ($ratio -lt 0.4) {
        # Interpolate between C1 and C2 (0.0 to 0.4)
        $localRatio = $ratio / 0.4
        $r = $c1.R + ($c2.R - $c1.R) * $localRatio
        $g = $c1.G + ($c2.G - $c1.G) * $localRatio
        $b = $c1.B + ($c2.B - $c1.B) * $localRatio
        return [System.Drawing.Color]::FromArgb(255, [int]$r, [int]$g, [int]$b)
    }
    else {
        # Interpolate between C2 and C3 (0.4 to 1.0)
        $localRatio = ($ratio - 0.4) / 0.6
        $r = $c2.R + ($c3.R - $c2.R) * $localRatio
        $g = $c2.G + ($c3.G - $c2.G) * $localRatio
        $b = $c2.B + ($c3.B - $c2.B) * $localRatio
        return [System.Drawing.Color]::FromArgb(255, [int]$r, [int]$g, [int]$b)
    }
}

try {
    $bmp = [System.Drawing.Bitmap]::FromFile($source)
    $height = $bmp.Height
    
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        for ($y = 0; $y -lt $bmp.Height; $y++) {
            $pixel = $bmp.GetPixel($x, $y)
            
            # If pixel is not transparent, apply gradient
            if ($pixel.A -gt 10) {
                $ratio = $y / $height
                $newColor = Get-GradientColor $ratio
                
                # Apply the new color but keep original Alpha channel
                $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($pixel.A, $newColor))
            }
        }
    }
    
    $bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Success: Created gold gradient logo at $dest"
}
catch {
    Write-Host "Error: $_"
}
