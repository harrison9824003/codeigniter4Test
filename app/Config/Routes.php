<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');
$routes->get('/toPdf', 'ToPdf::index');
$routes->get('/toImage', 'ToImage::index');
