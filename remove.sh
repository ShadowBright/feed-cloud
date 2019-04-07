docker ps -a | awk '{ print $1,$2 }' | grep feed_cloud | awk '{print $1 }' | xargs -I {} docker rm {}
docker rmi feed_cloud
