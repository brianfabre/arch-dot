import os
import subprocess
from datetime import datetime
from time import time
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy

HOME = os.path.expanduser("~")
SCRIPTS_PATH = HOME + "/.config/qtile/scripts/"


@hook.subscribe.startup_once
def startup():
    subprocess.call([HOME + "/.config/qtile/autostart.sh"])


class Commands:
    # dmenu = "dmenu_run -i -p '>>>' -fn 'SF Mono' -nb '#000' -nf '#fff' -sb '#00BF32' -sf '#fff'"
    dmenu = "dmenu_run -i -l 10 -p '>>>' -fn 'SF Mono' -nb '#000' -nf '#fff' -sb '#556F7A' -sf '#fff'"


# go to prev window
def prev_group(qtile):
    qtile.current_screen.set_group(qtile.current_screen.previous_group)


def screenshot():
    def f(qtile):
        date_time = datetime.fromtimestamp(time())
        filename = date_time.strftime("%Y-%m-%d-%-I-%M-%p-%S")
        path = HOME + f"/Desktop/screenshot_{filename}.png"
        subprocess.run(["maim", "--select", path])

    return f


mod = "mod4"
hyper = "mod3"
terminal = "alacritty"
browser = "firefox"
ocr = SCRIPTS_PATH + "ocr_capture.sh"
audio = SCRIPTS_PATH + "switch_audio.sh"
widget_padding = 25
window_gap = 10

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "space", lazy.spawn(Commands.dmenu)),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left().when(layout=["bsp", "columns"]),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide", "monadthreecol"]),
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide", "monadthreecol"]),
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "c", lazy.reload_config()),
    Key([mod, "shift"], "e", lazy.shutdown()),
    Key([mod], "t", lazy.window.toggle_floating()),
    Key([hyper], "space", lazy.function(prev_group)),
    Key([hyper], "1", lazy.spawn(ocr)),
    Key([hyper], "2", lazy.function(screenshot())),
    Key([mod], "semicolon", lazy.next_screen(), desc="Next monitor"),
]


# workspace_names = [
#     "1",
#     "2",
#     "3",
#     "4",
#     "5",
#     "",
#     "󰙯",
#     # "",
#     # "",
#     # "",
#     # "",
#     # "",
#     # "",
#     # "",
#     # "",
#     # "",
# ]
#
# groups = [
#     Group("1", label=workspace_names[0], spawn=browser),
#     Group("2", label=workspace_names[1], spawn=terminal),
#     Group("3", label=workspace_names[2]),
#     Group("4", label=workspace_names[3]),
#     Group("5", label=workspace_names[4]),
#     Group("6", label=workspace_names[5], spawn=browser),
#     Group("7", label=workspace_names[6], spawn="discord"),
#     # Group("8", label=workspace_names[7]),
#     # Group("9", label=workspace_names[8]),
#     # Group("0", label=workspace_names[9]),
# ]
#
# for i in groups:
#     keys.extend(
#         [
#             # mod1 + letter of group = switch to group
#             Key(
#                 [mod],
#                 i.name,
#                 lazy.group[i.name].toscreen(),
#                 desc="Switch to group {}".format(i.name),
#             ),
#             # mod1 + shift + letter of group = switch to & move focused window to group
#             Key(
#                 [mod, "shift"],
#                 i.name,
#                 lazy.window.togroup(i.name, switch_group=True),
#                 desc="Switch to & move focused window to group {}".format(i.name),
#             ),
#             # Or, use below if you prefer not to switch to that group.
#             # # mod1 + shift + letter of group = move focused window to group
#             # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
#             #     desc="move focused window to group {}".format(i.name)),
#         ]
#     )


groups = [Group(i) for i in "1234567890"]


for i in groups:
    keys.extend(
        [
            # Switch to group N
            Key(
                [mod],
                i.name,
                lazy.to_screen(0) if i.name in "12345" else lazy.to_screen(1),
                lazy.group[i.name].toscreen(),
            ),
            # Move window to group N
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
            ),
        ]
    )


# Define scratchpads
groups.append(
    ScratchPad(
        "scratch1",
        [
            DropDown(
                "term",
                terminal,
                # height=0.9,
                # width=0.28,
                # y=0.05,
                # x=0.7,
                width=0.6,
                height=0.6,
                x=0.2,
                y=0.2,
                opacity=1,
                match=Match(wm_class="Alacritty"),
            ),
            DropDown(
                "firefox",
                browser,
                width=0.6,
                height=0.6,
                x=0.2,
                y=0.2,
                opacity=1,
                match=Match(wm_class="firefox"),
            ),
        ],
    )
)

