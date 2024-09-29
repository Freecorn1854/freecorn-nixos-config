{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.freecorn = {
    isNormalUser = true;
    description = "Freecorn";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
