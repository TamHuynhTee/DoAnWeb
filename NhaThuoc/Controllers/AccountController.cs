using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using NhaThuoc.Models;

namespace NhaThuoc.Controllers
{
    public class AccountController : Controller
    {
        NHATHUOCEntities db = new NHATHUOCEntities();

        /* Get list of accounts (admin only) */
        [Authorize(Roles = "admin")]
        public PartialViewResult listAccount()
        {
            var listAcc = (from u in db.KhachHangs select u).ToList();
            return PartialView("~/Views/Partial/Admin/_AccountManage.cshtml", listAcc);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult listAcc()
        {
            var listAcc = (from u in db.KhachHangs select u).ToList();
            return PartialView("~/Views/Partial/Admin/_AccountList.cshtml", listAcc);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult addUser()
        {
            var listAcc = (from u in db.KhachHangs select u).ToList();
            return PartialView("~/Views/Partial/Admin/_AccountAdd.cshtml", listAcc);
        }
        [Authorize(Roles = "admin")]
        public JsonResult Add(string username, string password, string email)
        {
            TaiKhoan tk = new TaiKhoan();
            tk.Username = username;
            tk.Password = password;
            tk.Email = email;
            tk.Role = "user";
            tk.Block = false;
            db.TaiKhoans.Add(tk);
            KhachHang kh = new KhachHang { Username = username, AnhDaiDien = "/images/avatar_icon.png", SoLanHuyDon = 0 };
            db.KhachHangs.Add(kh);
            db.SaveChanges();
            return Json(new { message = "Tạo tài khoản thành công" },JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "admin")]
        public JsonResult Block(int kh)
        {

            var khach = db.KhachHangs.Find(kh);
            if (khach.TaiKhoan.Block == false)
            {
                khach.TaiKhoan.Block = true;
            }
            else
            {
                khach.TaiKhoan.Block = false;
            }
            db.Entry(khach.TaiKhoan).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return Json(new { state = khach.TaiKhoan.Block }, JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult search(string text, string type)
        {
            List<KhachHang> khList = new List<KhachHang>();
            text = text.ToLower();
            switch (type)
            {
                case "username": khList = (from u in db.KhachHangs where u.Username.ToLower().Contains(text) select u).ToList(); break;
                case "name": khList = (from u in db.KhachHangs where u.TenKH.ToLower().Contains(text) select u).ToList(); break;
                case "email": khList = (from u in db.KhachHangs where u.TaiKhoan.Email.ToLower().Contains(text) select u).ToList(); break;
                case "phone": khList = (from u in db.KhachHangs where u.SDT.ToLower().Contains(text) select u).ToList(); break;
                default: break;
            }
            return PartialView("~/Views/Partial/Admin/Search/_AccountSearch.cshtml", khList);
        }

        /* Profile View */
        [Authorize]
        public ViewResult _Profile()
        {
            return View();
        }
        /* Profile Info */
        [Authorize]
        public PartialViewResult getProfile(string username)
        {
            var nick = db.TaiKhoans.Find(username);
            _ProfileModel model = new _ProfileModel();
            if (nick.Role == "admin")
            {
                var ad = (from u in db.Admins where u.Username == username select u).FirstOrDefault();
                model.Ho_Dem = ad.Ho_TenDem;
                model.Ten = ad.TenAD;
                model.SDT = ad.SDT;
                model.Email = ad.TaiKhoan.Email;
                model.DiaChi = ad.DiaChi;
                model.GioiTinh = ad.GioiTinh;
                model.AnhDaiDien = ad.AnhDaiDien;
                model.NgaySinh = ad.NgaySinh;
                model.Username = ad.Username;
            }
            else
            {
                var kh = (from u in db.KhachHangs where u.Username == username select u).FirstOrDefault();
                model.Ho_Dem = kh.Ho_TenDem;
                model.Ten = kh.TenKH;
                model.SDT = kh.SDT;
                model.Email = kh.TaiKhoan.Email;
                model.DiaChi = kh.DiaChi;
                model.GioiTinh = kh.GioiTinh;
                model.AnhDaiDien = kh.AnhDaiDien;
                model.NgaySinh = kh.NgaySinh;
                model.Username = kh.Username;
            }
            return PartialView("~/Views/Partial/_ProfileDetail.cshtml", model);
        }
        /* Profile Edit */
        [Authorize]
        public PartialViewResult Edit(string username)
        {
            var nick = db.TaiKhoans.Find(username);
            _ProfileModel model = new _ProfileModel();
            if (nick.Role == "admin")
            {
                var ad = (from u in db.Admins where u.Username == username select u).FirstOrDefault();
                model.Ho_Dem = ad.Ho_TenDem;
                model.Ten = ad.TenAD;
                model.SDT = ad.SDT;
                model.Email = ad.TaiKhoan.Email;
                model.DiaChi = ad.DiaChi;
                model.GioiTinh = ad.GioiTinh;
                model.AnhDaiDien = ad.AnhDaiDien;
                model.NgaySinh = ad.NgaySinh;
                model.Username = ad.Username;
            }
            else
            {
                var kh = (from u in db.KhachHangs where u.Username == username select u).FirstOrDefault();
                model.Ho_Dem = kh.Ho_TenDem;
                model.Ten = kh.TenKH;
                model.SDT = kh.SDT;
                model.Email = kh.TaiKhoan.Email;
                model.DiaChi = kh.DiaChi;
                model.GioiTinh = kh.GioiTinh;
                model.AnhDaiDien = kh.AnhDaiDien;
                model.NgaySinh = kh.NgaySinh;
                model.Username = kh.Username;
            }
            return PartialView("~/Views/Partial/_EditProfile.cshtml", model);
        }

        public JsonResult MakeProfileChange(string username, string fname, string lname, string phone, bool gender, DateTime birthday, string email, string addr, string avatar)
        {
            var nick = db.TaiKhoans.Find(username);
            if (nick.Role == "admin")
            {
                var ad = (from u in db.Admins where u.Username == username select u).FirstOrDefault();
                ad.Ho_TenDem = lname;
                ad.TenAD = fname;
                ad.SDT = phone;
                ad.GioiTinh = gender;
                ad.NgaySinh = birthday;
                ad.TaiKhoan.Email = email;
                ad.AnhDaiDien = avatar;
                ad.DiaChi = addr;
                db.Entry(ad).State = System.Data.Entity.EntityState.Modified;
                db.Entry(ad.TaiKhoan).State = System.Data.Entity.EntityState.Modified;
            }
            else
            {
                var kh = (from u in db.KhachHangs where u.Username == username select u).FirstOrDefault();
                kh.Ho_TenDem = lname;
                kh.TenKH = fname;
                kh.SDT = phone;
                kh.GioiTinh = gender;
                kh.NgaySinh = birthday;
                kh.TaiKhoan.Email = email;
                kh.AnhDaiDien = avatar;
                kh.DiaChi = addr;
                db.Entry(kh).State = System.Data.Entity.EntityState.Modified;
                db.Entry(kh.TaiKhoan).State = System.Data.Entity.EntityState.Modified;
            }
            db.SaveChanges();
            return Json(new { message = "Đã cập nhật" }, JsonRequestBehavior.AllowGet);
        }
        /* Profile Password change*/
        [Authorize]
        public PartialViewResult changePass()
        {
            return PartialView("~/Views/Partial/_PassChange.cshtml");
        }

        public JsonResult CheckPass(string username, string opass)
        {
            var user = db.TaiKhoans.Find(username);
            if(!user.Password.Equals(opass))
                return Json(new { status = false }, JsonRequestBehavior.AllowGet);
            return Json(new { status = true }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult MakePassChange(string username, string npass, string confirm)
        {
            var user = db.TaiKhoans.Find(username);
            if(!npass.Equals(confirm))
                return Json(new { status = false }, JsonRequestBehavior.AllowGet);
            user.Password = npass;
            db.Entry(user).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return Json(new { status = true },JsonRequestBehavior.AllowGet);
        }

        /* Login */
        [HttpGet]
        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(LoginModel model)
        {
            TaiKhoan taiKhoan = db.TaiKhoans.FirstOrDefault(x => x.Username == model.UsernameorEmail);
            if (taiKhoan == null)
            {
                taiKhoan = db.TaiKhoans.FirstOrDefault(x => x.Email == model.UsernameorEmail);
                if (taiKhoan == null)
                {
                    ModelState.AddModelError("Invalid", "Invalid username or email");
                    return View();
                }
                goto Success;
            }
        Success:
            if (taiKhoan.Password != model.Password)
            {
                ModelState.AddModelError("Invalid", "Incorrect password");
                return View();
            }
            if (taiKhoan.Block == true)
            {
                return RedirectToAction("Error", "Home");
            }
            FormsAuthentication.SetAuthCookie(taiKhoan.Username, false);
            taiKhoan.Last_Login = DateTime.Now;
            db.Entry(taiKhoan).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("Index", "Home");
        }
        /* Log out */
        [Authorize]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }

        /* Register */
        [HttpGet]
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }
        // Post
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public ActionResult Register(RegisterModel model)
        {
            TaiKhoan taiKhoan = new TaiKhoan();
            bool exists = db.TaiKhoans.Any(x => x.Username == model.Username);
            if (exists)
            {
                ModelState.AddModelError("Invalid", "Username Exists");
                return View();
            }
            exists = db.TaiKhoans.Any(x => x.Email == model.Email);
            if (exists)
            {
                ModelState.AddModelError("Invalid", "Email Exists");
                return View();
            }
            if (!(model.Password.Equals(model.ConfirmPassword)))
            {
                ModelState.AddModelError("Invalid", "Password not match");
                return View();
            }
            taiKhoan.Username = model.Username;
            taiKhoan.Password = model.Password;
            taiKhoan.Email = model.Email;
            taiKhoan.Block = false;
            taiKhoan.Role = "user";
            taiKhoan.Last_Login = DateTime.Now;
            db.TaiKhoans.Add(taiKhoan);
            db.SaveChanges();
            FormsAuthentication.SetAuthCookie(model.Username, false);
            return RedirectToAction("InfoRegister", "KhachHang", new { username = model.Username });
        }

        /* Forgot password */
        [HttpGet]
        [AllowAnonymous]
        public ActionResult ForgotPassword()
        {
            return View();
        }
        // Post
        [HttpPost]
        public ActionResult ForgotPassword(string UsernameOrEmail)
        {
            TaiKhoan myUser = db.TaiKhoans.FirstOrDefault(u => u.Username == UsernameOrEmail);
            if (myUser == null)
            {
                myUser = db.TaiKhoans.FirstOrDefault(u => u.Email == UsernameOrEmail);
                if (myUser == null)
                {
                    ModelState.AddModelError("Invalid", "Invalid username or email");
                    return View();
                }
                goto Success;
            }
        Success:
            return RedirectToAction("ResetPassword", "Account", new { username = myUser.Username });
        }
        /* Reset your password */
        [HttpGet]
        public ActionResult ResetPassword(string username)
        {
            ViewBag.username = username;
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResetPassword(string Username, string Password, string ConfirmPassword)
        {
            TaiKhoan taiKhoan = new TaiKhoan();
            taiKhoan.Username = Username;
            if (!(Password.Equals(ConfirmPassword)))
            {
                ModelState.AddModelError("Invalid", "Password not match");
                return View();
            }
            taiKhoan.Password = Password;
            db.Entry(taiKhoan).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("Index", "Home");
        }
    }
}