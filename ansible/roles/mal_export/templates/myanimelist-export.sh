/myanimelist-export

date_time="$(date +%d.%m.%Y)_$(date +%H.%M.%S)"
mv anime.xml "{{ mal_username }}_anime_$date_time.xml"
mv manga.xml "{{ mal_username }}_manga_$date_time.xml"
