{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {
    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      settings = {
        font_family = "MaritanMono Nerd Font";
        font_size = 13.0;
        disable_ligatures = "always";

        cursor_shape = "block";
        cursor_shape_infocuse = "beam";
        cursor_blink_interval = 0;
        
        scrollbar = "never";
        scrollbar_interactive = "no";
        
        sync_to_monitor = "no";

        enable_audio_bell = "no";

        remember_window_size = "no";
        remember_window_position = "no";

        window_margin_width = 10;
        confirm_os_window_close = 0;
      };
    };
  };

}
