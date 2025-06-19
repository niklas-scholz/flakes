{ ... }:
{
  system.defaults.ActivityMonitor = {
    # Show the main window when launching Activity Monitor
    OpenMainWindow = true;
    # Visualize CPU usage in the Activity Monitor Dock icon
    IconType = 5;
    # Show all processes in Activity Monitor
    ShowCategory = 100;
    # Sort Activity Monitor results by CPU usage descending
    SortColumn = "CPUUsage";
    SortDirection = 0;
  };

}
