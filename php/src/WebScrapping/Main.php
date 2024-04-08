<?php

namespace Chuva\Php\WebScrapping;

/**
 * Runner for the Webscrapping exercice.
 */
class Main
{

  /**
   * Main runner, instantiates a Scrapper and runs.
   * also runs the SpreadSheetWriter to the I/O operations on model.xlsx (excel spreeadsheet)
   */

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
