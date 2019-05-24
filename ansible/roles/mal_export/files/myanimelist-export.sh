set -x

/myanimelist-export

cd /export

echo Renaming exported anime.xml and manga.xml

date_time="$(date +%d.%m.%Y)_$(date +%H.%M.%S)"

if [[ -z "${MAL_USERNAME}" ]]; then
    mv anime.xml "anime_${date_time}.xml"
    mv manga.xml "manga_${date_time}.xml"
else
    mv anime.xml "${MAL_USERNAME}_anime_${date_time}.xml"
    mv manga.xml "${MAL_USERNAME}_manga_${date_time}.xml"
fi
