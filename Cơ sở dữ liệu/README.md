**BÀI TẬP THỰC HÀNH MÔN HỌC CƠ SỞ DỮ LIỆU**

**Cơ sở dữ liệu quản lý bán hàng ( QLBH )** gồm có các quan hệ sau:

**KHACHHANG** (MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK)
Tân từ: Quan hệ khách hàng sẽ lưu trữ thông tin của khách hàng thành viên gồm có các thuộc tính: mã khách hàng, họ tên, địa chỉ, số điện thoại, ngày sinh, ngày đăng ký và doanh số (tổng trị giá các hóa đơn của khách hàng thành viên này).

**NHANVIEN** (MANV,HOTEN, NGVL, SODT)
Tân từ: Mỗi nhân viên bán hàng cần ghi nhận họ tên, ngày vào làm, điện thọai liên lạc, mỗi nhân viên phân biệt với nhau bằng mã nhân viên.

**SANPHAM** (MASP,TENSP, DVT, NUOCSX, GIA)
Tân từ: Mỗi sản phẩm có một mã số, một tên gọi, đơn vị tính, nước sản xuất và một giá bán.

**HOADON** (SOHD, NGHD, MAKH, MANV, TRIGIA)
Tân từ: Khi mua hàng, mỗi khách hàng sẽ nhận một hóa đơn tính tiền, trong đó sẽ có số hóa đơn, ngày mua, nhân viên nào bán hàng, trị giá của hóa đơn là bao nhiêu và mã số của khách hàng nếu là khách hàng thành viên.

**CTHD** (SOHD,MASP,SL)
Tân từ: Diễn giải chi tiết trong mỗi hóa đơn gồm có những sản phẩm gì với số lượng là bao nhiêu.

![image](https://github.com/user-attachments/assets/d33d617a-7757-442d-a8c9-4b634927faca)

