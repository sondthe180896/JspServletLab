<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body {
                min-height: 100vh;
                margin: 0;
                display: flex;
                flex-direction: column;
                font-family: Arial, sans-serif;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .product-details {
                display: flex;
                gap: 40px;
                margin-top: 30px;
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .product-image {
                flex: 0 0 500px;
            }

            .product-image img {
                width: 100%;
                height: auto;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .product-info {
                flex: 1;
            }

            .product-title {
                font-size: 24px;
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
            }

            .product-price {
                font-size: 28px;
                color: #e44d26;
                font-weight: bold;
                margin: 20px 0;
            }

            .product-description {
                color: #666;
                line-height: 1.6;
                margin: 20px 0;
            }

            .product-status {
                margin: 20px 0;
                padding: 10px;
                border-radius: 4px;
                display: inline-block;
            }

            .status-available {
                background-color: #e8f5e9;
                color: #2e7d32;
            }

            .status-unavailable {
                background-color: #ffebee;
                color: #c62828;
            }

            .add-to-cart {
                display: flex;
                align-items: center;
                gap: 20px;
                margin-top: 30px;
            }

            .quantity-input {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .quantity-input input {
                width: 60px;
                padding: 8px;
                text-align: center;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .btn-addCart {
                padding: 12px 30px;
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

            .btn-addCart:hover {
                background-color: #0056b3;
            }

            .back-button {
                display: inline-block;
                padding: 10px 20px;
                color: #666;
                text-decoration: none;
                margin-bottom: 20px;
            }

            .back-button:hover {
                color: #333;
            }
            .product-description {
                color: #666;
                line-height: 1.6;
                margin: 20px 0;
                white-space: pre-line;
            }
            .product-description strong {
                color: #333;
                display: block;
                margin-top: 20px;
                margin-bottom: 10px;
                font-size: 1.1em;
            }
            /* Modal Container */
            .modal {
                display: none; /* Ẩn mặc định */
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5); /* Nền đen mờ */
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }

            /* Modal Content */
            .modal-content {
                background-color: #fff;
                border-radius: 8px;
                padding: 20px;
                width: 90%;
                max-width: 500px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                animation: slideDown 0.3s ease-out;
            }

            /* Modal Header */
            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #ddd;
                padding-bottom: 10px;
            }

            .modal-header h3 {
                margin: 0;
                font-size: 1.5rem;
                color: #333;
            }

            .modal-header .close {
                font-size: 1.5rem;
                cursor: pointer;
                color: #aaa;
                transition: color 0.2s;
            }

            .modal-header .close:hover {
                color: #000;
            }

            /* Modal Body */
            .modal-body {
                margin: 20px 0;
                font-size: 1rem;
                color: #555;
            }

            .modal-body strong {
                color: #d9534f; /* Màu đỏ nổi bật */
            }

            /* Modal Footer */
            .modal-footer {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }

            .modal-footer .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.2s ease;
            }

            /* Secondary Button */
            .modal-footer .btn-secondary {
                background-color: #f0f0f0;
                color: #333;
            }

            .modal-footer .btn-secondary:hover {
                background-color: #ddd;
            }

            /* Danger Button */
            .modal-footer .btn-danger {
                background-color: #d9534f;
                color: #fff;
            }

            .modal-footer .btn-danger:hover {
                background-color: #c9302c;
            }

            /* Animation for Modal */
            @keyframes slideDown {
                from {
                    transform: translateY(-50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

        </style>
    </head>
    <body>
        <jsp:include flush="true" page="header.jsp"/>

        <div class="container">
            <a href="LoadAllVegetables" class="back-button">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>

            <div class="product-details">
                <div class="product-image">
                    <img src="${vegetable.imgSrc}" alt="${vegetable.name}">
                </div>

                <div class="product-info">
                    <h1 class="product-title">${vegetable.name}</h1>

                    <div class="product-price">
                        <fmt:formatNumber value="${vegetable.price}" pattern="#,###"/>₫ / 1 kilogram
                    </div>

                    <div class="product-description">
                        <c:out value="${vegetable.description}" escapeXml="false"/>
                    </div>

                    <div class="product-status ${vegetable.status ? 'status-available' : 'status-unavailable'}">
                        <i class="fas ${vegetable.status ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                        ${vegetable.status ? 'Còn hàng' : 'Hết hàng'}
                    </div>

                    <div class="add-to-cart">
                        <div class="quantity-input">
                            <label>Số lượng:</label>
                            <input type="number" value="1" min="1" max="99">
                        </div>

                        <button class="btn-addCart" ${!vegetable.status ? 'disabled' : ''}>
                            <i class="fas fa-shopping-cart"></i>
                            Thêm vào giỏ hàng
                        </button>
                        <div class="btn-container">
                            <a href="updateVegetable?id=${vegetable.id}" class="btn btn-primary">
                                <i class="fas fa-edit"></i> Sửa sản phẩm
                            </a>
                        </div>
                        <button type="button" class="btn btn-danger" onclick="showDeleteModal(${vegetable.id})">
                            <i class="fas fa-trash"></i> Xóa
                        </button>
                    </div>
                </div>
            </div>
        </div>
    <center>
        <div class="modal" id="deleteModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Xác nhận xóa</h3>
                    <span class="close" onclick="closeModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa sản phẩm này?</p>
                    <p><strong>Lưu ý:</strong> Hành động này không thể hoàn tác.</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" onclick="closeModal()">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                    <a id="confirmDelete" href="" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Xóa
                    </a>
                </div>
            </div>
        </div>
    </center>

    <footer>
        <jsp:include flush="true" page="footer.jsp"/>
    </footer>
</body>
<script>
    const modal = document.getElementById('deleteModal');
    const confirmDelete = document.getElementById('confirmDelete');

    function showDeleteModal(id) {
        console.log("Opening modal for id:", id);
        modal.style.display = "block"; // Thêm dòng này
        modal.classList.add('show');
        confirmDelete.href = "DeleteVegetable?id=" + id;
        console.log("Delete URL:", confirmDelete.href);
    }

    function openModal() {
        document.getElementById("deleteModal").style.display = "flex";
    }

    function closeModal() {
        document.getElementById("deleteModal").style.display = "none";
    }

    // Đóng modal khi click bên ngoài
    window.onclick = function (event) {
        if (event.target == modal) {
            closeModal();
        }
    }

    // Đóng modal khi nhấn ESC
    document.addEventListener('keydown', function (event) {
        if (event.key === "Escape") {
            closeModal();
        }
    });
</script>
</html>