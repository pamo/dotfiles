#!/usr/bin/env bash

osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront and run a keep-alive to update
# existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Setting write permissions on /Library/Preferences"
sudo chmod 755 /Library/Preferences

echo ""
echo "Would you like to set your computer name (System Preferences >> Sharing)?  (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo "What would you like it to be?"
  read COMPUTER_NAME
  sudo scutil --set ComputerName $COMPUTER_NAME
  sudo scutil --set HostName $COMPUTER_NAME
  sudo scutil --set LocalHostName $COMPUTER_NAME
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
fi

###############################################################################
# General UI/UX                                                               #
###############################################################################

echo ""
echo "Menu bar: show battery percentage"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

echo ""
echo "Set sidebar icon size to Small"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

echo ""
echo "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo ""
echo "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo ""
echo "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo ""
echo "Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo ""
echo "Disable the Time Machine new disk requests dialog"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo ""
echo "Menu bar: disable transparency"
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

echo ""
echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo ""
echo "Disabling the sound effects on boot"
sudo nvram SystemAudioVolume=" "

echo ""
echo "Setting Developer CrashReport dialog type"
defaults write com.apple.CrashReporter DialogType developer

echo ""
echo "Reduce transparency"
defaults write com.apple.universalaccess reduceTransparency -boolean true

# Screenshots Default Location
LOCATION="$HOME/Documents/ScreenShots"
mkdir $LOCATION
echo "Setting screenshot location to ${LOCATION}"
defaults write com.apple.screencapture location $LOCATION && killall SystemUIServer

echo ""
echo "Disable Photos.app from starting everytime a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Trackpad, mouse, keyboard, and input                                        #
###############################################################################

echo ""
echo "Don't automatically switch to a Space with open windows for and application when switching to it"
defaults write com.apple.dock workspaces-auto-swoosh -boolean NO

echo ""
echo "Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo ""
echo "Enable press-and-hold for keys and disable key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true

echo ""
echo " macOS: Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 40

echo ""
echo "Automatically illuminate built-in MacBook keyboard in low light"
defaults write com.apple.BezelServices kDim -bool true

echo ""
echo "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo ""
echo "Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true &&
           defaults write -g com.apple.mouse.tapBehavior -int 1 &&
           defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1

echo ""
echo "Fast mouse and trackpad speed"
defaults write -g com.apple.mouse.scaling -float 5
defaults write -g com.apple.trackpad.scaling -int 5

echo ""
echo "Trackpad: swipe between pages with three fingers"
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

echo ""
echo "Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo ""
echo "Enable access for assistive devices"
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled

echo ""
echo "Use scroll gesture with the Ctrl (^) modifier key to zoom"
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

echo ""
echo "Follow the keyboard focus while zoomed in"
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

echo ""
echo "Function keys"
defaults write -g com.apple.keyboard.fnState -bool true

echo ""
echo "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo ""
echo "Enbabling Autocorrect"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

###############################################################################
# Screen Saver                                                                #
###############################################################################

echo ""
echo "Require password 5 minutes after sleep or screen saver begins"
defaults write com.apple.screensaver askForPasswordDelay -int 300

###############################################################################
# Finder                                                                      #
###############################################################################

echo ""
echo "Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons"
defaults write com.apple.finder QuitMenuItem -bool true

echo ""
echo "Finder: show hidden files by default"
defaults write com.apple.Finder AppleShowAllFiles -bool true

echo ""
echo "Finder: set window title to full POSIX file path of current folder"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo ""
echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo ""

echo "Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo ""
echo "Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo ""
echo "Finder: allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo ""
echo "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo ""
echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo ""
echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo ""
echo "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

echo "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo ""
echo "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo ""
echo "Show the ~/Library folder"
chflags nohidden ~/Library

echo ""
echo "Disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

echo ""
echo "Expand the following File Info panes:"
echo "“General”, “Open with”, and “Sharing & Permissions”"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
        General -bool true \
        OpenWith -bool true \
        Privileges -bool true

###############################################################################
# Dock & hot corners                                                          #
###############################################################################

echo "Disable Automatically hide and show the Dock."
defaults write com.apple.dock autohide -bool false

echo ""
echo "Set the icon size of Dock items"
defaults write com.apple.dock tilesize -int 36

echo ""
echo "Turn on magnification for dock icons"
defaults write com.apple.dock largesize -int 96
defaults write com.apple.dock magnification -int 1

echo ""
echo "Don’t show Dashboard as a Space"
defaults write com.apple.dock "dashboard-in-overlay" -bool true

echo ""
echo "Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true

echo "Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

echo ""
echo "Hot corners"
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

echo ""
echo "Top right screen corner → Show Desktop"
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

echo ""
echo "Bottom right screen corner → Show Screen Saver"
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0

echo ""
echo "Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true

echo ""
echo "Wipe all (default) app icons from the Dock"
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock "persistent-apps" {} &&
  defaults write com.apple.dock "persistent-others" {}; killall Dock

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

echo ""
echo "Privacy: don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo ""
echo "Set Safari’s home page to nothing"
defaults write com.apple.Safari HomePage -string "about:blank"

echo ""
echo "Hide Safari’s bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo ""
echo "Disable Safari’s thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo ""
echo "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo ""
echo "Remove useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo ""
echo "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo ""
echo "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo ""
echo "Prevent Safari from opening "safe" files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

###############################################################################
# Activity Monitor                                                            #
###############################################################################

echo ""
echo "Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

echo ""
echo "Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

###############################################################################
# Mac App Store                                                               #
###############################################################################
echo "Disabling Gatekeeper settings for Apps"
sudo spctl --master-disable

echo ""
echo "Enable the WebKit Developer Tools in the Mac App Store"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

echo ""
echo "Enable Debug Menu in the Mac App Store and Reminders app"
defaults write com.apple.appstore ShowDebugMenu -bool true
defaults write com.apple.reminders RemindersDebugMenu -boolean true

###############################################################################
# Login Items
###############################################################################
echo 'Adding Login Items'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/1password.app", name:"1password", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Alfred 3.app", name:"Alfred", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Bartender 2.app", name:"Bartender", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Dropbox.app", name:"Dropbox", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Flux.app", name:"Flux", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Google Chrome.app", name:"Google Chrome", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Slack.app", name:"Slack", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Spectacle.app", name:"Spectacle", hidden:true}'
echo "Done. Note that some of these changes require a logout/restart to take effect."
