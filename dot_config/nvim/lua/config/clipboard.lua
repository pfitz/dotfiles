-- Headless container: Neovim's builtin provider only tries wl-copy/xclip when
-- it detects a live Wayland/X11 session, which never exists here — so
-- has('clipboard') is 0 regardless of which packages are installed. OSC52 is
-- NOT automatic (see :help provider-clipboard); it must be declared, and it
-- routes copy/paste through the terminal that `devpod ssh` is running in.
vim.g.clipboard = require("vim.ui.clipboard.osc52").config
