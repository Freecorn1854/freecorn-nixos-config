{pkgs, outputs, ...}: {
  home.packages = let
    # Use grim and slurp to take screenshots in multiple ways
    swayShot = pkgs.writeScriptBin "swayshot" ''
      # Swappy
      handle_swappy() {
        # Create an imv window to act as a static screen
        grim -t jpeg -q 100 - | imv -w "GlobalShot" - & imv_pid=$!

        # Capture the screenshot of the selected area and save to a temporary file
        selected_area=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"'\
        | XCURSOR_SIZE=40 slurp -w ${outputs.look.border.string} -c ${outputs.look.colors.prime} -B 00000066 -b 00000099)
        temp_file=$(mktemp -u).png
        grim -g "$selected_area" "$temp_file"

        # Kill the imv window
        kill $imv_pid

        # Copy the screenshot to the clipboard
        swappy -f - < "$temp_file"

        # Clean up the temporary file
        rm "$temp_file"
      }

      # Current
      handle_current() {
        # Take a screenshot and save it to the temporary file
        temp_file=$(mktemp -u).png
        grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') "$temp_file"

        # Check if the screenshot was successfully taken
        if [ $? -eq 0 ]; then
          # Copy the screenshot to the clipboard
          wl-copy < "$temp_file"

          # Show a notification with the screenshot
          notify-send -i "$temp_file" "Current screen copied."

          # Remove the temporary file
          rm "$temp_file"
        else
          # If the screenshot capture failed, show an error notification
          notify-send "Error: Unable to capture screenshot."
        fi
      }

      # All screens
      handle_all() {
        # Take a screenshot and save it to the temporary file
        temp_file=$(mktemp -u).png
        grim -t jpeg -q 100 "$temp_file"

        # Check if the screenshot was successfully taken
        if [ $? -eq 0 ]; then
          # Copy the screenshot to the clipboard
          wl-copy < "$temp_file"

          # Show a notification with the screenshot
          notify-send -i "$temp_file" "All screen copied."

          # Remove the temporary file
          rm "$temp_file"
        else
          # If the screenshot capture failed, show an error notification
          notify-send "Error: Unable to capture screenshot."
        fi
      }

      # Check for command-line arguments
      if [ "$1" == "--swappy" ]; then
        handle_swappy
      elif [ "$1" == "--current" ]; then
        handle_current
      elif [ "$1" == "--all" ]; then
        handle_all
      else
        echo "Please use the arguments swappy, current, or all."
      fi
    '';
  in with pkgs; [
    swayShot
  ];
}
