{
    Copyright (c) 2003-2004 by Peter Vreman and Florian Klaempfl

    This units contains support for DWARF debug info generation

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
unit dbgdwarf;

{$i fpcdefs.inc}

interface

    uses
      DbgBase;

    type
      TDebugInfoDwarf=class(TDebugInfo)
      end;

implementation

    uses
      Systems;

    const
      dbg_dwarf_info : tdbginfo =
         (
           id     : dbg_dwarf;
           idtxt  : 'DWARF';
         );

initialization
  RegisterDebugInfo(dbg_dwarf_info,TDebugInfoDwarf);
end.
