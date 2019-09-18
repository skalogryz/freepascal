{
    Copyright (c) 2002-2010 by Florian Klaempfl and Jonas Maebe

    This unit contains the CPU specific part of tprocinfo

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
unit cpupi;

{$i fpcdefs.inc}

interface

  uses
    cutils,
    procinfo,cpuinfo, symtype,
    psub;

  type

    { tcpuprocinfo }

    tcpuprocinfo=class(tcgprocinfo)
    public
      procedure postprocess_code; override;

      procedure set_first_temp_offset;override;
    end;

implementation

    uses
      systems,globals, tgcpu, aasmdata, aasmcpu,
      tgobj,paramgr,symconst;

    procedure tcpuprocinfo.postprocess_code;
      var
       templist : TAsmList;
       l : TWasmLocal;
      begin
        templist := TAsmList.create;
        l := ttgwasm(tg).localvars.first;
        while Assigned(l) do begin
          templist.Concat( tai_local.create(l.typ));
          l := l.nextseq;
        end;
        aktproccode.insertListBefore(nil, templist);
        templist.Free;

        inherited postprocess_code;
      end;

    procedure tcpuprocinfo.set_first_temp_offset;
      var
        sz : integer;
        i  : integer;
        sym: tsym;
      begin
        {
          Stackframe layout:
          sp:
            <incoming parameters>
            sp+first_temp_offset:
            <locals>
            <temp>
        }
        procdef.init_paraloc_info(calleeside);
        sz := procdef.calleeargareasize;
        tg.setfirsttemp(sz);
      end;


initialization
  cprocinfo:=tcpuprocinfo;
end.
