
// Git
modify(where=this.name=="Open Git GUI here"
  menu=title.more_options)
modify(where=this.name=="Open Git Bash here"
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
modify(where=this.id==id.view pos=1 menu=title.more_options)
modify(where=this.id==id.sort_by pos=1 menu=title.more_options)
modify(where=this.id==id.group_by pos=1 menu=title.more_options)
modify(find='add to favorites' menu=title.more_options)
modify(where=this.id(id.send_to,id.share,id.create_shortcut,id.set_as_desktop_background,
  id.rotate_left,id.rotate_right, id.map_network_drive,id.disconnect_network_drive,
  id.format, id.eject,id.give_access_to,id.include_in_library,id.print)
    menu=title.more_options)

// PowerToys
modify(find="What's using this file" menu='file manage' pos=pos.top)

// 7zip's checksums
modify(where=this.name=="7-Zip" menu=title.more_options)
//modify(find='CRC SHA' menu=title.more_options)
