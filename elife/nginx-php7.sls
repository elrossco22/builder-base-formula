#
# bridges Nginx and PHP 7
# depends on elife/php7.sls
# 

php-nginx-deps:
    pkg.installed:
        - name: php7.0-fpm
        - require:
            - php

php-fpm-config:
    file.managed:
        - name: /etc/php/7.0/fpm/php.ini
        - source: salt://elife/config/etc-php-7.0-fpm-php.ini
        - require:
            - php-nginx-deps
            - php-log

# favoring php_errors.log for everything
not-used-php-log:
    file.absent:
        - name: /var/log/php7.0-fpm.log

php-fpm:
    # nginx config needs to target this sock file. 
    # easier to target when version stripped out
    file.symlink:
        - name: /var/php-fpm.sock
        - target: /run/php/php7.0-fpm.sock

    service.running:
        - name: php7.0-fpm
        - require:
            - file: php-fpm
            - file: php-fpm-config            
