shell
{
	// MEGA
	item(find='mega' pos=4 menu=title.more_options)
	item(find='view previous versions' pos=4 menu=title.more_options)

	// Git
	item(find='Git Bash' pos=5 vis=vis.remove)
	item(find='Git GUI' pos=5 menu=title.more_options)

	// 7zip
	item(find='7-Zip' pos=3 menu=title.more_options)
	item(find='CRC SHA' pos=3 menu=title.more_options)

	// NordVPN
	item(find='NordVPN' menu=title.more_options)

	item(where=this.id==id.view pos=1 menu=title.more_options)
	item(where=this.id==id.sort_by pos=1 menu=title.more_options)
	item(where=this.id==id.group_by pos=1 menu=title.more_options)
	item(find='open linux shell here' vis=vis.remove)
	item(find='WinMerge' menu=title.more_options)
	item(find='Kill not responding tasks' pos=pos.bottom)
}