import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageDocks
import XMonad.Util.SpawnOnce
import XMonad.Actions.CopyWindow

import qualified XMonad.StackSet as W


baseConfig = desktopConfig

main = xmonad $ baseConfig {
    terminal = myTerminal,
    borderWidth = 3,
    focusedBorderColor = "#CC0099",
    startupHook = myStartupHook
} `additionalKeys` [ 
    ((mod1Mask, xK_d), spawn "dmenu_run"),
    ((mod1Mask .|. controlMask, xK_r), spawn "xmonad --recompile"),
    ((mod1Mask .|. controlMask, xK_Return), windows W.swapMaster),
    ((mod1Mask, xK_q), kill1),
    ((mod1Mask, xK_t), spawn "telegram-desktop"),
    ((mod1Mask, xK_n), spawn "networkmanager_dmenu"),
    ((mod1Mask, xK_Return), spawn myTerminal),
    ((mod1Mask, xK_F12), spawn "pactl set-sink-volume 0 +5%"),
    ((mod1Mask, xK_F11), spawn "pactl set-sink-volume 0 -5%"),
    ((mod1Mask, xK_F10), spawn "/home/dim/.scripts/brightness.sh 10"),
    ((mod1Mask, xK_F9), spawn "/home/dim/.scripts/brightness.sh -10"),
    ((mod1Mask, xK_F11), spawn "pactl set-sink-volume 0 -5%"),
    ((mod1Mask, xK_w), spawn "brave-nightly") ]

myStartupHook = do
    spawnOnce "setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle -option caps:swapescape"
    spawnOnce "xset r rate 300 50"
    spawnOnce "xmobar"
    spawnOnce "dunst"

myTerminal = "st"
