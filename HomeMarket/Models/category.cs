namespace HomeMarket.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class category
    {
        public category()
        {
            goods1 = new HashSet<Good>();
        }

        public int ID { get; set; }

        [Required]
        public string Name { get; set; }

        public string Description { get; set; }

        public string Picture { get; set; }

        public string Goods { get; set; }

        public bool isVisible { get; set; }

        public bool isDeleted { get; set; }

        public virtual ICollection<Good> goods1 { get; set; }
    }
}
