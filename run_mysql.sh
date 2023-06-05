#!/bin/bash

# Copyright (C) 2019-2023 alanndz <alanndz7@gmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later

basedir=$(pwd)
mysql=${basedir}/mysql
sql=()

mkdir -p ${mysql}

prin() { echo -e "$@"; }

_sql(){
    mysql -u root -p < "${1}"
}

prin "Daftar sql"

for i in ${mysql}/*.sql
do
    #prin $(basename $i)
    sql+=($(basename $i))
    # sudo mysql -e "$(cat $i)"
done

select namasql in ${sql[@]} run_all exit
do
    case $namasql in
        exit)
            exit 0
            ;;
        run_all)
            for i in ${sql[@]}
            do
                #prin "${mysql}/${i}"
                _sql "${mysql}/${i}"
                sleep 1
            done
            ;;
        *)
            _sql "${mysql}/${namasql}"
            ;;
    esac
done
