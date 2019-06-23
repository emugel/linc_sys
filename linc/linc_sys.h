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

        namespace nonblockingchar {
            void reset_terminal_mode();
            void set_conio_terminal_mode();
            int kbhit();
            int getch();
            extern bool is_canonical;
        }
    }

} //linc
