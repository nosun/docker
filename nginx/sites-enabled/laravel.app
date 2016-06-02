server {
    listen       80;
    server_name  laravel.app m.laravel.app api.laravel.app;
    index index.php index.html;
    root  /data/www/laravel.app/public;

    rewrite_log on;
    error_log /data/logs/nginx/laravel_nginx_error.log info;

    # rewrite
    location / {
        try_files $uri $uri/ @rewrite;
    }

    location @rewrite {
        rewrite ^(.*)$ /index.php$1;
    }

    location ~ \.php($|/) {
        fastcgi_pass php:9000;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        fastcgi_index  index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}