# Scratchpad keybindings
keys.extend(
    [
        Key([mod], "m", lazy.group["scratch1"].dropdown_toggle("term")),
        Key([mod], "n", lazy.group["scratch1"].dropdown_toggle("firefox")),
    ]
)

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.MonadTall(
        # margin=window_gap,
        margin=0,
        border_width=2,
        border_focus="#94e2d5",
    ),
    layout.Max(margin=0),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


widget_defaults = dict(
    font="SF Mono",
    # font="Hack",
    # font="FiraCode Nerd Font",
    # font="JetBrains Mono Bold",
    # font="Source Code Pro",
    fontsize=15,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        # wallpaper="~/Documents/wallpapers/waves.jpg",
        # wallpaper="~/Documents/wallpapers/shibuya.jpg",
        # wallpaper="~/Documents/wallpapers/snowmountain.jpg",
        # wallpaper="~/Documents/wallpapers/summer-pool.jpg",
        wallpaper="~/Documents/wallpapers/cat-arch.png",
        wallpaper_mode="fill",
        # wallpaper_mode="stretch",
        top=bar.Bar(
            [
                widget.GroupBox(
                    rounded=False,
                    # hide_unused=True,
                    highlight_method="block",
                    center_aligned=True,
                    disable_drag=True,
                    # inactive="#A9A9A9",
                ),
                widget.Sep(linewidth=1, padding=widget_padding),
                widget.CurrentLayout(),
                widget.Sep(linewidth=1, padding=widget_padding),
                widget.WindowCount(fmt="[ {} ]", show_zero=True),
                widget.Sep(linewidth=1, padding=widget_padding),
                widget.Spacer(),
                widget.WindowName(foreground="A9A9A9"),
                widget.Spacer(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # widget.TextBox(
                #     text="󰃟",
                #     mouse_callbacks={
                #         "Button1": lambda: qtile.cmd_spawn("dmenu_run"),
                #     },
                # ),
                widget.Sep(linewidth=1, padding=widget_padding),
                widget.Volume(
                    fmt="",
                    volume_up_command="pactl set-sink-volume @DEFAULT_SINK@ +5%",
                    volume_down_command="pactl set-sink-volume @DEFAULT_SINK@ -5%",
                    volume_app="pavucontrol",
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(audio)},
                    # mouse_callbacks={
                    #     "Button3": lambda: qtile.cmd_spawn(
                    #         "pactl set-sink-mute @DEFAULT_SINK@ toggle"
                    #     )
                    # },
                ),
                widget.Sep(linewidth=1, padding=widget_padding),
                widget.ThermalSensor(fmt="CPU {}", tag_sensor="Tctl"),
                widget.CPU(format=" {load_percent}%"),
                widget.Sep(linewidth=1, padding=widget_padding),
                # widget.NvidiaSensors(fmt="GPU {}"),
                # widget.Sep(linewidth=1, padding=widget_padding),
                widget.Memory(format="MEM {MemPercent}%"),
                widget.Sep(linewidth=1, padding=widget_padding),
                widget.Clock(
                    format="%a, %Y-%m-%d  %I:%M %p",
                    # format="[%Y-%m-%d] [%I:%M %p]",
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("gsimplecal")},
                ),
                widget.Sep(linewidth=1, padding=widget_padding),
                # widget.QuickExit(),
                # widget.Sep(linewidth=1, padding=15),
                widget.Systray(),
            ],
            26,
        ),
        # right=bar.Gap(),
        # left=bar.Gap(),
        # bottom=bar.Gap(),
    ),
]

screens.append(
    Screen(
        wallpaper="~/Documents/wallpapers/cat-arch.png",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.WindowName(foreground="A9A9A9"),
                widget.Spacer(),
                widget.GroupBox(
                    rounded=False,
                    # hide_unused=True,
                    highlight_method="block",
                    center_aligned=True,
                    disable_drag=True,
                    # inactive="#A9A9A9",
                ),
                widget.Sep(linewidth=1, padding=widget_padding),
                widget.CurrentLayout(),
                widget.Sep(linewidth=1, padding=widget_padding),
                widget.WindowCount(fmt="[ {} ]", show_zero=True),
                widget.Sep(linewidth=1, padding=widget_padding),
                widget.Spacer(),
            ],
            26,
        ),
    ),
)


# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus="#FFFFFF",
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="thunar"),
    ],
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
