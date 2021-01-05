using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using NhaThuoc.Models;

namespace NhaThuoc.Controllers
{
    public class KhachHangController : Controller
    {
        NHATHUOCEntities db = new NHATHUOCEntities();

        /* Update info right after registration */
        [HttpGet]
        [Authorize]
        public ActionResult InfoRegister(string username)
        {
            if (username.Equals(""))
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            ViewBag.username = username;
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public ActionResult InfoRegister(CustomerModel customer)
        {
            KhachHang khachHang = new KhachHang();
            khachHang.Ho_TenDem = customer.LastName;
            khachHang.TenKH = customer.FirstName;
            khachHang.SDT = customer.Phone;
            khachHang.GioiTinh = customer.Gender;
            khachHang.DiaChi = customer.Address;
            khachHang.NgaySinh = customer.Birthday;
            khachHang.AnhDaiDien = "/images/avatar_icon.png";
            khachHang.SoLanHuyDon = 0;
            khachHang.Username = User.Identity.Name;
            db.KhachHangs.Add(khachHang);
            db.SaveChanges();
            return RedirectToAction("Index", "Home");
        }
    }
}