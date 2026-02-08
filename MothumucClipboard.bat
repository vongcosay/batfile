:: ==========================================================
:: Ten Script: MothumucClipboard.bat
:: Chuc nang: Lay duong dan tu Clipboard va mo trong Explorer
:: Tac gia: Do Nguyen
:: HƯỚNG DẪN: 
::    1. Copy một đường dẫn bất kỳ (File hoặc Thư mục).
::    2. Chạy file .bat này.
::    3. Explorer sẽ mở đúng vị trí và chọn (highlight) sẵn file bạn đã copy.
::
:: VÍ DỤ CÁC ĐƯỜNG DẪN HỖ TRỢ:
::    - C:\Users\DoNguyen\test.jsx               (Mở thư mục & chọn file)
::    - C:\Users\DoNguyen\                            (Mở thẳng thư mục)
::    - "\\DONGUYEN\Do Nguyen\Auto\test.pdf" (Hỗ trợ dấu ngoặc kép & mạng)
:: ==========================================================

@echo off
setlocal enabledelayedexpansion

:: 1. Lấy dữ liệu từ Clipboard bằng PowerShell
for /f "usebackq delims=" %%I in (`powershell -command "Get-Clipboard"`) do (
    set "clipData=%%I"
)

:: 2. Kiểm tra nếu Clipboard trống
if not defined clipData (
    echo Clipboard dang trong!
    pause
    exit /b
)

:: 3. Làm sạch đường dẫn (Xóa dấu ngoặc kép nếu có)
set "clipData=%clipData:"=%"

:: 4. Kiểm tra đường dẫn tồn tại (File hoặc Folder)
if not exist "%clipData%" (
    echo Duong dan khong ton tai: "%clipData%"
    pause
    exit /b
)

:: 5. Xử lý mở Windows Explorer
:: Nếu là thư mục (kết thúc bằng \), mở thư mục đó.
:: Nếu là file, mở thư mục cha và bôi đen file đó.
echo Dang mo: "%clipData%"

if exist "%clipData%\" (
    :: Truong hop la thu muc
    explorer.exe "%clipData%"
) else (
    :: Truong hop la file
    explorer.exe /select,"%clipData%"
)

exit /b



