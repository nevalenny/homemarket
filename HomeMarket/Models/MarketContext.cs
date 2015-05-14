namespace HomeMarket.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class MarketContext : DbContext
    {
        public MarketContext()
            : base("name=MarketContext")
        {
        }

        public virtual DbSet<category> categories { get; set; }
        public virtual DbSet<good> goods { get; set; }
        public virtual DbSet<order> orders { get; set; }
        public virtual DbSet<user> users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<category>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<category>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<category>()
                .Property(e => e.Picture)
                .IsUnicode(false);

            modelBuilder.Entity<category>()
                .Property(e => e.Goods)
                .IsUnicode(false);

            modelBuilder.Entity<category>()
                .HasMany(e => e.goods1)
                .WithRequired(e => e.category)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<good>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<good>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<good>()
                .Property(e => e.Price)
                .HasPrecision(16, 2);

            modelBuilder.Entity<good>()
                .Property(e => e.Picture)
                .IsUnicode(false);

            modelBuilder.Entity<order>()
                .Property(e => e.Price)
                .HasPrecision(16, 2);

            modelBuilder.Entity<user>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<user>()
                .Property(e => e.E_mail)
                .IsUnicode(false);

            modelBuilder.Entity<user>()
                .Property(e => e.PasswordHash)
                .IsUnicode(false);

            modelBuilder.Entity<user>()
                .Property(e => e.WalletBalance)
                .HasPrecision(16, 2);

            modelBuilder.Entity<user>()
                .Property(e => e.AvatarPicture)
                .IsUnicode(false);
        }
    }
}
