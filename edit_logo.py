from PIL import Image
import numpy as np
import colorsys

def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def edit_logo_color(image_path, output_path, target_hex):
    img = Image.open(image_path).convert("RGBA")
    data = np.array(img)
    
    # Target color
    target_rgb = hex_to_rgb(target_hex)
    target_r, target_g, target_b = target_rgb
    
    # Get separate channels
    r, g, b, a = data[:,:,0], data[:,:,1], data[:,:,2], data[:,:,3]
    
    # Define "Red" mask (where Red is dominant and significantly brighter than Green/Blue)
    # This captures the red text "THE PARA"
    red_mask = (r > 100) & (r > g * 1.5) & (r > b * 1.5)
    
    # Apply target color to the masked area
    # We apply it directly for a solid look, or we could blend. 
    # Given "Edit the words to have our theme color", exact match is safest.
    data[red_mask, 0] = target_r
    data[red_mask, 1] = target_g
    data[red_mask, 2] = target_b
    
    # create result
    result = Image.fromarray(data)
    result.save(output_path)
    print(f"Saved edited logo to {output_path}")

if __name__ == "__main__":
    source = r"c:/Users/Joel/OneDrive/Documents/Anti Gravity/The Para/Para/images/logo.png"
    dest = r"c:/Users/Joel/OneDrive/Documents/Anti Gravity/The Para/Para/images/logo_edited.png"
    theme_color = "#e3d46b"
    
    try:
        edit_logo_color(source, dest, theme_color)
    except Exception as e:
        print(f"Error: {e}")
