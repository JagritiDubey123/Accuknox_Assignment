# #!/usr/bin/env bash

# SRVPORT=4499
# RSPFILE=response

# rm -f $RSPFILE
# mkfifo $RSPFILE

# get_api() {
# 	read line
# 	echo $line
# }

# handleRequest() {
#     # 1) Process the request
# 	get_api
# 	mod=`fortune`

# cat <<EOF > $RSPFILE
# HTTP/1.1 200


# <pre>`cowsay $mod`</pre>
# EOF
# }

# prerequisites() {
# 	command -v cowsay >/dev/null 2>&1 &&
# 	command -v fortune >/dev/null 2>&1 || 
# 		{ 
# 			echo "Install prerequisites."
# 			exit 1
# 		}
# }

# main() {
# 	prerequisites
# 	echo "Wisdom served on port=$SRVPORT..."

# 	while [ 1 ]; do
# 		cat $RSPFILE | nc -lN $SRVPORT | handleRequest
# 		sleep 0.01
# 	done
# }

# main


#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response

rm -f $RSPFILE
mkfifo $RSPFILE

get_api() {
    read line
    echo $line
}

handleRequest() {
    get_api
    mod=`fortune`

    cat <<EOF > $RSPFILE
HTTP/1.1 200

<pre>`cowsay $mod`</pre>
EOF
}

prerequisites() {
    if ! command -v cowsay >/dev/null 2>&1; then
        echo "cowsay not found. Install prerequisites."
        exit 1
    fi
    if ! command -v fortune >/dev/null 2>&1; then
        echo "fortune not found. Install prerequisites."
        exit 1
    fi
}

main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."

    while [ 1 ]; do
        cat $RSPFILE | nc -lN $SRVPORT | handleRequest
        sleep 0.01
    done
}

main
