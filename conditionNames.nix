# conditionNames.nix — host condition の universe 宣言
#
# mulix では is/type/feat/role の4条件名前空間を扱う。
# `is` は system から自動生成されるため手動宣言不可。
#
# denix では extensions で features を宣言していたが、
# mulix では conditionNames.feat に直接書く。
{
  type = [
    "laptop"
    "desktop"
    "server"
  ];

  feat = [
    "gui"
    "cli"
    "mangowc"
    "hyprland"
    "niri"
    "draw"
    "dtm"
    "server"
    "video-edit"
    "android-dev"
    "token2"
  ];

  role = [
    "workstation"
    "infra"
  ];
}
