package linc_sys;

import linc_sys.Sys;

@:keep
@:include('linc_sys.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('sys'))
#end
extern class ExternalSys {

    @:native("linc::ns_sys::_getThreadId")
    static function _getThreadId() : Int;

}
