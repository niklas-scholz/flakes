{ ... }:
{
  system.defaults.screencapture = {
    # Save screenshots to the desktop
    location = "~/Desktop/";
    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    type = "png";
    # Disable shadow in screenshots
    disable-shadow = true;
  };
}
