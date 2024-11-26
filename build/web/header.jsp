<%-- 
    Document   : header
    Created on : Nov 26, 2024, 1:30:27 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Frozen Yogurt Shop</title>
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link rel="stylesheet" type="text/css" href="css/mobile.css">
        <script src="js/mobile.js" type="text/javascript"></script>
    </head>
    <body>
        <div id="header">
            <div>
                <a href="LoadAllVegetables" class="logo"><h1>RAU TƯƠI</h1></a>
                <span id="mobile-navigation"></span><ul id="navigation">
                    <li class="selected">
                        <a href="index.html">Home</a>
                    </li>
                    <li class="menu">
                        <a href="about.html">About</a>
                        <ul class="primary">
                            <li>
                                <a href="product.html">Product</a>
                            </li>
                        </ul>
                        <span class="mobile-submenu" onclick="submenu(1)"></span></li>
                    <li class="menu">
                        <a href="blog.html">Blog</a>
                        <ul class="secondary">
                            <li>
                                <a href="singlepost.html">Single post</a>
                            </li>
                        </ul>
                        <span class="mobile-submenu" onclick="submenu(3)"></span></li>
                    <li>
                        <a href="contact.html">Contact</a>
                    </li>
                </ul>
            </div>
        </div>
    </body>
</html>
