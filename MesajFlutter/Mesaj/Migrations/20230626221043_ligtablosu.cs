using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mesaj.Migrations
{
    /// <inheritdoc />
    public partial class ligtablosu : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "LigTablosu",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TakimAdi = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    TakimOyananan = table.Column<int>(type: "int", nullable: false),
                    TakimGalibiyet = table.Column<int>(type: "int", nullable: false),
                    TakimBeraberlik = table.Column<int>(type: "int", nullable: false),
                    TakimMalubiyet = table.Column<int>(type: "int", nullable: false),
                    TakimAtilanGol = table.Column<int>(type: "int", nullable: false),
                    TakimYenenGol = table.Column<int>(type: "int", nullable: false),
                    TakimAveraj = table.Column<int>(type: "int", nullable: false),
                    TakimPuan = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LigTablosu", x => x.ID);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "LigTablosu");
        }
    }
}
