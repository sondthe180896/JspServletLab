<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm Sản Phẩm Mới</title>
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

            .add-form {
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
                transition: background-color 0.3s ease;
            }

            .btn-primary {
                background-color: #007bff;
                color: white;
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }

            .btn:hover {
                opacity: 0.9;
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
            .form-control[type="file"] {
                padding: 8px;
                border: 1px dashed #ddd;
                background-color: #f8f9fa;
            }

            .form-control[type="file"]:hover {
                background-color: #e9ecef;
            }

            #imagePreview {
                margin-top: 10px;
            }

            #imagePreview img {
                border-radius: 4px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
        </style>
    </head>
    <body>
        <jsp:include flush="true" page="header.jsp"/>

        <div class="container" style="width: 800px">
            <h2 class="form-title">Thêm Sản Phẩm Mới</h2>

            <form action="addVegetable" method="POST" class="add-form" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="name">Tên sản phẩm:</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="price">Giá (VNĐ):</label>
                    <input type="number" id="price" name="price" class="form-control" min="0" step="1000" required>
                </div>

                <div class="form-group">
                    <label for="description">Mô tả:</label>
                    <textarea id="description" name="description" class="form-control" required></textarea>
                </div>
                <div class="form-group">
                    <label for="image">Hình ảnh:</label>
                    <input type="file" id="image" name="image" class="form-control" 
                           accept="image/*" required>
                    <div id="imagePreview" class="mt-2"></div>
                </div>

                <div class="form-group">
                    <div class="status-toggle">
                        <label for="status">Còn hàng:</label>
                        <input type="checkbox" id="status" name="status" checked>
                    </div>
                </div>

                <div class="btn-container">
                    <a href="home" class="btn btn-secondary">Hủy</a>
                    <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                </div>
            </form>
        </div>

        <footer>
            <jsp:include flush="true" page="footer.jsp"/>
        </footer>
    </body>
    <script>
        document.getElementById('image').addEventListener('change', function (e) {
            const preview = document.getElementById('imagePreview');
            preview.innerHTML = '';

            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.maxWidth = '200px';
                    img.style.marginTop = '10px';
                    preview.appendChild(img);
                }
                reader.readAsDataURL(file);
            }
        });
    </script>
</html>