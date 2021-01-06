# Android Studio
> Setup notes for Android Studio and dependencies

## Files
- android-studio-ide-201.6953283-linux.tar.gz
- offline-android-gradle-plugin-preview.zip
- offline-gmaven-stable.zip

## Links
- https://developer.android.com/studio/install
	- To launch Android Studio, open a terminal, navigate to the `android-studio/bin/` directory, and execute `studio.sh`
	- To make Android Studio available in your list of applications, select `Tools > Create Desktop Entry` from the Android Studio menu bar

- https://developer.android.com/studio/intro/studio-config#offline (appears to be broken)

### Offline build
- Extract files to `${HOME}/.android/manual-offline-m2/`
	- `offline-android-gradle-plugin-preview.zip`
	- `offline-gmaven-stable.zip`
- applies to all Gradle projects you open on the workstation
- update file `${HOME}/.gradle/init.d/offline.gradle` to enable offline builds
	- Copy from `20-Resources/Copy/offline.gradle`
- Read fully `%USER_HOME%/.android/manual-offline-m2/README`

## Installation Notes
- From setup, do
	- https://developer.android.com/studio/run/emulator-acceleration?utm_source=android-studio#vm-linux
