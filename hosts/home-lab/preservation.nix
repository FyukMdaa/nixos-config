{ mulib, ... }:
mulib.host {
  name = "home-lab";

  os = {
    systemd.services.systemd-machine-id-commit.enable = false;
    preservation = {
      enable = true;
      preserveAt."/persist" = {
        directories = [
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/etc/NetworkManager/system-connections"
          "/etc/secureboot"
          # Nextcloud/Immichのデプロイ方式が決まったら、
          # コンテナランタイムの状態ディレクトリ等をここに追加。
          # データ本体は /srv 側(SSDミラー/HDD、rootとは別subvolume)に
          # 置くようにすれば、ここに追加すべきものは最小限で済む。
        ];
        files = [
          "/etc/machine-id"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
        ];
      };
    };
  };
}
