{ stdenv, callPackage, makeFontsConf, gnome2 }:

let
  mkStudio = opts: callPackage (import ./common.nix opts) {
    fontsConf = makeFontsConf {
      fontDirectories = [];
    };
    inherit (gnome2) GConf gnome_vfs;
  };
  stableVersion = {
    version = "3.4.1.0"; # "Android Studio 3.4.1"
    build = "183.5522156";
    sha256Hash = "0y4l9d1yrvv1csx6vl4jnqgqy96y44rl6p8hcxrnbvrg61iqnj30";
  };
  betaVersion = {
    version = "3.5.0.15"; # "Android Studio 3.5 Beta 3"
    build = "191.5585527";
    sha256Hash = "0b9yj3rf3nk8y9qfmf5kjh8rwn73v7ghym1bhz864r079h7lwr53";
  };
  latestVersion = { # canary & dev
    version = "3.6.0.1"; # "Android Studio 3.6 Canary 1"
    build = "191.5595896";
    sha256Hash = "1nd0xmq1aplznxbsnmzgszbblj6vdyhir708mks5ss6achn21xxc";
  };
in rec {
  # Attributes are named by their corresponding release channels

  stable = mkStudio (stableVersion // {
    channel = "stable";
    pname = "android-studio";
  });

  beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });

  dev = mkStudio (latestVersion // {
    channel = "dev";
    pname = "android-studio-dev";
  });

  canary = mkStudio (latestVersion // {
    channel = "canary";
    pname = "android-studio-canary";
  });
}
