<%-- 
    Document   : index.
    Created on : Nov 26, 2024, 1:40:44 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .product-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
                padding: 20px 0;
            }

            .product-col-item {
                border: 1px solid #eee;
                border-radius: 8px;
                padding: 15px;
                transition: all 0.3s ease;
                background: white;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .product-col-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            .product-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 6px;
                margin-bottom: 15px;
            }

            .item-info {
                padding: 10px 0;
            }

            .item-title {
                margin-bottom: 10px;
            }

            .item-title a {
                color: #333;
                text-decoration: none;
                font-weight: bold;
                font-size: 1.1em;
            }

            .item-title a:hover {
                color: #007bff;
            }

            .price-box {
                margin: 15px 0;
            }

            .regular-price .price {
                color: #e44d26;
                font-size: 1.2em;
                font-weight: bold;
            }

            .btn-addCart {
                display: inline-block;
                padding: 8px 15px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            .btn-addCart:hover {
                background-color: #0056b3;
            }

            .empty-message {
                text-align: center;
                padding: 20px;
                font-size: 1.2em;
                color: #666;
            }
            body {
                min-height: 100vh;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            #content {
                flex: 1 0 auto;
            }

            footer {
                flex-shrink: 0;
                width: 100%;
                margin-top: auto;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                overflow: hidden; /* Ngăn float làm ảnh hưởng layout */
            }

            /* Điều chỉnh product grid */
            .product-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
                padding: 20px 0;
                margin-bottom: 20px; /* Thêm margin bottom để tránh đè lên footer */
            }
            /* Add to your existing CSS */
            .search-container {
                margin-bottom: 30px;
            }

            .search-form {
                display: flex;
                gap: 10px;
                max-width: 600px;
                margin: 0 auto;
            }

            .search-input {
                flex: 1;
                padding: 10px 15px;
                border: 2px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }

            .search-input:focus {
                border-color: #007bff;
                outline: none;
            }

            .search-button {
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: background-color 0.3s ease;
            }

            .search-button:hover {
                background-color: #0056b3;
            }
            .add-button-container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 0 20px;
            }

            .add-button {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 12px 24px;
                background-color: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-weight: 500;
                transition: all 0.3s ease;
                border: none;
                cursor: pointer;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .add-button:hover {
                background-color: #218838;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            }

            .add-button i {
                font-size: 16px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .add-button {
                    padding: 10px 20px;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include flush="true" page="header.jsp"/>
        <div class="search-container">
            <form action="SearchVegetable" method="GET" class="search-form" style="margin-top: 20px">
                <input type="text" name="name" value="${searchName}" placeholder="Tìm kiếm sản phẩm..." class="search-input">
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i> Tìm kiếm
                </button>
            </form>
        </div>
        <div class="add-button-container">
            <a href="addVegetable" class="add-button">
                <i class="fas fa-plus"></i>
                Thêm sản phẩm mới
            </a>
        </div>
        <div id="content">
            <!-- Thêm vào đầu nội dung, sau header -->
            <div class="container">
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        ${sessionScope.success}
                    </div>
                    <c:remove var="success" scope="session" />
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        ${sessionScope.error}
                    </div>
                    <c:remove var="error" scope="session" />
                </c:if>
                <div class="container">
                    <c:if test="${empty listV}">
                        <p>Danh sách trống</p>
                    </c:if>
                    <c:forEach items="${listV}" var="v">
                        <div class="owl-item active" style="width: 258.667px; margin-right: 20px;float:
                             left"><div class="item">
                                <div class="product-col-item">
                                    <a href="ViewDetails?id=${v.id}">
                                        <img class="product-image" src="${v.imgSrc}" alt=""> 
                                    </a> 
                                    <div class="item-info">
                                        <div class="info-inner">
                                            <div class="item-title">
                                                <a href="ViewDetails?id=${v.id}" title="${v.name}">${v.name}</a>
                                            </div> 
                                            <div class="item-price"> 
                                                <div class="price-box">
                                                    <span class="regular-price">
                                                        <span class="price">
                                                            <fmt:formatNumber value="${v.price}" pattern="#,###" />₫ / <i>1 kilogram</i>
                                                        </span>
                                                    </span>
                                                </div>
                                            </div>
                                            <a href="#" class="btn-addCart"><i class="fa fa-shopping-cart">Add to cart</i></a>
                                        </div>
                                    </div>
                                </div>
                            </div></div>
                        </c:forEach>
                </div>
            </div>
            <footer>
                <jsp:include flush="true" page="footer.jsp"/>
            </footer>
    </body>
</html>
