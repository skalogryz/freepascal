{
    Copyright (c) 2019 by Dmitry Boyarintsev

    WebAssembly-specific code for call nodes

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 ****************************************************************************
}
unit nwasmcal;

{$i fpcdefs.inc}

interface

    uses
      cgbase,
      symtype,symdef,cgutils,parabase,
      node,ncal,ncgcal,hlcgobj,aasmcpu,cpubase, wasmdef;

    type
       { twasmcallparanode }

       twasmcallparanode = class(tcgcallparanode)
       end;

       { twasmcallnode }

       twasmcallnode = class(tcgcallnode)
         procedure set_result_location(realresdef: tstoreddef); override;
       end;


implementation

    uses
      globtype, aasmdata, defutil, tgobj, hlcgcpu;

      { twasmcallnode }

    procedure twasmcallnode.set_result_location(realresdef: tstoreddef);
      begin
        // default implementation is placing the return value on LOC_REGISTER.
        // WebAssembly always returns the value on stack.
        location_reset_ref(location,LOC_REFERENCE,def_cgsize(realresdef),1,[]);
        tg.gethltemp(current_asmdata.CurrAsmList,realresdef,retloc.intsize,tt_normal,location.reference);
      end;

begin
  ccallnode:=twasmcallnode;
  ccallparanode:=twasmcallparanode;
end.
