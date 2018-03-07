#!/bin/sh
export MYSQL_DATABASE="mybanca"
export MYSQL_USER="ariel"
export MYSQL_PASSWORD="ariel"
export MYSQL_ROOT_PASSWORD="_ariel_"
export MYSQLPORT="8306"

if [ -d /run/mysqld ]; then
    echo "skipping creation."
  else
    echo "MySQL data directory not found, creating initial DB."
    cat > $APPDIR/my.cnf <<!
        [mysqld]
        user    = root
        datadir = /run/mysqld
        port    = $MYSQLPORT
        skip-host-cache
!
    yes | cp -i $APPDIR/my.cnf /etc/mysql/my.cnf && \
        mkdir -p /run/mysqld && \
        mysql_install_db --user=root > /dev/null

    cat > create_db.sql <<!
        USE mysql;
        FLUSH PRIVILEGES;
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
        GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;
        GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
        CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;
        FLUSH PRIVILEGES;
!
    mysqld --user=root --bootstrap --verbose=0 < create_db.sql && \
        rm -f create_db.sql && \
        rm -f my.cnf
fi

# Run mysql and do migrations
mysqld --user=root & \
    sleep 1.5 && cd $APPDIR/src/back && \
    python3 migrations.py
