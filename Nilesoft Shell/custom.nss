
// Git
modify(where=this.name=="Open Git GUI here"
  vis=vis.remove)
modify(where=this.name=="Open Git Bash here"
  vis=vis.remove)
modify(where=this.name=="Open Alacritty here"
  vis=vis.remove)
modify(where=this.name=="Open with Visual Studio"
  vis=vis.remove)

// WinMerge / WizTree
modify(where=this.name=="WizTree"
  menu=title.more_options)
modify(where=this.name=="WinMerge"
  menu=title.more_options)

// Send with / Scan with
modify(find="Scan with"
  menu=title.more_options)
modify(find="Send with"
  menu=title.more_options)

// Remove Windows-added stuff
modify(where=this.id(id.restore_previous_versions,id.cast_to_device)
  vis=vis.remove)

// Modify Windows-added stuff
modify(where=this.id==id.view pos=1
  menu=title.more_options)
modify(where=this.id==id.sort_by pos=1
  menu=title.more_options)
modify(where=this.id==id.group_by pos=1
  menu=title.more_options)
modify(find='add to favorites'
  menu=title.more_options)
modify(where=this.id(id.send_to,id.share,id.create_shortcut,id.set_as_desktop_background,
  id.rotate_left,id.rotate_right, id.map_network_drive,id.disconnect_network_drive,
  id.format, id.eject,id.give_access_to,id.include_in_library,id.print)
    menu=title.more_options)

// PowerToys
modify(find="What's using this file"
  pos=pos.top menu='file manage')

// 7zip's checksums
modify(where=this.name=="7-Zip"
  menu=title.more_options)
//modify(find='CRC SHA' menu=title.more_options)

//////// Adding in stuff ////////
item(title='VSCodium' image=[\uE272, #22A7F2] cmd='codium' args='"@sel.path"'
  pos=8)
item(where=package.exists("WindowsTerminal") title=title.Windows_Terminal tip=tip_run_admin admin=has_admin image='@package.path("WindowsTerminal")\WindowsTerminal.exe' cmd='wt.exe' arg='-d "@sel.path\."'
  pos=8)
item(title='NeoVim' image='@sys.prog\Neovim\bin\nvim-qt.exe' cmd='alacritty' arg='-e nvim @sel.path\.'
  pos=8)