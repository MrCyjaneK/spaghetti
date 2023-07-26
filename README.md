# 🍝 Spaghetti 🍝

> Simple and easy to use file bin service

# Building

```bash
$ make server_build
```

# Running

```bash
$ spaghettiserver --datapath=$HOME/Documents/spaghetti/data_dir
```

# NixOS deployment

```nix
{ config, lib, pkgs, modulesPath, ... }:

let
  spaghettirepo = fetchGit {
    url = "https://git.mrcyjanek.net/mrcyjanek/spaghetti";
    ref = "master";
  };
  spaghettiserver = pkgs.callPackage (import "${spaghettirepo}/derivation.nix") {};  
in {
  
  users.users."spaghetti" = {
    isSystemUser = true;
    home = "/var/lib/spaghetti";
    createHome = true;
    group = "spaghetti";
    packages = [
      spaghettiserver
    ];
  };
  users.groups.spaghetti = {};
  systemd.services."spaghetti-server" = {
    script = ''
      set -eu
      ${spaghettiserver}/bin/spaghettiserver \
        --datapath='${config.users.users."spaghetti".home}' \
        --listenip=0.0.0.0 \
        --listenport=9898 \
        --expiresoft=14 \
        --expirehard=32
    '';
    enable = true;
    serviceConfig = {
      User = "spaghetti";
    };
  };
}
```