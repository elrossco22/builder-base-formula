gearman-daemon:
    pkg.installed:
        - pkgs:
            - gearman-job-server

gearman-php-extension:
    pkg.installed:
        - pkgs:
            - php-gearman
        - require:
            - gearman-daemon
            - php
