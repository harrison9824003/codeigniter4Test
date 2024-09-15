<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use Knp\Snappy\Image;

class ToImage extends BaseController
{
    public function index()
    {
        $html = '
            <style>
                h1 { color: green; }
                p { font-size: 14px; }
            </style>
            <h1>Hello World</h1>
            <p>This image is styled with CSS.</p>
        ';

        try {
            // 初始化 Snappy Image，使用 vendor 內的 wkhtmltoimage
            $snappy = new Image(__DIR__ . '/../../vendor/h4cc/wkhtmltoimage-amd64/bin/wkhtmltoimage-amd64');

            // 生成圖片
            $image = $snappy->getOutputFromHtml($html);

            // 設置 HTTP 響應頭
            return $this->response
                ->setHeader('Content-Type', 'image/png')
                ->setBody($image);
        } catch (\Exception $e) {
            // 捕獲並記錄異常
            log_message('error', $e->getMessage());
            return $this->response
                ->setStatusCode(500)
                ->setBody('An error occurred: ' . $e->getMessage());
        }
    }
}