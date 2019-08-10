;说明
;  快捷切换鼠标指针样式
;使用说明
;  1. 下载鼠标指针包, 使用包中的*.inf来安装该指针
;  2. 将想要快捷切换的指针*.inf路径保存在[cursorPaths]数组变量中
;  3. 每次执行该脚本, 会变更光标为下一组

;========================= 环境配置 =========================
#SingleInstance, Force


;========================= 初始化 =========================
cursorPaths := Object()
cursorPaths.Insert("D:\theme\主题们\鼠标指针\Glows\Red\右键安装.inf")
cursorPaths.Insert("D:\theme\主题们\鼠标指针\Glows\Green\右键安装.inf")
cursorPaths.Insert("D:\theme\主题们\鼠标指针\Night+Diamond+v2.0\Night Diamond v2.0 - Ruby Red\右键安装.inf")
cursorPaths.Insert("D:\theme\主题们\鼠标指针\lenovo指针\AutoSetup.inf")
cursorPaths.Insert("D:\theme\主题们\鼠标指针\Apple OS X Alphablended Shadow\Right click and Install (Aqua Swirl).inf")


;========================= 业务逻辑 =========================
RegRead, CURRENT_SCHEME_NAME, HKEY_CURRENT_USER, Control Panel\Cursors
CURRENT_CURSOR_INDEX :=
for index, cursorPath in cursorPaths {
	IniRead, SCHEME_NAME, %cursorPath%, Strings, SCHEME_NAME
	if (CURRENT_SCHEME_NAME == SCHEME_NAME) {
		CURRENT_CURSOR_INDEX := index
		break
	}
}
if (!CURRENT_CURSOR_INDEX || CURRENT_CURSOR_INDEX == cursorPaths.MaxIndex())
	NEXT_CURSOR_INDEX := 1
else
	NEXT_CURSOR_INDEX := CURRENT_CURSOR_INDEX + 1
changeCursor(cursorPaths[NEXT_CURSOR_INDEX])
return


changeCursor(cursorPath) {
	IniRead, SCHEME_NAME, %cursorPath%, Strings, SCHEME_NAME
	IniRead, CUR_DIR, %cursorPath%, Strings, CUR_DIR
	IniRead, pointer, %cursorPath%, Strings, pointer
	IniRead, help, %cursorPath%, Strings, help
	IniRead, work, %cursorPath%, Strings, work
	IniRead, busy, %cursorPath%, Strings, busy
	IniRead, cross, %cursorPath%, Strings, cross
	IniRead, text, %cursorPath%, Strings, text
	IniRead, hand, %cursorPath%, Strings, hand
	IniRead, unavailiable, %cursorPath%, Strings, unavailiable
	IniRead, vert, %cursorPath%, Strings, vert
	IniRead, horz, %cursorPath%, Strings, horz
	IniRead, dgn1, %cursorPath%, Strings, dgn1
	IniRead, dgn2, %cursorPath%, Strings, dgn2
	IniRead, move, %cursorPath%, Strings, move
	IniRead, alternate, %cursorPath%, Strings, alternate
	IniRead, link, %cursorPath%, Strings, link

	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, , %SCHEME_NAME%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, Arrow, `%SYSTEMROOT`%\%CUR_DIR%\%pointer%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, Help, `%SYSTEMROOT`%\%CUR_DIR%\%help%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, AppStarting, `%SYSTEMROOT`%\%CUR_DIR%\%work%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, Wait, `%SYSTEMROOT`%\%CUR_DIR%\%busy%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, Crosshair, `%SYSTEMROOT`%\%CUR_DIR%\%cross%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, IBeam, `%SYSTEMROOT`%\%CUR_DIR%\%text%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, NWPen, `%SYSTEMROOT`%\%CUR_DIR%\%hand%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, No, `%SYSTEMROOT`%\%CUR_DIR%\%unavailiable%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, SizeNS, `%SYSTEMROOT`%\%CUR_DIR%\%vert%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, SizeWE, `%SYSTEMROOT`%\%CUR_DIR%\%horz%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, SizeNWSE, `%SYSTEMROOT`%\%CUR_DIR%\%dgn1%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, SizeNESW, `%SYSTEMROOT`%\%CUR_DIR%\%dgn2%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, SizeAll, `%SYSTEMROOT`%\%CUR_DIR%\%move%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, UpArrow, `%SYSTEMROOT`%\%CUR_DIR%\%alternate%
	RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER, Control Panel\Cursors, Hand, `%SYSTEMROOT`%\%CUR_DIR%\%link%
	
	SPI_SETCURSORS := 0x57
	DllCall("SystemParametersInfo", "UInt", SPI_SETCURSORS, "UInt", 0, "UInt", 0, "UInt", 0)
}