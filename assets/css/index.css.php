<?php

$css = '';

if ($_GET['page']??'') {
    $file = str_replace(['/', '.php'], '', $_GET['page']).'.css';
    $css = "/* No styles for {$file} */";

    if (file_exists(__DIR__.'/'.$file)) {
        $css = file_get_contents(__DIR__.'/'.$file);
    }
}

echo $css;