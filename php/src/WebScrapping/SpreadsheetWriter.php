<?php

namespace Chuva\Php\WebScrapping;

use OpenSpout\Writer\Common\Creator\WriterEntityFactory;

/**
 * Does the I/O on a spreeadsheet.
 */
class SpreadsheetWriter {

  /**
   * Write the ../../assets/model.xlsx with the data scrapped from origin.
   */
  public function write($data = []): void {
    $writer = WriterEntityFactory::createXLSXWriter();
    $writer->openToFile(__DIR__ . '/../../assets/model.xlsx');
    $qtdauthor = 16;
    $columnNames = ["ID", "Title", "Type"];
    for ($i = 1; $i < $qtdauthor + 1; $i++)
    {
      $columnNames[] = "Author " . $i;
      $columnNames[] = "Author " . $i . " Institution";
    }

    $row = WriterEntityFactory::createRowFromArray($columnNames);
    $writer->addRow($row);

    foreach ($data as $paper)
    {
      $cells = [];
      $cells[] = $paper->id;
      $cells[] = $paper->title;
      $cells[] = $paper->type;
      foreach ($paper->authors as $author)
      {
        $cells[] = $author->name;
        $cells[] = $author->institution;
      }
    
      $row = WriterEntityFactory::createRowFromArray($cells);
      $writer->addRow($row);
    }

    $writer->close();
  }

}
