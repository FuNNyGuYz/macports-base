# et:ts=4
# portxmkmf.tcl
#
# Copyright (c) 2003 Kevin Van Vechten <kevin@opendarwin.org>
# Copyright (c) 2002 - 2003 Apple Computer, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of Apple Computer, Inc. nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

PortTarget 1.0

name			org.opendarwin.prepare.xmkmf
#version		1.0
maintainers		kevin@opendarwin.org
description		Prepare sources for building using xmkmf
requires		patch
provides		prepare xmkmf

commands xmkmf
#default xmkmf.cmd xmkmf
#default xmkmf.dir {[option worksrcpath]}

set UI_PREFIX "---> "

proc main {args} {
    global UI_PREFIX

    ui_msg "$UI_PREFIX [format [msgcat::mc "Configuring %s"] [option portname]]"

	option xmkmf.dir [option worksrcpath]

	if {[catch {system "[command xmkmf]"} result]} {
	    return -code error "[format [msgcat::mc "%s failure: %s"] xmkmf $result]"
	} else {
	    # XXX should probably use make command abstraction but we know that
	    # X11 will already set things up so that "make Makefiles" always works.
	    system "cd [option xmkmf.dir] && make Makefiles"
	}

    return 0
}
