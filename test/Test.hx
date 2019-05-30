import linc_sys.Sys;

class Test {
    static function main() {
        trace( "PID: " + cpp.NativeSys.sys_get_pid() ); // Main PID is provided by haxe natively
        trace( "Calling getThreadId() from main process gives " + linc_sys.Sys.getThreadId() );
        cpp.vm.Thread.create(_threadfunction);
        std.Sys.sleep(2);
        trace("Bye!");
    }

    static function _threadfunction() {
        trace("This is running from a thread with SPID " + linc_sys.Sys.getThreadId());
        std.Sys.sleep(1);
    }

}
