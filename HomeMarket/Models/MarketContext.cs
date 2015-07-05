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

        public virtual DbSet<Application> Applications { get; set; }
        public virtual DbSet<category> categories { get; set; }
        public virtual DbSet<Good> goods { get; set; }
        public virtual DbSet<Membership> Memberships { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<Profile> Profiles { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<UsersOpenAuthAccount> UsersOpenAuthAccounts { get; set; }
        public virtual DbSet<UsersOpenAuthData> UsersOpenAuthDatas { get; set; }
        public virtual DbSet<CartItem> CartItems { get; set; }

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

            modelBuilder.Entity<Good>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<Good>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<Good>()
                .Property(e => e.Price)
                .HasPrecision(16, 2);

            modelBuilder.Entity<Good>()
                .Property(e => e.Picture)
                .IsUnicode(false);

            modelBuilder.Entity<Order>()
                .Property(e => e.Price)
                .HasPrecision(16, 2);

            modelBuilder.Entity<User>()
                .Property(e => e.UserName)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.WalletBalance)
                .HasPrecision(16, 2);

            modelBuilder.Entity<User>()
                .Property(e => e.AvatarPicture)
                .IsUnicode(false);

            modelBuilder.Entity<UsersOpenAuthData>()
                .HasMany(e => e.UsersOpenAuthAccounts)
                .WithRequired(e => e.UsersOpenAuthData)
                .HasForeignKey(e => new { e.ApplicationName, e.MembershipUserName });
        }
    }
}
