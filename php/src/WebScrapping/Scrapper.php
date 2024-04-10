<?php

namespace Chuva\Php\WebScrapping;

use Chuva\Php\WebScrapping\Entity\Paper;
use Chuva\Php\WebScrapping\Entity\Person;

/**
 * Scrapper part.
 */
class Scrapper {

  /**
   * Loads paper information from the HTML and returns the array with the data.
   */
  public function scrap(\DOMDocument $dom): array {
    $cards = $dom->getElementsByTagName('a');
    $xp = new \DOMXPath($dom);

    $indexID = 0;
    $Papers = array();
    foreach ($cards as $card) {
      $title = $card->getElementsByTagName('h4')->item(0)->textContent;
      $author = $card->getElementsByTagName('div')->item(0)->textContent;
      $id = $xp->query("//div[@class='volume-info']");
      $type = $xp->query("//div[@class='tags mr-sm']");
      
      $spans = $card->getElementsByTagName('span');
      $Institution = array();
      foreach ($spans as $span){
        if($span->hasAttribute('title')){
          $Institution[] = $span->getAttribute('title');
        }
      }
      
      
      if ($title != null && $author != null && $id->length > 0) {
        $Authors = (explode('; ', $author));
        $Operson = array();
        for($i = 0; $i < count($Authors)-1; $i++){
          $Operson[] = new Person($Authors[$i], $Institution[$i]);
        }
        $Papers[] = new Paper($id[$indexID]->nodeValue, $title, $type[$indexID]->textContent, $Operson);          
        $indexID++;
      }
    }
    return $Papers;
    }
}
