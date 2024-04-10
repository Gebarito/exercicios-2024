<?php

namespace Chuva\Php\WebScrapping;

use Chuva\Php\WebScrapping\Entity\Paper;
use Chuva\Php\WebScrapping\Entity\Person;

/**
 * Does the scrapping of a webpage.
 */
class Scrapper {

  /**
   * Loads paper information from the HTML and returns the array with the data.
   */
  public function scrap(\DOMDocument $dom): array {
    $cards = $dom->getElementsByTagName('a');
    $xp = new \DOMXPath($dom);

    $indexID = 0;
    $papers = array();
    foreach ($cards as $card) {
      $title = $card->getElementsByTagName('h4')->item(0)->textContent;
      $author = $card->getElementsByTagName('div')->item(0)->textContent;
      $id = $xp->query("//div[@class='volume-info']");
      $type = $xp->query("//div[@class='tags mr-sm']");

      $spans = $card->getElementsByTagName('span');
      $institution = array();
      foreach ($spans as $span){
        if($span->hasAttribute('title')) {
          $institution[] = $span->getAttribute('title');
        }

      }

      if ($title != NULL && $author != NULL && $id->length > 0) {
        $authors = (explode('; ', $author));
        $operson = array();
        for ($i = 0; $i < count($authors) - 1; $i++) {
          $operson[] = new Person($authors[$i], $institution[$i]);
        }

        $papers[] = new Paper($id[$indexID]->nodeValue, $title, $type[$indexID]->textContent, $operson);          
        $indexID++;
      }

    }

    return $papers;
  }

}
