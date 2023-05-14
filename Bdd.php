<?php
class Bdd {


    function connect_to_bdd() {

        $servername = "localhost";
        $username = "root";
        $password = "admin";
        $db = "db";
        try {
            $db = new PDO('mysql:host=db;port=3306;dbname=my_database', 'root', 'admin');
            $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
        echo "Connected successfully";
        return 1;
        }
        catch(PDOException $e)
        {
        echo "Connection failed: " . $e->getMessage();
        return 0;
        }
    }

}
?>