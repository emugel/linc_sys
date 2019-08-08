package linc_sys;

import linc_sys.ExternalSys;

/**
 * Contains nothing other than a getThreadId() method for now.
 * This will, on Linux/CPP return the SPID of a thread.
 */
@:keep
@:include('linc_sys.h')
class Sys {

    public static function systemd_notify(state:String, unset_environment:Bool=false) : Int return ExternalSys._systemd_notify(state, unset_environment ? 1 : 0);
    public static function systemd_notify_service_is_ready(unset_environment:Bool=false) : Int return systemd_notify("READY=1", unset_environment);
    public static function systemd_notify_service_is_reloading_config(unset_environment:Bool=false) : Int return systemd_notify("RELOADING=1", unset_environment);
    public static function systemd_notify_service_is_stopping(unset_environment:Bool=false) : Int return systemd_notify("STOPPING=1", unset_environment);
    public static function systemd_notify_update_status(anything:String, unset_environment:Bool=false) : Int return systemd_notify(anything, unset_environment);
    public static function systemd_notify_errno(n:Int, unset_environment:Bool=false) : Int return systemd_notify("ERRNO=" + Std.string(n), unset_environment);
    public static function systemd_notify_buserror(dbusErrorCode:String, unset_environment:Bool=false) : Int return systemd_notify("BUSERROR=" + Std.string(dbusErrorCode), unset_environment);
    public static function systemd_notify_watchdog_heartbeat(unset_environment:Bool=false) : Int return systemd_notify("WATCHDOG=1", unset_environment);
    public static function systemd_notify_watchdog_usec(microseconds:Int, unset_environment:Bool=false) : Int return systemd_notify("WATCHDOG_USEC=" + Std.string(microseconds), unset_environment);
    public static function systemd_notify_timeout_extension(microseconds:Int, unset_environment:Bool=false) : Int return systemd_notify("EXTEND_TIMEOUT_USEC=" + Std.string(microseconds), unset_environment);

    /**
     * Get thread id (SPID) of a thread, using gettid() on Linux
     * @return (Int)
     */
    public static function getThreadId() : Int 
        return ExternalSys._getThreadId(); 

    /**
     * Read whether there was a keypressed, non-blockingly
     * compared to Sys.getChar().
     * It will automatically set terminal to non-canonical mode,
     * and will restore canonical mode automatically at program exit.
     * You can manually resetTermToCanonicalMode().
     */
    public static function getNonBlockingChar() : Int {
        return ExternalSys._getNonBlockingChar();
    }

    /**
     * In (default) canonical mode, terminal keys will be read until
     * a CR and/or LF. getNonBlockingChar() sets term to non-canonical
     * mode, and will restore automatically the non-canonical at program
     * exit, but you may manually reset it here at any time.
     */
    public static function resetTermToCanonicalMode() : Void {
        return ExternalSys._resetTermToCanonicalMode();
    }

}
// vim: fdm=marker
