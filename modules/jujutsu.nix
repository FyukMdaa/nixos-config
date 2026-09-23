{
  mulib,
  host,
  ...
}:
mulib.module {
  name = "jujutsu";

  options.enable = [host.feat.cli];

  home = {constants, ...}: {
    programs.jujutsu = {
      enable = true;

      settings = {
        user.name = constants.username;
        user.email = constants.useremail;
      };
    };
  };
}
