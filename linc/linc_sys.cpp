//hxcpp include should be first
#include <hxcpp.h>
#include "./linc_sys.h"

#define _GNU_SOURCE
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>


namespace linc {

    namespace ns_sys {

       /**
        * From `man 2 gettid`:
        *
        * SYNOPSIS
        *     #include <sys/types.h>
        *     pid_t gettid(void);
        *
        * DESCRIPTION
        *     gettid()  returns  the  caller's thread ID (TID).  In a single-threaded process,
        *     the thread ID is equal to the process ID (PID, as returned by getpid(2)).  In  a
        *     multithreaded  process, all threads have the same PID, but each one has a unique
        *     TID.  For further details, see the discussion of CLONE_THREAD in clone(2).
        * RETURN VALUE
        *     On success, returns the thread ID of the calling thread.
        * ERRORS
        *     This call is always successful.
        * VERSIONS
        *     The gettid() system call first appeared on Linux in kernel 2.4.11.  Library sup‐
        *     port was added in glibc 2.30.  (Earlier glibc versions did not provide a wrapper
        *     for this system call, necessitating the use of syscall(2).)
        * CONFORMING TO
        *     gettid() is Linux-specific and should not be used in programs that are  intended
        *     to be portable.
        */
        int _getThreadId(void) {
            // From https://stackoverflow.com/questions/7271154/how-to-get-pid-from-pthread
            // "As PlasmaHH notes, gettid() is called via syscall(). From the
            // syscall() man page:"
            return ::syscall(SYS_gettid);
        }
    }

} //linc
