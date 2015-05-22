namespace HomeMarket.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class UsersOpenAuthAccount
    {
        [Key]
        [Column(Order = 0)]
        public string ApplicationName { get; set; }

        [Key]
        [Column(Order = 1)]
        public string ProviderName { get; set; }

        [Key]
        [Column(Order = 2)]
        public string ProviderUserId { get; set; }

        [Required]
        public string ProviderUserName { get; set; }

        [Required]
        [StringLength(128)]
        public string MembershipUserName { get; set; }

        public DateTime? LastUsedUtc { get; set; }

        public virtual UsersOpenAuthData UsersOpenAuthData { get; set; }
    }
}
