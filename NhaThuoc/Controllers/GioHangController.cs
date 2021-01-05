using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NhaThuoc.Models;

namespace NhaThuoc.Controllers
{
    public class GioHangController : Controller
    {
        NHATHUOCEntities db = new NHATHUOCEntities();
        /* makh's cart detail */
        [Authorize(Roles = "user")]
        public ActionResult Index(int makh)
        {
            var gh = (from u in db.GioHangs where u.MaKH == makh && u.MaHD == null select u).ToList();
            double total_money = 0;
            int total_item = gh.Count, total_quantity = 0;
            foreach(var item in gh)
            {
                total_quantity += item.SoLuong;
                total_money += item.ThanhTien;
            }
            ViewBag.item = total_item;
            ViewBag.quantity = total_quantity;
            ViewBag.money = total_money;
            return PartialView("~/Views/Partial/_CartDetail.cshtml", gh);
        }

        /* add masp to makh's cart */
        [Authorize(Roles = "user")]
        public JsonResult AddtoCart(int makh, int masp, int soluong)
        {
            // Find product
            var thuoc = db.Thuocs.Find(masp);
            if (thuoc.TrongKho < soluong)
            {
                return Json(new { success = false, responseText = "Không đủ thuốc, rất xin lỗi quý khách." }, JsonRequestBehavior.AllowGet);
            }
            // Update quantity if exist masp in makh's cart
            if (existInCart(makh, masp) != null)
            {
                existInCart(makh, masp).ThoiGianCapNhat = DateTime.Now;
                existInCart(makh, masp).SoLuong += soluong;
                existInCart(makh, masp).ThanhTien += soluong * thuoc.DonGia.Value;
                db.Entry(existInCart(makh, masp)).State = EntityState.Modified;
            }
            else
            {
                GioHang gh = new GioHang();
                gh.MaKH = makh;
                gh.MaSP = masp;
                gh.SoLuong = soluong;
                gh.DonGia = thuoc.DonGia.Value;
                gh.ThoiGianCapNhat = DateTime.Now;
                gh.ThanhTien = soluong * thuoc.DonGia.Value;
                db.GioHangs.Add(gh);
            }
            thuoc.TrongKho -= soluong;
            db.Entry(thuoc).State = EntityState.Modified;
            db.SaveChanges();
            var count = (from u in db.GioHangs where u.MaKH == makh && u.MaHD == null select u).Count();
            return Json(new { success = true, responseText = "Thêm vào giỏ thành công.", count = count }, JsonRequestBehavior.AllowGet);
        }

        [NonAction]
        public GioHang existInCart(int kh, int thuoc)
        {
            return (from u in db.GioHangs
                    where u.MaKH == kh && u.MaSP == thuoc && u.MaHD == null
                    select u).FirstOrDefault();
        }

        /* Update cart's quantity */
        [Authorize(Roles = "user")]
        public JsonResult UpdateCart(int gh, int soluong, double dongia, int kh)
        {
            var cart = db.GioHangs.Find(gh);
            var sp = db.Thuocs.Find(cart.MaSP);
            sp.TrongKho -= (soluong - cart.SoLuong);
            cart.SoLuong += (soluong - cart.SoLuong);
            cart.ThanhTien = cart.SoLuong * dongia;
            cart.ThoiGianCapNhat = DateTime.Now;
            db.Entry(cart).State = EntityState.Modified;
            db.Entry(sp).State = EntityState.Modified;
            db.SaveChanges();
            double total_money = 0;
            int total_quantity = 0;
            var gio = (from u in db.GioHangs where u.MaKH == kh && u.MaHD == null select u).ToList();
            foreach (var item in gio)
            {
                total_quantity += item.SoLuong;
                total_money += item.ThanhTien;
            }
            return Json(new { quantity = total_quantity, money = total_money.ToString("0#,0"), purchase = cart.ThanhTien.ToString("0#,0") }, JsonRequestBehavior.AllowGet);
        }

        /* Delete gh from kh's cart */
        [Authorize(Roles = "user")]
        public JsonResult Delete(int gh, int kh)
        {
            var cart = db.GioHangs.Find(gh);
            var thuoc = db.Thuocs.Find(cart.MaSP);
            thuoc.TrongKho += cart.SoLuong;
            db.Entry(thuoc).State = EntityState.Modified;
            db.GioHangs.Remove(cart);
            db.SaveChanges();
            var gio = (from u in db.GioHangs where u.MaKH == kh && u.MaHD == null select u).ToList();
            double total_money = 0;
            int total_item = gio.Count, total_quantity = 0;
            foreach (var item in gio)
            {
                total_quantity += item.SoLuong;
                total_money += item.ThanhTien;
            }
            return Json(new { item = total_item, quantity = total_quantity, money = total_money.ToString("0#,0") }, JsonRequestBehavior.AllowGet);
        }

        /* Preview bill */
        [Authorize(Roles = "user")]
        public PartialViewResult CreateBill(int kh)
        {
            var khachhang = db.KhachHangs.Find(kh);
            var giohang = (from u in db.GioHangs where u.MaKH == kh && u.MaHD == null select u).ToList();
            double total_money = 0;
            int total_item = giohang.Count, total_quantity = 0;
            foreach ( var item in giohang)
            {
                total_money += item.ThanhTien;
                total_quantity += item.SoLuong;
            }
            OrderInfoModel hoadon = new OrderInfoModel{ 
                khach = khachhang,
                gio = giohang, 
                tongSL = total_quantity, 
                tongSP = total_item,
                tongTien = total_money};
            return PartialView("~/Views/Partial/_InvoiceReview.cshtml", hoadon);
        }

        /* Confirm payment */
        [Authorize(Roles = "user")]
        public JsonResult Purchase(int kh, string tenkh, string SDT, string email, string diachinhan)
        {
            var giohang = (from u in db.GioHangs where u.MaKH == kh && u.MaHD == null select u).ToList();
            double total_money = 0;
            foreach (var item in giohang)
            {
                total_money += item.ThanhTien;
            }
            HoaDon hd = new HoaDon();
            hd.MaKH = kh;
            hd.TenKhach = tenkh;
            hd.SDTDatHang = SDT;
            hd.EmailXacNhan = email;
            hd.DiaChiNhanHang = diachinhan;
            hd.TongThanhToan = total_money;
            hd.TrangThai = "Đã nhận đơn";
            hd.NgayLapHD = DateTime.Now;
            db.HoaDons.Add(hd);
            db.SaveChanges();
            foreach (var item in giohang)
            {
                item.MaHD = hd.MaHD;
                db.Entry(item).State = EntityState.Modified;
            }
            db.SaveChanges();
            return Json(JsonRequestBehavior.AllowGet);
        }
    }
}