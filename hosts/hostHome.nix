{
  config,
  lib,
  ...
}:
with lib; {
  config = let
    hostName = config.networking.hostName;
    makeHM = name: _user: let
      user = config.users.users.${name};
    in {
      _module.args = {
        inherit hostName user;
      };

      imports = [
        ./${hostName}/users/${name}/home.nix
      ];
      home.sessionVariables = {
        NOTES_PATH = "$HOME/Documents/Obsidian-Vault"; # path to notes folder ( for neovim )
        PROJECTS_PATH = "$HOME/Documents/Projects"; # path to Projects folder ( for neovim )
      };
    };
  in {
    home-manager.users = mapAttrs makeHM config.nix-relic.users.users;
  };
}
