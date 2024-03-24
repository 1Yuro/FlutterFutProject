using Mesaj.Controllers;
using Mesaj.Data;

var builder = WebApplication.CreateBuilder(args);
builder.WebHost.UseUrls("http://26.110.79.203:7105");
builder.Services.AddDbContext<DataContext>();
builder.Services.AddMvc();
var app = builder.Build();

app.MapControllerRoute("main", "{controller=Kullanici}/{action=Index}/{id?}");
app.Run();
