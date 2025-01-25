docker run --rm \
  --name cgit-server \
  -p 8080:8080 \
  -v $(pwd)/git/repositories:/var/git/repositories \
  -v $(pwd)/cgitrc:/etc/cgitrc \
  -v $(pwd)/cgit.css:/usr/share/cgit/cgit.css \
  -v $(pwd)/nginx.conf:/etc/nginx/conf.d/default.conf \
  cgit-server