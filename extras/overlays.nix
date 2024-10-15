{inputs, ...}: {

  # This one brings our custom packages from the 'pkgs' directory
  # additions = final: _prev: import ./pkgs {pkgs = final;};

  finalprev = (final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  });
}
