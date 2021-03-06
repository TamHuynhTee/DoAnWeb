//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace NhaThuoc.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Thuoc
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Thuoc()
        {
            this.DanhGiaSPs = new HashSet<DanhGiaSP>();
            this.GioHangs = new HashSet<GioHang>();
        }
    
        public int MaSP { get; set; }
        public string TenSP { get; set; }
        public Nullable<System.DateTime> NgaySX { get; set; }
        public Nullable<System.DateTime> HanSD { get; set; }
        public Nullable<double> DonGia { get; set; }
        public string Loai { get; set; }
        public Nullable<int> TrongKho { get; set; }
        public string AnhMinhHoa { get; set; }
        public Nullable<int> DaBan { get; set; }
        public string CongDung { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DanhGiaSP> DanhGiaSPs { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GioHang> GioHangs { get; set; }
        public virtual Loai Loai1 { get; set; }
    }
}
