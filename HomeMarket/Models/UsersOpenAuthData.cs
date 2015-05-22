namespace HomeMarket.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("UsersOpenAuthData")]
    public partial class UsersOpenAuthData
    {
        public UsersOpenAuthData()
        {
            UsersOpenAuthAccounts = new HashSet<UsersOpenAuthAccount>();
        }

        [Key]
        [Column(Order = 0)]
        public string ApplicationName { get; set; }

        [Key]
        [Column(Order = 1)]
        public string MembershipUserName { get; set; }

        public bool HasLocalPassword { get; set; }

        public virtual ICollection<UsersOpenAuthAccount> UsersOpenAuthAccounts { get; set; }
    }
}
