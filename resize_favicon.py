from PIL import Image
import os

source_path = r"C:/Users/Joel/.gemini/antigravity/brain/92cc137b-f77f-4979-9a69-7e989cfc30f3/uploaded_image_1767950449990.jpg"
target_path = r"c:/Users/Joel/OneDrive/Documents/Anti Gravity/The Para/Para/images/favicon.png"

try:
    with Image.open(source_path) as img:
        # Resize to standard favicon size (e.g. 64x64 for high dpi, or 32x32)
        # 64x64 is a safe bet for modern screens
        img_resized = img.resize((64, 64), Image.Resampling.LANCZOS)
        
        # Save as PNG
        img_resized.save(target_path, "PNG")
        print(f"Successfully resized and saved to {target_path}")
except Exception as e:
    print(f"Error: {e}")
