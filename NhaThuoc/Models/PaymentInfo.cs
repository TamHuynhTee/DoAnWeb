using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhaThuoc.Models
{
    public class PaymentInfo
    {
        public HoaDon hd { get; set; }
        public List<GioHang> gio { get; set; }
        public int tongSP { get; set; }
        public int tongSL { get; set; }
    }
}