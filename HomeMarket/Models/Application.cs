namespace HomeMarket.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Application
    {
        public Guid ApplicationId { get; set; }

        [Required]
        [StringLength(235)]
        public string ApplicationName { get; set; }

        [StringLength(256)]
        public string Description { get; set; }
    }
}
