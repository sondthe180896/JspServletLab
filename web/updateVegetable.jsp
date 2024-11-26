<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cập nhật sản phẩm</title>
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
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
            }

            .form-title {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            .update-form {
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #333;
                font-weight: bold;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
            }

            textarea.form-control {
                min-height: 150px;
                resize: vertical;
            }

            .form-control:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
            }

            .btn-container {
                display: flex;
                gap: 10px;
                justify-content: flex-end;
                margin-top: 20px;
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background-color: #28a745;
                color: white;
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }

            .btn-danger {
                background-color: #dc3545;
                color: white;
            }

            .btn:hover {
                opacity: 0.9;
                transform: translateY(-1px);
            }

            .preview-image {
                max-width: 200px;
                margin-top: 10px;
                border-radius: 4px;
            }

            .error-message {
                color: #dc3545;
                font-size: 14px;
                margin-top: 5px;
            }

            .status-toggle {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .status-toggle input[type="checkbox"] {
                width: 20px;
                height: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include flush="true" page="header.jsp"/>

        <div class="container">
            <h2 class="form-title">Cập nhật sản phẩm</h2>

            <form action="updateVegetable" method="POST" class="update-form">
                <input type="hidden" name="id" value="${vegetable.id}">

                <div class="form-group">
                    <label for="name">Tên sản phẩm:</label>
                    <input type="text" id="name" name="name" class="form-control" 
                           value="${vegetable.name}" required>
                </div>

                <div class="form-group">
                    <label for="price">Giá (VNĐ):</label>
                    <input type="number" id="price" name="price" class="form-control" 
                           value="${vegetable.price}" min="0" step="1000" required>
                </div>

                <div class="form-group">
                    <label for="description">Mô tả:</label>
                    <textarea id="description" name="description" class="form-control" 
                              required>${vegetable.description}</textarea>
                </div>

                <div class="form-group">
                    <label for="imgSrc">Link hình ảnh:</label>
                    <input type="text" id="imgSrc" name="imgSrc" class="form-control" 
                           value="${vegetable.imgSrc}" required>
                    <img src="${vegetable.imgSrc}" alt="Preview" class="preview-image">
                </div>

                <div class="form-group">
                    <div class="status-toggle">
                        <label for="status">Còn hàng:</label>
                        <input type="checkbox" id="status" name="status" 
                               ${vegetable.status ? 'checked' : ''}>
                    </div>
                </div>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        ${error}
                    </div>
                </c:if>
                <div class="btn-container">
                    <a href="ViewDetails?id=${vegetable.id}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Lưu thay đổi
                    </button>
                    <a href="deleteVegetable?id=${vegetable.id}" 
                       class="btn btn-danger" 
                       onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                        <i class="fas fa-trash"></i> Xóa
                    </a>
                </div>

            </form>
        </div>

        <footer>
            <jsp:include flush="true" page="footer.jsp"/>
        </footer>
    </body>
</html>