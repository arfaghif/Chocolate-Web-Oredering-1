<?php
include "logreg/config.php";
if (isset($_REQUEST['idchoco'])) {

	$idchoco = $_REQUEST['idchoco'];
}else {
	header('location: index.php');
}
?>
<!DOCTYPE html>
<html>
    <head>
        <title> Dashboard </title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
</html>
<?php
echo'
<body>
    <div class = "topnav" >
        <a class="active" href = "#home">Home</a>
        <a href="transaksi.php">History</a>
        <a href="logout" class= "nav-bar-right">Logout</a>
        
        <div class="search-container">
            <form action="search_result.php" method ="get">
                <input type="text" placeholder="Search.." name="search">
                <button type="submit" ><img src="icon/search.png" alt="submit"></button>
            </form>
        </div>
    </div>
    <div class = "choco-name">
            <p>Choclat Enak</p>
            </div>
    ';
    $datapembelian = Array();
    parse_str($_COOKIE['data-pembelian'],$datapembelian);
    $res = $connection->query("SELECT idchocolate,nama, amount_sold, price,amount_remaining,description FROM chocolate WHERE idchocolate =".$idchoco);
    $row = $res->fetch_assoc();
    $amount = $datapembelian['amount'];
    $totharga = $datapembelian['totharga'];
    $address = $datapembelian['address'];
    $user = $_COOKIE['user'];
    if($row['amount_remaining']>=$amount and $amount != 0){
        $sql = ("INSERT INTO transaksi(username,idchocolate, amount, time,address,total_price) VALUES('$user','$idchoco','$amount',NOW(),'$address','$totharga')");
        $connection->query($sql);
        echo'
        <div class = "buy-succes">
        <h1>Pembelian Berhasil Disimpan di Database</h1>
        <a href = "dashboard.php">
            <button type = "button">Back to Dashboard</button>
        </a>
        </div>';
        $amount_remaining = intval($row['amount_remaining'])-intval($amount);
        $amount_sold = intval($row['amount_sold']) + intval($amount);
        $sql2 = ("UPDATE chocolate SET amount_remaining='$amount_remaining', amount_sold='$amount_sold' WHERE idchocolate='$idchoco'");
        $connection->query($sql2);

    }else{
        echo'
        <div class = "buy-succes">
        <h1>Transaksi gagal, stok tidak mencukupi</h1>
        <a href = "dashboard.php">
            <button type = "button">Back to Dashboard</button>
        </a>
        </div>';
    }
?>