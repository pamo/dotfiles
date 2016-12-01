#!/bin/sh

echo "Setting write permissions on /Library/Preferences"
sudo chmod 755 /Library/Preferences

# Set Computer Name
COMPUTER="PurpleNurple"
echo "Setting computer name to $COMPUTER"
sudo scutil --set ComputerName $COMPUTER && \
sudo scutil --set HostName $COMPUTER && \
sudo scutil --set LocalHostName $COMPUTER && \
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Set sidebar icon size to Small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable the Time Machine new disk requests dialog
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Menu bar: disable transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Menu bar: hide the Time Machine and User icons
defaults write ~/Library/Preferences/ByHost/com.apple.systemuiserver.* dontAutoLoad -array \
  "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
  "/System/Library/CoreServices/Menu Extras/User.menu" \

# Run Time Machine backups on battery power
defaults write /Library/Preferences/com.apple.TimeMachine RequiresACPower 0

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Developer CrashReport dialog type
defaults write com.apple.CrashReporter DialogType developer

# Reduce transparency
defaults write com.apple.universalaccess reduceTransparency -boolean true

# Screenshots Default Location
defaults write com.apple.screencapture location ~/Documents/Screenshots && \
killall SystemUIServer


###############################################################################
# Trackpad, mouse, keyboard, and input                                        #
###############################################################################

# Don't automatically switch to a Space with open windows for and application when switching to it 
defaults write com.apple.dock workspaces-auto-swoosh -boolean NO

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Keyboard: Key Repeat
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 0.02

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: swipe between pages with three fingers
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

###############################################################################
# Screen Saver                                                                #
###############################################################################

# Require password 15 minutes after sleep or screen saver begins
defaults write com.apple.screensaver askForPasswordDelay -int 900

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show hidden files by default
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Finder: set window title to full POSIX file path of current folder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 70" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 70" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 70" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 40" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 40" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 40" ~/Library/Preferences/com.apple.finder.plist

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
chflags nohidden ~/Library

###############################################################################
# Dock & hot corners                                                          #
###############################################################################

# Set the icon size of Dock items to 30 pixels
defaults write com.apple.dock tilesize -int 50

# Don’t show Dashboard as a Space
defaults write com.apple.dock "dashboard-in-overlay" -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Hot corners
# Bottom right screen corner → Put Display to Sleep
defaults write com.apple.dock wvous-br-corner -int 10
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Set Safari’s home page to nothing
defaults write com.apple.Safari HomePage -string ""

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Prevent Safari from opening "safe" files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

###############################################################################
# Login Items
###############################################################################
echo 'Adding Login Items'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/1password.app", name:"1password", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Alfred 3.app", name:"Alfred", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Slack.app", name:"Slack", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Spectacle.app", name:"Spectacle", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Dropbox.app", name:"Dropbox", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Google Chrome.app", name:"Google Chrome", hidden:true}'

echo "Done. Note that some of these changes require a logout/restart to take effect."

