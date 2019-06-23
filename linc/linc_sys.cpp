//hxcpp include should be first
#include <hxcpp.h>
#include "./linc_sys.h"

// for _getThreadId()
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>

// for _getNonBlockingChar() (+ unistd.h)
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <termios.h>

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


        /**
         * Return 0 if there was no key pressed, otherwise return 
         * the charcode of the key. This is non-blocking.
         * If there are several such keys, this will only return the first one.
         */
        int _getNonBlockingChar(void) {
            if (nonblockingchar::is_canonical) 
                nonblockingchar::set_conio_terminal_mode();
            return nonblockingchar::kbhit() 
                ? nonblockingchar::getch()
                : 0
            ;
        }

        /**
         * The default, to read until CR/LF.
         * This will also call atexit() so default canonical
         * is set (only once) at program exit.
         */
        void _resetTermToCanonicalMode() {
            nonblockingchar::reset_terminal_mode();
        }

        namespace nonblockingchar {
            bool is_canonical = true;               // we sit in  canonical by default
            bool has_atexit_been_set = false;   
            struct termios orig_termios;            // default, canonical
            struct termios new_termios;             // non-canonical

            // this needs be called before exiting
            // to restore canonical mode (i.e. waiting ENTER key)
            void reset_terminal_mode() {
                tcsetattr(0, TCSANOW, &orig_termios);
                is_canonical = true;
            }

            // will set to canonical if needed
            void set_conio_terminal_mode() {
                if (!has_atexit_been_set) {
                    tcgetattr(0, &orig_termios);
                }
                if (is_canonical) {
                    memcpy(&new_termios, &orig_termios, sizeof(new_termios));
                    if (!has_atexit_been_set) {
                        atexit(reset_terminal_mode);
                        has_atexit_been_set = true;
                    }
                    cfmakeraw(&new_termios);
                    tcsetattr(0, TCSANOW, &new_termios);
                    is_canonical = false;
                }
            }

            int kbhit() {
                struct timeval tv = { 0L, 0L };
                fd_set fds;
                FD_ZERO(&fds);
                FD_SET(0, &fds);
                return select(1, &fds, NULL, NULL, &tv);
            }

            int getch() {
                int r;
                unsigned char c;
                if ((r = read(0, &c, sizeof(c))) < 0) {
                    return r;
                } else {
                    return c;
                }
            }

        }
    }

} //linc
