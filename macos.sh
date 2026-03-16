#!/usr/bin/env bash
# macOS Tahoe (26) defaults
# Run: ./macos.sh
# Many changes require logout/restart to take effect.

osascript -e 'tell application "System Settings" to quit'

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Computer Name                                                               #
###############################################################################
echo "Would you like to set your computer name? (y/n)"
read -r response
if [ "$response" = "y" ]; then
  echo "What should the computer name be?"
  read -r COMPUTER_NAME
  scutil --set LocalHostName "$COMPUTER_NAME"
  scutil --set ComputerName "$COMPUTER_NAME"
  scutil --set HostName "$COMPUTER_NAME"
fi

###############################################################################
# General UI/UX                                                               #
###############################################################################
echo "==> General UI"

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Small sidebar icons
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Auto quit printer app when done
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Check for software updates daily
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Crash reporter as developer dialog
defaults write com.apple.CrashReporter DialogType developer

###############################################################################
# Control Center — Battery & Clock                                            #
###############################################################################
echo "==> Control Center"

# Show battery percentage in menu bar
# On macOS Tahoe, battery is in Control Center. This writes the preference:
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

###############################################################################
# Screenshots                                                                 #
###############################################################################
echo "==> Screenshots"

SCREENSHOT_DIR="$HOME/Screenshots"
mkdir -p "$SCREENSHOT_DIR"
defaults write com.apple.screencapture location "$SCREENSHOT_DIR"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Trackpad, Keyboard, Input                                                   #
###############################################################################
echo "==> Input"

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Fast keyboard repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 40

# Enable press-and-hold for accented characters
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true

# Full keyboard access for all controls (Tab in dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Function keys as standard function keys
defaults write -g com.apple.keyboard.fnState -bool true

# Don't auto-rearrange Spaces
defaults write com.apple.dock mru-spaces -bool false

# Swipe between pages with three fingers
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true

# Autocorrect
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################
echo "==> Finder"

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar and status bar
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Show full POSIX path in title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable extension change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable empty trash warning
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# List view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show ~/Library
chflags nohidden ~/Library

# Snap-to-grid for icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null

# Allow quitting Finder via ⌘Q
defaults write com.apple.finder QuitMenuItem -bool true

# Expand File Info panes
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

###############################################################################
# Dock                                                                        #
###############################################################################
echo "==> Dock"

# Clear default Dock and add preferred apps
if command -v dockutil &>/dev/null; then
  dockutil --remove all --no-restart
  dockutil --add /Applications/Slack.app --no-restart
  dockutil --add /Applications/Notion.app --no-restart
  dockutil --add /Applications/iTerm.app --no-restart
  dockutil --add /System/Applications/Music.app --no-restart
  dockutil --add /System/Applications/Calendar.app --no-restart
  dockutil --add "/Applications/Visual Studio Code.app" --no-restart
fi

# Icon size
defaults write com.apple.dock tilesize -int 36

# Magnification
defaults write com.apple.dock largesize -int 96
defaults write com.apple.dock magnification -int 1

# Minimize into app icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open apps
defaults write com.apple.dock show-process-indicators -bool true

# Translucent icons for hidden apps
defaults write com.apple.dock showhidden -bool true

# Hot corners: top-right = Desktop, bottom-right = Screen Saver
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Safari                                                                      #
###############################################################################
echo "==> Safari"

defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari HomePage -string "about:blank"
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

###############################################################################
# Activity Monitor                                                            #
###############################################################################
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor ShowCategory -int 0

###############################################################################
# Disable Photos auto-launch                                                  #
###############################################################################
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# iTerm2                                                                      #
###############################################################################
defaults write com.googlecode.iterm2 "Normal Font" -string "FiraCodeNerdFont-Regular 13"
defaults write com.googlecode.iterm2 "Non Ascii Font" -string "FiraCodeNerdFont-Regular 13"

###############################################################################
# Kill affected apps                                                          #
###############################################################################
echo "==> Restarting affected apps"
for app in "Finder" "Dock" "SystemUIServer"; do
  killall "$app" &>/dev/null
done

echo "Done. Some changes require logout/restart."
