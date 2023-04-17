#!/bin/bash

BASE_DIR=""
CONTENT_DIR="$BASE_DIR/content"
COUNT=$(cat "$BASE_DIR/todo.txt" | wc -l)

backup() {
  rm -r $BASE_DIR/backup/cache
  mkdir $BASE_DIR/backup/cache
  cp $BASE_DIR/backup/*.txt $BASE_DIR/backup/cache/

  for name in $(printf $1)
  do
    cp $BASE_DIR/$name $BASE_DIR/backup/$name
  done
  echo "[200] backed up *.txt"
}

backup "done.txt\nfailed.txt\ntodo.txt"

for i in $(seq $COUNT)
do
  line=$(head -n 1 $BASE_DIR/todo.txt)
  url=$(echo $line | cut -d' ' -f1)
  name=$(echo $line | cut -d' ' -f2)

  echo "[Downloading] $name | $url"
  mkdir $BASE_DIR/tmp
  cd $BASE_DIR/tmp

  yt-dlp $url --write-info-json

  if [[ $? == 0 ]]
  then
    file_name="$(cat *.info.json | jq -r ".title") | $(cat *.info.json | jq -r ".channel")" 
    ext=$(cat *.info.json | jq -r ".ext")

    cat *.info.json | jq -r \
      ".channel,.id,.uploader_id,.thumbnail,.duration,.like_count" > "$CONTENT_DIR/$file_name.txt" 

    rm *.info.json
    mv * "$CONTENT_DIR/$file_name.$ext"
    echo "$url $(echo $name | sed 's/_/ /g')" >> "$BASE_DIR/done.txt"
    echo "Download Complete for $name"
  else
    echo "$url $(echo $name | sed 's/_/ /g')" >> "$BASE_DIR/failed.txt"
    echo "Download Failed for $name"
  fi

  x=$(cat $BASE_DIR/todo.txt | wc -l)
  tail -n $(( $x - 1 )) "$BASE_DIR/todo.txt" > "$BASE_DIR/todo.txt.swp"
  cp "$BASE_DIR/todo.txt.swp" "$BASE_DIR/todo.txt"

  rm -r $BASE_DIR/tmp
done
