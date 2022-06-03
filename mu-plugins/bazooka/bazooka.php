<?php

add_filter( 'automatic_updater_disabled', '__return_true' );

add_filter( 'auto_update_plugin', '__return_false' );

add_filter( 'auto_update_theme', '__return_false' );

add_filter( 'auto_update_translation', '__return_false' );
