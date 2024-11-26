//package format;
//
//public class DescriptionFormatter {
//
//    public static String formatVegetableDescription(String rawDescription) {
//        if (rawDescription == null || rawDescription.trim().isEmpty()) {
//            return "";
//        }
//
//        StringBuilder sb = new StringBuilder();
//
//        // Chuyển text về chữ thường và chuẩn hóa
//        String text = normalizeText(rawDescription.toLowerCase());
//
//        try {
//            // Tách và format từng phần
//            String[] parts = extractParts(text);
//
//            // Phần nguồn gốc
//            if (parts[0] != null) {
//                sb.append("<strong>Nguồn gốc và đặc điểm:</strong>\n");
//                sb.append(capitalizeFirstLetter(parts[0])).append("\n\n");
//            }
//
//            // Phần đặc điểm sinh trưởng
//            if (parts[1] != null) {
//                sb.append("<strong>Đặc điểm sinh trưởng:</strong>\n");
//                sb.append(capitalizeFirstLetter(parts[1])).append("\n\n");
//            }
//
//            // Phần cách sử dụng
//            if (parts[2] != null) {
//                sb.append("<strong>Cách sử dụng:</strong>\n");
//                String[] dishes = parts[2].split(",|\\.");
//                sb.append("Ở Việt Nam, thường được chế biến thành các món ăn như:\n");
//                for (String dish : dishes) {
//                    dish = dish.trim();
//                    if (!dish.isEmpty() && !dish.toLowerCase().startsWith("ở việt nam")) {
//                        sb.append("- ").append(capitalizeFirstLetter(dish)).append("\n");
//                    }
//                }
//                sb.append("\n");
//            }
//
//            // Phần chú ý
//            if (parts[3] != null) {
//                sb.append("<strong>Chú ý khi dùng:</strong>\n");
//                String[] notes = parts[3].split("\\.");
//                for (String note : notes) {
//                    note = note.trim();
//                    if (!note.isEmpty() && !note.toLowerCase().startsWith("chú ý")) {
//                        sb.append("- ").append(capitalizeFirstLetter(note)).append(".\n");
//                    }
//                }
//            }
//
//        } catch (Exception e) {
//            return capitalizeFirstLetter(text);
//        }
//
//        return sb.toString();
//    }
//
//    private static String normalizeText(String text) {
//        return text
//                .replace(" cm", "cm")
//                .replace(" - ", "-")
//                .replace("việt nam", "Việt Nam")
//                .replace("ấn độ", "Ấn Độ")
//                .replace("trung quốc", "Trung Quốc")
//                .replace("  ", " ")
//                .trim();
//    }
//
//    private static String capitalizeFirstLetter(String text) {
//        if (text == null || text.isEmpty()) {
//            return text;
//        }
//        return text.substring(0, 1).toUpperCase() + text.substring(1);
//    }
//
//    private static String[] extractParts(String text) {
//        String[] parts = new String[4];
//
//        // Tìm các từ khóa để tách phần
//        String[] keywords = {
//            "nguồn gốc", "đặc điểm",
//            "sử dụng", "chế biến",
//            "chú ý", "lưu ý"
//        };
//
//        int currentStart = 0;
//        int currentPart = 0;
//
//        for (int i = 0; i < text.length() && currentPart < 4; i++) {
//            for (String keyword : keywords) {
//                if (i + keyword.length() <= text.length()
//                        && text.substring(i, i + keyword.length()).equalsIgnoreCase(keyword)) {
//                    if (currentPart > 0) {
//                        parts[currentPart - 1] = text.substring(currentStart, i).trim();
//                    }
//                    currentStart = i;
//                    currentPart++;
//                    break;
//                }
//            }
//        }
//
//        // Thêm phần còn lại
//        if (currentPart > 0 && currentStart < text.length()) {
//            parts[currentPart - 1] = text.substring(currentStart).trim();
//        }
//
//        return parts;
//    }
//}
