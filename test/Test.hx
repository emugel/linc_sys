import linc_sys.Sys;

class Fake { public var id : Int; }

class Test {

    static function main() {
        trace( "PID: " + cpp.NativeSys.sys_get_pid() ); // Main PID is provided by haxe natively
        trace( "Calling getThreadId() from main process gives " 
            + linc_sys.Sys.getThreadId() );
        cpp.vm.Thread.create(_threadfunction);
        std.Sys.sleep(2);

        // --------------------------------------------------
        trace("Let's now test getNonBlockingChar()");
        var char;
        while ((char = linc_sys.Sys.getNonBlockingChar()) == 0) { std.Sys.sleep(0.2); } 
        trace("Ok charcode " + char + " was hit.");
        // linc_sys.Sys.resetTermToCanonicalMode();   // automatic normally

        // throw "Fwe";     // ok, canonical restored also in case of exception
        // var s : Fake = null;
        // s.id = 34;              // this should coredump on cpp
                                   // allowing to check whether
                                   // canonical mode worked:  YES

        // A useless systemd notify (useless because you'd have to create
        // a service and this is just a test)
        Sys.systemd_notify_service_is_stopping();

        trace("Bye!");
    }

    static function _threadfunction() {
        trace("This is running from a thread with SPID " + linc_sys.Sys.getThreadId());
        std.Sys.sleep(1);
    }

}
