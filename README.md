# linc_sys

Library in progress, allowing various system things for Haxe programs targeting **cpp Linux servers**.

Current features:

1. getting thread id (SPID) from [Haxe](https://www.haxe.org) on Linux cpp target (this is impossible from the API, only allows getting main process pid).
2. Calls to `sd_notify`, to notify systemd service manager about start-up completion and other service status changes.

# thread ids (SPID)

* `Sys.getThreadId() : Int` 
> return thread id (SPID) from the current thread. 
> This will return the PID when called from the main thread. 

# systemd C `sd_notify()`

When your daemon runs as a systemd service, those methods allow notifying the service manager
that your service is reading, stopping, changed status etc. You must define Type=notify in your .service file.
See `man systemd.service` and `man 3 sd_notify`. This includes <systemd/sd-daemon.h>.

All the following static methods return an Int, with 0 indicating no error, otherwise a negative errno-style error code is returned. In case environment variable $NOTIFY_SOCKET has been disabled (see Sys.systemd_notify()) 0 is returned too. All methods have an additional unset_environment:Bool=false, shown only in systemd_notify() here to save space.

* `Sys.systemd_notify(state:String, unset_environment:Bool=false) : Int` The low-level method (see `man 3 sd_notify`). All below methods are using it, with a unset_environment of false. When unset_environment is true, then subsequent calls to systemd_notify_xxx methods will silently fail, because $NOTIFY_SOCKET will be unset, this allows preventing child processes making calls to systemd-notify.
* `Sys.systemd_notify_service_is_ready()` Tells service manager startup is finished, or config was rehashed. Only used if .service file has Type=notify.
* `Sys.systemd_notify_service_is_reloading_config()` Only convenient to let systemd service manager show a more granular status.
* `Sys.systemd_notify_service_is_stopping()` Notify this service is beginning its shutdown. Same as above, useful only for more granular status.
* `Sys.systemd_notify_update_status(anything:String)` Expect single line UTF-8 status string, that will be shown with `systemctl status <servicename>`.
* `Sys.systemd_notify_errno(n:Int)` If a service fails, the errno-style error code, formatted as string. E.g. "ERRNO=2" for ENOENT.
* `Sys.systemd_notify_buserror(dbusErrorCode:String)` If a service fails, the DBus error-style error code. E.g. "org.freedesktop.DBus.Error.Timeout"
* `Sys.systemd_notify_mainpid(newMainPid:Int)` In case the service manager did not fork off the process itself.
* `Sys.systemd_notify_watchdog_heartbeat()` The keep-alive ping that services need to issue regularly if WatchdogSec= is enabled. (sends "WATCHDOG=1")
* `Sys.systemd_notify_watchdog_usec(microseconds:Int)` Reset watchdog_usec value during runtime. Notice that this is not available when using sd_event_set_watchdog() or sd_watchdog_enabled(). Example : "WATCHDOG_USEC=20000000"
* `Sys.systemd_notify_timeout_extension(microseconds:Int)` Tells service manager to extend the startup, runtime or shutdown service timeout corresponding the current state.

## How to install

You just need to `haxelib git` this repo, and target CPP with a `-lib linc_sys`.

Thanks to [Linc](http://snowkit.github.io/linc/).
