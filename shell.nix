{
  # nixpkgs 22.11, deterministic. Last updated: 2023-04-12.
  pkgs ? import (fetchTarball ("https://github.com/NixOS/nixpkgs/archive/115a96e2ac1e92937cd47c30e073e16dcaaf6247.tar.gz")) { }
}:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    pyserial
  ];
  python-with-my-packages = python3.withPackages my-python-packages;

  ambd_flash_tool = stdenv.mkDerivation rec {
    pname = "ambd_flash_tool";
    version = "145a371";

    src = fetchFromGitHub {
      owner = "Seeed-Studio";
      repo = pname;
      rev = version;
      hash = "sha256-dUdzCokmxVA4+ym0UMYgf5gc2Sfwy+oUDZIDcExFqHk=";
    };

    nativeBuildInputs = [
      autoPatchelfHook
    ];

    installPhase = ''
    install -m755 -D $src/tool/linux/amebad_image_tool $out/bin/amebad_image_tool
    '';
  };

in
mkShell {
  buildInputs = [
    gnumake
    ncurses dialog
    gcc-arm-embedded-10
    clang-tools
    python-with-my-packages
    ambd_flash_tool
  ];

  AMEBAD_IMAGE_TOOL="${ambd_flash_tool}/bin/amebad_image_tool";
  UPLOAD_PATH = "/dev/ttyUSB0";
}
