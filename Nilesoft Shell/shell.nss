shell
{
	var
	{
		isw11=sys.is11
	}
	
	set
	{
		theme
		{
			name="modern"
			view = view.small
			background
			{
				//opacity=85
				//effect=1
			}
			image.align = 2// 0 = checked, 1 = image, 2 = both
		}

		tip
		{
			enabled=1
			opacity=100
			width=400
			radius=1
			time=1.25
			padding=[10,10]
		}

		exclude.where = !process.is_explorer
		showdelay=0
	}

	images import 'imports/images.nss'

	static
	{	
		import 'imports/static.nss'
		import 'imports/customStatic.nss'
		item(where=this.title.length > 25 menu=title.more_options)
	}

	dynamic
	{
		menu(mode="multiple" title="Pin/Unpin" image=icon.pin) { }
		
		import 'imports/terminal.nss'
		import 'imports/develop.nss'
		import 'imports/goto.nss'
		import 'imports/file-manage.nss'
		menu(mode="multiple" title=title.more_options image=icon.more_options) { }
		import 'imports/taskbar.nss'
	}
}