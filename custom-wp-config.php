if ( !empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https' ) {
    $_SERVER['HTTPS'] = 'on';
}

if ( isset($_SERVER['HTTP_X_FORWARDED_HOST']) ) {
    $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_X_FORWARDED_HOST'];
    if (!(bool)ip2long($_SERVER['HTTP_HOST'])) {
        $_SERVER['REQUEST_URI'] = substr($_SERVER['REQUEST_URI'], strpos($_SERVER['REQUEST_URI'], '/', 1));
    }
}