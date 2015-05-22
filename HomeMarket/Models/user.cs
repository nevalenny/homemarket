namespace HomeMarket.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class User
    {
        public User()
        {
            Orders = new HashSet<Order>();
        }

        public Guid UserID { get; set; }

        [StringLength(50)]
        public string UserName { get; set; }

        public Guid? ApplicationID { get; set; }

        public bool? IsAnonymous { get; set; }

        public DateTime? LastActivityDate { get; set; }

        public decimal WalletBalance { get; set; }

        [Required]
        public string AvatarPicture { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
    }
}
