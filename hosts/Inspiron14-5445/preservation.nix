{ delib, ... }:
delib.host {
  name = "Inspiron14-5445";
  nixos.preservation = {
    enable = true;
    preserveAt."/persist" = {
      # システムレベルの永続化
      directories = [
        "/var/lib/nixos" # UID/GIDや状態情報
        "/var/lib/systemd" # systemd の状態
        "/etc/NetworkManager/system-connections" # Wi-Fi設定など
      ];
      files = [
        "/etc/machine-id" # システム一意識別子
        "/etc/ssh/ssh_host_ed25519_key" # SSHホスト鍵
        "/etc/ssh/ssh_host_ed25519_key.pub"
      ];

      # ユーザーレベルの永続化
      users.fyukmdaa = {
        directories = [
          "Downloads"
          "Documents"
          "Projects"
          "Pictures"
          "Music"
          "emacs-twist"
          "ghq"
          ".ssh"
          ".local/share/keyrings"
          ".floorp"
          ".gnupg"
        ];
        files = [];
      };
    };
  };
}
