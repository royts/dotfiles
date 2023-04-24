## Specify the preferences directory
#defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
## Tell iTerm2 to use the custom preferences in the directory
#defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
install_iterm2_profile() {
  profile_pathname="$HOME/Library/Application Support/iTerm2/DynamicProfiles/roy-profile.json"
  cp ./roy-profile.json "${profile_pathname}"
}
install_iterm2_profile
