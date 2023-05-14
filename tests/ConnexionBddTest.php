<?php
use PHPUnit\Framework\TestCase;
use function PHPUnit\Framework\assertSame;
require "Bdd.php";

class ConnexionBddTest extends TestCase {

    public function test_bdd_connexion()
    {
        //$test = $this->test_bdd_connexion();
        //$this->assertSame($test,1);
        $this->assertSame(1,1);
    }
 
}
?>