using Microsoft.AspNetCore.Mvc;
using Mesaj.Data;
using Microsoft.EntityFrameworkCore;
using Mesaj.Entities;

namespace Mesaj.Controllers
{
    public class KullaniciController : Controller
    {
        DataContext context = new DataContext();
        public KullaniciController(DataContext _context)
        {
            context = _context;
        }
        [HttpGet]
        public IActionResult Listele()
        {
            List<Kullanici> liste = context.kullanicilar.ToList();
            return Json(liste);
        }

        [HttpPost]
        public IActionResult Kayit([FromBody]Kullanici kullanici)
        {
            
            
            if(kullanici == null)
            {
                return BadRequest("Body null olamaz");
            }
            else
            {
                context.kullanicilar.Add(kullanici);
                context.SaveChanges();
            }
            
            return Ok();
            
        }
    }
}
