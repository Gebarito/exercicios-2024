<?php

namespace Chuva\Php\WebScrapping;

use OpenSpout\Writer\Common\Creator\WriterEntityFactory;
use OpenSpout\Common\Entity\Row;

/**
 * Does the I/O on a spreeadsheet
 */
class SpreadsheetWriter {

  /**
   * Write the ../../assets/model.xlsx with the data scrapped from origin
   */
  // public function foo(array $data): void {
  public function WriteToExcel($data = []): void {
    $writer = WriterEntityFactory::createXLSXWriter();
    $writer->openToFile(__DIR__ . '/../../assets/model.xlsx');

    //first row, collumn names
    $QtdAuthor = 16; //maior quantidade de autores existente no arquivo
    $columnNames = ["ID", "Title", "Type"];
    for($i = 1; $i < $QtdAuthor+1; $i++){
      $columnNames[] = "Author " . $i;
      $columnNames[] = "Author " . $i . " Institution";
    }

    $row = WriterEntityFactory::createRowFromArray($columnNames);
    $writer->addRow($row);

    foreach($data as $paper){
      $cells = [];
      $cells[] = $paper->id;
      $cells[] = $paper->title;
      $cells[] = $paper->type;
      
      foreach($paper->authors as $author){
        $cells[] = $author->name;
        $cells[] = $author->institution;
      }
    
      $row = WriterEntityFactory::createRowFromArray($cells);
      $writer->addRow($row);
    }

    $writer->close();
  }

}
