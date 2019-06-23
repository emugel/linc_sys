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
