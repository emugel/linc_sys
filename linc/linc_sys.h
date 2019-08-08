#pragma once

//hxcpp include should always be first    
#ifndef HXCPP_H
#include <hxcpp.h>
#endif

//include other library includes as needed
// #include "../lib/____"

namespace linc {

    namespace ns_sys {
        int _getThreadId(void);
        int _getNonBlockingChar(void);
        void _resetTermToCanonicalMode();

        int _systemd_notify(const char *state, int unset_environment);

        namespace nonblockingchar {
            void reset_terminal_mode();
            void set_conio_terminal_mode();
            int kbhit();
            int getch();
            extern bool is_canonical;
        }
    }

} //linc
