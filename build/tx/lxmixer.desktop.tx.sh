[ -f /home/pranav/Github-Projects/lxmixer/resources/lxmixer.desktop.in ] || exit 0
echo '[lxde-qt.lxmixer_desktop]'
echo 'type = DESKTOP'
echo 'source_lang = en'
echo 'source_file = resources/lxmixer.desktop.in'
echo 'file_filter = translations/lxmixer_<lang>.desktop'
echo ''
