package linc_sys;

import linc_sys.ExternalSys;

/**
 * Contains nothing other than a getThreadId() method for now.
 * This will, on Linux/CPP return the SPID of a thread.
 */
@:keep
@:include('linc_sys.h')
class Sys {

    /**
     * Get thread id (SPID) of a thread, using gettid() on Linux
     * @return (Int)
     */
    public static function getThreadId() : Int 
        return ExternalSys._getThreadId(); 

}
// vim: fdm=marker
