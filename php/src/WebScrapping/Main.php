<?php

namespace Chuva\Php\WebScrapping;

class Main
{
  public static function run(): void
  {
    ini_set('display-errors', 'off');
    error_reporting(0);
    libxml_use_internal_errors(true);

    $dom = new \DOMDocument();
    $dom->loadHTMLFile(__DIR__ . '/../../assets/origin.html');

    $scrapper = new Scrapper();
    $papers = $scrapper->scrap($dom);
    
    $TableWriter = new SpreadsheetWriter();
    $TableWriter->WriteToExcel($papers);

  }

}
