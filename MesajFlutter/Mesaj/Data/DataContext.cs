using Mesaj.Entities;
using Microsoft.EntityFrameworkCore;
namespace Mesaj.Data
{
    public class DataContext:DbContext
    {
        public DbSet<Kullanici> kullanicilar { get; set; }
        public DbSet<Lig> ligTablosu { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Server=EMIN;Database=Mesaj;Trusted_Connection=True;TrustServerCertificate=True");
            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Kullanici>().ToTable("Kullanicilar");
            modelBuilder.Entity<Kullanici>().HasKey(a => a.ID);
            modelBuilder.Entity<Kullanici>().Property(a => a.AdSoyad).HasMaxLength(50).IsRequired(true);
            modelBuilder.Entity<Kullanici>().Property(a => a.KullaniciAdi).HasMaxLength(15).IsRequired(true);
            modelBuilder.Entity<Kullanici>().Property(a => a.Eposta).HasMaxLength(50).IsRequired(true);
            modelBuilder.Entity<Kullanici>().Property(a => a.Parola).HasMaxLength(16).IsRequired(true);

            modelBuilder.Entity<Lig>().ToTable("LigTablosu");
            modelBuilder.Entity<Lig>().HasKey(a => a.ID);
            modelBuilder.Entity<Lig>().Property(a => a.TakimAdi).HasMaxLength(50).IsRequired(true);
            modelBuilder.Entity<Lig>().Property(a => a.TakimOyananan).IsRequired(true);
            modelBuilder.Entity<Lig>().Property(a => a.TakimGalibiyet).IsRequired(true);
            modelBuilder.Entity<Lig>().Property(a => a.TakimBeraberlik).IsRequired(true);
            modelBuilder.Entity<Lig>().Property(a => a.TakimMalubiyet).IsRequired(true);
            modelBuilder.Entity<Lig>().Property(a => a.TakimAtilanGol).IsRequired(true);
            modelBuilder.Entity<Lig>().Property(a => a.TakimYenenGol).IsRequired(true);
            modelBuilder.Entity<Lig>().Property(a => a.TakimAveraj).IsRequired(true);
            modelBuilder.Entity<Lig>().Property(a => a.TakimPuan).IsRequired(true);
        }
    }
}
