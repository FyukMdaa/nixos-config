{
  mulib,
  host,
  pkgs,
  ...
}:
mulib.module {
  name = "git";

  options.enable = [host.feat.cli];

  os.environment.systemPackages = [pkgs.git];

  home = {constants, ...}: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings = {
        user.name = constants.username;
        user.email = constants.useremail;
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };

  send.zenoSnippets = [
    {
      name = "git add .";
      keyword = "Gad";
      snippet = "git add .";
    }
    {
      name = "git commit";
      keyword = "Gcm";
      snippet = "git commit -m \"{{commit_message}}\"";
    }
    {
      name = "git push";
      keyword = "Gps";
      snippet = "git push";
    }
  ];
}
