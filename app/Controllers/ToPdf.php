<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use Dompdf\Dompdf;

class ToPdf extends BaseController
{
    public function index(): string
    {
        $html = '
            <link rel="stylesheet" href="path/to/your/style.css">
            <h1>Hello World</h1>
            <p>This is a paragraph styled with external CSS.</p>
        ';

        $dompdf = new Dompdf();
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();
        $dompdf->stream();
        // 回傳 pdf
        return $dompdf->output();
    }
}