# Cromha-Package-Manager
```
lolo@fedora ~ $ cromha-manager
_________                       .__            
\_   ___ \_______  ____   _____ |  |__ _____   
/    \  \/\_  __ \/  _ \ /     \|  |  \__  \  
\     \____|  | \(  <_> )  Y Y  \   Y  \/ __ \_
 \______  /|__|   \____/|__|_|  /___|  (____  /
        \/                    \/     \/     \/
Current version: 0.1
```

## About

The Cromha Package Manager is a personal project I made for myself (I currently use it for package managing) for fun. It is basically a bash script in your bin/ directory so you can use it everywhere. It has multiple useful functions, a logging system and a developed YAML config file to customize your command prompt.

It is actually two scripts: the cromha-manager script, the main script where you run the package managing commands and all that stuff, and the cromha-manager-ctl script, which you will use to update the Cromha Package Manager scripts and to do various stuff like, optimizing DNF...

## Installing & Using

### Installing

Installing and using the Cromha Package Manager might be kind of annoying if you don't understand how it works.
First, clone the github repository by running:
```
git clone git@github.com:OcelotWalrus/Cromha-Package-Manager.git
```

Then, run the install.sh script:
```
chmod +x install.sh
sh install.sh
```

And you should be good to go!

### Using

#### Introduction

The Cromha Package Manager command is very simple:

you can run 'OPTIONS', that will run specific actions. After that, you can add up to two 'PARAMETERS', separated by spaces, which are basically like 'OPTIONS' but they are runned after the 'OPTIONS'.
Example:
```
cromha-manager upgrade --purge --reboot
```

This command will first upgrade my packages, then it will purge my cache and finnally, it will reboot my system. All PARAMETERS that reboots, shutdown or close terminal prompts have a Timer of 60 seconds by default and it will send you a notification.

#### Configuration

By default, no package manager will be enabled and you won't be able to do almost anything. What you need to do is to run:
```
cromha-manager config
```

It will open your config file using nano. Then you can change all options to make the Cromha Package Manager like you want!

## Functions

You can check all functionalities by running:
<details>

  <summary>Expand</summary>

```
cromha-manager help
```

```
cromha-manager-ctl help
```

</details>

Here are the main functionalitities:
* cromha-manager script:
  * OPTIONS:
    * autoremove: remove all unneeded packages that were originaly installed as dependencies
    * logs/open-logs: open the latest cromha-manager log file
    * clean/purge: use the `clean` option of all enabled packages managers
    * config/customize: open the config file
    * info: Get infos about a specific package
    * install/add: install a package
    * list/packages: list all your enabled packages
    * reinstall: reinstall a package
    * search/find: find a package
    * uninstall/remove: uninstall a package
    * upgrade/update: upgrade all your packages
    * sys-upgrade: upgrade your distribution (from Fedora 36 to 37. Only Fedora is compatible for now)
  * PARAMETERS:
    * -clean/-purge: use the `clean` option of all enabled packages managers
    * -exit: close the command prompt after execution of the option
    * -reboot: reboot your system after execution of the option
    * -poweroff: shutdown your system after execution of the option
* cromha-manager-ctl script:
  * OPTIONS:
    * logs: open the lastest cromha-manager-ctl log file
    * clean-logs: clean both cromha-manager and cromha-mnagaer-ctl logs
    * upgrade/update: update both cromha-manager and cromha-manager-ctl scripts for git
    * uninstall/remove: uninstall both cromha-manager and cromha-manager-ctl scripts
    * dnf-optimize: modify your DNF configuration to optimize it
