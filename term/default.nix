{ config, pkgs, ... }:

# Import some common debugging packages often included with busy box separately
# in order to get help commands etc.
{
  home.packages = with pkgs; [
    blesh
  ];
}
