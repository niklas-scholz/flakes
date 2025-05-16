{ pkgs, ... }:
{
  system.defaults.NSGlobalDomain = {
    # Adjust toolbar title rollover delay
    NSToolbarTitleViewRolloverDelay = 0;
    # Set sidebar icon size to medium
    NSTableViewDefaultSizeMode = 2;

    # Expand save panel by default
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;

    # Finder: show all filename extensions
    AppleShowAllExtensions = true;

    com.apple.springing = {
      # Enable spring loading for directories
      enabled = true;
      # Remove the spring loading delay for directories
      delay = 0;
    };
  };

  com.apple.finder = {
    # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
    QuitMenuItem = true;

    # Finder: disable window animations and Get Info animations
    DisableAllAnimations = true;
    # Show icons for hard drives, servers, and removable media on the desktop
    ShowExternalHardDrivesOnDesktop = true;
    ShowHardDrivesOnDesktop = true;
    ShowMountedServersOnDesktop = true;
    ShowRemovableMediaOnDesktop = true;

    # Set Documents as the default location for new Finder windows
    # For other paths, use `PfLo` and `file:///full/path/here/`
    NewWindowTarget = "PfDo";
    NewWindowTargetPath = "file://~/Documents/";
    # Finder: show hidden files by default
    AppleShowAllFiles = true;

    # Finder: show status bar
    ShowStatusBar = true;

    # Finder: show path bar
    ShowPathbar = true;

    # Display full POSIX path as Finder window title
    _FXShowPosixPathInTitle = true;

    # Keep folders on top when sorting by name
    _FXSortFoldersFirst = true;

    # When performing a search, search the current folder by default
    FXDefaultSearchScope = "SCcf";

    # Disable the warning when changing a file extension
    FXEnableExtensionChangeWarning = false;

    # Use list view in all Finder windows by default
    FXPreferredViewStyle = "Nlsv";
  };

  # Avoid creating .DS_Store files on network or USB volumes
  com.apple.desktopservices = {
    DSDontWriteNetworkStores = true;
    DSDontWriteUSBStores = true;
  };

}
