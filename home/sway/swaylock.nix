{config, pkgs, outputs, ...}: let 
  swayLock = pkgs.writeScriptBin "swaylock" ''
    # Set the lock script
    lockscript() {
      BLANK='#00000000'
      CLEAR='#FFFFFF22'
      DEFAULT='#${outputs.look.colors.prime}FF'
      TEXT='#FFFFFFFF'
      WRONG='#${outputs.look.colors.split}FF'
      VERIFYING='#${outputs.look.colors.accent}FF'

      ${pkgs.swaylock-effects}/bin/swaylock -f -e \
      --key-hl-color=$VERIFYING \
      --bs-hl-color=$WRONG \
      \
      --ring-clear-color=$CLEAR \
      --ring-ver-color=$VERIFYING \
      --ring-wrong-color=$WRONG \
      --ring-color=$DEFAULT \
      --ring-clear-color=$VERIFYING \
      \
      --inside-color=$CLEAR \
      --inside-ver-color=$CLEAR \
      --inside-wrong-color=$CLEAR \
      --inside-clear-color=$CLEAR \
      \
      --text-color=$TEXT \
      --text-clear-color=$TEXT \
      --text-ver-color=$TEXT \
      --text-caps-lock-color=$TEXT \
      --text-wrong-color=$TEXT \
      \
      --indicator \
      --indicator-radius=80 \
      --image=~/.wallpapers/lock.png \
      --clock \
      --font=${outputs.look.fonts.main} \
      --font-size=30 \
      --timestr="%I:%M%p" \
      --datestr="%a %b %d %Y"
    }

    # Handle whether to lock or sleep
    if [ "$1" == "--sleep" ]; then
      lockscript &
      exec ${pkgs.swayidle}/bin/swayidle -w \
        timeout 1 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"; pkill -9 swayidle'
    else
      lockscript
    fi
  '';
in {
  # Enable Sway and write some scripts
  home.packages = with pkgs; [
    swayLock
  ];

  # Enable Sway lock on startup
  wayland.windowManager.sway.config.startup = [
    {command = "swaylock";}
  ];
}
