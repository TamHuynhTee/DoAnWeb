USE [master]
GO
/****** Object:  Database [NHATHUOC]    Script Date: 1/5/2021 10:05:58 PM ******/
CREATE DATABASE [NHATHUOC]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NHATHUOC', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\NHATHUOC.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NHATHUOC_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\NHATHUOC_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [NHATHUOC] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NHATHUOC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NHATHUOC] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NHATHUOC] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NHATHUOC] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NHATHUOC] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NHATHUOC] SET ARITHABORT OFF 
GO
ALTER DATABASE [NHATHUOC] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NHATHUOC] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NHATHUOC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NHATHUOC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NHATHUOC] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NHATHUOC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NHATHUOC] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NHATHUOC] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NHATHUOC] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NHATHUOC] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NHATHUOC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NHATHUOC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NHATHUOC] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NHATHUOC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NHATHUOC] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NHATHUOC] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NHATHUOC] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NHATHUOC] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NHATHUOC] SET  MULTI_USER 
GO
ALTER DATABASE [NHATHUOC] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NHATHUOC] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NHATHUOC] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NHATHUOC] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NHATHUOC] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [NHATHUOC] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [NHATHUOC] SET QUERY_STORE = OFF
GO
USE [NHATHUOC]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 1/5/2021 10:05:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[MaAD] [int] IDENTITY(1,1) NOT NULL,
	[Ho_TenDem] [nvarchar](30) NULL,
	[TenAD] [nvarchar](20) NULL,
	[SDT] [char](10) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[Username] [varchar](50) NULL,
	[GioiTinh] [bit] NULL,
	[NgaySinh] [date] NULL,
	[AnhDaiDien] [varchar](50) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[MaAD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhGiaSP]    Script Date: 1/5/2021 10:05:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGiaSP](
	[TaiKhoan] [varchar](50) NOT NULL,
	[MaSP] [int] NOT NULL,
	[NoiDungDinhGia] [nvarchar](300) NOT NULL,
	[ThoiGianDang] [datetime] NOT NULL,
 CONSTRAINT [PK_DanhGiaSP] PRIMARY KEY CLUSTERED 
(
	[TaiKhoan] ASC,
	[MaSP] ASC,
	[NoiDungDinhGia] ASC,
	[ThoiGianDang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoanhThu]    Script Date: 1/5/2021 10:05:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoanhThu](
	[Ngay] [date] NOT NULL,
	[DoanhThuNgay] [float] NULL,
 CONSTRAINT [PK_DoanhThu] PRIMARY KEY CLUSTERED 
(
	[Ngay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 1/5/2021 10:05:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioHang](
	[MaGH] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NOT NULL,
	[MaSP] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [float] NOT NULL,
	[ThanhTien] [float] NOT NULL,
	[ThoiGianCapNhat] [datetime] NOT NULL,
	[MaHD] [int] NULL,
 CONSTRAINT [PK_GioHang] PRIMARY KEY CLUSTERED 
(
	[MaGH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 1/5/2021 10:05:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHD] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NULL,
	[NgayLapHD] [datetime] NULL,
	[TenKhach] [nvarchar](50) NULL,
	[SDTDatHang] [char](10) NULL,
	[EmailXacNhan] [varchar](50) NULL,
	[DiaChiNhanHang] [nvarchar](200) NULL,
	[TongThanhToan] [float] NULL,
	[TrangThai] [nvarchar](50) NULL,
	[NgayNhanHang] [date] NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 1/5/2021 10:05:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[Ho_TenDem] [nvarchar](30) NULL,
	[TenKH] [nvarchar](20) NULL,
	[SDT] [char](10) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[Username] [varchar](50) NOT NULL,
	[GioiTinh] [bit] NULL,
	[NgaySinh] [date] NULL,
	[AnhDaiDien] [varchar](50) NULL,
	[SoLanHuyDon] [smallint] NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loai]    Script Date: 1/5/2021 10:05:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loai](
	[MaLoai] [varchar](10) NOT NULL,
	[TenLoai] [nvarchar](100) NULL,
 CONSTRAINT [PK_Loai] PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 1/5/2021 10:05:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Role] [varchar](30) NOT NULL,
	[Last_Login] [datetime] NULL,
	[Block] [bit] NOT NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Thuoc]    Script Date: 1/5/2021 10:05:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thuoc](
	[MaSP] [int] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](100) NULL,
	[NgaySX] [date] NULL,
	[HanSD] [date] NULL,
	[DonGia] [float] NULL,
	[Loai] [varchar](10) NULL,
	[TrongKho] [int] NULL,
	[AnhMinhHoa] [nvarchar](50) NULL,
	[DaBan] [int] NULL,
	[CongDung] [nvarchar](200) NULL,
 CONSTRAINT [PK_Thuoc] PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([MaAD], [Ho_TenDem], [TenAD], [SDT], [DiaChi], [Username], [GioiTinh], [NgaySinh], [AnhDaiDien]) VALUES (1, N'Huỳnh Thanh', N'Tâm', N'0347933844', N'Bà Rịa', N'tamhuynh', 0, CAST(N'2000-05-26' AS Date), N'/images/tamhuynh.png')
INSERT [dbo].[Admin] ([MaAD], [Ho_TenDem], [TenAD], [SDT], [DiaChi], [Username], [GioiTinh], [NgaySinh], [AnhDaiDien]) VALUES (2, N'Hồ Duy', N'Tân', N'0264322355', N'Tiền Giang', N'tanho', 0, CAST(N'2000-11-11' AS Date), N'/images/avatar_icon.png')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
INSERT [dbo].[DanhGiaSP] ([TaiKhoan], [MaSP], [NoiDungDinhGia], [ThoiGianDang]) VALUES (N'anhdo', 1, N'hihi', CAST(N'2021-01-04T08:45:59.850' AS DateTime))
INSERT [dbo].[DanhGiaSP] ([TaiKhoan], [MaSP], [NoiDungDinhGia], [ThoiGianDang]) VALUES (N'binhpham', 1, N'awd', CAST(N'2020-12-27T12:19:41.773' AS DateTime))
INSERT [dbo].[DanhGiaSP] ([TaiKhoan], [MaSP], [NoiDungDinhGia], [ThoiGianDang]) VALUES (N'binhpham', 1, N'test2', CAST(N'2020-12-27T12:21:07.477' AS DateTime))
INSERT [dbo].[DanhGiaSP] ([TaiKhoan], [MaSP], [NoiDungDinhGia], [ThoiGianDang]) VALUES (N'ducphung', 1, N'Sản phẩm này khá tốt', CAST(N'2021-01-04T10:22:08.050' AS DateTime))
INSERT [dbo].[DanhGiaSP] ([TaiKhoan], [MaSP], [NoiDungDinhGia], [ThoiGianDang]) VALUES (N'ducphung', 2, N'hết ho cmnr', CAST(N'2020-12-26T14:51:16.733' AS DateTime))
INSERT [dbo].[DanhGiaSP] ([TaiKhoan], [MaSP], [NoiDungDinhGia], [ThoiGianDang]) VALUES (N'ducphung', 2, N'Thuốc này ngon nè', CAST(N'2021-01-04T08:22:34.353' AS DateTime))
INSERT [dbo].[DanhGiaSP] ([TaiKhoan], [MaSP], [NoiDungDinhGia], [ThoiGianDang]) VALUES (N'ducphung', 2, N'tui ho quá', CAST(N'2020-12-26T14:51:09.490' AS DateTime))
INSERT [dbo].[DanhGiaSP] ([TaiKhoan], [MaSP], [NoiDungDinhGia], [ThoiGianDang]) VALUES (N'ducphung', 46, N'cái này có công dụng gì vậy ạ?', CAST(N'2021-01-01T14:26:03.530' AS DateTime))
GO
INSERT [dbo].[DoanhThu] ([Ngay], [DoanhThuNgay]) VALUES (CAST(N'2020-12-29' AS Date), 250000)
INSERT [dbo].[DoanhThu] ([Ngay], [DoanhThuNgay]) VALUES (CAST(N'2021-01-01' AS Date), 514000)
INSERT [dbo].[DoanhThu] ([Ngay], [DoanhThuNgay]) VALUES (CAST(N'2021-01-04' AS Date), 420000)
GO
SET IDENTITY_INSERT [dbo].[GioHang] ON 

INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (1, 1, 1, 3, 30000, 90000, CAST(N'2020-12-27T16:46:01.327' AS DateTime), 1)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (3, 1, 3, 2, 50000, 100000, CAST(N'2020-12-27T16:46:03.633' AS DateTime), 1)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (11, 0, 1, 2, 30000, 60000, CAST(N'2020-12-28T08:33:23.447' AS DateTime), 2)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (16, 3, 2, 3, 40000, 120000, CAST(N'2021-01-01T14:17:09.280' AS DateTime), 5)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (17, 3, 1, 3, 30000, 90000, CAST(N'2021-01-01T14:25:31.700' AS DateTime), 6)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (18, 3, 18, 2, 46000, 92000, CAST(N'2021-01-01T14:25:29.877' AS DateTime), 6)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (19, 3, 20, 1, 152000, 152000, CAST(N'2021-01-01T14:25:35.800' AS DateTime), 6)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (20, 3, 46, 3, 20000, 60000, CAST(N'2021-01-01T14:25:48.410' AS DateTime), 6)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (23, 1, 1, 1, 30000, 30000, CAST(N'2021-01-04T08:45:53.253' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (25, 3, 26, 4, 95000, 380000, CAST(N'2021-01-04T08:58:25.467' AS DateTime), 9)
INSERT [dbo].[GioHang] ([MaGH], [MaKH], [MaSP], [SoLuong], [DonGia], [ThanhTien], [ThoiGianCapNhat], [MaHD]) VALUES (27, 3, 2, 1, 40000, 40000, CAST(N'2021-01-04T10:31:45.780' AS DateTime), 11)
SET IDENTITY_INSERT [dbo].[GioHang] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayLapHD], [TenKhach], [SDTDatHang], [EmailXacNhan], [DiaChiNhanHang], [TongThanhToan], [TrangThai], [NgayNhanHang]) VALUES (1, 1, CAST(N'2020-12-27T18:06:38.100' AS DateTime), N'Đỗ Đức Anh', N'0111111112', N'anh@gmail.com', N'Vĩnh Long', 190000, N'Đã giao hàng', CAST(N'2020-12-29' AS Date))
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayLapHD], [TenKhach], [SDTDatHang], [EmailXacNhan], [DiaChiNhanHang], [TongThanhToan], [TrangThai], [NgayNhanHang]) VALUES (2, 0, CAST(N'2020-12-28T08:34:12.430' AS DateTime), N'Phạm Nhật Bình', N'0555555555', N'binh@gmail.com', N'Bình Phước', 60000, N'Đã giao hàng', CAST(N'2020-12-29' AS Date))
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayLapHD], [TenKhach], [SDTDatHang], [EmailXacNhan], [DiaChiNhanHang], [TongThanhToan], [TrangThai], [NgayNhanHang]) VALUES (5, 3, CAST(N'2021-01-01T14:19:35.840' AS DateTime), N'Phùng Vĩnh Đức', N'0562152332', N'duc@gmail.com', N'Nha Trang', 120000, N'Đã giao hàng', CAST(N'2021-01-01' AS Date))
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayLapHD], [TenKhach], [SDTDatHang], [EmailXacNhan], [DiaChiNhanHang], [TongThanhToan], [TrangThai], [NgayNhanHang]) VALUES (6, 3, CAST(N'2021-01-01T14:27:17.007' AS DateTime), N'Phùng Vĩnh Đức', N'0562152332', N'duc@gmail.com', N'Nha Trang', 394000, N'Đã giao hàng', CAST(N'2021-01-01' AS Date))
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayLapHD], [TenKhach], [SDTDatHang], [EmailXacNhan], [DiaChiNhanHang], [TongThanhToan], [TrangThai], [NgayNhanHang]) VALUES (9, 3, CAST(N'2021-01-04T08:59:27.277' AS DateTime), N'Phùng Vĩnh Đức', N'0562152332', N'duc@gmail.com', N'Nha Trang', 380000, N'Đã giao hàng', CAST(N'2021-01-04' AS Date))
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayLapHD], [TenKhach], [SDTDatHang], [EmailXacNhan], [DiaChiNhanHang], [TongThanhToan], [TrangThai], [NgayNhanHang]) VALUES (11, 3, CAST(N'2021-01-04T10:31:54.033' AS DateTime), N'Phùng Vĩnh Đức', N'0562152332', N'duc@gmail.com', N'Nha Trang', 40000, N'Đã giao hàng', CAST(N'2021-01-04' AS Date))
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKH], [Ho_TenDem], [TenKH], [SDT], [DiaChi], [Username], [GioiTinh], [NgaySinh], [AnhDaiDien], [SoLanHuyDon]) VALUES (0, N'Phạm Nhật', N'Bình', N'0555555555', N'Bình Phước', N'binhpham', 0, CAST(N'2000-01-15' AS Date), N'/images/avatar_icon.png', 0)
INSERT [dbo].[KhachHang] ([MaKH], [Ho_TenDem], [TenKH], [SDT], [DiaChi], [Username], [GioiTinh], [NgaySinh], [AnhDaiDien], [SoLanHuyDon]) VALUES (1, N'Đỗ Đức', N'Anh', N'0111111112', N'Vĩnh Long', N'anhdo', 0, CAST(N'2000-12-04' AS Date), N'/images/avatar_icon.png', 1)
INSERT [dbo].[KhachHang] ([MaKH], [Ho_TenDem], [TenKH], [SDT], [DiaChi], [Username], [GioiTinh], [NgaySinh], [AnhDaiDien], [SoLanHuyDon]) VALUES (2, NULL, N'Đảnh', N'0235252672', N'Bà Rịa', N'danhnguyen', 0, CAST(N'2000-12-13' AS Date), N'/images/avatar_icon.png', 0)
INSERT [dbo].[KhachHang] ([MaKH], [Ho_TenDem], [TenKH], [SDT], [DiaChi], [Username], [GioiTinh], [NgaySinh], [AnhDaiDien], [SoLanHuyDon]) VALUES (3, N'Phùng Vĩnh', N'Đức', N'0562152332', N'Nha Trang', N'ducphung', 0, CAST(N'2000-01-31' AS Date), N'/images/avatar_icon.png', 3)
INSERT [dbo].[KhachHang] ([MaKH], [Ho_TenDem], [TenKH], [SDT], [DiaChi], [Username], [GioiTinh], [NgaySinh], [AnhDaiDien], [SoLanHuyDon]) VALUES (4, N'Bùi Trung', N'Hiếu', N'0253236313', N'Bà Rịa', N'hieubui', 0, CAST(N'2000-05-26' AS Date), N'/images/avatar_icon.png', 0)
INSERT [dbo].[KhachHang] ([MaKH], [Ho_TenDem], [TenKH], [SDT], [DiaChi], [Username], [GioiTinh], [NgaySinh], [AnhDaiDien], [SoLanHuyDon]) VALUES (5, N'Trần Duy Đức', N'Độ', N'0111111113', N'TPHCM', N'domixi', 0, CAST(N'2021-01-21' AS Date), N'/images/avatar_icon.png', 0)
INSERT [dbo].[KhachHang] ([MaKH], [Ho_TenDem], [TenKH], [SDT], [DiaChi], [Username], [GioiTinh], [NgaySinh], [AnhDaiDien], [SoLanHuyDon]) VALUES (6, NULL, NULL, NULL, NULL, N'tamtam', NULL, NULL, N'/images/avatar_icon.png', 0)
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'CLH', N'Cảm lạnh, ho')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'CXK', N'Cơ, xương khớp')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'DD', N'Dạ dày')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'GC', N'Giảm cân')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'GDHS', N'Giảm đau, hạ sốt')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'KDU', N'Kháng dị ứng')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'PN', N'Phụ nữ')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'SRTH', N'Siro trị ho')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'TB', N'Táo bón')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'TH', N'Tiêu hóa')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'TPCN', N'Thực phẩm chức năng')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'VK', N'Vitamin, khoáng chất')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (N'VTYT', N'Vật tư y tế')
GO
INSERT [dbo].[TaiKhoan] ([Username], [Password], [Email], [Role], [Last_Login], [Block]) VALUES (N'anhdo', N'12345', N'anh@gmail.com', N'user', CAST(N'2021-01-04T08:34:59.037' AS DateTime), 0)
INSERT [dbo].[TaiKhoan] ([Username], [Password], [Email], [Role], [Last_Login], [Block]) VALUES (N'binhpham', N'Binh12345', N'binh@gmail.com', N'user', CAST(N'2020-12-28T09:31:49.783' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([Username], [Password], [Email], [Role], [Last_Login], [Block]) VALUES (N'danhnguyen', N'12345', N'danh@gmail.com', N'user', CAST(N'2020-12-26T13:43:15.443' AS DateTime), 0)
INSERT [dbo].[TaiKhoan] ([Username], [Password], [Email], [Role], [Last_Login], [Block]) VALUES (N'domixi', N'Dodeptrai123', N'do@gmail.com', N'user', CAST(N'2021-01-04T08:49:25.953' AS DateTime), 0)
INSERT [dbo].[TaiKhoan] ([Username], [Password], [Email], [Role], [Last_Login], [Block]) VALUES (N'ducphung', N'12345', N'duc@gmail.com', N'user', CAST(N'2021-01-04T10:37:56.093' AS DateTime), 0)
INSERT [dbo].[TaiKhoan] ([Username], [Password], [Email], [Role], [Last_Login], [Block]) VALUES (N'hieubui', N'12345', N'hieu@gmail.com', N'user', NULL, 1)
INSERT [dbo].[TaiKhoan] ([Username], [Password], [Email], [Role], [Last_Login], [Block]) VALUES (N'tamhuynh', N'Vovinam2015', N'tam@gmail.com', N'admin', CAST(N'2021-01-04T10:32:18.943' AS DateTime), 0)
INSERT [dbo].[TaiKhoan] ([Username], [Password], [Email], [Role], [Last_Login], [Block]) VALUES (N'tamtam', N'123', N'tam1@gmail.com', N'user', CAST(N'2021-01-04T09:41:55.163' AS DateTime), 0)
INSERT [dbo].[TaiKhoan] ([Username], [Password], [Email], [Role], [Last_Login], [Block]) VALUES (N'tanho', N'123', N'tan@gmail.com', N'admin', CAST(N'2021-01-01T16:12:58.033' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[Thuoc] ON 

INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (1, N'Oxymetazoline', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 30000, N'CLH', 191, N'/images/sanpham/Oxymetazoline.png', 8, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (2, N'Pholcodine', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 40000, N'CLH', 96, N'/images/sanpham/Pholcodine.png', 4, N'')
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (3, N'Codein', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 50000, N'CLH', 298, N'/images/sanpham/Codein.png', 2, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (4, N'Phenylephrine', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 60000, N'CLH', 220, N'/images/sanpham/Phenylephrine.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (5, N'Pseudoephedrine', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 100000, N'CLH', 100, N'/images/sanpham/Pseudoephedrine.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (6, N'Calyptin', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 120000, N'CLH', 300, N'/images/sanpham/Calyptin.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (7, N'Neo-codion', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 20000, N'CLH', 210, N'/images/sanpham/Neo-codion.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (8, N'Dextromethorphan', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 32000, N'CLH', 300, N'/images/sanpham/Dextromethorphan.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (9, N'Chericof', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 53000, N'CLH', 500, N'/images/sanpham/Chericof.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (10, N'Eucalyptine', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 12000, N'CLH', 320, N'/images/sanpham/Eucalyptine.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (11, N'Ambroxol', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 53000, N'CLH', 500, N'/images/sanpham/Ambroxol.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (12, N'Bromhexin', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 25000, N'CLH', 230, N'/images/sanpham/Bromhexin.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (13, N'Terpinzoat', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 24000, N'CLH', 100, N'/images/sanpham/Terpinzoat.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (14, N'Jointlab', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 35000, N'CXK', 210, N'/images/sanpham/Jointlab.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (15, N'Gen S Effer', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 42000, N'CXK', 430, N'/images/sanpham/GenSEffer.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (16, N'GHV BONE', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 75000, N'CXK', 200, N'/images/sanpham/GHVBONE.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (17, N'Mộc Cốt Linh', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 45000, N'CXK', 230, N'/images/sanpham/MocCotLinh.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (18, N'XUKODA ', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 46000, N'CXK', 98, N'/images/sanpham/XUKODA.png', 2, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (19, N'Viên khớp Tâm Bình', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 86500, N'CXK', 300, N'/images/sanpham/TamBinh.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (20, N'Khang Thọ Gold', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 152000, N'CXK', 249, N'/images/sanpham/KhangTho.png', 1, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (21, N'Habelric ', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 34000, N'CXK', 320, N'/images/sanpham/Habelric.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (22, N'Thuốc xương khớp Jex Max', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 320000, N'CXK', 100, N'/images/sanpham/Jex.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (23, N'Xương khớp Nhất Nhất ', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 64000, N'CXK', 230, N'/images/sanpham/NhatNhat.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (24, N'Yumangel', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 63000, N'DD', 100, N'/images/sanpham/Yumangel.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (25, N'Phosphalugel ', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 58000, N'DD', 50, N'/images/sanpham/Phosphalugel.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (26, N'Nexium Mups', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 95000, N'DD', 146, N'/images/sanpham/NexiumMups.png', 4, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (27, N'Thuốc Gastropulgite', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 56000, N'DD', 200, N'/images/sanpham/Gastropulgite.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (28, N'Thuốc Omeprazol
', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 76000, N'DD', 200, N'/images/sanpham/Omeprazol
.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (29, N'Thuốc Suncurmin', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 53000, N'DD', 100, N'/images/sanpham/Suncurmin.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (30, N'Thuốc Maalox', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 21000, N'DD', 200, N'/images/sanpham/Maalox.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (31, N'Thuốc Gaviscon', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 50000, N'DD', 100, N'/images/sanpham/Gaviscon.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (32, N'Dạ dày Nhất Nhất', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 280000, N'DD', 150, N'/images/sanpham/NhatNhatDD.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (33, N'Thuốc Cumargold', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 142000, N'DD', 300, N'/images/sanpham/Cumargold.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (34, N'Juicy Slim', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 32000, N'GC', 300, N'/images/sanpham/JuicySlim.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (35, N'Slim Mix', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 74000, N'GC', 200, N'/images/sanpham/SlimMix.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (36, N'Diet Smart', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 174000, N'GC', 100, N'/images/sanpham/DietSmart.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (37, N'Keto Slim', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 43000, N'GC', 250, N'/images/sanpham/KetoSlim.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (38, N'Black latte', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 570000, N'GC', 50, N'/images/sanpham/Blacklatte.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (39, N'ChocoSlim', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 600000, N'GC', 60, N'/images/sanpham/ChocoSlim.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (40, N'LIC', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 450000, N'GC', 70, N'/images/sanpham/LIC.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (41, N'Rich Slim USA', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 430000, N'GC', 80, N'/images/sanpham/RichSlimUSA.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (42, N'Sumbeau', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 770000, N'GC', 35, N'/images/sanpham/Sumbeau.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (43, N'Bona', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 450000, N'GC', 65, N'/images/sanpham/Bona.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (44, N'Green Coffee Bean', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 650000, N'GC', 50, N'/images/sanpham/GreenCoffeeBean.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (45, N'Dấm đen giảm cân Orihiro Nhật Bản', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 560000, N'GC', 100, N'/images/sanpham/Orihiro.png', 0, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (46, N'Viên C sủi', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date), 20000, N'VK', 497, N'/images/sanpham/csui.png', 3, NULL)
INSERT [dbo].[Thuoc] ([MaSP], [TenSP], [NgaySX], [HanSD], [DonGia], [Loai], [TrongKho], [AnhMinhHoa], [DaBan], [CongDung]) VALUES (47, N'Paracetamol', CAST(N'2019-11-14' AS Date), CAST(N'2021-01-31' AS Date), 10000, N'GDHS', 97, N'/images/sanpham/paracetamol.png', NULL, N'Paracetamol thường được dùng qua đường uống. Trường hợp người bệnh không thể uống thuốc có thể dùng dưới dạng đặt trực tràng.')
SET IDENTITY_INSERT [dbo].[Thuoc] OFF
GO
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD  CONSTRAINT [FK_Admin_TaiKhoan] FOREIGN KEY([Username])
REFERENCES [dbo].[TaiKhoan] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Admin] CHECK CONSTRAINT [FK_Admin_TaiKhoan]
GO
ALTER TABLE [dbo].[DanhGiaSP]  WITH CHECK ADD  CONSTRAINT [FK_DanhGiaSP_TaiKhoan] FOREIGN KEY([TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DanhGiaSP] CHECK CONSTRAINT [FK_DanhGiaSP_TaiKhoan]
GO
ALTER TABLE [dbo].[DanhGiaSP]  WITH CHECK ADD  CONSTRAINT [FK_DanhGiaSP_Thuoc] FOREIGN KEY([MaSP])
REFERENCES [dbo].[Thuoc] ([MaSP])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DanhGiaSP] CHECK CONSTRAINT [FK_DanhGiaSP_Thuoc]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD  CONSTRAINT [FK_GioHang_HoaDon] FOREIGN KEY([MaHD])
REFERENCES [dbo].[HoaDon] ([MaHD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GioHang] CHECK CONSTRAINT [FK_GioHang_HoaDon]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD  CONSTRAINT [FK_GioHang_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GioHang] CHECK CONSTRAINT [FK_GioHang_KhachHang]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD  CONSTRAINT [FK_GioHang_Thuoc] FOREIGN KEY([MaSP])
REFERENCES [dbo].[Thuoc] ([MaSP])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GioHang] CHECK CONSTRAINT [FK_GioHang_Thuoc]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_DoanhThu] FOREIGN KEY([NgayNhanHang])
REFERENCES [dbo].[DoanhThu] ([Ngay])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_DoanhThu]
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD  CONSTRAINT [FK_KhachHang_TaiKhoan] FOREIGN KEY([Username])
REFERENCES [dbo].[TaiKhoan] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [FK_KhachHang_TaiKhoan]
GO
ALTER TABLE [dbo].[Thuoc]  WITH CHECK ADD  CONSTRAINT [FK_Thuoc_Loai] FOREIGN KEY([Loai])
REFERENCES [dbo].[Loai] ([MaLoai])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Thuoc] CHECK CONSTRAINT [FK_Thuoc_Loai]
GO
USE [master]
GO
ALTER DATABASE [NHATHUOC] SET  READ_WRITE 
GO
