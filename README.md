Docker container that will crawl a given list of sub reddits (config/feeds.txt) and generate a word cloud background wallpaper

Run build.sh to build docker container
run run.sh to generate and deploy (ubuntu, windows) wallpaper

Note: if you change the list of sub reddits in the feeds.txt file, you will
need to eiter rebuild our docker container or push it up.

TODO: Should have the docker container read the feeds.txt from share on the host
