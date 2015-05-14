namespace HomeMarket.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class user
    {
        public user()
        {
            orders = new HashSet<order>();
        }

        public int ID { get; set; }

        public Guid Guid { get; set; }

        public bool isAdmin { get; set; }

        [Required]
        public string Name { get; set; }

        [Column("E-mail")]
        [Required]
        public string E_mail { get; set; }

        public bool isEmailConfirmed { get; set; }

        [Required]
        public string PasswordHash { get; set; }

        public DateTime CreatedOn { get; set; }

        public DateTime ChangedOn { get; set; }

        public DateTime? DeletedOn { get; set; }

        public DateTime? LastLoginOn { get; set; }

        public decimal WalletBalance { get; set; }

        [Required]
        public string AvatarPicture { get; set; }

        public virtual ICollection<order> orders { get; set; }
    }
}
