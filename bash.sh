Xaxis=$(xrandr --current 2>/dev/null | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
Yaxis=$(xrandr --current 2>/dev/null | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

docker run -e SCR_WDTH=${Xaxis} -e SCR_HGHT=${Yaxis} -e OUTPUT_DIR='/background' -v ${PWD}/background:/background -it feed_cloud bash

