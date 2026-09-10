{
  pkgs,
  lib,
  enableColima ? false,
  ...
}:
lib.mkIf enableColima {
  environment.systemPackages = with pkgs; [
    colima
    docker-client
    docker-compose
  ];

  launchd.user.agents.colima = {
    serviceConfig = {
      ProgramArguments = [
        "${pkgs.colima}/bin/colima"
        "start"
        "--foreground"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/colima.log";
      StandardErrorPath = "/tmp/colima.log";
      EnvironmentVariables = {
        PATH = "${pkgs.colima}/bin:${pkgs.docker-client}/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      };
    };
  };
}
