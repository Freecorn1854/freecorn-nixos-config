{inputs, ...}: {
  #selfsuper = (self: super: {
  #});
  
  finalprev = (final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  });
}
