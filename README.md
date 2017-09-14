# netstatusd
`netstatusd` is a simple bash daemon that aggressively monitors your internet connectivity status by performing up to three tests at a given interval. Whenever an attempt is successful (or unsuccessful), `netstatusd` executes provided "actions."

`netstatusd` also executes actions (`when-down.d/*`) whenever the internet is believed to be disconnected as well as another action (`when-up.d/*`) once internet connectivity has been restored.


## Requirements
* bash
* ping
* curl


## Installation
1. `cp default_config ~/.config/netstatusd/config`
2. `cp -R ./*.d ~/.config/netstatusd/`
2. `./netstatusd`

Note: `netstatusd` runs as a daemon and is meant to be backgrounded. `netstatusd` is meant to run as an unprivileged user, although technically, it could be run as root.


## Actions
An action is merely a shell script that is executed once an attempt or event occurs.

### Action Arguments
An action is always provided the following arguments:

1. `SOURCE` - If an attempt is successful, the source of the successful test. Valid sources are `primary`, `secondary` or `walled_garden`. This argument is empty if an attempt was unsuccessful.
2. `LATENCY` - If an attempt is successful, the latency (in ms) of the successful test.
3. `INTERVAL_COUNT` - The incrementing count (starting at 1).
4. `FAILED_ATTEMPT_COUNT` - If an attempt was unsuccessful, an incrementing count for the number of unsuccessful attempts. This counter is reset to 0 once internet connectivity has been restored.

#### ~/.config/netstatusd/attempt-successful.d/*
Actions called whenever an attempt is successful.

#### ~/.config/netstatusd/attempt-unsuccessful.d/*
Actions called whenever an attempt is unsuccessful.

#### ~/.config/netstatusd/when-up.d/*
Actions called whenever the internet is available. If the internet is available when the `netstatusd` is started, these actions will be triggered.

#### ~/.config/netstatusd/when-down.d/*
Actions called whenever the internet is unavailable. Unavailability is determined when the number of attempts match the configuration option `MAX_ATTEMPTS` (default is 3). These actions will only be called once per unavailability period. NOTE: If the internet is unavailable when the `netstatusd` is started, these actions will be triggered.


## Default Actions
`netstatusd` ships with default actions that can easily be removed by deleting the associated shell scripts.

### Latency File
A simple set of scripts that write the latency to a file. This is useful for displaying current internet latency in various status bars (tmux, screen, xmobar, etc). The location of this file is `~/.local/share/netstatusd/latency`. When an attempt is unsuccessful, this file is removed which means that it should also be a good way to determine internet availability by simply checking for a file.

#### Files
* `~/.config/netstatusd/attempt-successful.d/write-latency-file.sh`
* `~/.config/netstatusd/attempt-unsuccessful.d/remove-latency-file.sh`

### Uptime/Downtime Notifications
Two scripts that trigger a desktop notification when the internet is deemed unavailable or available. Currently these scripts only support this `notifiy-send` command in Linux.

#### Files
* `~/.config/netstatusd/when-up.d/notify.sh`
* `~/.config/netstatusd/when-down.d/notify.sh`

### GeoIP Information
A set of scripts that simply curl `http://pry.sh` (a site that provides GeoIP information), and stores it to a file (`~/.local/share/netstatusd/geoip-data.json`). When internet is unavailable, this file is removed.

#### Files
* `~/.config/netstatusd/when-up.d/write-geoip-file.sh`
* `~/.config/netstatusd/when-down.d/remove-geoip-file.sh`