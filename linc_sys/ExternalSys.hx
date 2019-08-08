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

    @:native("linc::ns_sys::_getNonBlockingChar")
    static function _getNonBlockingChar() : Int;

    @:native("linc::ns_sys::_resetTermToCanonicalMode")
    static function _resetTermToCanonicalMode() : Void;

    @:native("linc::ns_sys::_systemd_notify")
    static function _systemd_notify(msg:String, unset_environment:Int) : Int;
}
