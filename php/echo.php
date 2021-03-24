<?php

$output = [];
foreach ($_GET as $k=>$v) {
    $output[] = "${k}=${v}";
}
echo implode("&", $output);