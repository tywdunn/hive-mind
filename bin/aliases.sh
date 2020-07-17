#!/bin/bash

# get this script's directory path
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source docker-compose environment variables
. "$DIR/../.env"

# run gulp in node container; forwards ports 3000 & 3001 for 'gulp watch' functionality; shares current directory w/ container
alias hm-gulp='docker run -it --rm -v $(pwd):/data -p 3000:3000 -p 3001:3001 --net '$COMPOSE_PROJECT_NAME'_default '$COMPOSE_PROJECT_NAME'_node gulp'

# run npm in node container; shares current directory w/ container
alias hm-npm='docker run -it --rm -v $(pwd):/data '$COMPOSE_PROJECT_NAME'_node npm'

# run webpack in node container;
alias  hm-webpack='docker exec -ti '$COMPOSE_PROJECT_NAME'-node-cont sh -c "npm run start:prod"'

# run bower in node container; shares current directory w/ container
alias hm-bower='docker run -it --rm -v $(pwd):/data '$COMPOSE_PROJECT_NAME'_node bower'

# run composer in composer container; shares current directory w/ container
alias hm-composer='docker run --rm -v '$DIR'/../:/var/www/ '$COMPOSE_PROJECT_NAME'_composer --working-dir=/var/www/site'

# execute mysql client on percona container interactively using credentials in .env file
alias hm-mysql='docker exec -it '$COMPOSE_PROJECT_NAME'-percona-cont mysql -p'$COMPOSE_MYSQL_PASSWORD' -u'$COMPOSE_MYSQL_USER''

# create mysqldump file to supplied file name using executable on percona container and credentials in .env file
alias hm-dumpdb='docker exec -it '$COMPOSE_PROJECT_NAME'-percona-cont mysqldump -p'$COMPOSE_MYSQL_PASSWORD' -u'$COMPOSE_MYSQL_USER' '$COMPOSE_MYSQL_DATABASE' > '

# load mysqldump file from supplied file name using executable on percona container and credentials in .env file
alias hm-loaddb='docker exec -i '$COMPOSE_PROJECT_NAME'-percona-cont mysql -p'$COMPOSE_MYSQL_PASSWORD' -u'$COMPOSE_MYSQL_USER' '$COMPOSE_MYSQL_DATABASE' < '

# use container's php binary instead of loocal one
alias hm-php='docker exec -it '$COMPOSE_PROJECT_NAME'-php-cont php'