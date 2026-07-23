{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {

        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        binds = {
          "Mod+O".toggle-overview = [ ];

          "Mod+Q".spawn-sh = "${lib.getExe self'.packages.myKitty}";
          "Mod+B".spawn-sh = lib.getExe pkgs.librewolf;
          "Mod+R".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";

          "Mod+C".close-window = [ ];

          "Mod+H".focus-column-left = [ ];
          "Mod+L".focus-column-right = [ ];

          "Mod+Shift+H".move-column-left = [ ];
          "Mod+Shift+L".move-column-right = [ ];

          "Mod+1".focus-workspace = 1;
	        "Mod+2".focus-workspace = 2;
	        "Mod+3".focus-workspace = 3;
	        "Mod+4".focus-workspace = 4;
	        "Mod+5".focus-workspace = 5;
	        "Mod+6".focus-workspace = 6;
	        "Mod+7".focus-workspace = 7;
	        "Mod+8".focus-workspace = 8;
	        "Mod+9".focus-workspace = 9;
	        "Mod+0".focus-workspace = 10;

	        "Mod+Ctrl+J".focus-workspace-down = [ ];
	        "Mod+Ctrl+K".focus-workspace-up = [ ];

	        "Mod+Shift+1".move-column-to-workspace = 1;
	        "Mod+Shift+2".move-column-to-workspace = 2;
	        "Mod+Shift+3".move-column-to-workspace = 3;
        	"Mod+Shift+4".move-column-to-workspace = 4;
	        "Mod+Shift+5".move-column-to-workspace = 5;
	        "Mod+Shift+6".move-column-to-workspace = 6;
	        "Mod+Shift+7".move-column-to-workspace = 7;
	        "Mod+Shift+8".move-column-to-workspace = 8;
	        "Mod+Shift+9".move-column-to-workspace = 9;
          "Mod+Shift+0".move-column-to-workspace = 10;

          "Mod+F".maximize-column = [ ];
          "Mod+Shift+F".fullscreen-window = [ ];

          "Mod+Shift+Delete".quit = [ ];
        };

        layout = {
          gaps = 10;

          border = {
            width = 2;
            active-color = "#b8bb26";
            inactive-color = "#3c3836";
          };

          focus-ring = {
            off = [ ];
          };
        };

        hotkey-overlay = {
          skip-at-startup = true;
        };

        prefer-no-csd = true;

        gestures = {
          hot-corners = {
            off = [ ];
          };
        };

        animations = {
          slowdown = 1.5;
        };

        layer-rules = [
          {
            matches = [
              {
                namespace = "^noctalia-overview";
              }
            ];
            place-within-backdrop = true;
          }
        ];
      };
    };

  };

}
