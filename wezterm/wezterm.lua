local wezterm = require 'wezterm';
return {
    font = wezterm.font_with_fallback({
        "PragmataPro Liga",
        "Iosevka Custom Font Mono",
        "MesloLGS NF",
        "Cascadia Code PL",
    }),
    font_size = 18.0,

    color_scheme = "OneHalfLight"
}
